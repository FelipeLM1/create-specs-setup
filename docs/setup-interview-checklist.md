# Checklist de entrevista — setup SDD (sem gaps)

Referência da skill `create-specs-setup`. **Nenhum arquivo na instância** até todos os itens **obrigatórios** estarem preenchidos e o usuário confirmar o resumo final.

Legenda: 🔴 obrigatório · 🟡 recomendado (pode `[PENDENTE]` não crítico) · ⚪ opcional

---

## Fase 0 — Escopo do setup

| # | Pergunta | Campo / artefato |
|---|----------|------------------|
| 0.1 🔴 | Caminho absoluto do repositório de **specs** (destino)? | `TARGET_DIR` |
| 0.2 🔴 | Setup **novo** ou **upgrade** de instância existente? | novo → continuar · upgrade → `upgrade-specs` |
| 0.3 🔴 | Pasta destino está **vazia** ou tem conteúdo? Se tem, o que preservar? | |
| 0.4 🟡 | URL do repositório Git do specs (GitLab/GitHub)? | `project.git_url` |
| 0.5 🔴 | Nome de exibição do produto/sistema? | `PROJECT_NAME` |
| 0.6 🔴 | Slug do repo de specs (kebab-case, ex.: `acme-specs`)? | `SPECS_REPO_SLUG` |
| 0.7 🔴 | Idioma dos artefatos? (padrão: pt-BR) | `project.language` |
| 0.8 🔴 | Nome da skill de entrada? (sugerir `{slug}-specs-guide`) | `GUIDE_SKILL_NAME` |
| 0.9 🟡 | Responsável pelo SDD / PO / líder técnico? | `steering/product.md` |
| 0.10 🟡 | Produto é **greenfield** ou **sistema já em produção**? | contexto entrevista |

---

## Fase 1 — Negócio (`steering/product.md`)

| # | Pergunta | Seção |
|---|----------|-------|
| 1.1 🔴 | Qual **problema de negócio** o sistema resolve hoje? | Problema |
| 1.2 🔴 | **Quem usa** o sistema? (perfis, papéis) | Usuários |
| 1.3 🔴 | **Valor entregue** — o que melhora se o sistema funcionar bem? | Valor |
| 1.4 🔴 | O que está **dentro** e **fora** do escopo do produto? | Limites |
| 1.5 🟡 | Termos de domínio importantes (glossário)? | Glossário |
| 1.6 ⚪ | Links de documentação externa (Confluence, wiki, drive)? | Referências |

**Gate:** mostrar rascunho de `product.md` → usuário confirma ou corrige.

---

## Fase 2 — Engenharia (`steering/engineering.md` + `sdd.config.yaml` → `repos`)

| # | Pergunta | Campo |
|---|----------|-------|
| 2.1 🔴 | Pasta do repo **API** no workspace? Existe e é acessível? | `repos.api` |
| 2.2 🔴 | Pasta do repo **SPA** no workspace? Existe e é acessível? | `repos.spa` |
| 2.3 🟡 | Outros repos no ecossistema? (IA, mobile, jobs, etc.) | `repos.extra[]` |
| 2.4 🔴 | Stack da API (linguagem, framework)? | `ENGINEERING_STACK` |
| 2.5 🔴 | Stack do SPA (Angular, React, versão)? | agente pode ler `package.json` |
| 2.6 🔴 | Convenções de código (idioma dos identificadores, camadas)? | `ENGINEERING_PATTERNS` |
| 2.7 🟡 | Caminho do **design system** / componentes compartilhados no SPA? | padrão: `src/app/shared/components/` |
| 2.8 🟡 | Branch principal dos repos (main, develop)? | nota em engineering |
| 2.9 🟡 | Onde ficam migrations / contratos de API? | nota em engineering |

**Gate:** agente **valida paths no disco** antes de continuar. Se repo não estiver no workspace, pedir para adicionar ou informar path correto.

---

## Fase 3 — Regras de negócio (RN)

| # | Pergunta | Campo |
|---|----------|-------|
| 3.1 🔴 | Confirmar: fonte **primária** das RN = `features/{slug}/spec/business-rules.md`? | `primary_store: specs_repo` |
| 3.2 🔴 | O projeto usa **wiki externa** (GitLab) para publicar RN? sim/não | `wiki.enabled` |
| 3.3a 🔴 (se wiki) | URL base do GitLab/grupo? | `wiki.base_url` |
| 3.3b 🔴 (se wiki) | Em qual **repo** fica a wiki? (ex.: SPA) | `wiki.host_repo` |
| 3.3c 🔴 (se wiki) | Padrão da página? (ex.: `RN{code}`) | `wiki.page_pattern` |
| 3.3d 🟡 (se wiki) | Quem publica na wiki — dev, PO, agente com acesso? | nota em business-rules-store |
| 3.4 🟡 | Faixa de códigos RN já usados? (ex.: 700+) | evitar colisão |

---

## Fase 4 — GitLab / issues / fluxo operacional

| # | Pergunta | Campo |
|---|----------|-------|
| 4.1 🔴 | Usa **GitLab** (ou outro) para issues/MR? sim/não | `gitlab.enabled` |
| 4.2 🔴 (se sim) | URL base (grupo/organização)? | `gitlab.base_url` |
| 4.3 🟡 | Namespace dos projetos (ex.: `acme-corp/web`)? | `gitlab.namespace` |
| 4.4 🔴 | **Hotfix urgente** em produção: vai direto no GitLab **sem** pasta `fixes/`? | `workflow.hotfix_outside_specs` |
| 4.5 🟡 | Sprint tasks costumam ser **uma** ou **split** backend/frontend? | `workflow.sprint_task_split_default` |
| 4.6 🔴 | O time já tem **padrão/template** de escrita de tarefas (dev, front, back, design)? Quer **manter o de vocês** ou seguir o **template padrão** do setup? | `workflow.task_templates` |
| 4.6a 🔴 (se custom) | Pedir **exemplo** (issue GitLab colada, link ou arquivo): quais seções são obrigatórias? | adaptar `templates/sprint-task.md`, `design-task.md`, `fix-task.md` |
| 4.6b 🟡 (se custom) | O padrão difere entre **backend** e **frontend**? (ex.: `task-backend.md` + `task-frontend.md`) | alinhar com `workflow.sprint_task_split_default` |

**Texto sugerido ao usuário (Fase 4.6):**

> Vocês já têm um padrão ou template para escrever tarefas no GitLab (dev, frontend, backend, design)?  
> Querem **manter o de vocês** ou podemos seguir com o **template padrão** que o setup traz?

| Resposta | Ação na Fase 7 |
|----------|----------------|
| **Template padrão** | Copiar `templates/*.md` do `create-specs-setup` sem alteração estrutural |
| **Template do time** | Montar/adaptar `templates/sprint-task.md`, `design-task.md`, `fix-task.md` com base no exemplo; ajustar skills `sprint-task` / `design-task` **somente** se seções ou gates mudarem |

---

## Fase 5 — Protótipo Angular (opcional)

| # | Pergunta | Campo |
|---|----------|-------|
| 5.1 🔴 | Incluir projeto de **protótipo mockado** agora? sim/não | `prototype.enabled` |
| 5.2 🔴 (se sim) | **SPA do projeto** (`repos.spa`) existe e está acessível no workspace? | gate — sem SPA → não ativar |
| 5.3 🔴 (se sim) | Confirmar SPA fonte dos componentes (= `repos.spa`) | `prototype.spa_source_repo` |
| 5.4 🟡 | Copiar **todos** os shared components ou só subset? | decisão na cópia |
| 5.5 🟡 | Versão Angular / Tailwind — seguir o SPA? | ler `package.json` |
| 5.6 🟡 | Porta local do protótipo (padrão 4200)? | `prototype.dev_port` |
| 5.7 🔴 (se sim) | Após montar: rodar `npm install && npm start` para validar? | confirmação usuário |

Se **não**: `prototype.enabled: false` — protótipo pode ser adicionado depois via `upgrade-specs` (com SPA no workspace).

> **Requisito:** não há shell genérico no bootstrap. Protótipo = SPA do projeto adaptado para mock UI no specs repo.

---

## Fase 6 — Resumo e confirmação (gate final)

Antes de gravar **qualquer** arquivo, apresentar tabela resumo:

| Item | Valor definido |
|------|----------------|
| Produto | … |
| Repo specs | … |
| API / SPA | … |
| Wiki RN | sim/não |
| GitLab | sim/não |
| Templates de tarefas | padrão / custom (do time) |
| Protótipo | sim/não |
| Pendências não críticas | lista ou "nenhuma" |

Pergunta obrigatória:

> **Posso gravar a instância SDD com essas configurações?** (sim / ajustar X)

Somente após **sim** explícito → gravar arquivos.

---

## Fase 7 — Pós-gravação

- **Verificação obrigatória V1–V11** (`docs/instance-contract.md`) — tabela ✅/❌ antes do handoff
- Listar arquivos criados
- Indicar `[PENDENTE]` remanescentes (não críticos) e como preencher depois
- Handoff: usar `{GUIDE_SKILL_NAME}` no repo specs
