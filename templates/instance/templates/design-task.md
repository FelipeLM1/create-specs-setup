# Design Task — [Título da feature]

| Campo | Valor |
|-------|-------|
| **Feature** | `{slug-da-feature}` |
| **Público** | Design (UX/UI) |
| **Status** | `rascunho` |
| **Última atualização** | YYYY-MM-DD |
| **Baseado em** | `spec/`, `design/prototype.md` |
| **GitLab** | [link da issue de design — preencher ao criar] |

---

> **Como usar:** task para **designer** — telas, componentes visuais, comportamento e usabilidade. **Sem** endpoints, código, banco ou nomes de componentes de framework.
>
> Task de **dev** (implementação): `tasks/sprint-task.md`

---

## Texto para GitLab

### Contexto

- **Problema (usuário):** 
- **Quem usa:** 
- **Onde na aplicação:** (módulo, menu, aba, fluxo)

### Telas no escopo

| Tela / view | Objetivo para o usuário |
|-------------|-------------------------|
| | |

### Por tela — estrutura e componentes

Use blocos curtos por tela (não repetir o que já está igual em todas).

#### [Nome da tela]

- **Layout:** (ex.: cabeçalho + filtros fixos + área de KPIs + grid + tabela)
- **Componentes visuais:** (ex.: multiselect, chips de filtro, cards KPI, mapa, tabela paginada)
- **Hierarquia / prioridade:** o que o usuário vê primeiro e o que é secundário
- **Copy / labels:** idioma e termos principais (se já definidos)

### Comportamento e interação

- **Ações do usuário:** (cliques, seleções, busca, export, navegação entre telas)
- **Feedback:** (loading, sucesso, vazio, erro — o que aparece e onde)
- **Regras de UI:** (ex.: filtro X não altera painel Y; toggle no mapa; paginação)
- **Estados da interface:** (inicial, filtrado, sem dados, carregando)

### Usabilidade

- **Fluxo principal:** passos em linguagem de usuário (happy path)
- **Pontos de atenção:** confusão evitada, consistência com telas existentes, densidade de informação
- **Acessibilidade / responsivo:** [PENDENTE] ou requisitos mínimos acordados

### Critérios de aceite (design)

- [ ] 
- [ ] 

### Entregáveis esperados

- [ ] Layout(s) em Figma (ou ferramenta do time) com estados principais
- [ ] Especificação de componentes reutilizados vs novos (nível visual)
- [ ] Handoff alinhado com `design/prototype.md` e validação com PO/stakeholder

### Referências

- Prototype spec: `sprints/sprint-{N}/features/{slug}/design/prototype.md`
- Use case: `sprints/sprint-{N}/features/{slug}/spec/use-case.md`
- Protótipo navegável (se existir): [link]

### Fora do escopo (design)

- 

### Pendências para design

| # | Decisão | Impacto |
|---|---------|---------|
| | | |

---

## Notas (opcional)

| Item | Valor |
|------|-------|
| **Depende de** | A4 concluído; validação A5 recomendada |
| **Bloqueia** | Sprint task de dev (`tasks/sprint-task.md`) quando layout final for obrigatório |
