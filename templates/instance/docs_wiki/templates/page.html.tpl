<!DOCTYPE html>
<html lang="{{PROJECT_LANGUAGE}}" data-motion="{{DOCS_WIKI_ANIMACAO}}" data-theme="{{DOCS_WIKI_TEMA}}" data-writing="{{DOCS_WIKI_ESCRITA}}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{{PAGE_TITLE}} — {{PROJECT_NAME}}</title>
  <meta name="description" content="{{PAGE_DESCRIPTION}}">
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
          <li><a href="como-usar.html">Como usar</a></li>
        </ul>
      </div>
    </div>
  </header>

  <section class="hero hero--compact">
    <div class="hero__inner">
      <p class="hero__eyebrow">{{PAGE_EYEBROW}}</p>
      <h1 class="hero__title">{{PAGE_TITLE}}</h1>
      <p class="hero__lead">{{PAGE_LEAD}}</p>
    </div>
  </section>

  <div class="layout layout--with-sidebar">
    <aside class="sidebar" data-reveal>
      <p class="sidebar__title">Nesta página</p>
      <nav>
        <ul>
          <!-- links #ancora gerados pela skill -->
        </ul>
      </nav>
    </aside>

    <main class="content">
      <!--
        Estrutura narrativa padrão (escrita=narrativo):
        1. O problema
        2. O que o sistema resolve
        3. Como funciona (texto + diagrama .flow / .split se ajudar)
        4. Como fazer (steps)
        5. Dicas / o que observar
        Sem código, endpoints ou detalhes de implementação.
        Ver assets/css/diagrams.css para fluxos e decisões.
      -->
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
