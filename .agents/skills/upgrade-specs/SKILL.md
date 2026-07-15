---
name: upgrade-specs
description: Atualiza instância SDD existente para contract_version 1 — steering, sdd.config, skills, docs — sem apagar features/fixes/protótipos. O agente aplica mudanças diretamente, sem scripts.
---

# Skill: upgrade-specs

## Quando usar

- Retrofit de instância legada criada antes do contrato v1
- Adicionar `steering/`, `sdd.config.yaml`, gates RN atualizados
- Alinhar skills ao contrato em `docs/instance-contract.md`

**Não apagar:** `sprints/**`, `features/**` (legado), `fixes/**` (legado), protótipos de domínio já implementados.

**Sem scripts** — o agente lê, compara e grava arquivos.

---

## Regra de ouro

Mesmo em upgrade: **perguntar** o que falta (checklist `docs/setup-interview-checklist.md`), mostrar resumo, obter **sim** antes de gravar alterações que sobrescrevem arquivos existentes.

---

## Fluxo

### 1. Diagnóstico

Ler na instância alvo:

- Estrutura de pastas vs `docs/instance-contract.md`
- `AGENTS.md`, `README.md`, `.agents/skills/`
- Ausência de `steering/`, `sdd.config.yaml`, `docs/business-rules-store.md`

Reportar gaps ao usuário antes de alterar.

### 2. Adicionar/atualizar (sem sobrescrever specs de features)

| Artefato | Ação |
|----------|------|
| `sdd.config.yaml` | Criar com `contract_version: 1` e valores do projeto |
| `steering/product.md` | Extrair de README + entrevista curta se faltar |
| `steering/engineering.md` | Listar repos, stack, path SPA para protótipo |
| `docs/business-rules-store.md` | RN primária em spec; wiki condicional |
| Skills `business-rules`, `sprint-task` | Gate wiki só se `wiki.enabled: true` |
| `prototype-angular` | B5 (não B4); catálogo em `registry/` com `sprint` + busca/filtro na home; código por feature em `src/app/feature/{task_ref}-{slug}/` |
| Skill `prototype-export-screenshots` | Adicionar se ausente (prints do protótipo → pasta da feature) |
| Scaffold print (botão + script) | Se `prototypes/` existir: copiar `prototype-screenshot-button`, serviço, constantes, `scripts/export-spec-screenshots.mjs`, deps `html-to-image`/`playwright`, template `screenshot-manifest.json`; wire no layout se faltar (ver `LAYOUT-SCREENSHOT-WIRE.md`) |
| `docs/feature-lifecycle.md` | A0 = steering validado |
| `AGENTS.md`, `README.md` | Entrada `welcome`; links para steering e create-specs-setup |
| Skill `welcome` | Adicionar se ausente (boas-vindas — entrada em `AGENTS.md`) |
| Skill `spec-from-code` | Adicionar se ausente (spec de fluxo já implementado) |
| Skills `implement-sprint-task`, `implement-fix` | Adicionar se ausentes (implementação guiada para dev) |
| Templates `analysis-context`, `implementation-gaps`, `evolution-insights`, `spec-from-code-progress` | Adicionar em `templates/` se ausentes |

Usar templates em `create-specs-setup/templates/instance/` como referência — copiar conteúdo já parametrizado para o projeto.

### 3. Protótipo existente

Se `prototypes/` já existe com protótipos de domínio:

- **Não** remover cards nem páginas de domínio
- Só corrigir paths/docs inconsistentes (registry, `feature/` vs legado em `prototypes/pages`)
- Se faltar `src/app/feature/README.md`, adicionar com convenção `{task_ref}-{slug}`
- Se faltar `shared/components`, copiar do SPA conforme § Protótipo em `create-specs-setup`
- **Catálogo por sprint:** garantir `PrototypeCard.sprint: number` em todos os cards; home com busca por nome + filtro por sprint (referência: `templates/instance/prototypes/`). Cards legados sem sprint → perguntar N ou usar `workflow.current_sprint`

### 4. Valores da instância

Ler `sdd.config.yaml` existente ou confirmar na entrevista curta:

| Campo | Ação |
|-------|------|
| `skills.guide_name` | Manter nome atual do guide, salvo pedido do time |
| `business_rules.wiki.enabled` | Preservar decisão do projeto |
| `primary_store` | `specs_repo` (padrão contrato v1) |

---

## Validação

Mesmo gate **V1–V11** de `create-specs-setup` (§ Fase 7.5) e `docs/instance-contract.md`. Instância pode ter conteúdo legado adicional em `features/` e `prototypes/` — não falhar V7/V10 por isso.

---

## Anti-patterns

- Sobrescrever `features/*/spec/*.md`
- Renomear skill guide sem pedido do time
- Rodar scripts de render em vez de editar arquivos
