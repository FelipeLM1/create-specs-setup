---
name: prototype-export-screenshots
description: Exporta capturas de tela do protótipo Angular para sprints/sprint-{N}/features/{slug}/design/screenshots/ e atualiza design/prototype.md. Use quando pedir gerar prints da spec, exportar telas do protótipo para a pasta da feature, atualizar capturas do prototype.md ou preparar material visual para validação com cliente (B6).
---

# Skill: Exportar capturas do protótipo para a spec

## Quando usar

**Gatilhos:**
- "exportar prints do protótipo para a spec"
- "gerar capturas de tela do protótipo"
- "atualizar screenshots do prototype.md"
- "tirar foto das telas e colocar na pasta da feature"
- "preparar prints para enviar ao cliente"
- Após **B5** (`prototype-angular`) — antes ou durante **B6** (validação com stakeholder)

**Pré-requisito:** protótipo Angular implementado e acessível (`prototypes/` → `npm start`).

**Referência:** `docs/skill-conventions.md` · `prototypes/QUICKSTART.md`

---

## Objetivo

Gerar PNGs das telas do protótipo e anexá-los à spec em `sprints/sprint-{N}/features/{slug}/design/`, para compartilhar com cliente/stakeholder sem depender de captura manual.

**Alternativa rápida (1 tela):** no browser, nas rotas `/prototype/*`, use o botão flutuante **Baixar print** (canto inferior direito). Para lote + pasta da spec, use esta skill.

---

## Artefatos

| Artefato | Caminho |
|----------|---------|
| Manifesto de rotas | `sprints/sprint-{N}/features/{slug}/design/screenshot-manifest.json` |
| Imagens | `sprints/sprint-{N}/features/{slug}/design/screenshots/*.png` |
| Spec atualizada | `sprints/sprint-{N}/features/{slug}/design/prototype.md` (seção **Capturas de tela**) |

**Script (já no shell — não recriar):** `prototypes/scripts/export-spec-screenshots.mjs`

---

## Instruções passo a passo

### 1. Confirmar contexto

**Perguntas (máx. 3):**
1. Qual o **slug** da feature? (ex.: `listagem-usuario`)
2. O protótipo já está implementado em `prototypes/src/app/feature/{task_ref}-{slug}/`?
3. Quais telas exportar? (todas do `prototype.md` ou subconjunto)

Se o slug for informado e o protótipo existir, prossiga sem perguntar de novo.

---

### 2. Verificar ou criar o manifesto

**Arquivo:** `sprints/sprint-{N}/features/{slug}/design/screenshot-manifest.json`

**Fontes para montar o manifesto:**
- `sprints/sprint-{N}/features/{slug}/design/prototype.md` — rotas em cada tela
- `prototypes/src/app/app.routes.ts` — rotas reais
- Mock data — IDs/PNs para rotas com parâmetro (`:id`, `:pn`)

**Regras do manifesto:**

| Campo | Descrição |
|-------|-----------|
| `baseUrl` | `http://localhost:4201` (porta em `sdd.config.yaml` → `prototype.dev_port`) |
| `pages[].name` | Nome do arquivo sem extensão — padrão `01-cockpit`, `02-listagem`, etc. |
| `pages[].path` | Rota completa (ex.: `/prototype/100-listagem-usuario`) |
| `pages[].screenRef` | Título legível — deve bater com o título da tela no `prototype.md` |

**Template:** `templates/screenshot-manifest.json`

**Rotas com parâmetro:** usar IDs reais do mock — consultar `prototypes/src/app/feature/{task_ref}-{slug}/data/`.

---

### 3. Executar a exportação

```bash
cd {{SPECS_REPO_SLUG}}/prototypes
npm install
npx playwright install chromium   # só na primeira vez na máquina
npm run export:spec-screenshots -- {slug}
```

**O script:**
- Localiza `screenshot-manifest.json` sob `sprints/**/features/{slug}/design/` (ou legado `features/{slug}/design/`)
- Sobe `npm start` automaticamente se `localhost:4201` não responder
- Navega cada rota do manifesto
- Captura `section.content` (sem sidebar)
- **Oculta blocos de dev/PO** (classe `prototype-export-exclude`) e o botão **Baixar print**
- Salva PNGs em `design/screenshots/`
- Atualiza `design/prototype.md` com a seção **Capturas de tela**

**O que some do print (dev/PO — ver skill `prototype-angular`):** toolbars de estado, notas técnicas, banners de demo, links “voltar ao catálogo”, seções `discussion`/`hint-box`, chips “Dados mockados”.

**Flag opcional:** `--no-update-doc` — só gera PNGs, sem alterar `prototype.md`.

---

### 4. Validar resultado

**Checklist:**
- [ ] Um PNG por tela listada no manifesto
- [ ] Controles e observações **dev/PO** ausentes no PNG (`prototype-export-exclude`)
- [ ] `prototype.md` referencia `screenshots/*.png` com caminhos relativos corretos
- [ ] Telas com estado desejado (ajustar protótipo antes de exportar, se necessário)

**Se uma tela falhar:** conferir rota no manifesto, ID do mock e se o protótipo compila (`npm run build` em `prototypes/`).

---

### 5. Atualizar progress

Invocar `feature-progress` e registrar em `sprints/sprint-{N}/features/{slug}/progress.md`:

- Nota em **B5** ou **B6:** link/caminho `design/screenshots/` + data da exportação
- Se for entrega ao cliente: mencionar em **B6** que prints estão na spec

Não marcar **B6** `[x]` sem confirmação humana de validação.

---

## Relação com outras skills

| Skill | Papel |
|-------|-------|
| `prototype-spec` | Define telas e rotas em `prototype.md` (A4) |
| `prototype-angular` | Implementa protótipo navegável (B5) |
| **`prototype-export-screenshots`** | Gera PNGs na pasta da spec (pós-B5) |
| `feature-progress` | Atualiza checklist após export |

**Fluxo típico:**
```
prototype-spec (A4) → prototype-angular (B5) → prototype-export-screenshots → B6 validação
```

---

## Anti-patterns

❌ **NÃO fazer:**
- Recriar script de captura por feature
- Inventar rotas sem checar `app.routes.ts` e mock data
- Commitar prints desatualizados após mudança visual grande no protótipo
- Usar captura manual como único caminho quando o manifesto existe

✅ **Fazer:**
- Manter `screenshot-manifest.json` alinhado ao `prototype.md`
- Re-exportar após alterações visuais relevantes
- Usar `screenRef` consistente com títulos da spec
- Validar visualmente pelo menos uma captura antes de enviar ao cliente

---

## Troubleshooting

### `Servidor não respondeu em http://localhost:4201`
Rodar manualmente `cd prototypes && npm start` e repetir o comando.

### `strict mode violation` no seletor
O script usa `section.content` — não alterar para `.content` genérico (colide com outros elementos).

### Playwright não instalado
`cd prototypes && npx playwright install chromium`

### `Manifesto não encontrado`
Criar `screenshot-manifest.json` a partir de `templates/screenshot-manifest.json` e conferir o slug.

### Rota com `:id` retorna tela vazia
Conferir ID no mock data da feature.

---

## Saída esperada

1. **PNG(s)** em `sprints/sprint-{N}/features/{slug}/design/screenshots/`
2. **Seção Capturas de tela** em `design/prototype.md`
3. **Manifesto** `screenshot-manifest.json` criado ou revisado
4. **progress.md** atualizado com nota da exportação

---

## Após gerar — entrega

Responder conforme `docs/skill-conventions.md`:

```markdown
**Gerado:** `sprints/sprint-{N}/features/{slug}/design/screenshots/` (+ `prototype.md` atualizado)
**Etapa:** B5/B6 — capturas para validação
**Pendências:** {N} ou "nenhuma"
**Próximo:** B6 — validação com stakeholder (skill `feature-progress`)
**Continuo com a próxima etapa?**
```

---

**Versão:** 1.0  
**Última atualização:** 2026-07-14  
**Versão skill:** 1.0
