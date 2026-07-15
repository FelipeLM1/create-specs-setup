---
name: full-spec
description: Orquestra geração de artefatos SDD (meeting notes, business rules, use case, prototype spec, design task, sprint task) em modo guiado com perguntas e progress. Use quando o usuário pedir full spec, spec completo, feature nova ou especificar do zero no {{SPECS_REPO_SLUG}}. Modo batch só se pedido explicitamente.
---

# Skill: Full Spec — Geração Completa de Artefatos

## Quando usar

Use quando o usuário quiser **especificar uma feature nova** — do contexto de negócio ao sprint task.

**Gatilhos:**
- "gerar spec completo de..."
- "criar todos os artefatos de..."
- "full spec de..."
- "especificar a feature de..."
- "feature nova: ..."

**Delegação:** se o usuário não souber o fluxo, começar por `{{GUIDE_SKILL_NAME}}`.

> Não gera manual do sistema (D1) nem protótipo Angular (B5) — skills separadas após B2.

**Referências:** `docs/skill-conventions.md` · `docs/feature-lifecycle.md`

---

## Modos de execução

| Modo | Ativação | Comportamento |
|------|----------|---------------|
| **Guiado** (padrão) | Sempre | 1 artefato → progress → "continuo?" → próximo |
| **Batch** | "gerar tudo de uma vez" / "sem pausas" | A1→B2 contínuo; progress no final de cada artefato |

---

## Regra de ouro

> **Não escreva nenhum arquivo até o checklist de contexto inicial estar completo.**

Máximo **3 perguntas por mensagem**. O que faltar vira `[PENDENTE]` nos artefatos — não invente.

---

## Fase 0 — Contexto inicial (gate)

Antes de criar pastas ou arquivos, reunir:

| # | Campo | Pergunta guia |
|---|-------|---------------|
| 0.0 | **Local** | Já tem sprint? Se **não** (spec ainda em andamento / sem B2) → `in-progress`. Se **sim** → N (default: `workflow.current_sprint`) |
| 0.1 | **Problema** | Qual dor ou oportunidade de negócio? |
| 0.2 | **Usuário** | Quem usa (perfil)? |
| 0.3 | **Processo atual** | Como resolvem hoje? |
| 0.4 | **Restrições** | O que não pode / limites citados? |
| 0.5 | **Decisões** | O que já está definido vs em aberto? |
| 0.6 | **Escopo** | Dentro / fora desta entrega? |
| 0.7 | **Serviços** | {{API_REPO}}, {{SPA_REPO}}, repos em `repos.extra`? |
| 0.8 | **Slug** | Propor kebab-case e confirmar |

**Gate mínimo para iniciar A1:**
- [ ] Local confirmado: `sprints/in-progress/` **ou** `sprints/sprint-{N}/`
- [ ] Problema + usuário descritos
- [ ] Escopo mínimo (mesmo com pendências)
- [ ] Slug confirmado
- [ ] Pelo menos 1 serviço impactado (ou `[PENDENTE]`)

Ao passar o gate:
1. Criar `{feature_root}/progress.md` — `sprints/in-progress/features/{slug}/` ou `sprints/sprint-{N}/features/{slug}/` (template `feature-progress.md`)
2. Marcar **A0** `[x]`
3. Informar modo (guiado/batch) e iniciar **A1**

> Layout: `docs/sprint-layout.md`. Ao gerar B2 / definir sprint: **mover** de `in-progress/` → `sprint-{N}/`.

---

## Sequência

```
A1 Meeting Notes      → skill meeting-notes
A2 Business Rules     → skill business-rules
A3 Use Case           → skill use-case
A4 Prototype Spec     → skill prototype-spec
A5 Coerência          → checklist desta skill
B1 Design Task        → skill design-task (UX/UI; opcional se sem designer)
B2 Sprint Task        → skill sprint-task (dev)
```

Em **modo guiado**, após cada etapa:
1. Executar skill referenciada (gerar 1 artefato)
2. Atualizar `progress.md` (`feature-progress`)
3. Entregar mensagem padrão (`docs/skill-conventions.md`)
4. **Parar e aguardar** confirmação do usuário

Em **modo batch**, enfileirar A1→B2 sem pausa entre etapas, mantendo progress após cada uma.

---

## Fase A5 — Coerência (antes de declarar spec pronta)

Checklist (não gera arquivo separado — atualizar nota em progress **A5**):

- [ ] Slug consistente em todos os arquivos
- [ ] Business rules não contradizem meeting notes
- [ ] Use case cobre edge cases das RNs
- [ ] Prototype spec alinhado ao use case
- [ ] Design task (se aplicável): sem detalhe de código; alinhada ao prototype
- [ ] Sprint task: aceite verificável + pendências explícitas
- [ ] Nenhuma info crítica inventada

Marcar A5 `[x]` no progress; status geral → `validation` se B2 ok.

---

## Pendências abertas

Consolidar no sprint task:

```markdown
## Pendências abertas — resolver antes de implementar

| # | Decisão pendente | Impacto | Quem resolve |
|---|-----------------|---------|--------------|
```

---

## Estrutura gerada

```
sprints/sprint-{N}/features/{slug}/
├── progress.md
├── spec/
│   ├── meeting-notes.md
│   ├── business-rules.md
│   └── use-case.md
├── design/
│   └── prototype.md
└── tasks/
    ├── design-task.md
    └── sprint-task.md
```

---

## Após B2 — o que vem depois

| Etapa | Skill | Quando |
|-------|-------|--------|
| B3 | — | Criar issues GitLab (design-task e/ou sprint-task) |
| B5 | `prototype-angular` | Após A4 |
| Pós-B5 | `prototype-export-screenshots` | Prints na pasta da feature |
| B6 | `feature-progress` | Demo PO registrada |
| C* | — | Implementação {{API_REPO}} / {{SPA_REPO}} |
| D1 | `system-manual` | Pós-implementação |

Sugerir ao usuário: *"Spec A1–B2 concluída. Próximo: protótipo Angular (B5) ou issues GitLab (B3)?"*

---

## Anti-patterns

- Gerar 5 artefatos sem gate inicial
- Modo batch sem pedido explícito
- Pular atualização de `progress.md`
- Marcar revisão manual 🔍 sem humano
- Confundir com `quick-fix` (bug/ajuste pontual)

---

## Exemplo de abertura (modo guiado)

```
Vou especificar a feature em modo guiado — uma etapa por vez.

Antes de criar arquivos:
1. Qual problema de negócio esta feature resolve?
2. Quem é o usuário principal?
3. Já tem nome/slug em mente? (senão sugiro um)
```
