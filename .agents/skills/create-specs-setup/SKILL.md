---
name: create-specs-setup
description: Configura instância SDD completa via entrevista guiada sem gaps — steering, sdd.config, templates, skills e opcionalmente protótipo Angular gerado a partir do SPA do projeto. Pergunta tudo ao usuário antes de gravar. Use na primeira configuração do projeto no workspace multi-root.
---

# Skill: create-specs-setup

## Quando usar

- Primeira configuração SDD de um produto
- "configurar specs", "setup SDD", "criar repositório de especificações"
- Workspace com repos de código + pasta destino `{projeto}-specs`

**Não usar** para meeting notes, features ou fixes — isso é na **instância** gerada.

**Referências:** `docs/setup-interview-checklist.md` (checklist completo) · `docs/instance-contract.md` · `templates/instance/`

**Sem scripts** — o agente cria e copia arquivos diretamente.

---

## Regra de ouro

> **Não grave nenhum arquivo na instância até:**
> 1. Todos os itens 🔴 do checklist estiverem respondidos
> 2. Rascunhos de `steering/product.md` e `steering/engineering.md` estiverem **confirmados** pelo usuário
> 3. O usuário disser **sim** ao resumo final (Fase 6)

Se faltar dado: **perguntar** — máx. **3 perguntas por mensagem**, agrupadas por fase.

Não inventar paths, URLs, stack ou glossário. Use `[PENDENTE]` só para itens 🟡 não críticos — liste-os no resumo final.

---

## Objetivo

Conduzir usuário **não técnico** por entrevista **completa**, gravar **steering** e `sdd.config.yaml`, montar a árvore da instância (`contract_version: 1`) e, se confirmado, scaffold do protótipo Angular lendo o SPA real.

Idioma padrão: **pt-BR** (confirmar na Fase 0).

---

## Abertura (Fase 0 — primeira mensagem)

```
Vou configurar o SDD do seu projeto. Vou fazer perguntas por etapas — nada será criado até você confirmar o resumo final.

Para começar:
1. Qual o **caminho completo** da pasta do repositório de specs? (destino)
2. É setup **novo** ou **atualização** de instância que já existe?
3. Qual o **nome do produto/sistema**?
```

Se **atualização** → delegar `upgrade-specs` e encerrar esta skill.

---

## Entrevista completa (seguir ordem)

Consulte **`docs/setup-interview-checklist.md`** — todas as fases abaixo são obrigatórias no setup novo.

### Fase 0 — Escopo

Coletar: `TARGET_DIR`, vazio ou não, `PROJECT_NAME`, `SPECS_REPO_SLUG`, `GUIDE_SKILL_NAME`, idioma, responsável, greenfield vs produção, URL git do specs (se houver).

**Validar:** pasta destino existe ou pode ser criada.

### Fase 1 — Negócio → `steering/product.md`

Perguntar 🔴: problema, usuários, valor, limites de escopo.

Perguntar 🟡: glossário, docs externas, responsável.

Montar rascunho markdown → **pedir confirmação explícita** antes de Fase 2.

### Fase 2 — Engenharia → `steering/engineering.md` + `repos`

Perguntar 🔴: paths API e SPA no workspace, stack, convenções de código.

**O agente deve:**
- Verificar se `{API_REPO}` e `{SPA_REPO}` existem no workspace (listar diretório)
- Ler `package.json` / `pom.xml` / `README` quando disponível — **não assumir** stack

Perguntar 🟡: repos extras, design system path, branches, migrations.

Montar rascunho → **confirmar** com usuário.

### Fase 3 — Regras de negócio

Perguntar 🔴:
- Confirmar primário = `spec/business-rules.md`
- Wiki externa para RN? **sim/não**

Se **sim** 🔴: `base_url`, repo da wiki, padrão de página, quem publica.

Se **não**: `wiki.enabled: false`.

### Fase 4 — GitLab / fluxo operacional

Perguntar 🔴:
- Usa GitLab (ou similar) para issues? **sim/não**
- Se sim: URL base
- Hotfix urgente vai **direto** no GitLab sem `fixes/`? (padrão SDD: sim)

Perguntar 🟡: namespace, split backend/frontend nas tasks.

**Pergunta obrigatória — templates de tarefas (Fase 4.6):**

> Vocês já têm um **padrão ou template** para escrever tarefas no GitLab (dev, frontend, backend, design)?  
> Querem **manter o de vocês** ou seguimos com o **template padrão** do setup?

| Resposta | O que fazer na gravação (Fase 7) |
|----------|----------------------------------|
| **Template padrão** | Copiar `templates/sprint-task.md`, `design-task.md`, `fix-task.md` do bootstrap sem mudar a estrutura |
| **Template do time** | Pedir **exemplo** (colar issue, link ou descrever seções obrigatórias). Adaptar os templates da instância ao padrão do time. Se o formato for muito diferente, ajustar também as skills `sprint-task` e `design-task` |

Registrar em `sdd.config.yaml` → `workflow.task_templates`: `default` ou `custom`.

Se **custom** e o time usa arquivos separados por camada, alinhar com `workflow.sprint_task_split_default` (`single` ou `backend_frontend`).

### Fase 5 — Protótipo Angular

Pergunta 🔴 explícita:

> Deseja incluir o app de **protótipo de alta fidelidade** (Angular mockado, catálogo vazio) **agora**?

- **Não** → `prototype.enabled: false`
- **Sim** → **requisito obrigatório:** o SPA do projeto (`repos.spa`) deve existir e estar acessível no workspace. Sem SPA válido → não ativar protótipo; pedir adicionar o repo ou seguir com `prototype.enabled: false`.

Se **sim** e SPA ok:

1. Confirmar `prototype.spa_source_repo` (= `repos.spa`)
2. Perguntar se copia **todos** os shared components ou só subset
3. Alinhar versão Angular / Tailwind lendo `package.json` do SPA
4. Confirmar se valida com `npm install && npm start` após montar

> **Não há shell genérico no bootstrap.** O protótipo é montado lendo o SPA real do projeto — layout, estilos e componentes compartilhados.

---

## Fase 6 — Resumo final (gate antes de gravar)

Apresentar tabela com **todos** os valores definidos (ver checklist § Fase 6).

Listar `[PENDENTE]` não críticos restantes.

Perguntar:

> **Posso gravar a instância SDD em `{TARGET_DIR}` com essas configurações?**

**Sem "sim" explícito → não gravar.**

---

## Fase 7 — Gravar instância (somente após confirmação)

### 1. `sdd.config.yaml`

Preencher todos os campos (ver template `templates/instance/sdd.config.yaml.tpl`):

```yaml
contract_version: 1
project:
  name, specs_repo_slug, language, git_url, owner
repos:
  api, spa, extra: []
business_rules:
  primary_store: specs_repo
  wiki: enabled, base_url, host_repo, page_pattern
gitlab:
  enabled, base_url, namespace
workflow:
  hotfix_outside_specs: true
  task_templates: default | custom
  sprint_task_split_default: single | backend_frontend
prototype:
  enabled, spa_source_repo, folder, dev_port, feature_base_path, feature_folder_pattern
skills:
  guide_name
```

### 2. Steering

Gravar `steering/product.md` e `steering/engineering.md` (versão confirmada na entrevista).

### 3. Árvore da instância

| Origem (create-specs-setup) | Destino |
|--------------------|---------|
| `templates/instance/sdd.config.yaml.tpl` | `sdd.config.yaml` |
| `templates/instance/AGENTS.md.tpl` | `AGENTS.md` |
| `templates/instance/ai-rules.md.tpl` | `ai-rules.md` |
| `templates/instance/README.md.tpl` | `README.md` |
| `templates/instance/docs/*.tpl` | `docs/*.md` |
| `templates/instance/templates/*.md` | `templates/*.md` — ver § Templates de tarefas abaixo |
| `templates/instance/sprints/README.md.tpl` | `sprints/README.md` |
| `templates/instance/fixes/README.md.tpl` | `sprints/sprint-1/fixes/README.md` |
| `templates/instance/skills/welcome.md.tpl` | `.agents/skills/welcome/SKILL.md` |
| `templates/instance/skills/specs-guide.md.tpl` | `.agents/skills/{GUIDE_SKILL_NAME}/SKILL.md` |
| `templates/instance/skills/{nome}.md.tpl` | `.agents/skills/{nome}/SKILL.md` |

Criar estrutura inicial da sprint 1:

```
sprints/sprint-1/features/.gitkeep
sprints/sprint-1/fixes/README.md   # a partir do tpl
sprints/sprint-1/meetings/.gitkeep
```

(`workflow.current_sprint: 1` no `sdd.config.yaml`)

Substituir placeholders ao gravar (ver checklist e template).

**Templates de tarefas (`workflow.task_templates`):**

- **`default`:** copiar `sprint-task.md`, `design-task.md`, `fix-task.md` do bootstrap; substituir `{{GITLAB_BASE_URL}}`, `{{WIKI_HOST_REPO}}`, `{{API_REPO}}`, `{{SPA_REPO}}`, `{{SPECS_REPO_SLUG}}` pelos valores do `sdd.config.yaml`.
- **`custom`:** usar o exemplo do time como fonte de verdade; reescrever os templates da instância mantendo nomes de arquivo (`sprint-task.md`, etc.) para as skills continuarem funcionando. Documentar no resumo final quais templates foram personalizados.

### 4. Protótipo (se `prototype.enabled: true`)

**Requisito:** o protótipo **sempre** deriva do SPA do projeto configurado (`repos.spa`). Não usar código, ícones ou layout de outro produto.

**Pré-condição (gate):** `{SPA_REPO}` existe no workspace e contém app Angular. Se falhar → corrigir workspace ou desativar protótipo.

**Passos:**

1. **Ler o SPA** — `package.json`, `angular.json`, `src/app/` (layout, rotas), `src/styles/`, `src/app/shared/components/`
2. **Inicializar** `{TARGET_DIR}/prototypes/` com stack alinhada ao SPA (versão Angular, Tailwind, etc.)
3. **Copiar/adaptar do SPA** (sem HttpClient, auth nem serviços de API):
   - componentes em `shared/components/` (ou subset acordado)
   - estilos globais / variáveis de tema
   - padrão de layout (sidebar, header, footer) se existir no SPA
4. **Montar estrutura SDD** em `prototypes/`:
   - `src/app/prototypes/registry/prototype-catalog.data.ts` — catálogo vazio
   - `src/app/feature/README.md` — convenção `{task_ref}-{slug}`
   - rotas mínimas (catálogo + placeholder)
5. Registrar `prototype.spa_source_repo` e `prototype.shared_components_path` em `sdd.config.yaml`
6. Perguntar se deve rodar `npm install && npm start` para validar

### 5. Verificação pós-gravação (obrigatório — gate antes do handoff)

**Não encerrar o setup** até executar cada item abaixo. Se algum falhar → corrigir e revalidar.

| # | Verificação | Como checar |
|---|-------------|-------------|
| V1 | `sdd.config.yaml` com `contract_version: 1` | leitura do arquivo |
| V2 | **Nenhum** arquivo gravado contém `{{` (placeholders não substituídos) | buscar `{{` em `{TARGET_DIR}` |
| V3 | 17 pastas em `.agents/skills/*/SKILL.md` | listar diretórios |
| V4 | Cada `SKILL.md` com frontmatter `name` + `description` | primeiras linhas de cada skill |
| V5 | `AGENTS.md` aponta para `welcome`; guide com nome real (`{GUIDE_SKILL_NAME}`) | leitura |
| V6 | 14 arquivos em `templates/` | contagem |
| V7 | `sprints/README.md`, `sprints/sprint-1/features/.gitkeep`, `sprints/sprint-1/fixes/README.md`, `ai-rules.md`, `steering/product.md`, `steering/engineering.md` | existência |
| V8 | Skills críticas referenciam `{{GUIDE_SKILL_NAME}}` já substituído (ex.: sprint-task) | buscar `{{` em `.agents/skills/` |
| V9 | `ai-rules.md` contém seção Search-first | leitura |
| V10 | Se `prototype.enabled`: `prototypes/package.json`, catálogo vazio em `registry/` e `src/app/feature/README.md` | só se protótipo ativo |
| V11 | Nenhum arquivo gravado contém referências hardcoded a projetos externos (URLs ou nomes de repos alheios) | busca textual em `{TARGET_DIR}` |

Apresentar tabela **✅ / ❌** ao usuário. Com qualquer ❌, corrigir antes do handoff.

Referência: `docs/instance-contract.md` § Validação pós-setup.

---

## Handoff

```markdown
**Instância SDD pronta em:** `{TARGET_DIR}`

**Config:** `sdd.config.yaml`
**Steering:** `steering/product.md`, `steering/engineering.md`
**Entrada:** skill `welcome` (triagem fina: `{GUIDE_SKILL_NAME}`)

**Pendências não críticas:** {lista ou "nenhuma"}

No dia a dia, trabalhe só neste repositório.
Ex.: "Quero especificar uma feature nova"

O repositório create-specs-setup pode sair do workspace.
```

---

## Anti-patterns

- Gravar arquivos antes do resumo confirmado
- Assumir paths de API/SPA sem verificar no workspace
- Assumir stack sem ler repos
- Pular wiki / GitLab / hotfix / templates de tarefas sem perguntar
- Deixar `steering/product.md` com `[PENDENTE]` em problema/usuários/valor/escopo
- Executar scripts bash
- Criar `features/{slug}` durante setup
- Ativar protótipo sem SPA do projeto no workspace
- Montar `prototypes/` com assets ou código de outro produto — sempre derivar do SPA configurado
- Copiar protótipos de domínio de outro projeto
- Encerrar setup sem rodar a verificação V1–V11 (§ Fase 7.5)
- Gravar templates com URLs ou nomes de repos de um projeto específico (usar placeholders do `sdd.config.yaml`)
