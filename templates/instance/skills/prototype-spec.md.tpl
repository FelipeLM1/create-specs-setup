---
name: prototype-spec
description: Especifica telas, estados, mock data e navegação do protótipo em prototype.md. Use quando o usuário pedir spec do protótipo, definir telas, estados da interface ou documentar UX antes da implementação Angular no {{SPECS_REPO_SLUG}}.
---

# Skill: Gerar Especificação do Protótipo

## Quando usar

Use esta skill quando o `use-case.md` estiver pronto e o usuário pedir para especificar o protótipo de alta fidelidade da feature.

**Gatilhos:**
- "gerar spec do protótipo de..."
- "especificar protótipo para..."
- "criar prototype.md de..."
- "definir telas do protótipo de..."

---

## Objetivo

Traduzir o use case em uma especificação de protótipo navegável — descrevendo telas, estados, mock data e navegação — que será a base para a implementação do protótipo em Angular (veja `.agents/skills/prototype-angular/SKILL.md`).

> Esta skill gera o **documento de spec** (`prototype.md`). A **implementação** do protótipo em Angular é feita pela skill `.agents/skills/prototype-angular/SKILL.md`.

---

## Pré-condições (gate)

Antes de gerar, leia:

- [ ] `features/{slug}/spec/use-case.md`
- [ ] `features/{slug}/spec/business-rules.md`

Se use case não existir → delegar `use-case` primeiro.

> Ver `docs/skill-conventions.md`.

## Passo a passo

### 1. Mapear as telas necessárias

A partir do happy path e dos fluxos alternativos, identifique cada tela ou estado visual distinto.

Cada "mudança significativa de interface" = uma tela no protótipo.

**Exemplos:**
- Listagem com filtros
- Formulário de upload
- Modal de confirmação
- Tela de resultado/sucesso
- Estado de erro

### 2. Definir o ID do protótipo no catálogo

ID em kebab-case, igual ao slug da feature (ou mais específico se necessário):
- `import-planilha-fornecedor`
- `filtro-reparo-por-lote`

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

Arquivo `features/{slug}/design/prototype.md` com:
- ID e rota no catálogo
- Especificação de cada tela (layout, estados, mock data)
- Mapa de navegação
- Lista consolidada de componentes
- Pendências

---

## Após gerar — progress e entrega

1. Atualizar `features/{slug}/progress.md` — marcar **A4** `[x]` (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximos passos:** B1 — Sprint task (`sprint-task`) ou B4 — Protótipo Angular (`prototype-angular`)
