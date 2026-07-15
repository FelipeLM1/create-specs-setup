# Prototype — [Título da feature]

| Campo | Valor |
|-------|-------|
| **Feature** | `{slug-da-feature}` |
| **Sprint** | `{N}` (`sprints/sprint-{N}/`) — badge/filtro no catálogo |
| **Task ref** | `{task_ref}` (ex.: issue GitLab #100) |
| **Pasta do protótipo** | `feature/{task_ref}-{slug}/` (ex.: `feature/100-listagem-usuario/`) |
| **Status** | `rascunho` |
| **Última atualização** | YYYY-MM-DD |
| **Baseado em** | `use-case.md` |
| **Protótipo navegável** | `prototypes/` → [link local ou N/A] |
| **ID no catálogo** | `{task_ref}-{slug}` (ex.: `100-listagem-usuario`) |
| **Rota no catálogo** | `/prototype/{task_ref}-{slug}` |

---

## Objetivo do protótipo

Protótipo navegável de alta fidelidade para validar fluxo e UX **antes** da implementação real.

**Regras do protótipo:**

- [ ] Componentes do design system existente (`{{SPA_REPO}}`)
- [ ] Mock data — sem API real
- [ ] Sem autenticação
- [ ] Sem dependências bloqueantes de backend
- [ ] Estados loading / error / empty implementados
- [ ] Fluxo navegável ponta a ponta
- [ ] Pasta isolada em `prototypes/src/app/feature/{task_ref}-{slug}/`
- [ ] Registrado no catálogo com campo `sprint` (`prototypes/src/app/prototypes/registry/prototype-catalog.data.ts`)
- [ ] Badge Sprint {N} e filtros (busca + sprint) na home do catálogo
- [ ] Acessível via `npm start` no diretório `prototypes/`

---

## Telas

### Tela 01 — [nome]

| Campo | Valor |
|-------|-------|
| **Rota mock** | `/prototype/{task_ref}-{slug}/...` |
| **Objetivo** | |
| **Componentes DS** | ex.: `DataTable`, `Button`, `Modal` |

**Layout / comportamento:**

- 

**Estados:**

| Estado | Comportamento |
|--------|---------------|
| Loading | |
| Empty | |
| Error | |
| Success | |

**Mock data:**

```json
{
  "exemplo": "preencher"
}
```

---

### Tela 02 — [nome]

<!-- Repetir estrutura conforme necessário -->

---

## Navegação

Fluxo entre telas (como o usuário navega no protótipo).

```
[Tela A] → [ação] → [Tela B] → ...
```

---

## Componentes do design system

Lista consolidada para facilitar implementação.

| Componente | Uso |
|------------|-----|
| | |

---

## Fora do protótipo

O que **não** precisa existir no mock (mas pode existir na implementação real).

- 

---

## Implementação do protótipo

**Pasta:** `prototypes/src/app/feature/{task_ref}-{slug}/`

**Página:** `.../pages/{slug}-prototype-page.component.ts`

**Mock data:** `.../data/{slug}-mock.data.ts`

**Como criar:** consulte [skill prototype-angular](../.agents/skills/prototype-angular/SKILL.md)

---

## Pendências

- [PENDENTE] 
