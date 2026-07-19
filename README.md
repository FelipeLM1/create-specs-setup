# create-specs-setup

Como o **create-react-app**, mas para o repositório de **especificações** do seu produto.

Rode **uma vez** → nasce `{projeto}-specs` com steering, skills, templates e (opcional) protótipo Angular mockado. No dia a dia, use **só** `{projeto}-specs`.

## Como começar (instrução para o usuário)

**Você não precisa saber nomes de skills.** Abra o Agent no Cursor e converse de forma natural — a skill [`welcome`](.agents/skills/welcome/SKILL.md) é o ponto de entrada. Ela apresenta as opções e o agente segue guiando você pelas skills certas, uma etapa por vez.

### No `create-specs-setup` (primeira vez ou upgrade)

Abra o chat com este repositório no workspace e diga, por exemplo:

- *"Olá"*
- *"Quero configurar o SDD do meu projeto"*
- *"Preciso criar o repositório de specs"*
- *"Tenho uma instância antiga e quero atualizar"*
- *"O que posso fazer aqui?"*

O agente usa `welcome` → mostra o menu → delega para `create-specs-setup` ou `upgrade-specs` → conduz a **entrevista guiada** (perguntas, confirmação, gravação). Você só responde; o fluxo continua automático.

### No `{projeto}-specs` (dia a dia)

Depois do setup, trabalhe **só** no repo de specs e diga, por exemplo:

- *"Olá"*
- *"Quero especificar uma feature nova"*
- *"Documente o cadastro de usuário que já está implementado"*
- *"Tenho um bug na listagem"*
- *"Onde paramos na feature X?"*
- *"Quais capacidades esse repo tem?"*

O agente usa `welcome` da instância → apresenta opções para PO, dev ou líder → delega ao guide e às skills de artefato (`full-spec`, `spec-from-code`, `quick-fix`, etc.). Cada etapa segue **modo guiado** por padrão.

> **Resumo:** uma mensagem natural basta. A partir de `welcome`, o agente + skills cuidam do roteamento — no bootstrap e nos specs.

## O que este repositório faz

| Papel | Descrição |
|-------|-----------|
| **Bootstrap** | Entrevista guiada + templates → grava a instância SDD (`contract_version: 1`) |
| **Instância gerada** | `{projeto}-specs` — features, fixes, RN, tasks, protótipos no dia a dia |

A instância inclui:

- `steering/product.md` e `steering/engineering.md` — contexto de negócio e engenharia
- `sdd.config.yaml` — repos, wiki RN, docs wiki, GitLab, protótipo, fluxo de trabalho
- **20 skills** em `.agents/skills/` (welcome, guide, full-spec, design-to-spec, spec-from-code, quick-fix, implement-sprint-task, implement-fix, docs-wiki-page, A1–B2, B5, export de prints, D1, progress)
- **15 templates** vazios em `templates/` (inclui `screenshot-manifest.json`)
- `features/` e `fixes/` — artefatos do produto (vazios no setup)
- `prototypes/` — só se protótipo Angular for confirmado na entrevista (inclui botão **Baixar print** + script de export em lote)
- `docs_wiki/` — só se docs wiki for confirmada na entrevista (HTML estático de produto)

**Não há scripts de setup** — o agente lê `templates/instance/`, substitui placeholders e grava os arquivos na pasta destino.

## Quando usar

| Situação | Repositório | Skill |
|----------|-------------|-------|
| Primeira configuração SDD | **create-specs-setup** | `welcome` → `create-specs-setup` |
| Instância legada / retrofit | **create-specs-setup** | `welcome` → `upgrade-specs` |
| Dia a dia (feature, bug, status) | **`{projeto}-specs`** | `welcome` → guide (`skills.guide_name`) |

## Fluxo (setup novo)

```
1. Clonar create-specs-setup + repos de código + pasta {projeto}-specs no workspace
2. Workspace Cursor multi-root com todos os repos
3. Agent → diga "Olá" ou descreva o objetivo → `welcome` → entrevista guiada (`create-specs-setup`)
4. Confirmar rascunhos de steering + resumo final (sim explícito)
5. Agente grava instância + validação V1–V12 (tabela ✅/❌)
6. (Opcional) protótipo: agente lê o **SPA do projeto** no workspace e monta `prototypes/` (sem shell genérico no bootstrap)
7. Trabalhar só em {projeto}-specs
```

**Nada é gravado** antes da confirmação explícita do usuário.

Na entrevista, o agente também pergunta se o time usa **template padrão** ou **template custom** para tarefas (dev/design) — ver Fase 4.6 do checklist.

## Estrutura deste repositório

```
create-specs-setup/
├── .agents/skills/
│   ├── welcome/              # entrada — boas-vindas e roteamento
│   ├── create-specs-setup/   # setup novo
│   └── upgrade-specs/        # retrofit de instância existente
├── docs/
│   ├── setup-workflow.md
│   ├── setup-interview-checklist.md
│   └── instance-contract.md  # contrato v1 + validação V1–V12
└── templates/
    └── instance/             # árvore completa da instância (.tpl)
```

## Skills

| Skill | Uso |
|-------|-----|
| [`welcome`](.agents/skills/welcome/SKILL.md) | Boas-vindas e orientação (entrada padrão) |
| [`create-specs-setup`](.agents/skills/create-specs-setup/SKILL.md) | Setup novo — entrevista + gravar instância |
| [`upgrade-specs`](.agents/skills/upgrade-specs/SKILL.md) | Retrofit sem apagar `features/`, `fixes/` nem protótipos de domínio |

## Documentação

- [`docs/setup-workflow.md`](docs/setup-workflow.md) — pré-requisitos, workspace, handoff
- [`docs/setup-interview-checklist.md`](docs/setup-interview-checklist.md) — perguntas por fase (sem gaps 🔴)
- [`docs/instance-contract.md`](docs/instance-contract.md) — arquivos obrigatórios e gates pós-setup

## Protótipo (opcional)

**Requisito:** se ativado, o protótipo é gerado **somente** a partir do SPA do projeto (`repos.spa` no workspace). Não há código de referência no bootstrap.

1. Agente valida que o SPA existe e lê `package.json`, layout e `src/app/shared/components/`
2. Inicializa `{specs}/prototypes/` alinhado à stack do SPA
3. Copia/adapta componentes, estilos e layout do SPA (sem HTTP/auth)
4. Monta catálogo vazio em `registry/` (campo `sprint`), página do catálogo com busca/filtro por sprint, e pasta `src/app/feature/` (protótipos isolados por task)

Telas específicas vêm depois, via skill `prototype-angular` — uma pasta por feature (`feature/{task_ref}-{slug}/`).

## Licença

[MIT](LICENSE)
