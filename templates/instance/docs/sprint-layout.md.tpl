# Convenção de pastas por sprint

Artefatos SDD ficam sob `sprints/`, não mais na raiz do repositório.

```
sprints/
  in-progress/           # spec em andamento — ainda sem sprint definida
    features/{slug}/
    fixes/{slug}/        # opcional
  sprint-{N}/
    features/{slug}/     # meeting notes, RN/RF, use case, tasks, progress
    fixes/{slug}/        # fix-task + progress
    meetings/            # atas / transcrições da sprint
```

## Como escolher a pasta

| Situação | Destino |
|----------|---------|
| Spec iniciada, ainda **sem** sprint task / sprint indefinida | `sprints/in-progress/features/{slug}/` |
| Sprint N confirmada (ou B2 gerado) | `sprints/sprint-{N}/features/{slug}/` |
| Fix amarrado à sprint N | `sprints/sprint-{N}/fixes/{slug}/` |

Ao fechar a sprint da feature: **mover** de `in-progress/` → `sprint-{N}/` (e atualizar `sprint` no catálogo de protótipos, se houver).

## Como obter N (quando houver sprint)

1. Ler `workflow.current_sprint` em `sdd.config.yaml` (padrão **só** se o usuário confirmar que já entra na sprint)
2. Se o usuário informar outra sprint → usar essa
3. Ao **continuar** / **status** / slug ambiguo → buscar em `sprints/*/features/{slug}/` e `sprints/*/fixes/{slug}/` (inclui `in-progress`)

## Paths canônicos (usar nas skills)

| Antes (legado) | Agora |
|----------------|-------|
| `features/{slug}/` | `sprints/sprint-{N}/features/{slug}/` **ou** `sprints/in-progress/features/{slug}/` |
| `fixes/{slug}/` | `sprints/sprint-{N}/fixes/{slug}/` |
| `meetings/` | `sprints/sprint-{N}/meetings/` |

**Abreviação nas skills:**

- `{feature_root}` = `sprints/sprint-{N}/features/{slug}` **ou** `sprints/in-progress/features/{slug}`
- `{fix_root}` = `sprints/sprint-{N}/fixes/{slug}`

Na Fase 0 / gate: confirmar se já há **sprint** (N) ou se fica em **`in-progress`** + **slug**.
