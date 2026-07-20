<!DOCTYPE html>
<html lang="{{PROJECT_LANGUAGE}}" data-motion="{{DOCS_WIKI_ANIMACAO}}" data-theme="{{DOCS_WIKI_TEMA}}" data-writing="{{DOCS_WIKI_ESCRITA}}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Como usar esta wiki — {{PROJECT_NAME}}</title>
  <meta name="description" content="Como navegar na wiki do {{PROJECT_NAME}}.">
  <link rel="stylesheet" href="../assets/css/themes/{{DOCS_WIKI_TEMA}}.css">
  <link rel="stylesheet" href="../assets/css/tokens.css">
  <link rel="stylesheet" href="../assets/css/base.css">
  <link rel="stylesheet" href="../assets/css/diagrams.css">
  <link rel="stylesheet" href="../assets/css/motion.css">
</head>
<body>
  <div class="reading-progress" aria-hidden="true"></div>

  <header class="site-header">
    <div class="site-header__inner">
      <a class="brand" href="../index.html">
        <span class="brand__name">{{PROJECT_NAME}}</span>
      </a>
      <div class="site-header__tools">
        <div class="search">
          <label class="visually-hidden" for="wiki-search">Buscar na wiki</label>
          <input
            id="wiki-search"
            class="search__input"
            type="search"
            placeholder="Buscar páginas…"
            autocomplete="off"
            data-wiki-search
          >
          <ul class="search__results" data-wiki-search-results role="listbox" aria-label="Resultados da busca"></ul>
        </div>
        <ul class="nav">
          <li><a href="../index.html">Início</a></li>
          <li><a href="../index.html#catalogo">Catálogo</a></li>
          <li><a href="como-usar.html" aria-current="page">Como usar</a></li>
        </ul>
      </div>
    </div>
  </header>

  <section class="hero hero--compact">
    <div class="hero__inner">
      <p class="hero__eyebrow">Orientação</p>
      <h1 class="hero__title">Como usar esta wiki</h1>
      <p class="hero__lead">
        Um mapa rápido para encontrar respostas sobre o {{PROJECT_NAME}} —
        pensado para leitura agradável, não para manual técnico.
      </p>
    </div>
  </section>

  <div class="layout layout--with-sidebar">
    <aside class="sidebar" data-reveal>
      <p class="sidebar__title">Nesta página</p>
      <nav>
        <ul>
          <li><a href="#o-que-encontrar">O que encontrar</a></li>
          <li><a href="#como-encontrar">Como encontrar</a></li>
          <li><a href="#como-ler">Como ler</a></li>
          <li><a href="#atualizar">Manter atualizado</a></li>
        </ul>
      </nav>
    </aside>

    <main class="content">
      <section data-reveal>
        <h2 id="o-que-encontrar">O que encontrar</h2>
        <p>As páginas costumam seguir um fio narrativo:</p>
        <ol class="steps" data-reveal>
          <li><strong>O problema</strong> — qual dor ou necessidade motiva a funcionalidade.</li>
          <li><strong>O que o sistema resolve</strong> — o valor em linguagem de negócio.</li>
          <li><strong>Como funciona</strong> — o comportamento esperado, sem jargão técnico.</li>
          <li><strong>Como fazer</strong> — o passo a passo para realizar a ação no sistema.</li>
        </ol>
      </section>

      <section data-reveal>
        <h2 id="como-encontrar">Como encontrar</h2>
        <p>
          Use a <strong>busca</strong> no topo (título, descrição e tags) ou o
          <a href="../index.html#catalogo">catálogo na página inicial</a>, com filtros por tipo de página.
        </p>
      </section>

      <section data-reveal>
        <h2 id="como-ler">Como ler</h2>
        <p>
          Use o menu superior para ir ao início, ao catálogo ou a outras páginas.
          Nas páginas longas, a barra lateral destaca a seção em que você está.
        </p>
      </section>

      <section data-reveal>
        <h2 id="atualizar">Manter atualizado</h2>
        <p>
          Novas páginas nascem sob demanda. Ao gerar uma página, a skill atualiza o
          <code>assets/js/catalog-data.js</code> — assim busca e catálogo ficam sincronizados.
        </p>
        <div class="callout callout--tip">
          <p class="callout__label">Para o time</p>
          <p>Peça: “Gere uma página da docs wiki sobre {tópico/feature}”.</p>
        </div>
      </section>
    </main>
  </div>

  <footer class="site-footer">
    <div class="site-footer__inner">
      <p><a href="../index.html">← Voltar ao início</a> · <a href="../index.html#catalogo">Catálogo</a></p>
    </div>
  </footer>

  <script src="../assets/js/catalog-data.js"></script>
  <script src="../assets/js/catalog.js"></script>
  <script src="../assets/js/motion.js"></script>
  <script src="../assets/js/nav.js"></script>
</body>
</html>
