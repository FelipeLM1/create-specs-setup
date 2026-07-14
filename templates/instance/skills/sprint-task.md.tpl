---
name: sprint-task
description: Consolida artefatos em sprint task GitLab (dev) com checklist e orientações. Exige business-rules.md revisado; wiki RN só se habilitada em sdd.config.yaml. Use para sprint task, task de dev ou issue de implementação.
---

# Skill: Gerar Sprint Task (GitLab)

## Quando usar

- "gerar sprint task de..."
- "criar task para o GitLab de..."
- "montar a task de..." / "issue de dev"

**Design (UX/UI):** skill `design-task` (B1). **Esta skill:** desenvolvimento (B2).

---

## Objetivo

Task **curta** para o GitLab: contextualização de negócio, checklist verificável, orientações de implementação. **Regras** em `spec/business-rules.md` — referenciar por link/caminho, **não reescrever** SE/ENTÃO.

Convenção: `docs/business-rules-store.md` · ler `sdd.config.yaml`.

---

## Pré-condições (gate)

### Bloqueante — feature nova

**Não gerar sprint task** até que:

- [ ] `sprints/sprint-{N}/features/{slug}/spec/business-rules.md` exista, esteja completo e revisado
- [ ] Se `business_rules.wiki.enabled: true` → link da página wiki RN informado

Se faltar business rules → delegar skill `business-rules`.

| Tipo de trabalho | business-rules.md | Wiki (se enabled) |
|------------------|-------------------|-------------------|
| **Nova feature** | **Sim** — bloqueante | Sim, se `wiki.enabled` |
| Bug/ajuste (`sprints/sprint-{N}/fixes/`) | Não (RN existente ou fix-task) | Não |
| Hotfix urgente | Não | Não |

### Demais artefatos (recomendado)

- [ ] `spec/meeting-notes.md`
- [ ] `spec/business-rules.md` (espelho alinhado à wiki)
- [ ] `spec/use-case.md`
- [ ] `design/prototype.md` (se existir)
- [ ] `tasks/design-task.md` (se designer)

A1–A3 incompletos → `{{GUIDE_SKILL_NAME}}`. Design pendente → `design-task` primeiro.

---

## Search-first (antes de orientar implementação)

Antes de listar endpoints, classes, componentes ou paths na task:

1. Consultar `sdd.config.yaml` e repos irmãos no workspace (`repos.api`, `repos.spa`)
2. Citar caminhos **reais** encontrados (ex.: controller, service, component, rota)
3. Inferência sem evidência no código → `[HIPÓTESE]` na orientação de implementação
4. Não inventar contrato de API, payload ou nome de campo sem evidência

Ver `ai-rules.md` § Search-first.

---

## Link das regras de negócio (obrigatório na task)

### Obter URL

| Entrada do usuário | URL da página |
|--------------------|---------------|
| Link completo `.../RN{code}` | usar como está |
| `RN-100` ou `100` | `https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100` |

**Base wiki (exemplo):** `https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/`

Exemplo de referência: [RN100](https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100)

### Formato nas tasks (markdown)

**Cabeçalho / referências:**

```markdown
**Regras de negócio:** [RN-100 — Nome da feature](https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100)
```

**Critérios de aceite** — cada menção a regra **DEVE** ser link markdown (mesma página `RN{code}`):

```markdown
- [ ] Métrica principal conforme especificação ([RN-100.1](https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100))
- [ ] Filtro da listagem isolado ([RN-100.2](https://{{GITLAB_BASE_URL}}/{{WIKI_HOST_REPO}}/-/wikis/business-rules/RN100))
```

**Proibido na task:**

- ❌ Repetir texto SE/ENTÃO das regras
- ❌ Referenciar só `RN-08` ou `RN-01` sem código da feature (`RN-100.1`)
- ❌ Referenciar só `business-rules.md` sem link wiki na seção **Texto para GitLab**

**Permitido:** espelho local `spec/business-rules.md` como referência interna adicional no arquivo da task (fora do corpo copiado para GitLab, se o time preferir issue enxuta).

### Numeração

- **Código:** `RN-100` (feature / página wiki `RN100`)
- **Regras:** `RN-100.1`, `RN-100.2`, … (contador na mesma página)

---

## Passo a passo

### 1. Validar gate wiki

Confirmar link ou código com o usuário. Se RN não cadastrada → `business-rules` e **retornar**.

### 2. Uma ou múltiplas tasks

Split comum: `task-backend.md`, `task-frontend.md`.

### 3. Contextualização (**Problema**)

Negócio: quem usa, gap, valor. **Não** débito técnico. Ver exemplos na versão anterior desta skill (passo 2).

Ponte opcional para recorte backend/frontend.

### 4. Objetivos

2–4 bullets do que **esta task** entrega.

### 5. Critérios de aceite (checklist)

Verificável; referenciar **`[RN-{code}.{seq}]({url wiki})`** — não reescrever regras.

```
- [ ] [condição verificável] ([RN-100.N](https://.../RN100))
```

Cobrir: entregáveis, contrato API/UI, edge cases do use-case (por link RN).

### 6. Referências (GitLab)

- Link wiki RN (obrigatório)
- Use case, design task, protótipo
- Task irmã (backend/frontend) se split

### 7. Orientações de implementação (conciso)

Estrutura de código, endpoints, componentes, pontos de atenção, pendências — **sem** duplicar RN.

---

## Validação antes de entregar

- [ ] **Gate wiki:** link `.../RN{code}` presente; usuário informou código ou URL
- [ ] Critérios usam **`RN-{code}.{seq}`** com **links markdown** para a wiki
- [ ] Problema contextualiza negócio
- [ ] Regras **não** duplicadas no corpo da task
- [ ] Checklist verificável; orientações concisas
- [ ] Status `rascunho` → `pronta para sprint` após revisão

---

## Saída esperada

`sprints/sprint-{N}/features/{slug}/tasks/`:

- `sprint-task.md` ou `task-backend.md` / `task-frontend.md`
- Cabeçalho: **Regras de negócio (wiki):** link
- **Texto para GitLab:** Problema, Objetivos, Critérios (links RN), Referências
- **Orientações de implementação**

---

## Após gerar

1. `progress.md` — **B2** `[x]` (`feature-progress`)
2. Responder conforme `docs/skill-conventions.md`

**Próximo:** issue GitLab (B3) · copiar texto com links RN já formatados
