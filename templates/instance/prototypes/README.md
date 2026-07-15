# Catálogo de protótipos — referência de scaffold

Ao montar `prototypes/` (create-specs-setup / upgrade-specs), copiar estes arquivos para a instância:

| Fonte (este diretório) | Destino na instância |
|------------------------|----------------------|
| `src/app/core/models/prototype-card.model.ts` | idem |
| `src/app/prototypes/registry/prototype-catalog.data.ts` | idem (lista vazia) |
| `src/app/catalog/pages/prototype-catalog-page.*` | idem |
| `src/app/shared/styles/_prototype-pill-badge.scss` | idem (se ainda não existir no SPA copiado) |
| `src/app/shared/constants/prototype-export.constants.ts` | idem |
| `src/app/shared/services/prototype-screenshot.service.ts` | idem |
| `src/app/shared/components/prototype-screenshot-button/*` | idem |
| `scripts/export-spec-screenshots.mjs` | idem |
| `QUICKSTART.md` | idem |
| `LAYOUT-SCREENSHOT-WIRE.md` | referência para wiring no layout |

## Dependências (`package.json` do prototypes)

```json
{
  "scripts": {
    "export:spec-screenshots": "node scripts/export-spec-screenshots.mjs"
  },
  "dependencies": {
    "html-to-image": "^1.11.13"
  },
  "devDependencies": {
    "playwright": "^1.61.0"
  }
}
```

## Contrato do card

- Campo obrigatório `sprint: number` — igual a `N` de `sprints/sprint-{N}/` da feature.
- Badge **Sprint {N}** em cada card.
- Toolbar: **busca por nome** + **filtro por sprint** (chips).

## Prints (Baixar print + export em lote)

1. Copiar componentes/serviço/constantes acima.
2. Wire no layout — ver `LAYOUT-SCREENSHOT-WIRE.md` (botão só em rotas `/prototype/*`).
3. Adicionar deps `html-to-image` + `playwright` + script npm.
4. Copiar `templates/screenshot-manifest.json` para a raiz `templates/` da instância.
5. Marcar UI interna (toolbar de estados, notas PO) com classe `prototype-export-exclude`.

## Ao registrar novo protótipo (skill `prototype-angular`)

Sempre preencher `sprint` com `workflow.current_sprint` (ou a sprint da feature).
Após B5, prints: skill `prototype-export-screenshots` ou botão **Baixar print**.
