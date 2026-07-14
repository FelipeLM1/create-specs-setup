# Convenção de pastas por sprint

Artefatos SDD ficam sob `sprints/sprint-{N}/`, não mais na raiz do repositório.

```
sprints/
  sprint-{N}/
    features/{slug}/     # meeting notes, RN/RF, use case, tasks, progress
    fixes/{slug}/        # fix-task + progress
    meetings/            # atas / transcrições da sprint
```

## Como obter N

1. Ler `workflow.current_sprint` em `sdd.config.yaml` (padrão)
2. Se o usuário informar outra sprint → usar essa
3. Ao **continuar** / **status** / slug ambiguo → buscar em `sprints/*/features/{slug}/` e `sprints/*/fixes/{slug}/`

## Paths canônicos (usar nas skills)

| Antes (legado) | Agora |
|----------------|-------|
| `features/{slug}/` | `sprints/sprint-{N}/features/{slug}/` |
| `fixes/{slug}/` | `sprints/sprint-{N}/fixes/{slug}/` |
| `meetings/` | `sprints/sprint-{N}/meetings/` |

**Abreviação nas skills:** `{feature_root}` = `sprints/sprint-{N}/features/{slug}` · `{fix_root}` = `sprints/sprint-{N}/fixes/{slug}`

Na Fase 0 / gate de qualquer skill que cria pasta: confirmar **sprint** (default = `current_sprint`) + **slug**.
