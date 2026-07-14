---
name: design-to-spec
description: Especifica feature a partir de design visual já pronto (PNG/print de tela) — gera meeting notes via walkthrough visual, business rules, use case e sprint task. Pula A4, B1, B5 e B6 (design já existe). Use quando o usuário tiver print ou screenshot de tela pronta e quiser especificar a feature, gerar spec a partir de design, documentar feature com base em PNG ou iniciar spec design-first.
---

# Skill: Design-to-Spec

## Quando usar

**Gatilhos:**
- "tenho o print/PNG da tela, quero especificar..."
- "spec a partir do design..."
- "o design já está pronto, quero gerar os artefatos..."
- "tela do Figma/print → spec"

**Não usar** quando não houver design visual — usar `full-spec` (modo guiado padrão).

---

## Objetivo

Gerar spec completa (A1→B2) usando o **design visual como fonte primária** da A1, no lugar de reunião verbal. As etapas A4, B1, B5 e B6 são marcadas `[-]` N/A porque o design já existe.

**Referências:** `docs/skill-conventions.md` · `docs/feature-lifecycle.md`

---

## Fluxo

```
A0  Contexto + PNG(s) salvos em design/
A1  Meeting notes — walkthrough visual do PNG
A2  Business rules
A3  Use case
A5  Coerência
B2  Sprint task (referencia os PNGs)
B3  Issue GitLab
```

**Etapas N/A:** A4 · B1 · B5 · B6

**Modo padrão:** guiado — 1 artefato por vez, confirmação antes de avançar.  
**Modo batch:** só se o usuário pedir explicitamente.

---

## Fase A0 — Gate inicial

**Não crie nenhum arquivo até ter:**

- [ ] Problema de negócio + perfil do usuário
- [ ] Pelo menos 1 PNG anexado no chat ou caminho no repositório
- [ ] Escopo técnico: `{{API_REPO}}`, `{{SPA_REPO}}` ou ambos
- [ ] Slug confirmado (kebab-case)

Se faltar algo, pergunte — **máximo 3 perguntas por mensagem**.

**Ao passar o gate:**
1. Criar `sprints/sprint-{N}/features/{slug}/` com subpastas `spec/`, `design/`, `tasks/`
2. Salvar referência dos PNGs em `sprints/sprint-{N}/features/{slug}/design/` (ou anotar caminhos se já existentes)
3. Criar `sprints/sprint-{N}/features/{slug}/progress.md` (template `templates/feature-progress.md`) com A4, B1, B5, B6 marcados `[-]` e nota "design já existente (PNG em design/)"
4. Marcar **A0** `[x]` no progress
5. Informar modo (guiado/batch) e iniciar **A1**

---

## Fase A1 — Meeting notes via walkthrough visual

**Input:** PNG(s) + respostas do usuário às perguntas de gap.

### Walkthrough (percorrer tela a tela)

Para cada tela/estado visível no PNG, extrair:

| O que observar | O que registrar |
|----------------|-----------------|
| Título e contexto da tela | Onde ela aparece no produto |
| Componentes presentes | Tabelas, cards, filtros, botões, formulários |
| Labels e copy visíveis | Textual exatamente como aparece |
| Ações disponíveis | Botões, links, toggles e o que disparam |
| Estados visíveis | Dados preenchidos, vazio, erro, loading |
| Fluxo implícito | O que acontece antes/depois desta tela |

### Perguntas de gap obrigatórias (máx. 3 por rodada)

Antes de gerar o arquivo, fechar pelo menos:
1. **Contexto de negócio:** qual problema esta tela resolve? quem usa?
2. **Ações críticas:** o que acontece ao confirmar/salvar? há validações?
3. **Estados não visíveis no PNG:** como fica a tela em erro? em vazio?

Marcar `[PENDENTE]` o que não for respondido — não inventar.

**Saída:** `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md` (template `templates/meeting-notes.md`)

Na seção "Origem": registrar `design-to-spec — walkthrough PNG` e listar os arquivos em `design/`.

---

## Fase A2 — Business rules

Delegar à skill `business-rules`.

- Input: `spec/meeting-notes.md` gerado na A1
- Output: `spec/business-rules.md`

---

## Fase A3 — Use case

Delegar à skill `use-case`.

- Input: `spec/business-rules.md` + `spec/meeting-notes.md`
- Output: `spec/use-case.md`

---

## Fase A5 — Coerência

Checklist (não gera arquivo separado — atualizar nota A5 no progress):

- [ ] Slug consistente em todos os arquivos
- [ ] Business rules não contradizem o que é visível nos PNGs
- [ ] Use case cobre edge cases das RNs
- [ ] PNGs referenciados nas meeting notes e na sprint task
- [ ] Nenhuma informação inventada além do que foi fornecido

Marcar A5 `[x]` no progress; status geral → `validation` se B2 ok.

---

## Fase B2 — Sprint task

Delegar à skill `sprint-task`.

**Atenção:** a sprint task deve:
- Referenciar os PNGs em `design/` como fonte visual
- Incluir link/caminho dos arquivos PNG na seção de referências
- Marcar A4/B1/B5/B6 como `[-]` no progress antes de gerar

---

## Estrutura gerada

```
sprints/sprint-{N}/features/{slug}/
├── progress.md
├── spec/
│   ├── meeting-notes.md    ← A1 (walkthrough do PNG)
│   ├── business-rules.md   ← A2
│   └── use-case.md         ← A3
├── design/
│   ├── tela-principal.png  ← PNG(s) de referência visual
│   └── ...
└── tasks/
    └── sprint-task.md      ← B2 (referencia os PNGs)
```

---

## Progress — etapas N/A

Ao criar o `progress.md`, marcar já de início:

```
- [-] **A4** Prototype spec → `design/prototype.md` 🔍  
  - Nota: N/A — design já existente (PNG em design/)

- [-] **B1** Design task (UX/UI) → `tasks/design-task.md` 🔍  
  - Nota: N/A — design já concluído

- [-] **B5** Protótipo Angular → catálogo `prototypes/` 🔍  
  - Nota: N/A — design já existente (PNG em design/)

- [-] **B6** Validação com stakeholder (demo protótipo) 🔍  
  - Nota: N/A
```

---

## Após cada artefato

Seguir `docs/skill-conventions.md` — atualizar progress e entregar mensagem padrão.
