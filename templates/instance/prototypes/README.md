# Catálogo de protótipos — referência de scaffold

Ao montar `prototypes/` (create-specs-setup / upgrade-specs), copiar estes arquivos para a instância:

| Fonte (este diretório) | Destino na instância |
|------------------------|----------------------|
| `src/app/core/models/prototype-card.model.ts` | idem |
| `src/app/prototypes/registry/prototype-catalog.data.ts` | idem (lista vazia) |
| `src/app/catalog/pages/prototype-catalog-page.*` | idem |
| `src/app/shared/styles/_prototype-pill-badge.scss` | idem (se ainda não existir no SPA copiado) |

## Contrato do card

- Campo obrigatório `sprint: number` — igual a `N` de `sprints/sprint-{N}/` da feature.
- Badge **Sprint {N}** em cada card.
- Toolbar: **busca por nome** + **filtro por sprint** (chips).

## Ao registrar novo protótipo (skill `prototype-angular`)

Sempre preencher `sprint` com `workflow.current_sprint` (ou a sprint da feature).
