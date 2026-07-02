---
name: welcome
description: Boas-vindas e orientação no create-specs-setup. Apresenta opções (setup novo, upgrade, entender o repo) e delega à skill correta. Use na primeira mensagem no bootstrap ou quando o usuário não souber por onde começar.
---

# Skill: Boas-vindas (create-specs-setup)

## Quando usar

- Primeira interação neste repositório
- "o que posso fazer aqui?", "por onde começo?", "boas-vindas"
- Usuário abriu o workspace e não sabe se é setup ou upgrade

**Esta skill não grava instância** — orienta e delega.

---

## Objetivo

Receber o usuário, explicar o papel do **create-specs-setup** em uma frase e ajudá-lo a escolher o próximo passo.

---

## Mensagem de abertura (1ª interação)

```
Bem-vindo ao **create-specs-setup**.

Este repositório **configura** o SDD do seu produto — ele **não** é onde você especifica features no dia a dia. Aqui você roda o setup **uma vez** e nasce `{projeto}-specs`.

O que você quer fazer?

1. **Setup novo** — criar instância SDD pela primeira vez (entrevista guiada)
2. **Upgrade** — atualizar instância que já existe para o contrato v1
3. **Entender o fluxo** — explicar pré-requisitos, workspace e handoff (sem gravar nada)
4. **Já tenho instância** — orientar a trabalhar só em `{projeto}-specs`

Descreva em uma frase ou escolha o número.
```

Se o usuário já disse o que quer (ex.: "configurar SDD do projeto X"), **pule o menu** e vá direto à delegação.

---

## Roteamento

| Escolha / sinal | Delegar para |
|-----------------|--------------|
| 1 · setup novo · "criar specs" · "primeira vez" | `.agents/skills/create-specs-setup/SKILL.md` |
| 2 · upgrade · "retrofit" · "atualizar instância" | `.agents/skills/upgrade-specs/SKILL.md` |
| 3 · "como funciona" · dúvidas sobre processo | Resumir `docs/setup-workflow.md` + oferecer iniciar setup |
| 4 · "já configurei" · trabalho no dia a dia | Orientar: abrir `{projeto}-specs` e usar skill `welcome` **da instância** |

---

## Explicação rápida (opção 3)

Resumir em poucas linhas:

1. Workspace multi-root: bootstrap + repos de código + pasta `{projeto}-specs`
2. Entrevista completa → confirmação → agente grava arquivos (sem scripts)
3. Validação V1–V11 → handoff para `{projeto}-specs`
4. Protótipo Angular opcional

Links: `docs/setup-workflow.md` · `docs/setup-interview-checklist.md` · `docs/instance-contract.md`

Perguntar: *"Quer iniciar o setup novo (1) ou upgrade (2)?"*

---

## Anti-patterns

- Iniciar entrevista de setup nesta skill (delegar `create-specs-setup`)
- Criar `features/` ou gravar na instância destino daqui
- Assumir que o usuário quer setup sem confirmar

---

## Referências

- `AGENTS.md` — regras do bootstrap
- `README.md` — visão geral
