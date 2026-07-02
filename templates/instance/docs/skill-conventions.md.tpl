# Convenções das skills ({{SPECS_REPO_SLUG}})

Referência compartilhada por **todas** as skills em `.agents/skills/`. A IA deve seguir estas regras ao gerar artefatos.

---

## Formato do arquivo SKILL.md

Cada skill **deve** iniciar com frontmatter YAML para roteamento no Cursor:

```yaml
---
name: nome-da-skill
description: Uma linha — o que faz e quando usar (gatilhos).
---
```

- `name`: kebab-case, igual ao nome da pasta em `.agents/skills/`
- `description`: português, objetiva — o harness usa para escolher a skill automaticamente

---

## Search-first

Antes de inventar endpoint, campo, tela ou path de arquivo na spec, consultar repos irmãos no workspace. Regra completa: `ai-rules.md` § Search-first. Aplica com prioridade em `business-rules`, `sprint-task` e `spec-from-code`.

---

## Regra de ouro

> **Não escreva arquivos até o contexto mínimo da etapa estar completo.**

> **Implementação (dev):** não altere código em `{{API_REPO}}` / `{{SPA_REPO}}` até a entrevista fechar gaps e o dev confirmar o plano (`implement-sprint-task`, `implement-fix`).

Se faltar informação: perguntar — **máximo 3 perguntas por mensagem**, agrupadas por tema.

---

## Modos de execução (features)

| Modo | Quando | Comportamento |
|------|--------|---------------|
| **Guiado** (padrão) | Sempre, salvo pedido explícito | 1 artefato → atualiza progress → pergunta se continua |
| **Batch** | Usuário pede "gerar tudo de uma vez" / "full spec completo sem pausas" | Sequência A1–B2 com checkpoint só no final |

---

## Após gerar artefato (feature)

Obrigatório ao final de **cada** skill de artefato:

1. **Progress:** atualizar `features/{slug}/progress.md` conforme `.agents/skills/feature-progress/SKILL.md`
   - Se `progress.md` não existir, criar a partir de `templates/feature-progress.md`
   - Marcar etapa correspondente `[x]` (A1, A2, A3, A4, B1, B2, B5, D1…)
   - Atualizar status geral, **Próximo passo**, **Histórico**
2. **Entrega ao usuário** — responder neste formato:

```markdown
**Gerado:** `{caminho/do/arquivo}`
**Etapa:** {ID} — {nome} (ex.: A2 — Business rules)
**Pendências:** {N} item(ns) [PENDENTE] ou "nenhuma"
**Próximo:** {ID} — {nome} (skill `{nome-da-skill}`)
**Continuo com a próxima etapa?**
```

Não marcar revisão manual 🔍 como `[x]` sem confirmação humana.

---

## Após gerar artefato (fix)

Obrigatório ao final da skill `quick-fix`:

1. Atualizar `fixes/{slug}/progress.md` (F1 `[x]`) — ver `fix-progress`
2. Entrega no formato:

```markdown
**Gerado:** `fixes/{slug}/fix-task.md` + `progress.md`
**Próximo:** F2 — criar issue GitLab
**Texto GitLab:** (resumo ou referência à seção)
```

---

## Integração entre skills

| Situação | Skill |
|----------|-------|
| Não sabe por onde começar | `{{GUIDE_SKILL_NAME}}` |
| Feature nova do zero | `full-spec` (guiado) ou etapas individuais |
| Bug / ajuste (documentar) | `quick-fix` |
| Implementar tarefa/feature (C*) | `implement-sprint-task` |
| Investigar e corrigir bug (F3) | `implement-fix` |
| Continuar spec existente | `{{GUIDE_SKILL_NAME}}` → modo continuar |
| Consultar andamento feature | `feature-progress` |
| Consultar andamento fix | `fix-progress` |

---

**Versão:** 1.1  
**Última atualização:** 2026-05-31
