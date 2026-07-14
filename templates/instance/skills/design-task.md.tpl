---
name: design-task
description: Gera task de design (UX/UI) para designer — telas, componentes visuais, comportamento e usabilidade, sem implementação de código. Use quando pedir task de design, issue para designer, spec visual ou entregável Figma no {{SPECS_REPO_SLUG}}.
---

# Skill: Gerar Design Task

## Quando usar

Use quando a spec (A1–A4) estiver pronta e o usuário precisar de uma **issue para design**, separada da task de **dev**.

**Gatilhos:**
- "gerar task de design de..."
- "criar issue para designer..."
- "task UX/UI de..."
- "especificação visual para o design..."

**Não usar** para implementação — delegar `sprint-task` (dev).

---

## Objetivo

Consolidar `prototype.md`, use case e regras de negócio em uma task **curta e acionável** para o designer: o que desenhar, como deve se comportar na tela e como validar — **sem** detalhes de código.

---

## Pré-condições (gate)

Ler em `sprints/sprint-{N}/features/{slug}/`:

- [ ] `design/prototype.md` (obrigatório)
- [ ] `spec/use-case.md`
- [ ] `spec/business-rules.md` (regras que afetam UI)

Se A4 incompleto → delegar `prototype-spec` via `{{GUIDE_SKILL_NAME}}`.

---

## O que incluir vs excluir

| Incluir | Excluir |
|---------|---------|
| Telas, views, abas | Endpoints, REST, DTOs |
| Componentes visuais (tabela, filtro, card, mapa) | Classes Angular, services, repos |
| Estados de UI (loading, empty, error) | SQL, migrations, entidades JPA |
| Interações (clique, toggle, busca local) | Estimativa em story points de dev |
| Copy, labels, idioma da UI | Lógica de negócio só backend |
| Critérios de aceite **verificáveis em design** | Critérios de deploy ou API |

---

## Passo a passo

### 1. Resumir contexto (2–3 bullets)

Problema do **usuário**, perfil e onde a feature aparece no produto.

### 2. Listar telas no escopo

Tabela: tela → objetivo. Uma linha por view principal.

### 3. Detalhar por tela (enxuto)

Para cada tela relevante:

- Layout (regiões da tela)
- Componentes visuais
- Hierarquia / o que é primário
- Labels já definidos

Não repetir o mesmo bloco em todas as telas se for idêntico (ex.: "filtros globais iguais à aba X").

### 4. Comportamento e interação

Traduzir use case e RNs em linguagem de interface:

- Ações do usuário e efeito na tela
- Feedback e mensagens
- Regras de UI (o que atualiza com filtro, o que não atualiza)
- Estados (inicial, filtrado, vazio, erro)

### 5. Usabilidade

Fluxo principal em passos de usuário; 2–4 pontos de atenção (clareza, consistência, carga cognitiva). Acessibilidade/responsivo: fato ou `[PENDENTE]`.

### 6. Critérios de aceite (design)

Verificáveis pelo designer ou PO na revisão visual:

- ✅ Layout da tela de resumo cobre cards, filtros e tabela com estados empty documentados
- ❌ Tela bonita e intuitiva

### 7. Entregáveis, referências, fora do escopo, pendências

Preencher seções do template. Marcar `[PENDENTE]` o que faltar — não inventar.

---

## Relação com sprint task (dev)

- **Design task** (`tasks/design-task.md`) → designer; etapa **B1**
- **Sprint task** (`tasks/sprint-task.md`) → devs; etapa **B2**

A sprint task deve **referenciar** o link Figma/design task quando existir. Se o time não usa designer formal, marcar B1 como `[-]` no progress e ir direto para B2.

---

## Validação antes de entregar

- [ ] Nenhum detalhe de implementação de código
- [ ] Telas e comportamentos alinhados a `prototype.md` e use case
- [ ] Critérios de aceite verificáveis em revisão de design
- [ ] Pendências explícitas
- [ ] Status = `rascunho`

---

## Saída esperada

- Arquivo: `sprints/sprint-{N}/features/{slug}/tasks/design-task.md` (template `templates/design-task.md`)
- Seção **Texto para GitLab** pronta para copiar

---

## Após gerar

1. Atualizar `progress.md` — marcar **B1** `[x]` (`feature-progress`)
2. Mensagem pós-etapa em `docs/skill-conventions.md`
3. Sugerir próximo: **B2** — `sprint-task` (dev) ou revisão com designer
