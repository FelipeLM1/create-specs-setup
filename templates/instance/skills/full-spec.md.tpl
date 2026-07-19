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

> Não gera manual do sistema (D1) nem protótipo Angular (B5) sozinho — skill `prototype-angular` quando o ramo incluir protótipo.

**Referências:** `docs/skill-conventions.md` · `docs/feature-lifecycle.md`

---

## Modos de execução

| Modo | Ativação | Comportamento |
|------|----------|---------------|
| **Guiado** (padrão) | Sempre | 1 artefato → progress → "continuo?" → próximo |
| **Batch** | "gerar tudo de uma vez" / "sem pausas" | Sequência conforme ramo escolhido; progress no final de cada artefato |

---

## Regra de ouro

> **Não escreva nenhum arquivo até o checklist de contexto inicial estar completo.**

Máximo **3 perguntas por mensagem**. O que faltar vira `[PENDENTE]` nos artefatos — não invente.

---

## Fase 0 — Contexto inicial (gate)

Antes de criar pastas ou arquivos, reunir:

| # | Campo | Pergunta guia |
|---|-------|---------------|
| 0.0 | **Local** | Já tem sprint? Se **não** (spec ainda em andamento / sem sprint task) → `in-progress`. Se **sim** → N (default: `workflow.current_sprint`) |
| 0.1 | **Problema** | Qual dor ou oportunidade de negócio? |
| 0.2 | **Usuário** | Quem usa (perfil)? |
| 0.3 | **Processo atual** | Como resolvem hoje? |
| 0.4 | **Restrições** | O que não pode / limites citados? |
| 0.5 | **Decisões** | O que já está definido vs em aberto? |
| 0.6 | **Escopo** | Dentro / fora desta entrega? |
| 0.7 | **Serviços** | {{API_REPO}}, {{SPA_REPO}}, repos em `repos.extra`? |
| 0.8 | **Slug** | Propor kebab-case e confirmar |
| 0.9 | **Protótipo** | Esta feature vai ter protótipo (telas / mock navegável)? **sim / não** |

**Gate mínimo para iniciar Meeting notes:**
- [ ] Local confirmado: `sprints/in-progress/` **ou** `sprints/sprint-{N}/`
- [ ] Problema + usuário descritos
- [ ] Escopo mínimo (mesmo com pendências)
- [ ] Slug confirmado
- [ ] Pelo menos 1 serviço impactado (ou `[PENDENTE]`)
- [ ] Decisão de protótipo registrada (**sim** ou **não**)

Ao passar o gate:
1. Criar `{feature_root}/progress.md` — `sprints/in-progress/features/{slug}/` ou `sprints/sprint-{N}/features/{slug}/` (template `feature-progress.md`)
2. Registrar no progress: **Vai ter protótipo?** `sim` | `não`
3. Se **não** a protótipo → marcar Prototype spec, Design task, Protótipo Angular e Validação do protótipo como `[-]` (N/A)
4. Marcar contexto inicial (A0) `[x]`
5. Informar modo (guiado/batch) e iniciar **Meeting notes**

> Layout: `docs/sprint-layout.md`. Ao gerar sprint task / definir sprint: **mover** de `in-progress/` → `sprint-{N}/`.

> Se **não** vai ter protótipo, **não** perguntar nada relacionado a prototype spec, design task, protótipo Angular ou validação de protótipo nas etapas seguintes.

---

## Sequência

### Etapa fixa (sempre primeiro)

```
Meeting notes  → skill meeting-notes
```

O contexto coletado na Fase 0 deve ser **suficiente** para gerar Meeting notes com boa base.

### Após Meeting notes — ramo (obrigatório se vai ter protótipo)

Consultar no `progress.md` se **Vai ter protótipo?** = `sim`.

**Se não** (sem protótipo):

```
Business rules  → skill business-rules
Use case        → skill use-case
Coerência       → checklist desta skill
Sprint task     → skill sprint-task
```

**Se sim** — perguntar ao usuário (não assumir sem confirmação):

```
Depois do Meeting notes, qual caminho?

1. Protótipo primeiro (recomendado quando há tela nova)
   → fecha fluxos no protótipo; depois Business rules e Use case com mais precisão
2. Artefatos de negócio primeiro
   → Business rules → Use case → (protótipo depois)
```

| Escolha | Ordem sugerida |
|---------|----------------|
| **1 — Protótipo primeiro** | Prototype spec → (Design task, se houver designer) → Protótipo Angular → Validação → **depois** Business rules → Use case → Sprint task |
| **2 — Negócio primeiro** | Business rules → Use case → Prototype spec → (Design task) → Protótipo Angular → Sprint task |

Registrar no `progress.md` o **Ramo pós Meeting notes:** `prototype-first` | `artifacts-first`.

**Padrão sugerido:** quando a feature tem tela nova, preferir **protótipo primeiro** — o protótipo define melhor os fluxos; Meeting notes + protótipo fechado alimentam Business rules e Use case com menos retrabalho.

### Flexibilidade

Após Meeting notes, a ordem das demais etapas é **flexível**. O usuário pode pular, reordenar ou pausar — respeitar a escolha e atualizar o **Próximo passo** no progress. Não forçar sequência rígida A2→A3→A4.

Em **modo guiado**, após cada etapa:
1. Executar skill referenciada (gerar 1 artefato)
2. Atualizar `progress.md` (`feature-progress`)
3. Entregar mensagem padrão (`docs/skill-conventions.md`)
4. **Parar e aguardar** confirmação do usuário — oferecer o próximo passo **do ramo**, não uma ordem fixa global

Em **modo batch**, enfileirar a sequência do ramo escolhido sem pausa entre etapas, mantendo progress após cada uma.

---

## Coerência (antes de declarar spec pronta)

Checklist (não gera arquivo separado — atualizar nota em progress **A5**):

- [ ] Slug consistente em todos os arquivos
- [ ] Business rules não contradizem meeting notes (nem o protótipo, se existir)
- [ ] Use case cobre edge cases das RNs
- [ ] Se há protótipo: prototype spec alinhado ao que foi validado nas telas
- [ ] Design task (se aplicável): sem detalhe de código; alinhada ao protótipo
- [ ] Sprint task: aceite verificável + pendências explícitas
- [ ] Nenhuma info crítica inventada

Marcar A5 `[x]` no progress; status geral → `validation` se sprint task ok.

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
│   └── prototype.md          ← só se vai ter protótipo
└── tasks/
    ├── design-task.md        ← opcional (designer)
    └── sprint-task.md
```

---

## Após sprint task — o que vem depois

| Etapa | Skill | Quando |
|-------|-------|--------|
| Issue GitLab | — | Criar issues (design-task e/ou sprint-task) |
| Protótipo Angular | `prototype-angular` | Se ramo inclui protótipo e ainda não feito |
| Prints | `prototype-export-screenshots` | Após protótipo Angular |
| Validação | `feature-progress` | Demo PO registrada |
| Implementação | — | {{API_REPO}} / {{SPA_REPO}} |
| Manual | `system-manual` | Pós-implementação |

Sugerir conforme o que faltar no ramo — não sugerir protótipo se estiver `[-]`.

---

## Anti-patterns

- Gerar vários artefatos sem gate inicial (incluindo decisão de protótipo)
- Assumir ordem rígida Business rules → Use case → Prototype após Meeting notes
- Perguntar sobre protótipo quando a feature já marcou **não**
- Modo batch sem pedido explícito
- Pular atualização de `progress.md`
- Marcar revisão manual 🔍 sem humano
- Confundir com `quick-fix` (bug/ajuste pontual)
- Escrever Business rules / Use case “definitivos” demais **antes** do protótipo quando o ramo é prototype-first (preferir fechar telas primeiro)

---

## Exemplo de abertura (modo guiado)

```
Vou especificar a feature em modo guiado — uma etapa por vez.

Antes de criar arquivos:
1. Qual problema de negócio esta feature resolve?
2. Quem é o usuário principal?
3. Vai ter protótipo (telas / mock navegável)? sim ou não
```
