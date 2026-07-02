# Armazenamento de regras de negócio (RN)

**Versão:** 1.0 · alinhado a `contract_version: 1`

---

## Fonte primária (padrão)

As regras de negócio vivem em:

```
features/{slug}/spec/business-rules.md
```

Formato **SE / ENTÃO**, numeradas `RN-{code}.{seq}` (ex.: `RN-100.1`).

- Testáveis e rastreáveis aos meeting notes
- Revisão humana antes da sprint task
- Sprint tasks **referenciam** o arquivo local e/ou wiki — não repetem SE/ENTÃO inteiros

---

## Wiki externa (opcional)

Se `sdd.config.yaml` → `business_rules.wiki.enabled: true`:

| Campo | Uso |
|-------|-----|
| `wiki.base_url` | URL base do GitLab/wiki |
| `wiki.page_pattern` | Padrão da página (ex.: `RN{code}`) |

**Gate sprint task (feature nova):** wiki obrigatória **somente** quando `enabled: true`. Caso contrário, basta `business-rules.md` completo e revisado.

---

## Numeração

| Elemento | Formato | Exemplo |
|----------|---------|---------|
| Código da feature/epic | 3 dígitos | `100` |
| Sequência da regra | inteiro a partir de 1 | `.1`, `.2` |
| ID completo | `RN-{code}.{seq}` | `RN-100.1` |

O usuário informa o **código** na skill `business-rules` ou na entrevista de spec.

---

## Espelho local vs wiki

| Cenário | Ação |
|---------|------|
| Só specs repo | Preencher `spec/business-rules.md` apenas |
| Wiki habilitada | Cadastrar na wiki **e** manter espelho local alinhado |

---

## Referência nas tasks

```markdown
**Regras de negócio:** `features/{slug}/spec/business-rules.md`
```

Se wiki habilitada, acrescentar link da página `RN{code}`.

---

**Skill relacionada:** `business-rules` · **Gate B2:** `sprint-task`
