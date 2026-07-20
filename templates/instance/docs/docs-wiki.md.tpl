# Docs wiki (documentação de produto)

A **docs wiki** é um site HTML estático em `docs_wiki/`: explica o produto — o que resolve, como funciona e como fazer no sistema — em linguagem de negócio.

**Não confundir** com a wiki externa de regras de negócio (`business_rules.wiki` no GitLab), usada para RN numeradas e gates de sprint task.

---

## Quando existe

Somente se `sdd.config.yaml` → `docs_wiki.enabled: true` (decidido no setup ou no upgrade).

---

## Conteúdo

| Inclui | Não inclui |
|--------|------------|
| Problema de negócio | Código-fonte |
| Valor e comportamento do sistema | Endpoints / banco |
| Passo a passo de uso | Decisões de implementação |

Estilo de escrita configurável: `narrativo` (padrão) · `didatico` · `conciso` · `personalizado`.

Não justificar na página “para quem é a wiki” — ir direto ao conteúdo do produto.

---

## Visual e animação

| Eixo | Opções |
|------|--------|
| Tema | `editorial` · `suave` · `marcante` · `minimalista` — cada um já traz tipografia **e** paleta de cores |
| Cores da marca | `usar_cores_marca: false` (padrão — mantém paleta do tema) ou `true` + `cor_principal` / `cor_destaque` |
| Animação | `sutil` (padrão) · `elaborado` · `nenhum` |

Animações via CSS + `assets/js/motion.js`. Respeita se o visitante pediu reduzir movimento no sistema.

### SVG / ilustrações

A skill `docs-wiki-page` pode buscar ou criar SVGs para enriquecer as páginas.

**Regra:** somente licença **MIT** (ou SVG criado pelo agente). Sem CC, “personal use”, ou origem sem licença clara.

Exemplos MIT: Lucide, Heroicons, Phosphor. Preferir embutir em `docs_wiki/assets/svg/` ou inline no HTML.

### Diagramas

Usar `assets/css/diagrams.css` (fluxo, split, decisão, figura SVG) para didática visual — estático, sem dependência de build. A skill `docs-wiki-page` deve incluir diagramas quando o fluxo ou a decisão forem o centro da explicação.

---

## Como abrir / entregar

1. Abrir `docs_wiki/index.html` no navegador, ou
2. Empacotar a pasta `docs_wiki/` e enviar, ou
3. Servir como site estático

Sem framework e sem build obrigatório.

---

## Novas páginas

Skill **`docs-wiki-page`** — sob demanda (não automática no lifecycle da feature).

Modelo: `docs_wiki/templates/page.html`.

### Catálogo e busca

- Fonte: `docs_wiki/assets/js/catalog-data.js` (formato JS para funcionar via `file://`)
- UI: busca no header + seção catálogo no `index.html` (filtros por tipo)
- Ao gerar página: **obrigatório** registrar em `catalog-data.js`

### Marca

Logo opcional em `docs_wiki/assets/brand/` (`logo.png` / `logo-on-dark.png`).

---

## Relação com o SDD

As specs em `sprints/.../features/{slug}/` continuam sendo a fonte detalhada interna. A docs wiki **reescreve** o essencial em tom de produto.
