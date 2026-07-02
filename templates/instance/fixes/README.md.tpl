# Fixes — bug-fix e ajustes

Pasta para instâncias de correções e ajustes pontuais. Cada item tem sua subpasta:

```
fixes/{slug}/
├── fix-task.md
└── progress.md
```

**Como criar:** use a skill `.agents/skills/quick-fix/SKILL.md` ou comece por `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md`.

**Ciclo de vida:** [`docs/fix-lifecycle.md`](../docs/fix-lifecycle.md)

**Hotfix urgente em produção:** não use esta pasta — issue GitLab + MR direto.
