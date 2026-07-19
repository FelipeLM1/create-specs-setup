---
name: prototype-spec
description: Especifica telas, estados, mock data e navegação do protótipo em prototype.md. Use quando o usuário pedir spec do protótipo, definir telas, estados da interface ou documentar UX antes da implementação Angular no {{SPECS_REPO_SLUG}}.
---

# Skill: Gerar Especificação do Protótipo

## Quando usar

Use esta skill quando o usuário pedir para especificar o protótipo de alta fidelidade da feature — **após Meeting notes**, no ramo protótipo-primeiro, **ou** após use case no ramo artefatos-primeiro.

**Gatilhos:**
- "gerar spec do protótipo de..."
- "especificar protótipo para..."
- "criar prototype.md de..."
- "definir telas do protótipo de..."

---

## Objetivo

Traduzir o contexto da feature (Meeting notes e, se existirem, use case / business rules) em uma especificação de protótipo navegável — telas, estados, mock data e navegação — base para o protótipo Angular (`.agents/skills/prototype-angular/SKILL.md`).

> Esta skill gera o **documento de spec** (`prototype.md`). A **implementação** do protótipo em Angular é feita pela skill `.agents/skills/prototype-angular/SKILL.md`.

---

## Pré-condições (gate)

Antes de gerar, leia o que existir em `sprints/sprint-{N}/features/{slug}/`:

- [ ] `spec/meeting-notes.md` — **obrigatório** (mínimo no ramo protótipo-primeiro)
- [ ] `spec/use-case.md` — se existir (ramo artefatos-primeiro ou já gerado)
- [ ] `spec/business-rules.md` — se existir

Se **Meeting notes** não existir → delegar `meeting-notes` primeiro.

**Não** exigir use case / business rules quando o ramo for `prototype-first` — o protótipo ajuda a fechá-los depois.

> Ver `docs/skill-conventions.md` · `docs/feature-lifecycle.md` § Ramos pós Meeting notes.

## Passo a passo

### 1. Mapear as telas necessárias

Fontes, nesta ordem de disponibilidade:
1. Use case (happy path e fluxos alternativos), se existir
2. Meeting notes (o que foi pedido, decisões, restrições)
3. Conversa atual com o usuário

Cada "mudança significativa de interface" = uma tela no protótipo.

**Exemplos:**
- Listagem com filtros
- Formulário de upload
- Modal de confirmação
- Tela de resultado/sucesso
- Estado de erro

### 2. Definir o ID do protótipo no catálogo e a sprint

ID em kebab-case, igual ao padrão `{task_ref}-{slug}` (ou mais específico se necessário):
- `100-import-planilha-fornecedor`
- `101-filtro-reparo-por-lote`

**Sprint (`sprint: number`):** obrigatória no card do catálogo — igual a `N` de `sprints/sprint-{N}/features/{slug}/` (default: `workflow.current_sprint`). A home do catálogo filtra por sprint e exibe badge **Sprint {N}**.

### 3. Especificar cada tela

Para cada tela, documente:

**Identificação:**
- Nome descritivo
- Rota mock (ex.: `/prototype/{task_ref}-{slug}`)
- Task ref (ex.: issue GitLab #100) — usado no nome da pasta `feature/{task_ref}-{slug}/`
- Objetivo da tela

**Componentes do design system:**
Liste os componentes visuais necessários do `{{SPA_REPO}}`. Exemplos: `DataTable`, `Button`, `Modal`, `SearchInput`, `Badge`, `Stepper`.

**Layout e comportamento:**
Descreva em bullets o que aparece na tela e como o usuário interage. Seja específico — o dev Angular vai usar isso diretamente.

**Estados obrigatórios:**

| Estado | Comportamento |
|--------|---------------|
| Loading | O que aparece enquanto carrega |
| Empty | O que aparece quando não há dados |
| Error | O que aparece em caso de falha |
| Success | O que aparece após operação bem-sucedida |

**Mock data:**
Forneça exemplos de dados realistas em JSON para popular a tela. Dados devem fazer sentido no contexto do negócio (nomes, códigos, valores plausíveis).

```json
{
  "exemplo": "dados realistas aqui"
}
```

### 4. Definir a navegação entre telas

Descreva como o usuário se move entre telas:

```
[Tela A: Listagem] → clica "Importar" → [Tela B: Upload]
[Tela B: Upload] → arquivo válido → [Tela C: Confirmação]
[Tela C: Confirmação] → confirma → [Tela D: Resultado]
[Tela B: Upload] → arquivo inválido → [Tela B: Upload com erro]
```

### 5. Consolidar componentes do design system

Liste todos os componentes usados em todas as telas — facilita a implementação em Angular.

### 6. Delimitar o que fica fora do protótipo

Funcionalidades que existirão na implementação real mas **não** precisam estar no mock:
- Autenticação
- Integração com API real
- Persistência de dados
- Validações complexas de backend

### 7. Definir pendências

Tudo que ainda precisa de decisão antes de implementar o protótipo.

---

## Validação antes de entregar

- [ ] Todas as telas do happy path estão especificadas
- [ ] Todos os estados (loading, empty, error, success) definidos para cada tela
- [ ] Mock data realista e coerente com o negócio
- [ ] Navegação entre telas documentada
- [ ] Componentes do design system listados
- [ ] Nenhuma dependência de backend real
- [ ] Status = `rascunho`

---

## Saída esperada

Arquivo `sprints/sprint-{N}/features/{slug}/design/prototype.md` com:
- ID e rota no catálogo
- Especificação de cada tela (layout, estados, mock data)
- Mapa de navegação
- Lista consolidada de componentes
- Pendências

---

## Após gerar — progress e entrega

1. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **A4** `[x]` (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximos passos** (conforme ramo no progress):
- Ramo `prototype-first`: Protótipo Angular (`prototype-angular`) ou Design task (`design-task`); depois Business rules / Use case
- Ramo `artifacts-first` ou já com RN/use case: Protótipo Angular (`prototype-angular`) ou Sprint task (`sprint-task`)
