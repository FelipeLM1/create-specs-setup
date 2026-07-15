# Specs em andamento (sem sprint)

Features e ajustes **ainda sem sprint definida** — tipicamente antes da sprint task (B2) ou enquanto a spec ainda está sendo fechada.

```
sprints/in-progress/
  features/{slug}/
  fixes/{slug}/     # opcional
```

## Quando usar

| Situação | Pasta |
|----------|-------|
| Spec iniciada, **sem** sprint task | `in-progress/features/{slug}/` |
| Sprint N definida / B2 gerado | `sprint-{N}/features/{slug}/` |

## Promoção para uma sprint

1. Mover `sprints/in-progress/features/{slug}/` → `sprints/sprint-{N}/features/{slug}/`
2. Atualizar `sprint` no card do catálogo de protótipos (se houver)
3. Seguir com `sprint-task` / implementação

Ver `docs/sprint-layout.md`.
