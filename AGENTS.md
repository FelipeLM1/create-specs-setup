# AGENTS — create-specs-setup (bootstrap)

Este repositório **não** é o repositório de specs do seu produto. Ele serve apenas para **configurar** ou **atualizar** uma instância SDD (`contract_version: 1`).

---

## Ponto de entrada

**Skill padrão:** [`.agents/skills/welcome/SKILL.md`](.agents/skills/welcome/SKILL.md)

A skill `welcome` apresenta as opções e delega:

| Situação | Skill delegada |
|----------|----------------|
| Setup **novo** | [`create-specs-setup`](.agents/skills/create-specs-setup/SKILL.md) |
| **Upgrade** de instância existente | [`upgrade-specs`](.agents/skills/upgrade-specs/SKILL.md) |

Se na Fase 0 do setup o usuário disser **atualização** → `create-specs-setup` delega `upgrade-specs` e encerra.

---

## Após o setup

Trabalhe **somente** no repositório de specs gerado (ex.: `my-product-specs`). Use a skill **`welcome`** da instância (depois o guide para triagem fina).

---

## Regras

1. **Não** criar `features/` ou `fixes/` neste repositório bootstrap.
2. Modo sempre **guiado** — seguir [`docs/setup-interview-checklist.md`](docs/setup-interview-checklist.md); máx. **3 perguntas por rodada**.
3. **Não gravar** na instância até o resumo final confirmado pelo usuário (Fase 6).
4. **Não inventar** paths, URLs, stack ou glossário — validar no disco e perguntar o que faltar.
5. Idioma padrão das instâncias: **pt-BR** (confirmar na entrevista).
6. Após gravar: executar validação **V1–V12** ([`docs/instance-contract.md`](docs/instance-contract.md)) e reportar tabela ✅/❌ antes do handoff.
7. Responder em português.

---

## Referências

- [`docs/setup-workflow.md`](docs/setup-workflow.md) — workspace, handoff, protótipo
- [`docs/setup-interview-checklist.md`](docs/setup-interview-checklist.md) — entrevista completa (Fases 0–7)
- [`docs/instance-contract.md`](docs/instance-contract.md) — contrato da instância gerada
- [`templates/instance/`](templates/instance/) — fonte dos arquivos renderizados
