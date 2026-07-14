---
name: feature-progress
description: Cria e atualiza o acompanhamento de progresso de features no {{SPECS_REPO_SLUG}} (progress.md), responde perguntas de status e mantém checklist alinhada ao ciclo de vida. Use quando o usuário perguntar status da feature, onde parou, atualizar andamento, criar checklist de progresso ou marcar etapa concluída.
---

# Skill: Feature Progress (acompanhamento)

## Quando usar

**Gatilhos:**
- "qual o status da feature …"
- "onde paramos em …"
- "atualizar progresso de …"
- "criar checklist de acompanhamento"
- "marcar etapa X como feita"
- Após **qualquer** trabalho em artefatos SDD, protótipo ou spec de uma feature — atualizar `progress.md` no fim

**Referência obrigatória:** `docs/feature-lifecycle.md` · `docs/skill-conventions.md`

**Chamada automática:** toda skill de artefato (meeting-notes, business-rules, use-case, prototype-spec, design-task, sprint-task, prototype-angular, system-manual) e `full-spec` deve invocar esta skill **ao final** para atualizar o progress.

**Continuar spec:** quando o usuário pedir retomar, use com `{{GUIDE_SKILL_NAME}}` — ler progress, identificar próxima etapa, perguntar se continua.

---

## Objetivo

Manter **um arquivo por feature** — `sprints/sprint-{N}/features/{slug}/progress.md` — curto, atualizado e legível como uma issue do GitLab: checklist + notas breves + próximo passo.

---

## Arquivo alvo

```
sprints/sprint-{N}/features/{slug}/progress.md
```

Se não existir, criar a partir de `templates/feature-progress.md`.

---

## Status geral (campo do cabeçalho)

Calcular com base no checklist (primeira fase incompleta):

| Status | Condição |
|--------|----------|
| `not_started` | Só A0 ou nada feito |
| `specification` | A em progresso; B–D não |
| `validation` | A concluída; B incompleta ou B6 pendente |
| `implementation` | B essencial ok; C em andamento |
| `delivery` | C ok; D em andamento |
| `done` | D4 marcado |
| `paused` | Apenas se usuário indicar pausa — não inferir |

Atualizar **Última atualização** para a data de hoje (ISO `YYYY-MM-DD`).

---

## Regras de marcação

### Artefato concluído `[x]`

Marcar `[x]` na etapa quando o artefato existir e estiver alinhado ao estado atual (não rascunho abandonado).

| Etapa | Verificar |
|-------|-----------|
| A1 | `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md` |
| A2 | `spec/business-rules.md` |
| A3 | `spec/use-case.md` |
| A4 | `design/prototype.md` |
| B1 | `tasks/design-task.md` (ou `[-]` se N/A) |
| B2 | `tasks/sprint-task.md` |
| B5 | pasta `prototypes/src/app/feature/{task_ref}-{slug}/` + catálogo em `registry/prototype-catalog.data.ts` + rota |
| D1 | `docs/system-manual.md` |

### Revisão manual 🔍

- **Nunca** marcar `Revisão: [x]` só porque a IA gerou o arquivo.
- Só marcar `[x]` na revisão quando o usuário confirmar revisão, ou houver evidência explícita na conversa (ex.: "revisei e aprovei").
- Formato da nota: `Revisão: [x] — Nome, YYYY-MM-DD`

### Coerência

Se um artefato for reescrito de forma relevante, voltar revisão para `[ ]` naquela etapa e registrar uma linha no **Histórico**.

---

## Operações

### 1. Criar checklist (feature nova)

1. Confirmar `slug` (kebab-case).
2. Copiar `templates/feature-progress.md` → `sprints/sprint-{N}/features/{slug}/progress.md`.
3. Preencher título, responsável, links se conhecidos.
4. Marcar `[x]` / `[~]` conforme artefatos já existentes no disco.
5. Preencher **Resumo**, **Próximo passo**, **Pendências** a partir de sprint task / meeting notes.
6. Adicionar linha no **Histórico**.

### 2. Atualizar após mudança

1. Ler `progress.md` atual.
2. Aplicar mudanças mínimas (não reescrever o arquivo inteiro).
3. Ajustar status geral, próximo passo, pendências.
4. Adicionar linha no Histórico: `| data | o que mudou |`

### 3. Responder "qual o status?"

1. Ler `sprints/sprint-{N}/features/{slug}/progress.md`.
2. Se ausente, inferir de artefatos e oferecer criar o arquivo.
3. Responder em português, estruturado:
   - Status geral + resumo (1 frase)
   - O que já está feito (fases concluídas)
   - O que falta (próximas 3–5 etapas)
   - Pendências abertas
   - Próximo passo recomendado
   - Revisões manuais pendentes (etapas 🔍 com revisão `[ ]`)

Não inventar progresso — só o que consta no arquivo ou nos artefatos verificados.

### 4. Conduzir próxima etapa (modo continuar)

Quando acionado via `{{GUIDE_SKILL_NAME}}`:

1. Identificar primeira etapa com `[ ]` no checklist (prioridade A → B → C → D)
2. Mapear etapa → skill (tabela em `{{GUIDE_SKILL_NAME}}`)
3. Perguntar: *"Posso continuar com {ID} — {nome}?"*
4. Se sim, delegar skill — **não** gerar artefato nesta skill

---

## Integração com outras skills

| Após usar… | Atualizar em progress.md |
|------------|-------------------------|
| `meeting-notes` | A1 |
| `business-rules` | A2 |
| `use-case` | A3 |
| `prototype-spec` | A4 |
| `full-spec` | A0–A5 conforme aplicável |
| `design-task` | B1 |
| `sprint-task` | B2 |
| `prototype-angular` | B5 |
| `system-manual` | D1 |
| Implementação {{API_REPO}} / {{SPA_REPO}} | C1 / C2 (nota com MR se informado) |

Ao concluir `full-spec`, garantir que `progress.md` existe e A0–A4 refletem o estado.

---

## Anti-patterns

- Não criar um único `progress.md` global para todas as features.
- Não duplicar business rules ou critérios de aceite inteiros no progress — só referência + nota curta.
- Não marcar B6 (stakeholder) sem demo/validação real.
- Não marcar C* sem indicação de que implementação começou ou MR existe.

---

## Exemplo de resposta de status

```markdown
**Feature:** relatorio-vendas-mensal  
**Status geral:** validation  

**Feito:** Spec completa (A1–A4), protótipo Angular (B5), design task (B1), sprint task (B2).  
**Falta:** Revisões manuais pendentes em A5/B2; issues GitLab (B3); validação PO (B6); implementação (C*).  
**Pendências:** [PENDENTE] definição de período padrão do filtro.  
**Próximo passo:** Demo do protótipo com PO e criar issues no GitLab.
```
