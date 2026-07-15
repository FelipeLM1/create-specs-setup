# Contrato da instância SDD (contract_version: 1)

Uma instância válida é o repositório `{projeto}-specs` gerado pelo `create-specs-setup`. O agente e o time usam **apenas** essa instância no dia a dia.

## Arquivos obrigatórios na raiz

| Arquivo | Função |
|---------|--------|
| `sdd.config.yaml` | Configuração do projeto (repos, RN, protótipo, guide) |
| `AGENTS.md` | Entrada para agentes — aponta para o guide da instância |
| `ai-rules.md` | Regras IA (fato / hipótese / pendente) |
| `README.md` | Visão geral do SDD do projeto |

## Steering (contexto persistente)

| Arquivo | Função |
|---------|--------|
| `steering/product.md` | Negócio: problema, usuários, valor, glossário |
| `steering/engineering.md` | Stack, padrões, repos no workspace |

**Gate:** skills de artefato devem ler steering quando relevante. Não gerar com `[PENDENTE]` crítico sem confirmar com o usuário.

**Setup:** entrevista completa em [`setup-interview-checklist.md`](setup-interview-checklist.md) — sem gaps 🔴 antes de gravar.

## Pastas obrigatórias

```
{specs-repo}/
├── steering/
├── templates/          # 14 templates vazios
├── docs/
│   ├── feature-lifecycle.md
│   ├── fix-lifecycle.md
│   ├── skill-conventions.md
│   ├── business-rules-store.md
│   └── sprint-layout.md
├── sprints/
│   ├── README.md
│   ├── in-progress/    # specs em andamento (sem sprint)
│   │   └── features/   # .gitkeep
│   └── sprint-1/       # current_sprint
│       ├── features/   # .gitkeep
│       ├── fixes/      # README.md
│       └── meetings/   # .gitkeep
├── .agents/skills/     # 17 skills (ver lista abaixo)
└── prototypes/         # somente se prototype.enabled: true
    └── src/app/feature/   # um protótipo por pasta: {task_ref}-{slug}
```

## Skills obrigatórias (`.agents/skills/`)

| Pasta | Etapa |
|-------|-------|
| `welcome/` | Boas-vindas e visão de capacidades |
| `{guide_name}/` | Triagem e roteamento |
| `full-spec/` | Orquestrador feature |
| `quick-fix/` | Bug / ajuste |
| `meeting-notes/` | A1 |
| `business-rules/` | A2 |
| `use-case/` | A3 |
| `prototype-spec/` | A4 |
| `design-task/` | B1 |
| `sprint-task/` | B2 |
| `prototype-angular/` | B5 |
| `system-manual/` | D1 |
| `feature-progress/` | Status feature |
| `fix-progress/` | Status fix |
| `spec-from-code/` | Spec de fluxo já implementado |
| `implement-sprint-task/` | C1–C4 — implementação guiada (dev) |
| `implement-fix/` | F3 — investigação e correção guiada (dev) |

## Templates obrigatórios (`templates/`)

- `meeting-notes.md`
- `business-rules.md`
- `use-case.md`
- `prototype.md`
- `design-task.md`
- `sprint-task.md`
- `feature-progress.md`
- `fix-task.md`
- `fix-progress.md`
- `system-manual.md`
- `analysis-context.md`
- `implementation-gaps.md`
- `evolution-insights.md`
- `spec-from-code-progress.md`

## sdd.config.yaml — campos mínimos

```yaml
contract_version: 1
project:
  name: string
  specs_repo_slug: string
  language: "pt-BR"
repos:
  api: string | null
  spa: string | null
business_rules:
  primary_store: "specs_repo"
  wiki:
    enabled: boolean
    base_url: string
gitlab:
  enabled: boolean
  base_url: string
workflow:
  hotfix_outside_specs: boolean
  sprint_task_split_default: "single" | "backend_frontend"
  task_templates: "default" | "custom"
prototype:
  enabled: boolean
  spa_source_repo: string | null
  folder: "prototypes"
  feature_base_path: "src/app/feature"
  feature_folder_pattern: "{task_ref}-{slug}"  # ex.: 100-listagem-usuario
skills:
  guide_name: string
```

## Validação pós-setup

Gate obrigatório na skill `create-specs-setup` (Fase 7.5) — reportar ✅/❌ ao usuário:

| ID | Item |
|----|------|
| V1 | `contract_version: 1` em `sdd.config.yaml` |
| V2 | Nenhum arquivo gravado contém `{{` (placeholders) |
| V3 | 17 pastas `.agents/skills/*/SKILL.md` |
| V4 | Cada skill com frontmatter YAML `name` + `description` |
| V5 | `AGENTS.md` aponta para `welcome`; guide com nome real (sem placeholder) |
| V6 | 14 templates em `templates/` |
| V7 | `sprints/README.md`, `sprints/in-progress/features/.gitkeep`, `sprints/sprint-1/features/.gitkeep`, `sprints/sprint-1/fixes/README.md`, `ai-rules.md`, `steering/*` |
| V8 | Skills sem referências `{{...}}` não substituídas |
| V9 | `ai-rules.md` com seção Search-first |
| V10 | Se `prototype.enabled`: `prototypes/package.json` + catálogo vazio em `registry/` (modelo com `sprint`) + página do catálogo com busca/filtro sprint + `src/app/feature/README.md` |
| V11 | Sem referências hardcoded a projetos externos (URLs/nomes de repos alheios) |

## Setup e upgrade

- **Setup novo:** skill `create-specs-setup` — agente grava arquivos a partir de `templates/instance/` (sem scripts bash).
- **Protótipo opcional:** requisito `repos.spa` no workspace. Agente lê o SPA do projeto (stack, layout, `shared/components`), monta `prototypes/` com catálogo vazio e pasta `src/app/feature/` para protótipos isolados por task. Sem shell genérico no bootstrap.
- **Upgrade:** skill `upgrade-specs` — retrofit sem apagar `features/` nem protótipos de domínio.
