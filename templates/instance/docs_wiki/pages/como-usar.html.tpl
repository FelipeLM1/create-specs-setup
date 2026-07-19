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
      <a class="brand" href="../index.html">{{PROJECT_NAME}}</a>
      <ul class="nav">
        <li><a href="../index.html">Início</a></li>
        <li><a href="como-usar.html" aria-current="page">Como usar esta wiki</a></li>
      </ul>
    </div>
  </header>

  <section class="hero">
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
          <li><a href="#para-quem">Para quem é</a></li>
          <li><a href="#o-que-encontrar">O que encontrar</a></li>
          <li><a href="#como-ler">Como ler</a></li>
          <li><a href="#atualizar">Manter atualizado</a></li>
        </ul>
      </nav>
    </aside>

    <main class="content">
      <section data-reveal>
        <h2 id="para-quem">Para quem é</h2>
        <p>
          Esta wiki serve a <strong>clientes</strong>, <strong>usuários finais</strong> e ao <strong>time</strong>
          (produto, negócio e desenvolvimento). Todos compartilham a mesma linguagem: o sistema como ele é vivido no dia a dia.
        </p>
        <div class="callout">
          <p class="callout__label">O que você não encontra aqui</p>
          <p>Código, endpoints, detalhes de banco ou decisões de implementação. Isso fica nos repositórios técnicos e nas specs internas.</p>
        </div>
      </section>

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
        <h2 id="como-ler">Como ler</h2>
        <p>
          Use o menu superior para ir ao início ou a outras páginas.
          Nas páginas longas, a barra lateral destaca a seção em que você está.
        </p>
        <p>
          Prefira ler com calma: a wiki foi feita para ser prazerosa —
          com ritmo de texto, destaques e animações leves (respeitando a preferência do seu sistema por menos movimento).
        </p>
      </section>

      <section data-reveal>
        <h2 id="atualizar">Manter atualizado</h2>
        <p>
          Novas páginas nascem sob demanda, a partir das specs do produto
          (meeting notes, regras de negócio e casos de uso — sempre reescritas em tom de produto).
        </p>
        <div class="callout callout--tip">
          <p class="callout__label">Para o time</p>
          <p>Peça: “Gere uma página da docs wiki sobre {tópico/feature}” — a skill <code>docs-wiki-page</code> cuida disso.</p>
        </div>
      </section>
    </main>
  </div>

  <footer class="site-footer">
    <div class="site-footer__inner">
      <p><a href="../index.html">← Voltar ao início</a></p>
    </div>
  </footer>

  <script src="../assets/js/motion.js"></script>
  <script src="../assets/js/nav.js"></script>
</body>
</html>
