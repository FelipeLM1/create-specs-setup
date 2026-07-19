# AGENTS — {{SPECS_REPO_SLUG}}

Instruções para agentes de IA trabalhando neste repositório.

---

## Propósito

O **{{SPECS_REPO_SLUG}}** transforma conversas em artefatos rastreáveis:

- **Features** → `sprints/sprint-{N}/features/{slug}/` (SDD completo)
- **Bugs e ajustes** → `sprints/sprint-{N}/fixes/{slug}/` (fluxo enxuto)

O usuário **não precisa conhecer** nomes de skills — comece sempre pelas boas-vindas.

---

## Ponto de entrada

**Skill padrão:** `.agents/skills/welcome/SKILL.md`

A skill `welcome` apresenta capacidades (PO, dev, líder) e delega ao roteamento.

**Triagem fina:** `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md` — quando o pedido for ambíguo ou precisar de continuar/status detalhado.

---

## Fluxos

### Feature nova (guiado — padrão)

```
{{GUIDE_SKILL_NAME}} → full-spec (modo guiado)
  → Fase 0: contexto + "vai ter protótipo?" (sim/não)
  → meeting-notes (A1)
  → se tem protótipo: perguntar ramo
       · prototype-first (recomendado com tela) → prototype / Angular → depois RN + use case
       · artifacts-first → business-rules → use-case → (protótipo depois)
  → se sem protótipo: business-rules → use-case → sprint-task (sem etapas de protótipo)
  → progress.md atualizado a cada etapa (ordem pós-A1 é flexível)
```

Referência: `docs/feature-lifecycle.md` § Ramos pós Meeting notes

### Implementação (dev — guiada)

```
{{GUIDE_SKILL_NAME}} → implement-sprint-task | implement-fix
  → entrevista (spec sim/não, referências ou descrição)
  → plano confirmado pelo dev
  → código em {{API_REPO}} / {{SPA_REPO}} + testes unitários quando aplicável
  → progress.md atualizado (C* ou F3)
```

Referência: `docs/feature-lifecycle.md` § Fase C · `docs/fix-lifecycle.md` § F3

### Bug / ajuste (documentação)

```
{{GUIDE_SKILL_NAME}} → quick-fix (perguntas → fix-task.md + progress.md)
```

Referência: `docs/fix-lifecycle.md`

Hotfix urgente: **sem** {{SPECS_REPO_SLUG}} — GitLab + MR direto.

### Feature com design visual pronto (design-to-spec)

```
{{GUIDE_SKILL_NAME}} → design-to-spec
  → meeting-notes via walkthrough do PNG (A1)
  → business-rules (A2)
  → use-case (A3)
  → sprint-task (B2, dev) — referencia os PNGs
  → A4 / B1 / B5 / B6 marcados [-] N/A
  → progress.md atualizado a cada etapa
```

Referência: `.agents/skills/design-to-spec/SKILL.md`

### Spec a partir do código (fluxo já implementado)

```
{{GUIDE_SKILL_NAME}} → spec-from-code
  → analysis-context (sempre)
  → business-rules / use-case / gaps / insights (conforme escolha do usuário)
  → progress.md (checklist R0–R6)
```

Referência: `docs/feature-lifecycle.md` § Fluxo spec-from-code

### Continuar / status

```
{{GUIDE_SKILL_NAME}} → lê progress.md → delega próxima skill
```

### Docs wiki (produto — sob demanda)

```
{{GUIDE_SKILL_NAME}} → docs-wiki-page
  → página HTML em docs_wiki/pages/ (se docs_wiki.enabled)
```

Referência: `docs/docs-wiki.md` · skill `docs-wiki-page`

---

## Regras obrigatórias

1. Seguir `ai-rules.md` (fato / `[HIPÓTESE]` / `[PENDENTE]`)
2. Seguir `docs/skill-conventions.md` (gate, progress, mensagem pós-etapa)
3. **RN na wiki** antes de sprint task em feature nova — ver `docs/business-rules-wiki.md` (numeração `RN-{code}.{seq}`, links na issue)
4. **Não inventar** regras, endpoints ou campos sem evidência
5. **Atualizar progress** após cada artefato gerado
6. Responder em **português**
7. Modo **guiado** por padrão — batch só se usuário pedir explicitamente
8. **Protótipo:** decidir na Fase 0; após Meeting notes, se sim → perguntar ramo (protótipo primeiro vs RN/use case). Sem protótipo → não oferecer etapas de protótipo

---

## Estrutura

```
sprints/
  in-progress/         specs em andamento (sem sprint definida)
    features/{slug}/
  sprint-{N}/
    features/{slug}/   spec, design, tasks, progress.md
    fixes/{slug}/      fix-task.md, progress.md
    meetings/
templates/             templates vazios
docs/                  lifecycles + skill-conventions + sprint-layout + docs-wiki
.agents/skills/        uma skill por etapa + orquestradores
docs_wiki/             wiki HTML de produto (se docs_wiki.enabled)
prototypes/            app Angular mockado; cada protótipo em src/app/feature/{task_ref}-{slug}/
```

Sprint atual (quando houver N): `workflow.current_sprint` em `sdd.config.yaml`. Specs sem sprint: `sprints/in-progress/`. Ver `docs/sprint-layout.md`.

---

## Skills disponíveis

| Skill | Uso |
|-------|-----|
| `welcome` | Boas-vindas e visão de capacidades |
| `{{GUIDE_SKILL_NAME}}` | Triagem e roteamento |
| `full-spec` | Orquestrador feature — Meeting notes + ramos flexíveis pós-A1 |
| `design-to-spec` | Feature a partir de design visual pronto (PNG) — A1 via walkthrough, pula A4/B1/B5/B6 |
| `quick-fix` | Bug/ajuste |
| `meeting-notes` | A1 |
| `business-rules` | A2 |
| `use-case` | A3 |
| `prototype-spec` | A4 |
| `design-task` | B1 (designer) |
| `sprint-task` | B2 (dev) |
| `prototype-angular` | B5 |
| `prototype-export-screenshots` | Exportar prints do protótipo para a spec (pós-B5) |
| `system-manual` | D1 |
| `spec-from-code` | Documentar fluxo já implementado (código → spec) |
| `implement-sprint-task` | Implementar tarefa/feature (C1–C4, guiado) |
| `implement-fix` | Investigar e corrigir bug (F3, guiado) |
| `docs-wiki-page` | Página da docs wiki de produto (sob demanda) |
| `feature-progress` | Status feature |
| `fix-progress` | Status fix |

---

## Workspace multi-root

Este repo costuma abrir junto com os repos de código (`repos.api`, `repos.spa` em `sdd.config.yaml`). Ao especificar impacto técnico, **consulte o código** nos repos irmãos quando disponível — não assuma da memória.
