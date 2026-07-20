<!DOCTYPE html>
<html lang="{{PROJECT_LANGUAGE}}" data-motion="{{DOCS_WIKI_ANIMACAO}}" data-theme="{{DOCS_WIKI_TEMA}}" data-writing="{{DOCS_WIKI_ESCRITA}}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{PROJECT_NAME}} — Wiki do produto</title>
  <meta name="description" content="Guia de produto do {{PROJECT_NAME}}: o que resolve, como funciona e como fazer no sistema.">
  <link rel="stylesheet" href="assets/css/themes/{{DOCS_WIKI_TEMA}}.css">
  <link rel="stylesheet" href="assets/css/tokens.css">
  <link rel="stylesheet" href="assets/css/base.css">
  <link rel="stylesheet" href="assets/css/diagrams.css">
  <link rel="stylesheet" href="assets/css/motion.css">
</head>
<body>
  <div class="reading-progress" aria-hidden="true"></div>

  <header class="site-header">
    <div class="site-header__inner">
      <a class="brand" href="index.html">
        <!-- Se existir assets/brand/logo(-on-dark).png, a skill/setup pode ativar o <img> -->
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
          <li><a href="index.html" aria-current="page">Início</a></li>
          <li><a href="#catalogo">Catálogo</a></li>
          <li><a href="pages/como-usar.html">Como usar</a></li>
        </ul>
      </div>
    </div>
  </header>

  <section class="hero hero--compact">
    <div class="hero__inner hero__row">
      <div>
        <p class="hero__eyebrow">Wiki do produto</p>
        <h1 class="hero__title">Entenda o {{PROJECT_NAME}} sem abrir o código</h1>
        <p class="hero__lead">
          Aqui contamos, em linguagem de negócio, o problema que o sistema resolve,
          como ele funciona no dia a dia e o passo a passo para realizar as principais ações.
        </p>
      </div>
      <!-- Opcional: <div class="hero__visual"><img src="assets/brand/logo-on-dark.png" alt=""></div> -->
    </div>
  </section>

  <main class="layout">
    <div class="content content--wide">
      <section data-reveal id="catalogo">
        <h2>Catálogo de páginas</h2>
        <p class="lead">
          Todas as páginas da wiki em um só lugar. Filtre por tipo ou use a busca no topo.
        </p>
        <div class="catalog-toolbar" data-catalog-filters></div>
        <div data-catalog></div>
      </section>
    </div>
  </main>

  <footer class="site-footer">
    <div class="site-footer__inner">
      <p>{{PROJECT_NAME}} — documentação de produto. Use a busca ou o catálogo para encontrar tópicos.</p>
    </div>
  </footer>

  <script src="assets/js/catalog-data.js"></script>
  <script src="assets/js/catalog.js"></script>
  <script src="assets/js/motion.js"></script>
  <script src="assets/js/nav.js"></script>
</body>
</html>
