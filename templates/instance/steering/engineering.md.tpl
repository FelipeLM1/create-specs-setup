# Steering — Engenharia

| Campo | Valor |
|-------|-------|
| **Projeto** | {{PROJECT_NAME}} |
| **Última atualização** | {{SETUP_DATE}} |

---

## Stack principal

{{ENGINEERING_STACK}}

---

## Repositórios no workspace

| Papel | Pasta / repo | Uso |
|-------|--------------|-----|
| API | `{{API_REPO}}` | Backend, regras, integrações |
| SPA | `{{SPA_REPO}}` | Interface web |
| Specs | `{{SPECS_REPO_SLUG}}` | SDD, protótipos mockados |
{{ENGINEERING_EXTRA_REPOS}}

---

## Padrões de código

{{ENGINEERING_PATTERNS}}

---

## Design system e componentes

| Item | Caminho |
|------|---------|
| Componentes compartilhados (SPA) | `{{SPA_SHARED_COMPONENTS_PATH}}` |
| Branch principal (API) | {{API_MAIN_BRANCH}} |
| Branch principal (SPA) | {{SPA_MAIN_BRANCH}} |

---

## Protótipo de alta fidelidade

| Item | Valor |
|------|-------|
| Habilitado | {{PROTOTYPE_ENABLED}} |
| Pasta raiz | `prototypes/` |
| Pasta por feature | `prototypes/src/app/feature/{task_ref}-{slug}/` |
| Padrão de pasta | `{task_ref}-{slug}` (ex.: `100-listagem-usuario`, `101-login`) |
| Catálogo | `prototypes/src/app/prototypes/registry/prototype-catalog.data.ts` |
| Porta dev | {{PROTOTYPE_DEV_PORT}} |
| Origem UI | `{{SPA_REPO}}/{{SPA_SHARED_COMPONENTS_PATH}}` |

**Regras:** um protótipo por pasta isolada; `task_ref` = issue/task GitLab; mock data apenas; sem auth/HTTP real; estados `loading`, `empty`, `error`, `success`.

---

## Onde o agente deve buscar evidência

1. `steering/` (este arquivo e `product.md`)
2. `sdd.config.yaml`
3. Código nos repos listados acima
4. Artefatos em `features/{slug}/` — nunca inventar fora disso
