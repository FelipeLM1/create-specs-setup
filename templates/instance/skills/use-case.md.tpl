---
name: use-case
description: Gera caso de uso com happy path, fluxos alternativos e edge cases a partir de business rules. Use quando o usuário pedir use case, fluxo funcional, cenários de exceção ou documentar jornada do usuário no {{SPECS_REPO_SLUG}}.
---

# Skill: Gerar Use Case

## Quando usar

Use esta skill quando o `business-rules.md` estiver pronto e o usuário pedir para gerar o fluxo funcional da feature.

**Gatilhos:**
- "gerar use case de..."
- "criar caso de uso para..."
- "documentar o fluxo de..."
- "derivar use case do business rules"

---

## Objetivo

Traduzir as regras de negócio em um fluxo funcional completo — com happy path, fluxos alternativos e edge cases — que sirva de base para o protótipo e para a implementação.

---

## Pré-condições (gate)

Antes de gerar, leia:

- [ ] `sprints/sprint-{N}/features/{slug}/spec/meeting-notes.md`
- [ ] `sprints/sprint-{N}/features/{slug}/spec/business-rules.md`

Se business rules não existir → delegar `business-rules` primeiro.

> Não escreva se RNs estiverem ausentes — pergunte ou volte à etapa anterior. Ver `docs/skill-conventions.md`.

## Passo a passo

### 1. Absorver os artefatos anteriores

Leia meeting notes e business rules. Identifique:
- Quem usa esta feature? (ator principal)
- O que o ator quer alcançar?
- Quais pré-condições devem ser verdadeiras antes de iniciar?
- O que muda no sistema após o sucesso?

### 2. Preencher o resumo do use case

| Campo | Guia |
|-------|------|
| **Ator principal** | Quem inicia a ação (ex.: Comprador, Analista de Estoque) |
| **Objetivo** | O que o ator quer alcançar em uma frase |
| **Pré-condições** | O que deve ser verdade antes do início |
| **Pós-condições** | O que o sistema garante após o sucesso |

### 3. Escrever o fluxo principal (happy path)

Liste os passos em ordem, do ponto de vista do **usuário + sistema**:

```
1. Usuário faz X
2. Sistema valida Y e exibe Z
3. Usuário confirma
4. Sistema persiste e notifica
```

**Regras do happy path:**
- Começa no ponto de partida do usuário, não no backend
- Cada passo é uma ação ou resposta clara
- Não inclui erros nem alternativas — isso vai nos fluxos seguintes
- Referencie as RNs aplicáveis (ex.: "aplica RN-02")

### 4. Escrever fluxos alternativos

Caminhos válidos que diferem do principal mas ainda terminam em sucesso.

```
### FA-01 — [nome descritivo]
Quando: [condição que ativa este fluxo]
1. [passo]
2. [passo]
Resultado: [o que o usuário consegue]
```

### 5. Mapear edge cases e exceções

| ID | Cenário | Comportamento esperado | Regra relacionada |
|----|---------|----------------------|-------------------|
| EX-01 | [situação anormal] | [o que o sistema faz] | RN-XX |

**Fontes de edge cases:**
- Dúvidas do meeting notes
- Pendências do business rules
- Casos de dados inválidos, ausentes ou em conflito
- Limites de volume, permissão ou estado

### 6. Definir estados da interface

Para cada estado relevante, descreva o que o usuário vê:

| Estado | Quando ocorre | O que o usuário vê |
|--------|---------------|-------------------|
| Loading | Processamento em andamento | Indicador de carregamento |
| Empty | Nenhum dado para exibir | Mensagem de estado vazio |
| Error | Operação falhou | Mensagem de erro + ação sugerida |
| Success | Operação concluída | Confirmação visual |

### 7. Delimitar o escopo

Liste explicitamente o que está **fora** deste use case — para evitar scope creep na implementação.

### 8. Listar pendências abertas

Qualquer ponto que ficou sem resposta clara deve ir em **Pendências** com `[PENDENTE]`.

> Estas pendências devem ser escaladas para os líderes antes da implementação.

---

## Validação antes de entregar

- [ ] Happy path é coerente com as business rules
- [ ] Edge cases cobrem os cenários mencionados nas regras e no meeting notes
- [ ] Estados da interface definidos
- [ ] Nenhuma contradição com artefatos anteriores
- [ ] Pendências explícitas e rastreáveis
- [ ] Status = `rascunho`

---

## Saída esperada

Arquivo `sprints/sprint-{N}/features/{slug}/spec/use-case.md` com:
- Resumo do use case (ator, objetivo, pré/pós-condições)
- Fluxo principal passo a passo
- Fluxos alternativos numerados (FA-XX)
- Tabela de edge cases (EX-XX) com referência às regras
- Estados da interface
- Escopo e pendências

---

## Após gerar — progress e entrega

1. Atualizar `sprints/sprint-{N}/features/{slug}/progress.md` — marcar **A3** `[x]` (skill `feature-progress`)
2. Responder ao usuário conforme `docs/skill-conventions.md`

**Próximo passo:** A4 — Prototype spec (skill `prototype-spec`)
