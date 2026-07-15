# Quick Start — Protótipo Angular

Guia rápido para o ambiente de protótipos mockados gerado no setup.

## 1. Primeira execução

```bash
cd prototypes
npm install
npm start
```

Acesse: http://localhost:4201 (porta em `sdd.config.yaml` → `prototype.dev_port`)

## 2. Exportar print para cliente

### Botão na tela (1 captura)

Nas rotas `/prototype/*`, use o botão flutuante **Baixar print** (canto inferior direito).

- Captura a área de conteúdo da tela (sem sidebar)
- Oculta elementos com classe `prototype-export-exclude` (toolbar de estados, notas internas)
- Salva PNG com nome `{rota}-{data}.png`

Antes de exportar, ajuste filtros, abas e estado visual desejado — o print reflete exatamente o que está na tela.

### Export automático para a pasta da spec (lote)

```bash
cd prototypes
npm run export:spec-screenshots -- {feature-slug}
```

- Lê `sprints/sprint-{N}/features/{slug}/design/screenshot-manifest.json`
- Salva PNGs em `sprints/sprint-{N}/features/{slug}/design/screenshots/`
- Atualiza `design/prototype.md` com as imagens

Requer Playwright (`npm install` já inclui; na primeira vez: `npx playwright install chromium`).

Skill da instância: `prototype-export-screenshots`.

## 3. Navegar no catálogo

- A home exibe cards de todos os protótipos disponíveis
- **Busca** por nome, descrição ou tag
- **Filtro por sprint** (chips) — cada card tem badge `Sprint {N}`
- Clique em "Abrir protótipo" para visualizar

## 4. Testar estados visuais

Cada protótipo deve cobrir:

- **Loading** — simulação de carregamento
- **Empty** — quando não há dados
- **Error** — simulação de erro
- **Success** — conteúdo completo com mock data

## 5. Criar novo protótipo

Consulte a skill `prototype-angular` da instância ou siga o resumo:

1. Confirmar `task_ref` (issue GitLab), `slug` da feature e **sprint** (`workflow.current_sprint`)
2. Criar pasta `src/app/feature/{task_ref}-{slug}/` com `data/` e `pages/`
3. Adicionar card em `src/app/prototypes/registry/prototype-catalog.data.ts` **com `sprint: N`**
4. Criar mock data, página, rota `/prototype/{task_ref}-{slug}`
5. Marcar controles internos com `prototype-export-exclude`
6. Testar localmente e validar o botão **Baixar print**

## Dependências de print

No `package.json` do `prototypes/`:

- `html-to-image` (botão **Baixar print**)
- `playwright` (devDependency — script `export:spec-screenshots`)
- Script: `"export:spec-screenshots": "node scripts/export-spec-screenshots.mjs"`

## Ajuda

- **Convenção de pastas:** `src/app/feature/README.md`
- **Scaffold de catálogo/print:** `create-specs-setup/templates/instance/prototypes/`
- **Skill B5:** `.agents/skills/prototype-angular/SKILL.md`
- **Skill prints:** `.agents/skills/prototype-export-screenshots/SKILL.md`
- **Template manifesto:** `templates/screenshot-manifest.json`
