---
name: quick-fix
description: Cria especificação enxuta de bug-fix ou ajuste no {{SPECS_REPO_SLUG}} (fixes/{slug}/). Faz perguntas até reunir contexto mínimo e gera fix-task.md e progress.md. Use quando o usuário reportar bug, pedir correção, ajuste pontual, fix task, issue de bug ou investigar problema sem ser feature nova.
---

# Skill: Quick Fix (bug-fix e ajustes)

## Quando usar

**Gatilhos:**
- "registrar bug de…"
- "criar fix de…"
- "ajustar…" / "corrigir…"
- "montar task de bug…"
- "investigar e documentar…"
- "quick fix de…"
- Sintoma + pedido de task/issue enxuta

**Não usar quando:**
- Hotfix urgente em produção → issue GitLab + MR direto, sem {{SPECS_REPO_SLUG}}
- Nova funcionalidade ou mudança de regra de negócio → skill `full-spec` / fluxo `features/`

**Referência:** `docs/fix-lifecycle.md` · `docs/skill-conventions.md`

---

## Objetivo

Conduzir uma **entrevista curta** com o usuário, reunir o contexto mínimo e gerar automaticamente:

```
fixes/{slug}/
├── fix-task.md
└── progress.md
```

A seção **Texto para GitLab** deve ser copiável e objetiva: contexto, atual vs esperado, reprodução, aceite.

---

## Regra de ouro

> **Não escreva arquivos até o checklist de contexto mínimo estar completo.**

Se faltar informação, faça perguntas — no máximo **3 por mensagem**, agrupadas por tema. Não invente causa raiz nem solução sem evidência; use `[HIPÓTESE]` ou `[PENDENTE]`.

---

## Fase 1 — Triagem rápida (1ª interação)

Antes de perguntas detalhadas, classifique mentalmente:

| Tipo | Sinal |
|------|-------|
| `bug` | Comportamento incorreto vs o esperado |
| `adjustment` | Melhoria pontual acordada (label, copy, filtro, validação) |

Se claramente for **feature nova**, interrompa e sugira fluxo `features/`.

---

## Fase 2 — Coleta de contexto (perguntas)

Pergunte **apenas o que faltar**. Use esta ordem de prioridade:

### Bloco A — Identificação (obrigatório)

| # | Campo | Pergunta guia |
|---|-------|---------------|
| A1 | **Título** | Em uma frase: qual o problema ou ajuste? |
| A2 | **Slug** | Sugira kebab-case a partir do título; confirme com o usuário |
| A3 | **Tipo** | `bug` ou `adjustment`? |
| A4 | **Origem** | Quem reportou? (QA, PO, usuário, dev, produção) |
| A5 | **Prioridade** | `baixa`, `media` ou `alta`? |

### Bloco B — Comportamento (obrigatório)

| # | Campo | Pergunta guia |
|---|-------|---------------|
| B1 | **Atual** | O que acontece hoje? (bullets) |
| B2 | **Esperado** | O que deveria acontecer? |
| B3 | **Reprodução** | Passos para reproduzir — ou "não reproduzível" + evidência (print, log, request) |

### Bloco C — Localização (obrigatório)

| # | Campo | Pergunta guia |
|---|-------|---------------|
| C1 | **Onde** | Tela, menu, endpoint, job, importação, etc. |
| C2 | **Serviços** | {{API_REPO}}, {{SPA_REPO}}, {{SPECS_REPO_SLUG}}, `repos.extra` — quais? |
| C3 | **Feature relacionada** | Existe spec em `features/{slug}/`? Link se souber |

### Bloco D — Aceite e escopo (obrigatório)

| # | Campo | Pergunta guia |
|---|-------|---------------|
| D1 | **Critérios de aceite** | 1–3 condições verificáveis ("passou" / "falhou") |
| D2 | **Fora de escopo** | O que **não** entra neste fix? |

### Bloco E — Investigação (recomendado, não bloqueante)

| # | Campo | Pergunta guia |
|---|-------|---------------|
| E1 | **Hipótese de causa** | Alguma suspeita? (ou deixar `[PENDENTE]`) |
| E2 | **Caminho de investigação** | Onde olhar primeiro? (classe, query, componente) |
| E3 | **Solução sugerida** | Ideia de fix, se houver |
| E4 | **Referências** | Links, MRs, logs, IDs de request, versão deployada |

**Enriquecimento opcional:** se o usuário autorizar e o repo estiver acessível, busque no código classes/endpoints mencionados e **refine** hipótese e caminho de investigação — sempre rotulando inferências como `[HIPÓTESE]`.

---

## Checklist de contexto mínimo (gate)

Só avance para gerar arquivos quando **todos** estiverem preenchidos:

- [ ] Slug confirmado (kebab-case, pasta ainda não existente ou usuário pediu atualização)
- [ ] Tipo (`bug` | `adjustment`)
- [ ] Comportamento atual **e** esperado
- [ ] Reprodução **ou** evidência explícita de não-reprodução
- [ ] Localização (tela/endpoint/fluxo)
- [ ] Pelo menos 1 serviço impactado
- [ ] Pelo menos 1 critério de aceite verificável
- [ ] Fora de escopo definido (pode ser "nenhum" explícito)

Se E1–E3 vazios, preencher com `[PENDENTE]` ou sugestão `[HIPÓTESE]` — **não bloqueia** geração.

---

## Fase 3 — Gerar arquivos

### 1. Criar estrutura

```bash
mkdir -p fixes/{slug}
```

### 2. `fix-task.md`

- Copiar estrutura de `templates/fix-task.md`
- Preencher **todos** os campos do cabeçalho
- **Texto para GitLab:** linguagem clara, bullets, passos numerados em reprodução
- **Investigação e solução:** hipótese, caminho, solução sugerida, serviços, referências, pendências
- Status inicial: `rascunho`
- Data: hoje (`YYYY-MM-DD`)

### 3. `progress.md`

- Copiar `templates/fix-progress.md`
- Status geral: `specification`
- Marcar **F1** `[x]` após gerar fix-task
- **Próximo passo:** criar issue GitLab (F2)
- Histórico: linha "Checklist e fix-task criados"

### 4. Validar slug único

Se `fixes/{slug}/` já existir:
- Perguntar se atualiza o existente ou usa slug diferente
- Nunca sobrescrever sem confirmação

---

## Qualidade do Texto para GitLab

**Bons critérios de aceite:**
- ✅ Ao exportar CSV da aba X, coluna "Status" aparece preenchida
- ✅ Filtro "All" não zera seleção ao trocar de aba
- ❌ Funciona corretamente
- ❌ Sem regressões *(vago — especificar smoke)*

**Reprodução:**
- Passos numerados, dados de exemplo quando relevante
- Ambiente se souber (dev, homolog, prod)

**Investigação (no arquivo, opcional no GitLab):**
- Ordem lógica: reproduzir → logs/network → camada (UI/API/DB) → diff recente
- Solução sugerida: concreta mas não obrigatória ("considerar…", "verificar se…")

---

## Fase 4 — Entrega ao usuário

Após gerar, responda em português com:

1. **Resumo** (1–2 frases)
2. **Caminho dos arquivos** criados
3. **Texto para GitLab** (bloco copiável ou referência à seção)
4. **Próximos passos:** criar issue (F2), implementar (F3), verificar aceite (F4)
5. **Escalar?** — avisar se parecer feature, não fix

---

## Atualizar fix existente

Se o usuário pedir alteração em fix já documentado:

1. Ler `fixes/{slug}/fix-task.md` e `progress.md`
2. Aplicar mudanças mínimas
3. Atualizar **Última atualização** e linha no **Histórico**
4. Usar skill `fix-progress` se só for status/checklist

---

## Anti-patterns

- Gerar fix-task sem reprodução **e** sem evidência
- Critérios de aceite vagos
- Duplicar meeting notes / business rules
- Criar pasta em `features/` para bug simples
- Marcar status `pronta para sprint` — usar `rascunho` até revisão humana; após revisão pode ir para implementação via progress F2+

---

## Integração

| Após… | Ação |
|-------|------|
| Issue GitLab criada | Atualizar link em fix-task + `fix-progress` F2 |
| MR mergeado | `fix-progress` F3 |
| Aceite verificado | F4, F5, F6 |

---

## Exemplo de abertura da skill

```
Vou registrar este fix no {{SPECS_REPO_SLUG}}. Preciso de algumas informações:

1. Em uma frase: qual o problema ou ajuste?
2. É bug (comportamento errado) ou adjustment (ajuste pontual acordado)?
3. O que acontece hoje e o que deveria acontecer?

(Depois pergunto reprodução, onde ocorre e critérios de aceite.)
```
