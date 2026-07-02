# Workflow de setup SDD

## Pré-requisitos

- **create-specs-setup** no workspace
- Repos de código (API, SPA, …)
- Pasta destino **`{projeto}-specs`** (vazia ou nova)

## Workspace

```json
{
  "folders": [
    { "path": "create-specs-setup" },
    { "path": "meu-projeto-specs" },
    { "path": "meu-projeto-api" },
    { "path": "meu-projeto-spa" }
  ]
}
```

## Setup (agente — skill create-specs-setup)

1. Abrir Agent com **create-specs-setup** no contexto (skill `welcome` orienta as opções)
2. Pedir: *"Configurar SDD do projeto X"* ou apenas *"Olá"* para ver o menu
3. Responder **todas** as fases em [`setup-interview-checklist.md`](setup-interview-checklist.md) — sem pular itens 🔴
4. Confirmar rascunhos de `steering/product.md` e `steering/engineering.md`
5. Revisar **resumo final** e responder **sim** — só então o agente grava
6. Se protótipo confirmado: agente lê o **SPA do projeto** no workspace e monta `prototypes/` (requisito: `repos.spa` acessível)

**Nada é gravado** antes da confirmação explícita do usuário.

## Handoff

- Trabalhar só em `{projeto}-specs`
- Primeira mensagem: *"Olá"* (skill `welcome`) ou *"Quero especificar uma feature nova"*

## Protótipo (opcional)

**Requisito:** o protótipo deriva **exclusivamente** do SPA do projeto configurado. Sem SPA no workspace → não ativar protótipo.

O agente:

1. Valida `{spa}` no workspace e lê `package.json`, estrutura `src/app/`, estilos e `shared/components/`
2. Inicializa `{specs}/prototypes/` com stack alinhada ao SPA
3. Copia/adapta componentes, layout e tema do SPA (sem HTTP/auth)
4. Cria catálogo vazio em `registry/` e pasta `src/app/feature/` (um protótipo por subpasta `{task_ref}-{slug}`)

Protótipos de telas específicas vêm depois, via skill `prototype-angular` — cada um em `feature/100-listagem-usuario/`, `feature/101-login/`, etc.

## Retrofit

Instância legada → skill **upgrade-specs** no create-specs-setup.
