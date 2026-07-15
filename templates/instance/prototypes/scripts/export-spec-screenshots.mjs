import { spawn } from 'node:child_process';
import { access, mkdir, readdir, readFile, writeFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

import { chromium } from 'playwright';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const prototypesRoot = path.resolve(__dirname, '..');
const specsRoot = path.resolve(prototypesRoot, '..');

const EXPORT_HIDE_STYLE = `
  .prototype-export-exclude,
  .prototype-screenshot-button {
    display: none !important;
  }
`;

async function pathExists(targetPath) {
  try {
    await access(targetPath);
    return true;
  } catch {
    return false;
  }
}

/**
 * Resolves screenshot-manifest.json for a feature slug.
 * Prefer: sprints/sprint-{N}/features/{slug}/design/ or sprints/in-progress/features/{slug}/design/
 * Fallback: features/{slug}/design/ (legacy layout)
 */
async function resolveManifestPath(featureSlug) {
  const sprintsRoot = path.join(specsRoot, 'sprints');
  if (await pathExists(sprintsRoot)) {
    const sprintDirs = await readdir(sprintsRoot, { withFileTypes: true });
    const candidates = [];

    for (const entry of sprintDirs) {
      if (!entry.isDirectory()) {
        continue;
      }

      candidates.push(
        path.join(sprintsRoot, entry.name, 'features', featureSlug, 'design', 'screenshot-manifest.json')
      );
    }

    for (const candidate of candidates) {
      if (await pathExists(candidate)) {
        return candidate;
      }
    }
  }

  const legacyPath = path.join(specsRoot, 'features', featureSlug, 'design', 'screenshot-manifest.json');
  if (await pathExists(legacyPath)) {
    return legacyPath;
  }

  throw new Error(
    `Manifesto não encontrado para "${featureSlug}". ` +
      `Crie screenshot-manifest.json em sprints/sprint-{N}/features/${featureSlug}/design/ ` +
      `(template: templates/screenshot-manifest.json).`
  );
}

async function readManifest(manifestPath) {
  const raw = await readFile(manifestPath, 'utf8');
  return JSON.parse(raw);
}

async function waitForServer(baseUrl, timeoutMs = 60000) {
  const startedAt = Date.now();

  while (Date.now() - startedAt < timeoutMs) {
    try {
      const response = await fetch(baseUrl);
      if (response.ok) {
        return;
      }
    } catch {
      // Server not ready yet.
    }

    await new Promise((resolve) => setTimeout(resolve, 1000));
  }

  throw new Error(`Servidor não respondeu em ${baseUrl}`);
}

function startDevServer() {
  return spawn('npm', ['start'], {
    cwd: prototypesRoot,
    stdio: 'ignore',
    detached: true
  });
}

async function captureScreenshots({ manifestPath, updatePrototypeDoc }) {
  const manifest = await readManifest(manifestPath);
  const featureDesignDir = path.dirname(manifestPath);
  const screenshotsDir = path.join(featureDesignDir, 'screenshots');
  const baseUrl = manifest.baseUrl ?? 'http://localhost:4201';

  await mkdir(screenshotsDir, { recursive: true });

  let devServer = null;
  let startedServer = false;

  try {
    await waitForServer(baseUrl);
  } catch {
    devServer = startDevServer();
    startedServer = true;
    await waitForServer(baseUrl);
  }

  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });

  const captured = [];

  for (const screen of manifest.pages) {
    const targetUrl = new URL(screen.path, baseUrl).toString();
    await page.goto(targetUrl, { waitUntil: 'networkidle' });
    await page.addStyleTag({ content: EXPORT_HIDE_STYLE });
    await page.locator('section.content').waitFor({ state: 'visible' });

    const fileName = `${screen.name}.png`;
    const filePath = path.join(screenshotsDir, fileName);

    await page.locator('section.content').screenshot({ path: filePath });
    captured.push({ ...screen, fileName, filePath });
    console.log(`Capturado: ${fileName}`);
  }

  await browser.close();

  if (updatePrototypeDoc) {
    await updatePrototypeMarkdown(featureDesignDir, captured);
  }

  if (startedServer && devServer) {
    process.kill(-devServer.pid);
  }

  return captured;
}

async function updatePrototypeMarkdown(featureDesignDir, captured) {
  const prototypeDocPath = path.join(featureDesignDir, 'prototype.md');
  if (!(await pathExists(prototypeDocPath))) {
    console.warn(`prototype.md não encontrado em ${featureDesignDir} — pulando atualização do doc.`);
    return;
  }

  const raw = await readFile(prototypeDocPath, 'utf8');
  const generatedAt = new Date().toISOString().slice(0, 10);

  const screenshotsSection = [
    '## Capturas de tela',
    '',
    `> Gerado automaticamente em ${generatedAt} via \`npm run export:spec-screenshots\`.`,
    '',
    ...captured.flatMap((screen) => [
      `### ${screen.screenRef ?? screen.name}`,
      '',
      `![${screen.screenRef ?? screen.name}](screenshots/${screen.fileName})`,
      ''
    ])
  ].join('\n');

  const withoutOldSection = raw.replace(/\n## Capturas de tela[\s\S]*$/m, '').trimEnd();
  const updated = `${withoutOldSection}\n\n${screenshotsSection}\n`;

  await writeFile(prototypeDocPath, updated, 'utf8');
  console.log(`Atualizado: ${prototypeDocPath}`);
}

const featureSlug = process.argv[2];
const shouldUpdateDoc = !process.argv.includes('--no-update-doc');

if (!featureSlug) {
  console.error('Uso: node scripts/export-spec-screenshots.mjs <feature-slug>');
  process.exit(1);
}

resolveManifestPath(featureSlug)
  .then((manifestPath) => {
    console.log(`Manifesto: ${manifestPath}`);
    return captureScreenshots({ manifestPath, updatePrototypeDoc: shouldUpdateDoc });
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
