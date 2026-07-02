---
name: {{GUIDE_SKILL_NAME}}
description: Ponto de entrada do {{SPECS_REPO_SLUG}} ({{PROJECT_NAME}}). Triagem conversacional (feature nova, spec-from-code, bug, ajuste, hotfix, status, continuar spec) e roteamento para a skill correta. Use quando o usuário não souber qual skill usar, pedir ajuda no repositório de specs, iniciar spec ou continuar de onde parou.
---

# Skill: {{PROJECT_NAME}} — Guide (entrada e roteamento)

## Quando usar

**Gatilhos:**
- "quero especificar…" / "preciso documentar…"
- "por onde começo no {{SPECS_REPO_SLUG}}?"
- "tenho um bug…" / "preciso de um ajuste…"
- "continuar a spec de…" / "onde paramos?"
- "qual o status de…?"
- Mensagem ambígua sobre feature, fix ou documentação
- Primeira interação no repositório {{SPECS_REPO_SLUG}}

**Esta skill não gera artefatos diretamente** — identifica o fluxo e delega à skill especializada.

Normalmente o usuário chega aqui via `welcome` — esta skill faz a **triagem fina**.

**Referências:** `docs/skill-conventions.md` · `AGENTS.md` · `welcome`

---

## Objetivo

Permitir que **qualquer pessoa** inicie ou retome trabalho no {{SPECS_REPO_SLUG}} **só conversando**, sem conhecer nomes de skills ou pastas.

---

## Abertura padrão (1ª mensagem)

Se o usuário não deu contexto suficiente, comece assim:

```
Posso ajudar no {{SPECS_REPO_SLUG}}. O que você precisa fazer?

1. **Feature nova** — especificar do zero (reunião → artefatos SDD)
2. **Documentar o que já está implementado** — spec a partir do código
3. **Bug ou ajuste** — correção pontual (fluxo enxuto em fixes/)
4. **Continuar** — retomar spec ou fix já iniciado
5. **Status** — ver andamento de feature ou fix
6. **Hotfix urgente** — produção (sem pasta no {{SPECS_REPO_SLUG}})

Descreva em uma frase ou escolha o número.
```

Se o usuário já descreveu o problema, **pule a lista** e vá direto à triagem.

---

## Triagem (decisão em 30 segundos)

| Sinal do usuário | Fluxo | Skill delegada |
|------------------|-------|----------------|
| Nova funcionalidade, reunião, tela nova, regra nova | Feature | `full-spec` (padrão guiado) |
| Feature nova com **design/PNG já pronto** (print de tela, screenshot) | Feature design-first | `design-to-spec` |
| Fluxo/tela/módulo **já implementado**, documentar a partir do código | Spec from code | `spec-from-code` |
| Comportamento errado vs esperado | Fix (doc) | `quick-fix` |
| Implementar / codar tarefa ou feature | Implementação | `implement-sprint-task` |
| Investigar e corrigir bug no código | Implementação fix | `implement-fix` |
| Label, copy, filtro, tweak acordado | Fix (`adjustment`) | `quick-fix` |
| "Onde paramos" / slug conhecido incompleto | Continuar | ver § Continuar abaixo |
| "Status da feature X" | Consulta | `feature-progress` |
| "Status do fix X" | Consulta | `fix-progress` |
| Produção quebrada, urgente | Hotfix | **Não** usar {{SPECS_REPO_SLUG}} — issue GitLab + MR |
| Só um artefato ("só meeting notes") | Etapa isolada | skill da etapa (ex.: `meeting-notes`) |

**Escalar fix → feature:** se PO precisa decidir **novo** comportamento, interrompa e sugira `full-spec`.

**Escalar feature → fix:** se só corrige comportamento já definido, sugira `quick-fix`.

---

## Roteamento por fluxo

### Feature nova

1. Confirmar que não é bug/ajuste nem documentação de código existente.
2. Perguntar: *"Você tem um design visual (print/PNG de tela) pronto?"*
   - Sim → delegar `.agents/skills/design-to-spec/SKILL.md`
   - Não → delegar `full-spec` em **modo guiado** (padrão)
3. Se usuário pedir batch: delegar `full-spec` em **modo batch**.

### Spec a partir do código

1. Confirmar que o fluxo **já existe** no código (API e/ou SPA).
2. Informar: *"Vou ler o código e gerar só os documentos que você escolher."*
3. Delegar `.agents/skills/spec-from-code/SKILL.md`.

### Implementação (dev)

1. Confirmar: implementar **feature/task** ou **corrigir bug**?
2. **Feature/task** → delegar `.agents/skills/implement-sprint-task/SKILL.md`
3. **Bug/fix no código** → delegar `.agents/skills/implement-fix/SKILL.md`
4. Se só documentar bug → `quick-fix` (não confundir com implement-fix)

### Bug / ajuste (documentação)

1. Perguntar urgência: *"É hotfix em produção?"*
   - Sim → orientar GitLab direto, encerrar fluxo {{SPECS_REPO_SLUG}}.
   - Não → delegar `.agents/skills/quick-fix/SKILL.md`.

### Status

- Feature: ler `features/{slug}/progress.md` via `feature-progress`.
- Fix: ler `fixes/{slug}/progress.md` via `fix-progress`.
- Slug desconhecido: listar pastas em `features/` e `fixes/` e pedir qual.

### Continuar spec ou fix

1. Identificar slug (perguntar se necessário).
2. Ler `progress.md` correspondente.
3. Encontrar **primeira etapa incompleta** no checklist.
4. Informar ao usuário:

```markdown
**Item:** {slug}
**Tipo:** feature | fix
**Status geral:** {status}
**Última etapa concluída:** {ID}
**Próxima etapa:** {ID} — {nome}
**Pendências abertas:** {resumo ou "nenhuma"}

Posso continuar com {próxima etapa}? (farei perguntas se faltar contexto)
```

5. Se usuário confirmar, delegar:

| Próxima etapa | Skill |
|---------------|-------|
| R0–R6 (spec-from-code) | `spec-from-code` |
| A1 | `meeting-notes` |
| A2 | `business-rules` |
| A3 | `use-case` |
| A4 | `prototype-spec` |
| A5 | `full-spec` (checklist coerência) ou revisão manual |
| B1 | `design-task` |
| B2 | `sprint-task` |
| B5 | `prototype-angular` |
| B6 | atualizar `feature-progress` (registro demo) |
| C1 | `implement-sprint-task` (backend) |
| C2 | `implement-sprint-task` (frontend) |
| C3–C4 | `implement-sprint-task` (verificação / aceite) |
| D1 | `system-manual` |
| F1 (fix) | `quick-fix` (atualizar) |
| F3 | `implement-fix` |
| F2+ (status) | `fix-progress` |

6. Executar a skill delegada seguindo `docs/skill-conventions.md`.

---

## Mapa rápido de skills

| Skill | Função |
|-------|--------|
| `{{GUIDE_SKILL_NAME}}` | Entrada e roteamento (esta skill) |
| `full-spec` | Orquestra A1–B2 (feature sem design prévio) |
| `design-to-spec` | Feature a partir de design/PNG pronto — A1 via walkthrough visual |
| `meeting-notes` | A1 |
| `business-rules` | A2 |
| `use-case` | A3 |
| `prototype-spec` | A4 |
| `design-task` | B1 (UX/UI) |
| `sprint-task` | B2 (dev) |
| `prototype-angular` | B5 |
| `system-manual` | D1 |
| `feature-progress` | Status / checklist feature |
| `spec-from-code` | Spec de fluxo já implementado (código → artefatos) |
| `quick-fix` | Fix/ajuste (F1 — documentação) |
| `implement-sprint-task` | Implementação guiada (C1–C4) |
| `implement-fix` | Investigação + correção guiada (F3) |
| `fix-progress` | Status / checklist fix |

---

## Anti-patterns

- Gerar artefatos nesta skill sem delegar
- Escolher fluxo sem triagem quando ambíguo
- Ignorar hotfix urgente e criar pasta em `fixes/`
- Continuar batch quando usuário não pediu

---

## Exemplo de roteamento

**Usuário:** "Preciso documentar a importação de planilha do fornecedor."

**Resposta:**
```
Isso é feature nova. Vou usar o fluxo guiado (meeting notes → business rules → …).

Antes de gerar qualquer arquivo, preciso entender:
1. Qual problema essa importação resolve hoje?
2. Quem usa (perfil do usuário)?
3. Já existe decisão de escopo ou reunião registrada?
```

→ Em seguida, invocar `full-spec` Fase 0.

**Usuário:** "Preciso documentar o cadastro de usuário que já está na tela."

**Resposta:**
```
Isso é spec a partir do código. Vou ler API e SPA e gerar só os documentos que você escolher.

1. Qual o slug da pasta (ex.: usuario-cadastro)?
2. Quais artefatos quer: RN, use case, gaps, insights — todos ou alguns?
```

→ Em seguida, invocar `spec-from-code`.
