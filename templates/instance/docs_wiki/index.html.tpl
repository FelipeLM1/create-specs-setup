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
      <a class="brand" href="index.html">{{PROJECT_NAME}}</a>
      <ul class="nav">
        <li><a href="index.html" aria-current="page">Início</a></li>
        <li><a href="pages/como-usar.html">Como usar esta wiki</a></li>
      </ul>
    </div>
  </header>

  <section class="hero">
    <div class="hero__inner">
      <p class="hero__eyebrow">Wiki do produto</p>
      <h1 class="hero__title">Entenda o {{PROJECT_NAME}} sem abrir o código</h1>
      <p class="hero__lead">
        Aqui contamos, em linguagem de negócio, o problema que o sistema resolve,
        como ele funciona no dia a dia e o passo a passo para realizar as principais ações.
      </p>
    </div>
  </section>

  <main class="layout">
    <div class="content">
      <section data-reveal>
        <h2 id="bem-vindo">Bem-vindo</h2>
        <p class="lead">
          Esta wiki é para <strong>cliente, usuário final e time</strong>.
          O foco é produto: o quê, por quê e como fazer — sem detalhes técnicos de implementação.
        </p>
        <div class="callout callout--tip">
          <p class="callout__label">Dica</p>
          <p>Comece por “Como usar esta wiki” e depois explore os tópicos conforme a necessidade do momento.</p>
        </div>
      </section>

      <section data-reveal>
        <h2 id="explorar">Explorar</h2>
        <div class="card-grid">
          <a class="card" href="pages/como-usar.html">
            <h3 class="card__title">Como usar esta wiki</h3>
            <p class="card__text">Orientação rápida para navegar e tirar o máximo desta documentação.</p>
          </a>
          <!-- Novas páginas: adicione cards aqui ao gerar com a skill docs-wiki-page -->
        </div>
      </section>
    </div>
  </main>

  <footer class="site-footer">
    <div class="site-footer__inner">
      <p>{{PROJECT_NAME}} — documentação de produto. Abra o <code>index.html</code> no navegador para navegar offline.</p>
    </div>
  </footer>

  <script src="assets/js/motion.js"></script>
  <script src="assets/js/nav.js"></script>
</body>
</html>
