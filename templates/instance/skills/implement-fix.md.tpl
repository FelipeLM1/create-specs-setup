---
name: implement-fix
description: Guia o dev na investigação e correção de bug/ajuste no {{API_REPO}} e {{SPA_REPO}}. Pergunta até fechar gaps, identifica causa no código, corrige seguindo padrões do projeto e inclui testes unitários quando fizer sentido. Use quando pedir investigar bug, corrigir comportamento errado, implementar fix ou avançar F3.
---

# Skill: Implementar fix (guiada — dev)

## Quando usar

**Gatilhos:**
- "investigue o bug X" / "corrija o bug em…"
- "implemente o fix…"
- "o comportamento está errado em…"
- Continuar etapa **F3** de `fixes/{slug}/progress.md`

**Não usar quando:**
- Hotfix urgente em produção → GitLab + MR direto, sem fluxo specs
- Só **documentar** o bug (sem codar ainda) → `quick-fix`
- Nova funcionalidade ou RN nova → `full-spec`

**Repos:** alterações em `{{API_REPO}}` / `{{SPA_REPO}}`. Spec de fix em `fixes/{slug}/` quando existir.

**Referências:** `steering/engineering.md` · `ai-rules.md` · `docs/fix-lifecycle.md` · `docs/skill-conventions.md`

---

## Regra de ouro

> **Não altere código até entender o problema, reproduzir (ou ter evidência) e o dev confirmar o plano de correção.**

Perguntar sempre que houver gap — máximo **3 perguntas por mensagem**. Causa raiz incerta → `[HIPÓTESE]` + pedir validação antes do patch.

---

## Objetivo

1. Entender o bug (com ou sem `fix-task.md`)
2. **Localizar** a causa no código (investigação guiada)
3. Propor correção mínima alinhada aos padrões do projeto
4. Implementar + testes unitários quando fizer sentido
5. Validar aceite e atualizar `fixes/{slug}/progress.md`

---

## Fase 0 — Abertura

```
Vou guiar a investigação e correção. Antes de alterar código:

1. **Existe fix documentado** em `fixes/{slug}/` ou issue GitLab?
2. Se **sim** — qual slug, link ou caminho do fix-task?
3. Se **não** — descreva: o que acontece hoje, o que deveria acontecer, como reproduzir
```

---

## Fase 1 — Contexto: spec de fix sim ou não

### Caminho A — **Existe `fixes/{slug}/fix-task.md`**

Ler:

- `fixes/{slug}/fix-task.md`
- `fixes/{slug}/progress.md`
- Feature relacionada em `features/` (se linkada)
- `steering/engineering.md`

Confirmar com o dev se a descrição ainda está atualizada.

### Caminho B — **Não existe fix-task**

Coletar **antes de investigar no código**:

| # | Campo | Pergunta |
|---|-------|----------|
| B1 | **Atual vs esperado** | Comportamento hoje vs correto |
| B2 | **Reprodução** | Passos, dados, perfil de usuário, ambiente |
| B3 | **Onde** | Tela, endpoint, job, importação |
| B4 | **Serviços** | `{{API_REPO}}`, `{{SPA_REPO}}` ou ambos? |
| B5 | **Evidência** | Print, log, request/response, mensagem de erro |
| B6 | **Critérios de aceite** | Como saber que corrigiu? |

Se contexto mínimo incompleto → continuar perguntando **ou** sugerir `quick-fix` para documentar antes.

Opcional: oferecer criar `fix-task.md` via `quick-fix` se o time quiser rastreio formal.

---

## Fase 2 — Investigação (Search-first)

**Ainda sem alterar código** — salvo spikes acordados com o dev.

1. Localizar fluxo no `{{SPA_REPO}}` (componente, service, rota)
2. Localizar API no `{{API_REPO}}` (controller, service, query)
3. Formular **hipótese de causa** com evidência (arquivo, linha, trecho)
4. Se não reproduzir → pedir mais dados ao dev; marcar `[PENDENTE]`

Apresentar ao dev:

```markdown
## Diagnóstico (rascunho)

**Sintoma:** …
**Hipótese de causa:** …
**Evidência:** `{arquivo}` — …
**Confiança:** alta | média | baixa

Confirma o diagnóstico ou quer que eu investigue mais? (sim / investigar / corrigir entendimento)
```

---

## Fase 3 — Plano de correção (gate)

```markdown
## Plano de fix — {slug ou título}

**Arquivos a alterar:**
- …

**Correção proposta:** (1–3 frases)
**Risco de regressão:** …
**Testes unitários:** {novo teste em … | atualizar teste … | N/A — motivo}

**Posso aplicar a correção?** (sim / ajustar)
```

**Sem "sim" → não codar.**

---

## Fase 4 — Implementação

Mesmas regras de `implement-sprint-task` § Fase 3:

- Padrões de `steering/engineering.md` e código existente
- **Menor diff** que resolve o aceite
- **Testes** para regressão quando a lógica corrigida for testável
- Não expandir escopo ("já que estou aqui…")

---

## Fase 5 — Verificação e encerramento

1. Validar critérios de aceite do fix-task ou descrição oral
2. Rodar testes afetados
3. Atualizar `fixes/{slug}/progress.md` — **F3** (e F4/F5 se aplicável)
4. Resumir para MR/issue GitLab

---

## Diferença vs `quick-fix`

| | `quick-fix` | `implement-fix` (esta skill) |
|---|-------------|------------------------------|
| Foco | Documentar em `{{SPECS_REPO_SLUG}}` | Codar em `{{API_REPO}}` / `{{SPA_REPO}}` |
| Saída | `fix-task.md`, `progress.md` | Patch + testes |
| Quando | Antes ou sem implementação | Dev pronto para corrigir no código |

Fluxo comum: `quick-fix` → depois `implement-fix`. Se `fix-task` já existe, ir direto para Fase 2 desta skill.

---

## Anti-patterns

- Aplicar fix sem reprodução ou evidência (salvo hotfix acordado)
- Refatorar módulo inteiro no fix pontual
- Alterar RN/spec sem escalar para `full-spec`
- Codar sem plano confirmado

---

## Skills relacionadas

| Antes | Depois |
|-------|--------|
| `quick-fix` | `fix-progress` |
| `implement-sprint-task` (se virou feature) | MR / review humano |
