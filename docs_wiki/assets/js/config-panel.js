(function () {
  var STORAGE_KEY = "create-specs-docs-wiki-demo";
  var TEMAS = ["editorial", "suave", "marcante", "minimalista"];
  var ANIMACOES = ["sutil", "elaborado", "nenhum"];

  function themeHref(tema) {
    var base =
      window.location.pathname.indexOf("/pages/") !== -1
        ? "../assets/css/themes/"
        : "assets/css/themes/";
    return base + tema + ".css";
  }

  function assetPath(file) {
    if (window.location.pathname.indexOf("/pages/") !== -1) {
      return "../assets/" + file;
    }
    return "assets/" + file;
  }

  function readStored() {
    try {
      var raw = localStorage.getItem(STORAGE_KEY);
      if (!raw) return null;
      return JSON.parse(raw);
    } catch (e) {
      return null;
    }
  }

  function save(tema, animacao) {
    try {
      localStorage.setItem(
        STORAGE_KEY,
        JSON.stringify({ tema: tema, animacao: animacao })
      );
    } catch (e) {
      /* ignore */
    }
  }

  function findThemeLink() {
    var links = document.querySelectorAll('link[rel="stylesheet"]');
    for (var i = 0; i < links.length; i++) {
      var href = links[i].getAttribute("href") || "";
      if (href.indexOf("/themes/") !== -1 || href.indexOf("themes/") !== -1) {
        return links[i];
      }
    }
    return null;
  }

  function apply(tema, animacao) {
    if (TEMAS.indexOf(tema) === -1) tema = "suave";
    if (ANIMACOES.indexOf(animacao) === -1) animacao = "sutil";

    var root = document.documentElement;
    root.setAttribute("data-theme", tema);
    root.setAttribute("data-motion", animacao);

    var link = findThemeLink();
    if (link) {
      link.setAttribute("href", themeHref(tema));
    }

    save(tema, animacao);
    syncRadios(tema, animacao);

    // Re-run reveal for elaborado after theme change: mark visible if needed
    if (animacao === "nenhum") {
      document.querySelectorAll("[data-reveal]").forEach(function (el) {
        el.classList.add("is-visible");
      });
    }
  }

  function syncRadios(tema, animacao) {
    var temaInput = document.querySelector(
      'input[name="wiki-tema"][value="' + tema + '"]'
    );
    var animInput = document.querySelector(
      'input[name="wiki-animacao"][value="' + animacao + '"]'
    );
    if (temaInput) temaInput.checked = true;
    if (animInput) animInput.checked = true;
  }

  function currentTema() {
    return document.documentElement.getAttribute("data-theme") || "suave";
  }

  function currentAnimacao() {
    return document.documentElement.getAttribute("data-motion") || "sutil";
  }

  function buildPanel() {
    var style = document.createElement("link");
    style.rel = "stylesheet";
    style.href = assetPath("css/config-panel.css");
    document.head.appendChild(style);

    var btn = document.createElement("button");
    btn.type = "button";
    btn.className = "wiki-config-btn";
    btn.setAttribute("aria-expanded", "false");
    btn.setAttribute("aria-controls", "wiki-config-panel");
    btn.title = "Configurar preview (tema e animação)";
    btn.innerHTML =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12.22 2 h-.44 a2 2 0 0 0 -2 2 v.18 a2 2 0 0 1 -1 1.73 l-.43 .25 a2 2 0 0 1 -2 0 l-.15 -.08 a2 2 0 0 0 -2.73 .73 l-.22 .38 a2 2 0 0 0 .73 2.73 l.15 .1 a2 2 0 0 1 1 1.72 v.51 a2 2 0 0 1 -1 1.74 l-.15 .09 a2 2 0 0 0 -.73 2.73 l.22 .38 a2 2 0 0 0 2.73 .73 l.15 -.08 a2 2 0 0 1 2 0 l.43 .25 a2 2 0 0 1 1 1.73 V20 a2 2 0 0 0 2 2 h.44 a2 2 0 0 0 2 -2 v-.18 a2 2 0 0 1 1 -1.73 l.43 -.25 a2 2 0 0 1 2 0 l.15 .08 a2 2 0 0 0 2.73 -.73 l.22 -.39 a2 2 0 0 0 -.73 -2.73 l-.15 -.08 a2 2 0 0 1 -1 -1.74 v-.5 a2 2 0 0 1 1 -1.74 l.15 -.09 a2 2 0 0 0 .73 -2.73 l-.22 -.38 a2 2 0 0 0 -2.73 -.73 l-.15 .08 a2 2 0 0 1 -2 0 l-.43 -.25 a2 2 0 0 1 -1 -1.73 V4 a2 2 0 0 0 -2 -2 z"/><circle cx="12" cy="12" r="3"/></svg>';

    var panel = document.createElement("div");
    panel.id = "wiki-config-panel";
    panel.className = "wiki-config-panel";
    panel.setAttribute("role", "dialog");
    panel.setAttribute("aria-label", "Configuração do preview");

    var temasHtml = TEMAS.map(function (t) {
      return (
        '<label><input type="radio" name="wiki-tema" value="' +
        t +
        '"> ' +
        t +
        "</label>"
      );
    }).join("");

    var animHtml = ANIMACOES.map(function (a) {
      return (
        '<label><input type="radio" name="wiki-animacao" value="' +
        a +
        '"> ' +
        a +
        "</label>"
      );
    }).join("");

    panel.innerHTML =
      "<h2>Preview</h2>" +
      '<p class="wiki-config-hint">Só neste exemplo do create-specs-setup. A escolha fica salva neste navegador.</p>' +
      "<fieldset><legend>Tema</legend><div class=\"wiki-config-options\">" +
      temasHtml +
      "</div></fieldset>" +
      "<fieldset><legend>Animação</legend><div class=\"wiki-config-options\">" +
      animHtml +
      "</div></fieldset>";

    document.body.appendChild(btn);
    document.body.appendChild(panel);

    btn.addEventListener("click", function () {
      var open = panel.classList.toggle("is-open");
      btn.setAttribute("aria-expanded", open ? "true" : "false");
    });

    document.addEventListener("click", function (ev) {
      if (!panel.classList.contains("is-open")) return;
      if (panel.contains(ev.target) || btn.contains(ev.target)) return;
      panel.classList.remove("is-open");
      btn.setAttribute("aria-expanded", "false");
    });

    panel.addEventListener("change", function (ev) {
      var target = ev.target;
      if (!target || target.name !== "wiki-tema" && target.name !== "wiki-animacao") {
        return;
      }
      var tema =
        (document.querySelector('input[name="wiki-tema"]:checked') || {}).value ||
        currentTema();
      var animacao =
        (document.querySelector('input[name="wiki-animacao"]:checked') || {})
          .value || currentAnimacao();
      apply(tema, animacao);
    });

    return { syncRadios: syncRadios };
  }

  function init() {
    var stored = readStored();
    var tema = (stored && stored.tema) || currentTema();
    var animacao = (stored && stored.animacao) || currentAnimacao();

    buildPanel();
    apply(tema, animacao);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
