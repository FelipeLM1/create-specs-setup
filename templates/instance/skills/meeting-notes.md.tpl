---
name: meeting-notes
description: Gera meeting notes estruturadas a partir de contexto de reunião ou conversa com stakeholder. Use quando o usuário pedir registrar reunião, documentar conversa, criar meeting notes ou iniciar spec de feature no {{SPECS_REPO_SLUG}} (etapa A1).
---

# Skill: Gerar Meeting Notes

## Quando usar

Use esta skill quando o usuário fornecer o contexto de uma reunião ou conversa com cliente/stakeholder e pedir para registrar, documentar ou criar as meeting notes.

**Gatilhos:**
- "registrar reunião de..."
- "criar meeting notes de..."
- "documentar conversa sobre..."
- "gerar meeting notes para a feature..."

---

## Objetivo

Transformar contexto verbal/informal em um `meeting-notes.md` estruturado, rastreável e pronto para avançar para business rules — sem inventar informações além do que foi fornecido.

---

## Passo a passo

### 1. Coletar o contexto mínimo necessário

Antes de gerar, verifique se você tem:

- [ ] O contexto da conversa (o que foi discutido)
- [ ] Um slug sugerido para a feature (ou você propõe um)
- [ ] Data da reunião (se disponível — senão usar a data atual)
- [ ] Participantes (se disponível — senão deixar em aberto)

> Se o contexto for muito raso, **não escreva o arquivo** — pergunte (máx. 3 por mensagem). Ver `docs/skill-conventions.md`.

### 2. Propor o slug da feature

Slug em **kebab-case**, descritivo, em português ou inglês (consistente com outros slugs do projeto).

Bons exemplos: `importacao-planilha-csv`, `filtro-por-periodo`, `dashboard-resumo-operacional`

### 3. Criar a estrutura de pastas

A feature deve seguir esta estrutura:

```
sprints/sprint-{N}/features/{slug}/
├── spec/
│   ├── meeting-notes.md    ← este arquivo
│   ├── business-rules.md
│   └── use-case.md
├── design/
│   └── prototype.md
├── tasks/
│   └── sprint-task.md
└── docs/
    └── system-manual.md    (pós-implementação)
```

Crie apenas `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md` agora. As demais pastas e arquivos serão criados nas próximas etapas.

### 4. Gerar o arquivo

Use o template `templates/meeting-notes.md` como base. Preencha com o conteúdo extraído do contexto fornecido.

**Regras de preenchimento:**

| Seção | Como preencher |
|-------|---------------|
| **Contexto** | Por que esta conversa aconteceu — o problema ou oportunidade |
| **O que foi pedido** | Lista objetiva — sem interpretar além do que foi dito |
| **Fatos confirmados** | Só o que é certeza — sem inferências |
| **Decisões tomadas** | Só decisões explícitas — não inferir |
| **Regras mencionadas** | Qualquer "não pode", limite ou condição citada — serão refinadas em business-rules |
| **Dúvidas e pendências** | Tudo que impede avançar com segurança — seja generoso aqui |
| **Fora de escopo** | O que foi explicitamente descartado ou adiado |

**Marcadores obrigatórios:**
- `[HIPÓTESE]` — inferência ou suposição que não foi confirmada explicitamente
- `[PENDENTE]` — informação que falta e impede avançar

### 5. Validar antes de entregar

- [ ] Nenhuma regra de negócio detalhada inventada (isso vai para `business-rules.md`)
- [ ] Hipóteses marcadas com `[HIPÓTESE]`
- [ ] Dúvidas críticas listadas com responsável (se souber)
- [ ] Status = `rascunho`
- [ ] Slug consistente com o negócio

---

## Saída esperada

Arquivo `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md` pronto, com:
- Cabeçalho preenchido (feature, status, data, origem)
- Seções preenchidas com base no contexto real
- Dúvidas explícitas listadas
- Nada inventado além do que foi fornecido

---

## Após gerar — progress e entrega

1. Criar ou atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **A0** e **A1** `[x]` (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximo passo:** A2 — Business rules (skill `business-rules`)
