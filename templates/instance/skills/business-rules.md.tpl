---
name: business-rules
description: Gera regras de negócio (RN-{code}.{seq}) e requisitos funcionais (RF-{code}.{seq}) em sprints/sprint-{N}/features/{slug}/spec/business-rules.md a partir de meeting notes (e protótipo, se existir). Wiki externa opcional se sdd.config.yaml wiki.enabled. Use para business rules, regras de negócio ou antes de sprint task.
---

# Skill: Regras de negócio (spec primário)

## Quando usar

- "cadastrar regras de negócio na wiki"
- "gerar business rules de..."
- "criar RN-100" / "nova RN para a feature"
- Antes de sprint task em **feature nova** (gate obrigatório)

**Não usar** para hotfix urgente sem RN nova, nem para repetir RN já cadastrada sem alteração.

---

## Objetivo

Produzir, em `sprints/sprint-{N}/features/{slug}/spec/business-rules.md`, dois tipos de artefato com formatos distintos:

- **RN-{code}.{seq}** — Regras de negócio: decisões de produto, independentes de tecnologia
- **RF-{code}.{seq}** — Requisitos funcionais: o que o sistema faz para satisfazer as RNs

Ler `sdd.config.yaml` e `steering/product.md`. Se `business_rules.wiki.enabled: true`, também cadastrar na wiki externa e manter espelho alinhado.

Convenção: `docs/business-rules-store.md`.

---

## Separação de camadas — regra fundamental

| Camada | Identificador | Critério | Exemplos |
|--------|---------------|----------|---------|
| **Regra de negócio** | `RN-{code}.{seq}` | Decisão de produto; válida independente de linguagem ou framework; linguagem do domínio | "Somente usuários com perfil Gestor podem aprovar", "Inativação deve ser registrada no histórico" |
| **Requisito funcional** | `RF-{code}.{seq}` | O que o sistema faz; sem dizer como; referencia a RN que motiva | "O sistema registra um evento de criação ao persistir a entidade", "O sistema retorna lista paginada ordenada do mais recente" |
| **Detalhe de implementação** | — | Como o código resolve: classes, métodos, interfaces, frameworks, nomes de tabelas | Nomes de classes, métodos, interfaces, anotações de framework, estruturas de banco |

**Regra inviolável:** detalhes de implementação **nunca** entram no `business-rules.md`. Pertencem à sprint task, ADR ou documento técnico separado.

**Teste rápido:** se a frase usa nome de classe, método, interface ou framework — é implementação, não RN nem RF.

---

## Pré-condições (gate)

- [ ] `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md` com conteúdo suficiente
- [ ] `steering/product.md` lido (contexto de domínio)
- [ ] Usuário informou **código da RN** (ex.: `100`) — obrigatório
- [ ] Se existirem: `design/prototype.md` e/ou protótipo Angular — **ler como fonte** (especialmente no ramo `prototype-first`)

Se faltar código → **perguntar antes de escrever** (máx. 3 perguntas).

Se meeting notes inexistente → delegar `meeting-notes` ou `full-spec` primeiro.

---

## Passo 0 — Confirmar identificador RN

**Perguntar se ainda não informado:**

> Qual o código da RN desta feature? (ex.: **100** → regras `RN-100.1`, `RN-100.2`, …)

| Entrada | Ação |
|---------|------|
| `RN-100` ou `100` | `code = 100` |
| Wiki habilitada + link da página | Extrair `code` e validar espelho local |

### Wiki (somente se `wiki.enabled: true`)

Orientar cadastro na wiki usando `wiki.base_url` e `page_pattern`. Se página não existe, criar antes de publicar regras finais.

Exemplo (code `100`): `https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100`

---

## Passo a passo

### 1. Ler fontes de negócio

Absorver, nesta ordem:
1. `spec/meeting-notes.md` — problema, comportamentos, restrições, decisões, pendências
2. `design/prototype.md` e/ou protótipo Angular, **se existirem** — fluxos e estados de tela já fechados (ramo `prototype-first`)
3. Conversa atual com o usuário

No ramo protótipo-primeiro, preferir alinhar RNs ao que o protótipo já validou — evitar reinventar fluxo que a tela já define.

### 1b. Consultar código (search-first)

Quando a RN envolve integração, API, tela ou dado já existente:

1. Ler `sdd.config.yaml` e consultar `repos.api` / `repos.spa` no workspace (se disponíveis)
2. Buscar endpoints, entidades, componentes ou rotas relacionados ao escopo da feature
3. Comportamento **novo** → vem das meeting notes; comportamento **existente** → citar evidência no código ou marcar `[HIPÓTESE]`

Ver `ai-rules.md` § Search-first.

### 2. Preencher cabeçalho (template)

Usar `templates/business-rules.md`:

- Título: `# RN-{code} / <Nome>`
- Tabela: ID, **Wiki** (link completo), Nome, datas, Autor, Stakeholders, slug da feature
- Objetivo de negócio (uma frase)
- Glossário (só termos necessários)

### 3. Escrever regras de negócio (RN)

**Formato obrigatório:**

```markdown
### RN-{code}.{seq} — [nome curto]

- **SE** [condição em linguagem de negócio]
- **ENTÃO** [decisão de produto verificável]
- **Origem:** meeting notes / protótipo / [HIPÓTESE] / [PENDENTE]
```

| Princípio | Descrição |
|-----------|-----------|
| Decisão de produto | Independente de tecnologia — válida com qualquer stack |
| Linguagem do domínio | Sem classes, métodos, frameworks ou nomes de tabela |
| Testável | Dá para validar em aceite sem conhecer o código |
| Atômica | Uma decisão, uma responsabilidade |
| Rastreável | Origem explícita |

### 4. Escrever requisitos funcionais (RF)

**Formato obrigatório:**

```markdown
### RF-{code}.{seq} — [nome curto]

- **SE** [condição funcional]
- **ENTÃO** [comportamento do sistema, sem dizer como implementar]
- **Origem:** RN-{code}.{seq} que motiva este requisito
```

| Princípio | Descrição |
|-----------|-----------|
| Funcional | Descreve o que o sistema faz, não como |
| Sem implementação | Sem classes, métodos, interfaces ou frameworks |
| Rastreável | Referencia a RN que motiva |
| Sequência própria | `RF-{code}.1`, `RF-{code}.2`… independente da numeração RN |

**Nem toda RN gera um RF** — RNs de política pura (imutabilidade, retenção, acesso) podem não ter RF correspondente.

### 5. Validações, exceções e pendências

- Tabela **Validações e mensagens** referenciando `RN-{code}.{seq}` ou `RF-{code}.{seq}`
- **Exceções conhecidas** (comportamentos fora do fluxo normal que não justificam RN/RF próprios)
- **Pendências** apenas se houver decisão genuinamente em aberto — não registrar "não-regras" como pendência

### 6. Publicar na wiki (se habilitado)

1. Conteúdo final na página `RN{code}` da wiki (usuário ou agente com acesso).
2. Espelhar o mesmo conteúdo em `sprints/sprint-{N}/features/{slug}/spec/business-rules.md`.
3. Registrar no cabeçalho do espelho local o **link wiki** canônico.

### 7. Matriz opcional (features complexas)

Se a feature tiver muitos blocos de UI/API com filtros distintos, incluir seção **Matriz — aplicação de filtros por bloco** (como em dashboards), referenciando `RN-{code}.{seq}` nas células.

---

## Validação antes de entregar

- [ ] Código RN confirmado com o usuário
- [ ] RNs em linguagem de negócio — sem nomes de classe, método, interface ou framework
- [ ] RFs descrevem o que o sistema faz — sem dizer como implementar
- [ ] Detalhes de implementação ausentes — movidos para sprint task ou ADR
- [ ] Todas as regras usam `RN-{code}.{seq}` ou `RF-{code}.{seq}` (não RN-01 genérico)
- [ ] Regras testáveis; hipóteses `[HIPÓTESE]`; pendências somente se decisão genuinamente aberta
- [ ] Wiki cadastrada/atualizada **antes** de indicar sprint task (se habilitado)
- [ ] Espelho `spec/business-rules.md` atualizado

---

## Saída esperada

| Artefato | Onde |
|----------|------|
| Fonte primária | `sprints/sprint-{N}/features/{slug}/spec/business-rules.md` |
| Wiki (se enabled) | `{{WIKI_HOST_REPO}}` — `RN{code}` |
| Link para tasks | `https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN{code}` |

**Mensagem ao usuário (após gerar):**

```markdown
**Espelho:** `sprints/sprint-{N}/features/{slug}/spec/business-rules.md`
**Regras:** RN-{code}.1 … RN-{code}.{N} | RF-{code}.1 … RF-{code}.{M}
**Próximo:** use-case (A3) ou sprint-task (B2) — tasks devem referenciar RN/RF, não repetir o conteúdo
```

---

## Após gerar

1. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — **A2** `[x]` (`feature-progress`)
2. Responder conforme `docs/skill-conventions.md`

**Próximo passo:** Use case (`use-case`) · depois Sprint task (`sprint-task`) — ou Prototype spec se o ramo ainda for `artifacts-first` e o protótipo não foi feito
