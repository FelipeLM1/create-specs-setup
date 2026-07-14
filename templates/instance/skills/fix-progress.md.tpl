---
name: fix-progress
description: Cria e atualiza acompanhamento de bug-fix e ajustes no {{SPECS_REPO_SLUG}} (sprints/sprint-{N}/fixes/{slug}/progress.md). Use quando perguntar status do fix, onde parou, marcar MR mergeado, aceite verificado ou encerrar fix.
---

# Skill: Fix Progress (acompanhamento)

## Quando usar

**Gatilhos:**
- "qual o status do fix …"
- "onde paramos no bug …"
- "marcar fix como feito"
- "atualizar progresso do ajuste …"
- Após issue GitLab, MR ou verificação de aceite

**Referência:** `docs/fix-lifecycle.md` · `docs/skill-conventions.md`

**Chamada automática:** `quick-fix` deve invocar esta skill ao gerar arquivos.

---

## Arquivo alvo

```
sprints/sprint-{N}/fixes/{slug}/progress.md
```

Se não existir, criar a partir de `templates/fix-progress.md` (normalmente já criado pela skill `quick-fix`).

---

## Status geral

| Status | Condição |
|--------|----------|
| `specification` | F1 ok; F2 pendente |
| `implementation` | F2 ok; F3 em andamento ou feito |
| `done` | F6 marcado |
| `paused` | Apenas se usuário indicar |

Atualizar **Última atualização** para hoje (`YYYY-MM-DD`).

---

## Etapas F1–F6

| Etapa | Marcar `[x]` quando |
|-------|---------------------|
| F1 | `fix-task.md` existe e está alinhado |
| F2 | Link GitLab preenchido em fix-task e progress |
| F3 | MR aberto ou mergeado (nota com link) |
| F4 | Critérios de aceite da fix-task verificados |
| F5 | Smoke básico ok (nota breve) |
| F6 | Fix encerrado |

---

## Operações

### Criar progress (fix sem progress)

1. Confirmar slug em `sprints/sprint-{N}/fixes/{slug}/`
2. Copiar template → `progress.md`
3. Sincronizar com `fix-task.md` (tipo, resumo, GitLab)
4. Marcar F1 se fix-task existir

### Atualizar após evento

1. Ler `progress.md` e `fix-task.md`
2. Mudanças mínimas — não reescrever arquivo inteiro
3. Ajustar status geral, próximo passo
4. Linha no **Histórico**

### Responder "qual o status?"

1. Ler `sprints/sprint-{N}/fixes/{slug}/progress.md` e `fix-task.md`
2. Responder em português:
   - Status geral + resumo
   - Etapas feitas / pendentes
   - Próximo passo
   - Link GitLab / MR se houver

Não inventar progresso.

---

## Integração

| Evento | Atualizar |
|--------|-----------|
| `quick-fix` criou arquivos | F1 `[x]`, status `specification` |
| Issue GitLab | F2, link em ambos arquivos |
| MR | F3 |
| Aceite + smoke | F4, F5 |
| Encerramento | F6, status `done` |

---

## Anti-patterns

- Não usar checklist A0–D4 de features
- Não exigir revisão manual 🔍 por etapa
- Não duplicar fix-task inteiro no progress
