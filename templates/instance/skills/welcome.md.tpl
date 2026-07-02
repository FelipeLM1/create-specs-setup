---
name: welcome
description: Boas-vindas no {{SPECS_REPO_SLUG}} ({{PROJECT_NAME}}). Apresenta capacidades para PO, dev e líderes e delega ao roteamento. Use na primeira mensagem na instância ou quando o usuário perguntar o que pode fazer aqui.
---

# Skill: Boas-vindas ({{PROJECT_NAME}})

## Quando usar

- Primeira interação no **{{SPECS_REPO_SLUG}}**
- "o que posso fazer?", "quais capacidades tem?", "boas-vindas"
- PO, dev ou líder abrindo o repo sem saber por onde começar

**Esta skill não gera artefatos** — apresenta opções e delega.

---

## Objetivo

Receber o usuário, mostrar **o que o SDD deste projeto permite** e encaminhar para a skill certa.

Contexto do produto: ler `steering/product.md` (1 frase no boas-vindas, se existir).

---

## Mensagem de abertura (1ª interação)

```
Bem-vindo ao **{{SPECS_REPO_SLUG}}** — especificações do **{{PROJECT_NAME}}**.

Aqui conversas viram artefatos rastreáveis: features em `features/`, ajustes em `fixes/`.

**O que você precisa?**

1. **Feature nova** — especificar do zero (reunião → RN → use case → tasks)
2. **Documentar o que já existe** — spec a partir do código (API/SPA)
3. **Bug ou ajuste** — correção pontual
4. **Continuar** — retomar spec ou fix em andamento
5. **Status** — andamento de feature ou fix
6. **Ver todas as capacidades** — lista completa para PO / dev / líder

Descreva em uma frase ou escolha o número.
```

Se o usuário já descreveu a necessidade, **pule o menu** e delegue direto.

---

## Roteamento

| Escolha / sinal | Delegar para |
|-----------------|--------------|
| 1 · feature nova · especificar · reunião | `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md` → fluxo `full-spec` |
| 2 · código já implementado · documentar tela | `.agents/skills/spec-from-code/SKILL.md` |
| 3 · bug · ajuste · comportamento errado | `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md` → `quick-fix` |
| 4 · continuar · onde paramos | `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md` → § Continuar |
| 5 · status | `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md` → `feature-progress` / `fix-progress` |
| 6 · capacidades · ajuda | § Capacidades abaixo + perguntar próximo passo |

**Triagem fina** (ambiguidade, hotfix, etapa isolada): sempre `.agents/skills/{{GUIDE_SKILL_NAME}}/SKILL.md`.

---

## Capacidades (opção 6)

Apresentar por perfil — linguagem simples, sem exigir nomes de skills:

### Para PO / negócio

| Você pode… | Como pedir |
|------------|------------|
| Especificar feature nova | "Quero especificar…" |
| Documentar fluxo já na tela | "Documente o cadastro que já existe" |
| Ver andamento | "Qual o status da feature X?" |
| Registrar reunião / RN / use case | "Meeting notes de…" / "Regras de negócio de…" |

### Para dev

| Você pode… | Como pedir |
|------------|------------|
| Gerar sprint task | "Task de dev para…" (após RN) |
| **Implementar tarefa/feature** | "Implemente a tarefa X" / "Implemente a feature {slug}" |
| **Investigar e corrigir bug** | "Investigue o bug em…" / "Corrija o fix {slug}" |
| Spec a partir do código | "Spec do módulo X já implementado" |
| Documentar bug (sem codar) | "Tenho um bug em…" → `quick-fix` |
| Protótipo navegável | "Protótipo da tela…" (se `prototypes/` ativo) |

### Para líder / coordenação

| Você pode… | Como pedir |
|------------|------------|
| Status de features e fixes | "Onde estamos na feature X?" |
| Visão do ciclo completo | Ver `docs/feature-lifecycle.md` |
| Hotfix urgente | **Fora** deste repo — GitLab + MR direto |

### Skills disponíveis (referência técnica)

| Skill | Função |
|-------|--------|
| `welcome` | Boas-vindas (esta skill) |
| `{{GUIDE_SKILL_NAME}}` | Triagem e roteamento |
| `full-spec` | Orquestra feature A1–B2 |
| `spec-from-code` | Código → spec (RN, use case, gaps, insights) |
| `quick-fix` | Bug / ajuste |
| `meeting-notes` · `business-rules` · `use-case` · `prototype-spec` | Etapas A1–A4 |
| `design-task` · `sprint-task` | B1 · B2 |
| `implement-sprint-task` · `implement-fix` | C* · F3 (dev) |
| `prototype-angular` | B5 |
| `system-manual` | D1 |
| `feature-progress` · `fix-progress` | Status |

Perguntar: *"Qual dessas opções quer seguir agora?"*

---

## Anti-patterns

- Gerar artefatos nesta skill
- Pular triagem em pedido ambíguo (delegar `{{GUIDE_SKILL_NAME}}`)
- Prometer hotfix via pasta `fixes/` quando for urgência em produção

---

## Referências

- `AGENTS.md` · `steering/product.md` · `docs/feature-lifecycle.md`
