# Ciclo de vida de uma feature ({{SPECS_REPO_SLUG}})

Documento de referência: **todas as features** do {{PROJECT_NAME}} seguem estas etapas. O acompanhamento operacional fica em `sprints/sprint-{N}/features/{slug}/progress.md` (uma checklist por feature).

---

## Princípios

1. **O fluxo não é linear de um dia só** — `progress.md` é atualizado sempre que algo avançar ou parar.
2. **Revisão manual é obrigatória** nas etapas marcadas com 🔍 — não fechar só porque a IA gerou o arquivo.
3. **Uma fonte de verdade por feature** — ao perguntar "qual o status?", ler `sprints/sprint-{N}/features/{slug}/progress.md`.
4. **Checklist curta** — observações em uma linha; detalhes ficam nos artefatos (`spec/`, `design/`, `tasks/`).
5. **Meeting notes primeiro; o resto é flexível** — após Meeting notes, a ordem das etapas depende do ramo (protótipo primeiro vs artefatos de negócio primeiro). Ver § Ramos pós Meeting notes.

---

## Status geral da feature

| Valor | Significado |
|-------|-------------|
| `not_started` | Pasta criada ou só ideia; nada relevante feito |
| `specification` | Trabalhando em meeting notes, RNs, use case, prototype spec |
| `validation` | Protótipo / pendências / issue GitLab / alinhamento PO |
| `implementation` | Desenvolvimento em {{API_REPO}}, {{SPA_REPO}} ou outros repos |
| `delivery` | Manual, UAT, deploy ou encerramento |
| `paused` | Parada temporária (registrar motivo em Notas) |
| `done` | Entregue e encerrada |
| `spec_from_code` | Documentação gerada a partir do código — aguardando revisão humana |

---

## Status de cada etapa (item da checklist)

| Símbolo | Significado |
|---------|-------------|
| `[ ]` | Não iniciado |
| `[~]` | Em andamento |
| `[x]` | Concluído (artefato ou entrega existe) |
| `[!]` | Bloqueado |
| `[-]` | Não se aplica nesta feature |

**Revisão manual** (sub-item obrigatório nas etapas 🔍):

| Símbolo | Significado |
|---------|-------------|
| `[ ]` | Ainda não revisado por humano |
| `[x]` | Revisado — incluir **quem** e **data** na nota |

---

## Etapas obrigatórias (todas as features)

### Fase A — Especificação (SDD)

| ID | Etapa | Artefato / saída | 🔍 Revisão manual |
|----|-------|-----------------|-------------------|
| A0 | Steering validado | steering/product.md + steering/engineering.md revisados | — |
| A1 | Meeting notes | `spec/meeting-notes.md` | Sim |
| A2 | Business rules | Wiki {{SPA_REPO}} `RN{code}` + espelho `spec/business-rules.md` (`RN-{code}.{seq}`) | Sim |
| A3 | Use case | `spec/use-case.md` | Sim |
| A4 | Prototype spec | `design/prototype.md` | Sim |
| A5 | Coerência entre artefatos de spec | Checklist full-spec | Sim |

### Fase B — Validação e planejamento

| ID | Etapa | Artefato / saída | 🔍 Revisão manual |
|----|-------|-----------------|-------------------|
| B1 | Design task (UX/UI) | `tasks/design-task.md` | Sim |
| B2 | Sprint task (dev) | `tasks/sprint-task.md` — wiki RN opcional se configurada | Sim |
| B3 | Issue no GitLab | Link nas tasks (design e/ou dev) | Sim |
| B4 | Pendências de negócio/técnicas fechadas | Lista vazia nas tasks | Sim |
| B5 | Protótipo navegável ({{SPECS_REPO_SLUG}}) | `prototypes/src/app/feature/{task_ref}-{slug}/` + catálogo | Sim |
| Pós-B5 | Capturas na pasta da feature | `design/screenshots/` via `prototype-export-screenshots` ou botão **Baixar print** | Não |
| B6 | Validação do protótipo com stakeholder | Registro em `progress.md` | Sim |

**B1** pode ser `[-]` quando não há designer no fluxo.

**A4 / B1 / B5 / B6** devem ser `[-]` quando a feature **não** terá protótipo (decisão no início da spec, Fase 0 do `full-spec`).

---

## Ramos pós Meeting notes

No início da feature (Fase 0), registrar se **vai ter protótipo**. Depois de **Meeting notes** (A1):

| Situação | Comportamento |
|----------|---------------|
| **Sem protótipo** | Seguir Business rules → Use case → Sprint task. Não perguntar nada de protótipo. |
| **Com protótipo** | Perguntar o ramo: **protótipo primeiro** ou **artefatos de negócio primeiro**. |

### Protótipo primeiro (recomendado com tela nova)

Motivo: o protótipo fecha fluxos e telas; Meeting notes + protótipo alimentam Business rules e Use case com mais precisão e menos retrabalho.

Ordem sugerida: Prototype spec → (Design task, se houver) → Protótipo Angular → Validação → Business rules → Use case → Sprint task.

### Artefatos de negócio primeiro

Ordem sugerida: Business rules → Use case → Prototype spec → (Design task) → Protótipo Angular → Sprint task.

**Design task:** útil como brief enquanto o protótipo ainda será construído; após o protótipo fechado, vira histórico — não é o guia da próxima ação.

Orquestração: skill `full-spec`.

---

## Fluxo spec-from-code (alternativo)

Quando o fluxo **já está implementado** e a spec deve ser **inferida do código** (não de reunião), usar a skill `spec-from-code` em vez de A1–A4.

| ID | Etapa | Artefato / saída | 🔍 Revisão manual |
|----|-------|-----------------|-------------------|
| R0 | Escopo e artefatos confirmados | — | — |
| R1 | Análise do código | `spec/analysis-context.md` | — |
| R2 | Business rules (opcional) | `spec/business-rules.md` | Sim |
| R3 | Use case (opcional) | `spec/use-case.md` | Sim |
| R4 | Gaps (opcional) | `spec/implementation-gaps.md` | Sim |
| R5 | Insights (opcional) | `spec/evolution-insights.md` | Sim |
| R6 | Revisão humana concluída | `progress.md` | Sim |

**Progress:** `templates/spec-from-code-progress.md` · Status geral: `spec_from_code`

**Não aplicável neste fluxo:** A1, A4, B1, B2, B5 (a menos que gaps virem tasks depois).

### Fase C — Implementação

| ID | Etapa | Artefato / saída | 🔍 Revisão manual | Skill |
|----|-------|-----------------|-------------------|-------|
| C1 | Backend ({{API_REPO}}) | MR / branch | Sim (code review) | `implement-sprint-task` |
| C2 | Frontend ({{SPA_REPO}}) | MR / branch | Sim (code review) | `implement-sprint-task` |
| C3 | Testes / QA da feature | Evidência em MR ou plano de teste | Sim | `implement-sprint-task` |
| C4 | Critérios de aceite da sprint task verificados | Checklist da issue | Sim | `implement-sprint-task` |

### Fase D — Entrega

| ID | Etapa | Artefato / saída | 🔍 Revisão manual |
|----|-------|-----------------|-------------------|
| D1 | Manual do sistema | `docs/system-manual.md` | Sim |
| D2 | UAT / aceite de negócio | Registro em `progress.md` | Sim |
| D3 | Deploy / disponível em ambiente alvo | Link ou versão | — |
| D4 | Feature encerrada | Status `done` em `progress.md` | — |

---

## Quando atualizar `progress.md`

| Evento | Ação |
|--------|------|
| Nova feature iniciada | Criar `progress.md` a partir de `templates/feature-progress.md` |
| Artefato SDD criado ou alterado | Marcar etapa `A*` e revisão se já revisado |
| Protótipo implementado ou alterado | Atualizar `B5`, link do catálogo |
| Decisão ou pendência nova | Seção **Pendências** + nota com data |
| Pausa / retomada | Status geral + nota em **Próximo passo** |
| MR aberto / mergeado | Atualizar `C1` / `C2` |
| Usuário pergunta "status da feature X" | Ler `progress.md` e responder (skill `feature-progress`) |

---

## Estrutura de pastas (referência)

```
sprints/sprint-{N}/features/{slug}/
├── progress.md              ← acompanhamento (esta skill)
├── spec/
├── design/
├── tasks/
└── docs/
    └── system-manual.md     ← após implementação
```

---

## Skills relacionadas

| Etapa | Skill |
|-------|-------|
| Boas-vindas | `welcome` |
| Entrada / continuar | `{{GUIDE_SKILL_NAME}}` |
| A0–A5 / orquestração | `full-spec` |
| A1 | `meeting-notes` |
| A2 | `business-rules` |
| A3 | `use-case` |
| A4 | `prototype-spec` |
| A5 / A0–A5 | checklist em `full-spec` |
| B1 | `design-task` |
| B2 | `sprint-task` |
| B5 | `prototype-angular` |
| Pós-B5 | `prototype-export-screenshots` |
| C1–C4 | `implement-sprint-task` |
| D1 | `system-manual` |
| Spec from code | `spec-from-code` |
| Progresso | `feature-progress` |

Convenções: `docs/skill-conventions.md`

---

**Versão:** 1.2  
**Última atualização:** 2026-07-16
