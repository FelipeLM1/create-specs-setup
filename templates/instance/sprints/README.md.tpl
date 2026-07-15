# Sprints

Artefatos SDD organizados por sprint (e por specs ainda sem sprint).

```
sprints/
  in-progress/          # spec em andamento — sem sprint definida
    features/{slug}/
  sprint-{N}/
    features/{slug}/
    fixes/{slug}/
    meetings/
```

Sprint atual (quando houver N): ver `workflow.current_sprint` em `sdd.config.yaml`.

Specs sem sprint ainda: `sprints/in-progress/` — ver `docs/sprint-layout.md`.
