# Regras para IA no processo SDD

Regras mínimas para usar IA (Cursor, ChatGPT, etc.) na geração e refinamento de specs. Objetivo: **previsibilidade**, não automação cega.

---

## Princípios

1. **A IA assiste; o time decide.** Outputs são rascunhos para revisão humana.
2. **Spec > memória do modelo.** Nunca confie no que a IA "sabe" sobre o sistema — use apenas o que está nos artefatos e no código.
3. **Menos é mais.** Respostas curtas, estruturadas, copiáveis para os templates.
4. **Incerteza explícita.** Na dúvida, pergunte — não preencha com suposição.

---

## Antes de gerar qualquer artefato

A IA deve confirmar que tem:

- [ ] Slug/nome da feature
- [ ] Artefato anterior do fluxo (se não for meeting notes)
- [ ] Contexto mínimo: o que o usuário quer, para quem, por quê

**Se faltar contexto:** fazer no máximo 3 perguntas objetivas. Não gerar spec completo com lacunas inventadas.

---

## O que a IA NÃO pode fazer

- Inventar regras de negócio não mencionadas nos artefatos anteriores
- Assumir endpoints, tabelas, campos ou fluxos do sistema sem evidência (código ou spec)
- Criar critérios de aceite vagos ("deve funcionar bem", "sem bugs")
- Pular etapas do fluxo de **feature** (ex.: gerar sprint task sem business rules)
- Adicionar novos tipos de documento além dos templates oficiais (`sprints/sprint-{N}/features/` ou `sprints/sprint-{N}/fixes/`)
- Misturar fato e hipótese sem rotular

---

## Search-first (evidência antes de especificar)

Antes de documentar **endpoint REST**, **campo de banco**, **rota de tela**, **componente** ou **comportamento técnico** já existente no sistema:

1. Ler `sdd.config.yaml` → paths em `repos.api`, `repos.spa` e `repos.extra`
2. Se os repos estiverem no workspace, **buscar evidência** (grep, controllers, services, models, rotas Angular)
3. Prioridade: **código existente** > artefatos da feature > conversa com stakeholder
4. Sem evidência → `[HIPÓTESE]` ou `[PENDENTE]` — nunca apresentar como fato

Isso **não substitui** meeting notes para regra de negócio nova; complementa quando a spec toca implementação real.

Skills com gate técnico: `business-rules`, `sprint-task`, `prototype-spec`, `use-case`.

---

## Separação obrigatória: fato, hipótese, pendente

Em todo output, classificar informação:

| Tipo | Significado | Como marcar |
|------|-------------|-------------|
| **Fato** | Veio da reunião, do sistema ou de spec anterior | Texto normal |
| **Hipótese** | Inferência razoável, não confirmada | `[HIPÓTESE] ...` |
| **Pendente** | Falta confirmação | `[PENDENTE] ...` |

Se uma seção inteira depende de hipóteses, iniciar com:

> ⚠️ Este rascunho contém hipóteses não validadas. Revisar antes de avançar.

---

## Prompts recomendados por etapa

### Meeting Notes

```
Com base nas notas abaixo da reunião, preencha o template meeting-notes.md.
- Extraia apenas o que foi dito ou claramente implícito
- Marque suposições como [HIPÓTESE]
- Liste perguntas abertas em Pendências
- Não invente requisitos
```

### Business Rules

```
Com base em sprints/sprint-{N}/features/{slug}/meeting-notes.md, preencha business-rules.md.
- Regras no formato SE/ENTÃO/QUANDO
- Cada regra deve ser testável
- Não adicione regras ausentes nas meeting notes sem marcar [HIPÓTESE]
```

### Use Case

```
Com base em meeting-notes.md e business-rules.md da feature {slug}, preencha use-case.md.
- Fluxo principal + alternativos + exceções
- Edge cases derivados das rules, não inventados
```

### Prototype

```
Com base nos artefatos da feature {slug}, preencha prototype.md.
- Usar componentes do design system existente ({{SPA_REPO}})
- Mock data, sem auth, estados loading/error/empty
- Não inventar telas que não derivam do use case
```

### Sprint Task

```
Com base em todos os artefatos de sprints/sprint-{N}/features/{slug}/, preencha sprint-task.md.
- Texto curto, copiável para GitLab
- Critérios de aceite verificáveis
- Serviços impactados apenas se mencionados ou evidentes no escopo
```

### Quick Fix (bug / ajuste)

```
Use a skill .agents/skills/quick-fix/SKILL.md.
- Faça perguntas até o checklist de contexto mínimo estar completo
- Só então gere sprints/sprint-{N}/fixes/{slug}/fix-task.md e progress.md
- Texto GitLab: contexto, atual vs esperado, reprodução, aceite
- Investigação e solução sugerida ficam no fix-task (referência interna)
- Não invente causa raiz — use [HIPÓTESE] ou [PENDENTE]
```

### Specs Guide (entrada)

```
Use a skill .agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md quando o usuário não souber por onde começar.
- Triagem: feature / fix / status / continuar / hotfix / implementação
- Delegar para a skill correta
- Modo guiado por padrão em features
```

### Implementação (repos de código)

```
Use implement-sprint-task ou implement-fix conforme o caso.
- Perguntar: existe spec? (sim → referências; não → descrição da task)
- Não alterar código até fechar gaps e o dev confirmar o plano
- Seguir steering/engineering.md e padrões do código existente (Search-first)
- Testes unitários quando fizer sentido (service, regra de negócio, componente)
- Atualizar progress.md (C* ou F3) no {{SPECS_REPO_SLUG}}
```

Convenções compartilhadas: `docs/skill-conventions.md` · agentes: `AGENTS.md`

---

## Reduzir alucinação

1. **Anexar contexto real:** colar trecho de meeting notes, código ou print — não pedir "crie do zero"
2. **Modo guiado por padrão:** uma etapa por vez, com confirmação — batch só se o usuário pedir
3. **Pedir referências:** "cite de qual artefato veio cada regra"
4. **Revisar nomes:** validar nomes de entidades, telas e serviços contra o código quando possível
5. **Limitar criatividade:** "siga exatamente a estrutura do template, sem seções extras"
6. **Ponto de entrada:** se o usuário não souber o fluxo, usar skill `{{GUIDE_SKILL_NAME}}`

---

## Formato de output

- Markdown compatível com os templates
- Português (salvo pedido contrário)
- Sem parágrafos longos — preferir bullets
- Sem emojis no conteúdo dos specs (exceto avisos de hipótese)
- Manter cabeçalho de metadados (slug, status, data, origem)

---

## Revisão humana obrigatória

Antes de marcar qualquer artefato como `pronta para sprint`, um humano deve:

- [ ] Remover ou confirmar todas as `[HIPÓTESE]`
- [ ] Resolver ou registrar todas as `[PENDENTE]`
- [ ] Validar coerência entre os 5 arquivos da pasta

A IA não muda status para `concluída` — isso é decisão do time.
