---
name: docs-wiki-page
description: Gera ou atualiza páginas HTML da docs wiki do produto em docs_wiki/. Tom narrativo de negócio/produto. Use quando pedir página da wiki, documentar feature na docs wiki, atualizar docs wiki ou exportar guia de produto no {{SPECS_REPO_SLUG}}.
---

# Skill: Docs wiki — gerar/atualizar página

## Quando usar

**Gatilhos:**
- "gerar página da wiki sobre…"
- "documentar na docs wiki a feature…"
- "atualizar a wiki do produto…"
- "página da wiki sobre…"

**Pré-condição:** `docs_wiki.enabled: true` em `sdd.config.yaml` e pasta `docs_wiki/` existente.
Se desabilitada → informar e oferecer criar via `upgrade-specs` / setup.

**Sob demanda** — não faz parte do lifecycle automático da feature.

---

## Objetivo

Criar ou atualizar uma página HTML estática em `docs_wiki/pages/`, alinhada ao tema/escrita/animação configurados, em tom de **negócio/produto**.

---

## Regras de conteúdo (obrigatórias)

1. **Sem** código, endpoints, nomes de tabela, stacks ou detalhes de implementação
2. Linguagem acessível; seguir `docs_wiki.escrita` em `sdd.config.yaml`
3. Preferir narrativa: problema → o que resolve → como funciona → como fazer
4. Usar componentes do template: `callout`, `steps`, `card` quando fizer sentido
5. Fontes de verdade internas (specs) **reescritas** em tom de produto — não copiar RN/SE-ENTÃO literal
6. Respeitar `ai-rules.md` (fato / `[HIPÓTESE]` / `[PENDENTE]`)
7. Responder em **português** (ou idioma de `project.language`)
8. **Não** incluir seções do tipo “para quem é esta wiki” / justificar público — ir direto ao conteúdo

### Estilos de escrita (`docs_wiki.escrita`)

| Valor | Como escrever |
|-------|----------------|
| `narrativo` (padrão) | Contar a história; prosa fluida; poucos jargões |
| `didatico` | Mais tutorial; listas e “como faço X” em destaque |
| `conciso` | Parágrafos curtos; ir direto ao ponto |
| `personalizado` | Seguir `docs_wiki.escrita_notas` no config |

### SVG e animações visuais

Quando fizer sentido (hero, passos, callouts, cards), incluir ilustrações/ícones SVG e animá-los conforme `docs_wiki.animacao`.

**Licença obrigatória: somente MIT** (ou SVG criado pelo agente na hora).  
Não usar assets com CC, proprietários, “free for personal use only”, origem duvidosa ou licença desconhecida.

Fontes MIT aceitáveis (exemplos): Lucide, Heroicons, Phosphor Icons — baixar o SVG, embutir inline ou em `docs_wiki/assets/svg/`, adaptar `stroke`/`fill` às cores do tema.

| `animacao` | Comportamento visual |
|------------|----------------------|
| `sutil` | Entrada ao scroll + hover leve; SVG com animação discreta |
| `elaborado` | Draw-on, stagger, SVG mais expressivo no hero/passos |
| `nenhum` | SVG estático, sem animar |

Anti-patterns: Lottie/JSON de origem não-MIT; imagens raster pesadas; SVG sem licença verificada.

### Diagramas e didática visual

Quando ajudar a explicar (fluxo, decisão, antes/depois, jornada), preferir diagramas **estáticos no HTML/CSS/SVG** — sem Mermaid/CDN obrigatório (offline e dois cliques).

Componentes em `assets/css/diagrams.css`:

| Classe | Uso |
|--------|-----|
| `.diagram` + `.flow` | Fluxograma vertical (passos com trilho) |
| `.flow.flow--row` | Fluxo horizontal no desktop (até ~4 etapas) |
| `.split` | Dois caminhos / comparação |
| `.decision` | Caixa de decisão / ponto de atenção |
| `.diagram-figure` | SVG ilustrativo com legenda |

Regras:
- Diagramas reforçam o texto — não substituem a narrativa
- Manter poucos nós (legível no mobile)
- SVG próprio ou MIT; cores via `currentColor` / tokens do tema
- Incluir `data-reveal` no bloco para animar com o nível configurado

---

## Entrevista (máx. 3 perguntas por rodada)

Antes de gravar, obter:

1. **Tópico** — feature/slug, conceito ou descrição livre
2. **Fonte** — spec em `sprints/.../features/{slug}/`, steering, ou só o que o usuário narrar?
3. **Tipo de página** — `feature` · `concept` · `flow` · `glossary` · `onboarding` · outro
4. **Slug do arquivo** — kebab-case (ex.: `aprovacao-pedidos`)
5. Confirmar tags/descrição curta para o catálogo (busca)

Se a fonte for feature: ler `meeting-notes`, `business-rules`, `use-case` (e design/screenshots se existirem) — **só para entender**; reescrever para a wiki.

---

## Estrutura de arquivo

```
docs_wiki/
  index.html                 ← hub + catálogo (data-catalog)
  pages/{slug}.html          ← página nova/atualizada
  templates/page.html        ← esqueleto de referência
  assets/js/catalog-data.js  ← registro de páginas (busca + catálogo)
  assets/js/catalog.js       ← renderiza catálogo e busca
  assets/brand/              ← logo opcional (logo.png / logo-on-dark.png)
  assets/…                   ← não alterar salvo pedido de tema
```

Copiar estrutura de `templates/page.html` (já na pasta `docs_wiki/`).

Placeholders a preencher (valores de `sdd.config.yaml`):

- `data-motion`, `data-theme`, `data-writing` iguais às páginas existentes
- Links CSS/JS relativos (`../assets/...`)
- Header com busca (`data-wiki-search`) + scripts `catalog-data.js` e `catalog.js`

---

## Seções mínimas (página tipo feature / flow)

1. Hero compacto: eyebrow + título + lead
2. **O problema** (ou contexto de negócio)
3. **O que o sistema resolve**
4. **Como funciona** (comportamento visível ao usuário)
5. **Como fazer** (`ol.steps`)
6. Callout de dica ou atenção, se útil
7. Sidebar com âncoras das seções

Ajustar seções ao tipo (`glossary`, `concept`, etc.) sem perder o tom de produto.

---

## Após gravar a página

1. **Obrigatório:** atualizar `docs_wiki/assets/js/catalog-data.js` — adicionar/atualizar entrada:

```js
{
  id: "{slug}",
  title: "…",
  description: "…",
  href: "pages/{slug}.html",
  type: "feature", // feature | concept | flow | glossary | onboarding | …
  tags: ["…"],
  listed: true
}
```

2. Não é necessário editar cards manuais no `index.html` — o catálogo é renderizado pelo JS
3. Mensagem pós-etapa:

```
✅ Página da docs wiki gerada.

Arquivo: docs_wiki/pages/{slug}.html
Catálogo: docs_wiki/assets/js/catalog-data.js (atualizado)
Abrir: docs_wiki/index.html (navegador)

Quer gerar outra página ou ajustar o texto desta?
```

---

## Anti-patterns

- Incluir seção “para quem é a wiki” / justificar público da documentação
- Incluir trechos de código ou contratos de API
- Copiar `business-rules.md` literalmente
- Inventar comportamento sem evidência na spec/conversa
- Alterar tema CSS global sem pedido explícito
- Gerar página se `docs_wiki.enabled: false`
- Usar SVG/ilustração **sem licença MIT** (ou origem duvidosa)
- Esquecer de registrar a página em `catalog-data.js` (quebra busca e catálogo)

---

## Referências

- `docs/docs-wiki.md`
- `sdd.config.yaml` → `docs_wiki`
- `docs_wiki/README.md`
- `docs_wiki/templates/page.html`
- `docs_wiki/assets/js/catalog-data.js`
