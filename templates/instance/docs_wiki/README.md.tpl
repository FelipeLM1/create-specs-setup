# Docs wiki — {{PROJECT_NAME}}

Wiki HTML estática de **produto/negócio**: o que o sistema resolve, como funciona e como fazer no dia a dia.

## Abrir

Abra `index.html` no navegador (dois cliques) ou sirva a pasta como site estático.

## Configuração

Definida em `sdd.config.yaml` → `docs_wiki`:

| Campo | Valores |
|-------|---------|
| `tema` | `editorial` · `suave` · `marcante` · `minimalista` |
| `usar_cores_marca` | `true` / `false` — se true, usa `cor_principal` e `cor_destaque` |
| `escrita` | `narrativo` · `didatico` · `conciso` · `personalizado` |
| `animacao` | `sutil` · `elaborado` · `nenhum` |

Com marca: `assets/css/tokens.css` recebe as cores informadas.

## Novas páginas

Use a skill `docs-wiki-page` (sob demanda). Modelo: `templates/page.html`.

## Público

Documentação de produto em linguagem de negócio (sem código).
