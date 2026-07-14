# Ciclo de vida de fix e ajuste ({{SPECS_REPO_SLUG}})

Documento de referência para **bugs e ajustes** — fluxo enxuto, paralelo ao de features. O acompanhamento fica em `sprints/sprint-{N}/fixes/{slug}/progress.md`.

---

## Quando usar este fluxo

| Situação | Usar `sprints/sprint-{N}/fixes/`? |
|----------|----------------|
| Bug reproduzível ou com evidência clara | Sim |
| Ajuste de label, validação, filtro, texto | Sim |
| Comportamento já definido em feature existente — só corrigir | Sim (+ link em `sprints/sprint-{N}/features/`) |
| Hotfix urgente em produção | **Não** — issue GitLab + MR direto |
| Nova regra de negócio ou tela nova | **Não** — use `sprints/sprint-{N}/features/` (fluxo SDD completo) |

---

## Princípios

1. **Um artefato principal** — `fix-task.md` (sem meeting notes, use case ou protótipo).
2. **Perguntas antes de gerar** — a skill `quick-fix` só escreve arquivos quando o contexto mínimo estiver completo.
3. **Issue GitLab curta** — seção "Texto para GitLab" copiável; investigação técnica fica no arquivo local.
4. **Pasta separada** — `sprints/sprint-{N}/fixes/{slug}/`, nunca misturar com `sprints/sprint-{N}/features/`.

---

## Status geral

| Valor | Significado |
|-------|-------------|
| `specification` | Fix task sendo refinada; issue ainda não criada |
| `implementation` | Issue criada; MR em andamento |
| `done` | Critérios de aceite ok; fix encerrado |
| `paused` | Parada temporária (registrar motivo no progress) |

---

## Etapas (checklist F1–F6)

| ID | Etapa | Artefato / saída | Skill |
|----|-------|------------------|-------|
| F1 | Fix task | `sprints/sprint-{N}/fixes/{slug}/fix-task.md` | `quick-fix` |
| F2 | Issue GitLab | Link no fix-task e progress | — |
| F3 | Implementação | MR em {{API_REPO}} / {{SPA_REPO}} / etc. | `implement-fix` |
| F4 | Critérios de aceite | Checklist da issue verificada | — |
| F5 | Smoke / regressão básica | Evidência breve (MR ou nota) | — |
| F6 | Encerramento | Status `done` no progress | `fix-progress` |

Não há revisão manual 🔍 obrigatória por etapa — code review no MR substitui.

---

## Estrutura de pastas

```
sprints/sprint-{N}/fixes/{slug}/
├── fix-task.md      ← especificação + texto GitLab
└── progress.md      ← checklist F1–F6
```

**Convenção de slug:** kebab-case, descritivo, sem número de ticket no nome.

Exemplos: `export-coluna-vazia`, `filtro-status-reset`, `label-allocation-date`

---

## Skills relacionadas

| Ação | Skill |
|------|-------|
| Entrada / triagem | `{{GUIDE_SKILL_NAME}}` |
| Criar fix do zero (perguntas + arquivos) | `quick-fix` |
| Investigar e corrigir no código (F3) | `implement-fix` |
| Atualizar status / marcar etapa | `fix-progress` |

Convenções: `docs/skill-conventions.md`

---

## Escalar para fluxo de feature

Migrar para `sprints/sprint-{N}/features/{slug}/` se:

- PO precisa decidir **novo** comportamento (não correção)
- Surge regra de negócio nova ou contradiz spec existente
- Exige protótipo ou validação formal com stakeholder
- Escopo cresce além de fix pontual (registrar em **Fora de escopo** e reavaliar)

---

**Versão:** 1.0  
**Última atualização:** 2026-05-30
