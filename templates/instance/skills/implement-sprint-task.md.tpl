---
name: implement-sprint-task
description: Guia o dev na implementação de tarefa/feature no {{API_REPO}} e {{SPA_REPO}} com base em spec existente ou descrição fornecida. Pergunta até fechar gaps, segue padrões do projeto (steering, artefatos, código) e inclui testes unitários quando fizer sentido. Use quando pedir implementar tarefa, implementar feature, desenvolver backend/frontend, cumprir sprint task ou avançar C1–C4.
---

# Skill: Implementar sprint task (guiada — dev)

## Quando usar

**Gatilhos:**
- "implemente a tarefa X" / "implemente a feature X"
- "desenvolva o backend/frontend de…"
- "codifique a sprint task…"
- "implemente conforme a issue #…"
- Continuar etapa **C1–C4** de `sprints/sprint-{N}/features/{slug}/progress.md`

**Não usar quando:**
- Hotfix urgente em produção → GitLab + MR direto
- Só gerar documentação de spec → `sprint-task`, `full-spec`, `spec-from-code`
- Corrigir bug → `implement-fix`

**Repos de código:** alterações em `{{API_REPO}}` e/ou `{{SPA_REPO}}`. Leitura de specs em `{{SPECS_REPO_SLUG}}`.

**Referências:** `steering/engineering.md` · `ai-rules.md` · `docs/feature-lifecycle.md` · `docs/skill-conventions.md`

---

## Regra de ouro

> **Não altere nenhum arquivo de código até a entrevista de contexto estar completa e o dev confirmar o plano.**

Se faltar informação: **perguntar** — máximo **3 perguntas por mensagem**. Não preencher lacunas com suposição; use `[HIPÓTESE]` ou `[PENDENTE]` e peça confirmação.

---

## Objetivo

Conduzir o desenvolvedor em modo **guiado**:

1. Entender o que implementar (com ou sem spec formal)
2. Ler artefatos e código existente (Search-first)
3. Apresentar plano de implementação para aprovação
4. Implementar seguindo **padrões do projeto**
5. Adicionar **testes unitários** quando fizer sentido
6. Verificar critérios de aceite e atualizar `progress.md`

---

## Fase 0 — Abertura (1ª interação)

Se o dev não deu contexto, comece assim:

```
Vou guiar a implementação. Antes de alterar código, preciso entender o escopo.

1. **Existe spec** para esta tarefa? (pasta em features/, sprint-task, issue GitLab, wiki RN)
2. Se **sim** — qual a referência? (slug, caminho, link)
3. Se **não** — descreva o que deve ser implementado: objetivo, telas/endpoints, critérios de aceite
```

Se o dev já disse "implemente a tarefa X", pule para Fase 1.

---

## Fase 1 — Spec: sim ou não

### Caminho A — **Existe spec**

Coletar referências (perguntar o que faltar):

| # | Campo | Pergunta |
|---|-------|----------|
| R1 | **Slug / pasta** | Qual `sprints/sprint-{N}/features/{slug}/`? |
| R2 | **Task** | Caminho de `tasks/sprint-task.md` ou link da issue GitLab? |
| R3 | **RN / use case** | Há `spec/business-rules.md` e `spec/use-case.md`? Outros? |
| R4 | **Camada** | Backend (`{{API_REPO}}`), frontend (`{{SPA_REPO}}`) ou ambos? |
| R5 | **Branch base** | Qual branch? (padrão sugerido: `develop`) |

**Leitura obrigatória antes de codar:**

- `sprints/sprint-{N}/features/{slug}/tasks/sprint-task.md`
- `sprints/sprint-{N}/features/{slug}/spec/business-rules.md` (se existir)
- `sprints/sprint-{N}/features/{slug}/spec/use-case.md` (se existir)
- `steering/product.md`, `steering/engineering.md`
- Código existente no domínio (Search-first em `{{API_REPO}}` / `{{SPA_REPO}}`)

### Caminho B — **Não existe spec**

Coletar descrição mínima — **não codar** até ter:

| # | Campo | Pergunta |
|---|-------|----------|
| D1 | **Objetivo** | O que deve passar a funcionar após a implementação? |
| D2 | **Escopo** | Telas, endpoints, entidades — o que entra e o que fica fora? |
| D3 | **Critérios de aceite** | 2–5 condições verificáveis |
| D4 | **Comportamento atual** | Já existe parcialmente ou é greenfield neste módulo? |
| D5 | **Camada** | Backend, frontend ou ambos? |
| D6 | **Referências visuais** | Protótipo, print, issue, conversa com PO? |

Se escopo crescer (RN nova, tela nova sem acordo) → sugerir fluxo `full-spec` antes de implementar.

---

## Fase 2 — Plano (gate antes do código)

Apresentar resumo e **aguardar confirmação explícita** do dev:

```markdown
## Plano de implementação — {título}

**Spec:** {sim — links | não — resumo}
**Repos:** {API | SPA | ambos}
**Branch:** {nome}

### Arquivos previstos (estimativa)
- …

### Padrões a seguir
- Stack e camadas: `steering/engineering.md`
- Convenções observadas no código existente (cite paths lidos)

### Testes unitários
- {o que será testado — ex.: service X, component Y} ou "não aplicável porque …"

### Critérios de aceite a validar
- [ ] …

### Pendências / hipóteses
- [HIPÓTESE] … ou [PENDENTE] …

**Posso começar as alterações no código?** (sim / ajustar)
```

**Sem "sim" explícito → não codar.**

---

## Fase 3 — Implementação

### Onde codar

| Camada | Repo | Padrões |
|--------|------|---------|
| Backend | `{{API_REPO}}` | Pacotes por domínio, camadas controller/service/repository — ver `steering/engineering.md` |
| Frontend | `{{SPA_REPO}}` | Feature modules, shared components — ver `steering/engineering.md` |

### Regras durante a implementação

1. **Search-first** — reutilizar padrões, nomes e abstrações já usados no domínio
2. **Menor diff** — só o necessário para cumprir a task
3. **RN/spec** — se divergir do artefato, **pare e pergunte**; não altere spec sem acordo
4. **Idioma do código** — conforme `steering/engineering.md` (geralmente inglês)
5. **Comentários** — só para lógica de negócio não óbvia

### Testes unitários

Incluir quando fizer sentido:

| Situação | Ação |
|----------|------|
| Regra de negócio em service | Teste unitário do service (JUnit/Vitest conforme repo) |
| Lógica de componente/pipe | Teste do componente |
| CRUD trivial sem lógica | Teste opcional — registrar no resumo por que pulou |
| Integração/E2E | Fora do escopo desta skill — sugerir plano manual se PO pedir |

Seguir framework e pastas de teste **já usados no repo** (não introduzir stack nova).

---

## Fase 4 — Verificação e encerramento

Antes de encerrar:

1. Percorrer **critérios de aceite** da task/spec
2. Rodar testes afetados (comando do repo: Maven, `ng test`, etc.)
3. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **C1** / **C2** / **C3** / **C4** conforme aplicável
4. Informar ao dev: arquivos alterados, testes adicionados, pendências

Mensagem de fechamento sugerida:

```markdown
**Implementação concluída** (aguardando seu review / MR)

- **Alterações:** {lista resumida}
- **Testes:** {adicionados / não aplicável — motivo}
- **Aceite:** {N}/{M} critérios atendidos
- **Próximo passo:** abrir MR, code review, atualizar issue GitLab
```

---

## Anti-patterns

- Codar antes da entrevista ou sem confirmação do plano
- Inventar RN, campos ou endpoints não presentes na spec/descrição
- Ignorar padrões do repo vizinho "por ser mais rápido"
- Pular testes em lógica de negócio relevante sem explicar
- Gravar código em `{{SPECS_REPO_SLUG}}` (exceto `progress.md`)

---

## Skills relacionadas

| Antes | Depois |
|-------|--------|
| `sprint-task` (gerar task) | `system-manual` (D1, pós-entrega) |
| `full-spec` (spec incompleta) | `feature-progress` (status) |
| `prototype-angular` (referência UX) | MR / code review (humano) |
