---
name: spec-from-code
description: Gera especificação a partir de código já implementado — lê API e SPA, infere RN, use case, gaps e insights. Pergunta quais artefatos gerar. Use quando o usuário pedir documentar fluxo/tela/módulo existente, spec do que já está implementado ou reverse spec from code.
---

# Skill: Spec a partir do código

## Quando usar

**Gatilhos:**
- "documentar o que já está implementado"
- "criar spec do fluxo de cadastro de usuário"
- "especificar a partir do código"
- "reverse engineer" / "engenharia reversa da feature X"
- "gerar RN e use case do que já existe na tela"

**Não usar** quando:
- feature ainda não existe no código → `full-spec`
- só corrigir bug → `quick-fix`
- meeting notes ou RN a partir de reunião (sem ler código como fonte) → `business-rules` / `full-spec`

**Diferença do fluxo normal:** a **fonte de verdade é o código** (API + SPA), não meeting notes.

---

## Objetivo

Documentar um fluxo **já implementado** em `features/{slug}/`, gerando apenas os artefatos que o usuário escolher:

| Artefato | Arquivo |
|----------|---------|
| Regras de negócio | `spec/business-rules.md` |
| Casos de uso | `spec/use-case.md` |
| Gaps encontrados | `spec/implementation-gaps.md` |
| Insights de evolução | `spec/evolution-insights.md` |

Sempre criar `spec/analysis-context.md` (escopo, repos, arquivos analisados).

---

## Regra de ouro

> **Não gravar artefatos até:**
> 1. Escopo e slug confirmados
> 2. Usuário escolher **quais** documentos gerar
> 3. Código relevante lido no workspace (search-first)
> 4. Resumo do que será gerado confirmado

Máx. **3 perguntas por mensagem**. Seguir `ai-rules.md` (fato / `[HIPÓTESE]` / `[PENDENTE]`).

---

## Passo 1 — Entrevista (gate)

Perguntar (agrupar em até 3 por rodada):

| # | Pergunta | Campo |
|---|----------|-------|
| 1 🔴 | Qual fluxo/módulo/tela documentar? (ex.: "cadastro de usuário") | escopo |
| 2 🔴 | Slug da pasta `features/{slug}/` — criar nova ou usar existente? | `slug` |
| 3 🔴 | Código RN da feature (ex.: `100`) — ou próximo livre | `RN-{code}` |
| 4 🔴 | **Quais artefatos gerar?** (marcar todos que aplicam) | seleção |
| 5 🟡 | Dicas de onde está no código? (rota, módulo, endpoint) | pistas |
| 6 🟡 | Pasta já tem spec greenfield? Sobrescrever, mesclar ou pasta nova? | estratégia |

**Texto sugerido (seleção de artefatos):**

```
Quais documentos devo gerar para este fluxo?

1. Regras de negócio (`business-rules.md`)
2. Casos de uso (`use-case.md`)
3. Gaps encontrados (`implementation-gaps.md`)
4. Insights para evolução (`evolution-insights.md`)

Responda: todos, ou liste os números (ex.: 1 e 2).
```

Se pasta `features/{slug}/` já existir com conteúdo → **não sobrescrever** sem confirmação explícita.

---

## Passo 2 — Análise do código (search-first)

Ler `sdd.config.yaml`, `steering/product.md`, `steering/engineering.md`.

**Repos** (do config): `repos.api`, `repos.spa` e `repos.extra[]` se aplicável.

Buscar no código (adaptar à stack):

| Camada | Onde procurar |
|--------|---------------|
| SPA | rotas, módulos, componentes, services, guards, formulários |
| API | controllers, handlers, DTOs, validações, entidades, testes |
| Contratos | OpenAPI, testes de integração, fixtures |

Registrar em `spec/analysis-context.md`:

- Data da análise
- Repos e paths analisados
- Lista de arquivos relevantes (com caminho)
- Limitações (código não encontrado, módulo parcial)

**Não inventar** comportamento sem evidência — citar arquivo ou endpoint. Incerteza → `[HIPÓTESE]` ou `[PENDENTE]`.

---

## Passo 3 — Gerar artefatos (somente os selecionados)

Usar templates em `templates/`. No topo de **cada** arquivo:

```markdown
> **Origem:** spec-from-code (inferido do código)
> **Data:** YYYY-MM-DD
> **Repos:** {api}, {spa}
> **Revisão humana:** pendente
```

### `spec/business-rules.md` (se pedido)

- Formato SE/ENTÃO, `RN-{code}.{seq}`
- Cada RN relevante: coluna **Evidência** (arquivo, método, endpoint)
- Comportamento confirmado no código = fato; inferido = `[HIPÓTESE]`
- Se `wiki.enabled`: perguntar se publica na wiki **depois** da revisão humana

### `spec/use-case.md` (se pedido)

- Happy path, alternativos e exceções **observados** no código
- Estados de UI se identificados no SPA
- Referenciar RNs quando existirem no mesmo slug

### `spec/implementation-gaps.md` (se pedido)

Documentar lacunas e riscos, por exemplo:

- Validação só no front ou só no back
- Tratamento de erro ausente ou inconsistente
- Código morto / fluxo inacessível
- Divergência API ↔ UI
- Segurança, permissões, edge cases não cobertos

Classificar severidade: `alta` | `média` | `baixa`

### `spec/evolution-insights.md` (se pedido)

Oportunidades de produto e melhorias — **marcar como `[HIPÓTESE]`** quando não confirmadas com stakeholder.

Separar de gaps: aqui é evolução/ideia, não defeito.

---

## Passo 4 — Progress e handoff

1. Criar ou atualizar `features/{slug}/progress.md` a partir de `templates/spec-from-code-progress.md`
2. Marcar etapas R* concluídas conforme artefatos gerados
3. Status geral: `spec_from_code` até revisão humana; depois sugerir `done` ou evolução via `full-spec`

**Mensagem pós-etapa** (obrigatória):

```markdown
**Fluxo:** spec-from-code
**Slug:** {slug}
**Artefatos gerados:** {lista}
**Arquivos analisados:** {n} — ver `spec/analysis-context.md`

🔍 **Revisão humana obrigatória** — o código pode não refletir a intenção de negócio.

Próximos passos possíveis:
- Corrigir gaps → `quick-fix` ou sprint task manual
- Evoluir feature → `full-spec` (complementar meeting notes)
- Publicar RN na wiki (se habilitada) → após revisão
```

---

## Anti-patterns

- Gerar meeting notes ou prototype-spec neste fluxo
- Tratar inferência do agente como RN oficial sem revisão
- Documentar o sistema inteiro em uma rodada — fatiar por fluxo
- Ignorar `steering/product.md` ao nomear atores e termos de domínio
- Sobrescrever spec greenfield existente sem confirmação

---

## Referências

- `docs/feature-lifecycle.md` § Fluxo spec-from-code
- `ai-rules.md` § Search-first
- `docs/business-rules-store.md`
- Templates: `analysis-context.md`, `implementation-gaps.md`, `evolution-insights.md`, `spec-from-code-progress.md`
