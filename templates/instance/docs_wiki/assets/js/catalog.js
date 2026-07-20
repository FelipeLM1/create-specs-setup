(function () {
  var catalog = window.DOCS_WIKI_CATALOG;
  if (!catalog || !Array.isArray(catalog.pages)) {
    return;
  }

  var path = window.location.pathname.replace(/\\/g, "/");
  var inPages = /\/pages\//.test(path) || /pages\/[^/]+\.html$/i.test(path);
  var assetPrefix = inPages ? "../" : "";

  function resolveHref(href) {
    if (!href) {
      return "#";
    }
    if (/^https?:\/\//i.test(href) || href.charAt(0) === "#") {
      return href;
    }
    if (inPages) {
      if (href === "index.html") {
        return "../index.html";
      }
      if (href.indexOf("pages/") === 0) {
        return href.slice("pages/".length);
      }
    }
    return href;
  }

  function normalize(text) {
    return String(text || "")
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "");
  }

  function listedPages() {
    return catalog.pages.filter(function (page) {
      return page.listed !== false;
    });
  }

  function matchesQuery(page, query) {
    if (!query) {
      return true;
    }
    var haystack = normalize(
      [page.title, page.description, page.type]
        .concat(page.tags || [])
        .join(" ")
    );
    return haystack.indexOf(query) !== -1;
  }

  function typeLabel(type) {
    var labels = {
      home: "Início",
      onboarding: "Orientação",
      feature: "Funcionalidade",
      concept: "Conceito",
      flow: "Fluxo",
      glossary: "Glossário"
    };
    return labels[type] || type || "Página";
  }

  function renderCards(pages, mount) {
    if (!mount) {
      return;
    }
    if (!pages.length) {
      mount.innerHTML = '<p class="catalog-empty">Nenhuma página encontrada.</p>';
      return;
    }
    mount.innerHTML =
      '<div class="card-grid">' +
      pages
        .map(function (page) {
          return (
            '<a class="card" href="' +
            resolveHref(page.href) +
            '">' +
            '<span class="card__type">' +
            typeLabel(page.type) +
            "</span>" +
            '<h3 class="card__title">' +
            page.title +
            "</h3>" +
            '<p class="card__text">' +
            (page.description || "") +
            "</p>" +
            "</a>"
          );
        })
        .join("") +
      "</div>";
  }

  function uniqueTypes(pages) {
    var seen = {};
    var types = [];
    pages.forEach(function (page) {
      if (!page.type || seen[page.type]) {
        return;
      }
      seen[page.type] = true;
      types.push(page.type);
    });
    return types;
  }

  function initCatalogGrid() {
    var mount = document.querySelector("[data-catalog]");
    if (!mount) {
      return;
    }

    var state = { query: "", type: "all" };
    var pages = listedPages();
    var toolbar = document.querySelector("[data-catalog-filters]");

    function apply() {
      var filtered = pages.filter(function (page) {
        if (state.type !== "all" && page.type !== state.type) {
          return false;
        }
        return matchesQuery(page, state.query);
      });
      renderCards(filtered, mount);
    }

    if (toolbar) {
      var types = uniqueTypes(pages);
      toolbar.innerHTML =
        '<button type="button" data-type="all" class="is-active">Todas</button>' +
        types
          .map(function (type) {
            return (
              '<button type="button" data-type="' +
              type +
              '">' +
              typeLabel(type) +
              "</button>"
            );
          })
          .join("");

      toolbar.addEventListener("click", function (event) {
        var button = event.target.closest("button[data-type]");
        if (!button) {
          return;
        }
        state.type = button.getAttribute("data-type") || "all";
        toolbar.querySelectorAll("button").forEach(function (el) {
          el.classList.toggle("is-active", el === button);
        });
        apply();
      });
    }

    var catalogSearch = document.querySelector("[data-catalog-search]");
    if (catalogSearch) {
      catalogSearch.addEventListener("input", function () {
        state.query = normalize(catalogSearch.value.trim());
        apply();
      });
    }

    apply();
  }

  function initHeaderSearch() {
    var input = document.querySelector("[data-wiki-search]");
    var results = document.querySelector("[data-wiki-search-results]");
    if (!input || !results) {
      return;
    }

    function closeResults() {
      results.classList.remove("is-open");
      results.innerHTML = "";
    }

    function openResults(pages) {
      if (!pages.length) {
        results.innerHTML = '<li class="search__empty">Nenhum resultado.</li>';
        results.classList.add("is-open");
        return;
      }
      results.innerHTML = pages
        .slice(0, 8)
        .map(function (page) {
          return (
            "<li><a href=\"" +
            resolveHref(page.href) +
            "\">" +
            "<strong>" +
            page.title +
            "</strong>" +
            '<span class="search__meta">' +
            typeLabel(page.type) +
            (page.description ? " · " + page.description : "") +
            "</span>" +
            "</a></li>"
          );
        })
        .join("");
      results.classList.add("is-open");
    }

    input.addEventListener("input", function () {
      var query = normalize(input.value.trim());
      if (!query) {
        closeResults();
        return;
      }
      openResults(
        catalog.pages.filter(function (page) {
          return matchesQuery(page, query);
        })
      );
    });

    input.addEventListener("keydown", function (event) {
      if (event.key === "Escape") {
        closeResults();
        input.blur();
      }
    });

    document.addEventListener("click", function (event) {
      if (!event.target.closest(".search")) {
        closeResults();
      }
    });
  }

  function markCurrentNav() {
    var current = path.split("/").pop() || "index.html";
    document.querySelectorAll(".nav a[href]").forEach(function (link) {
      var href = link.getAttribute("href") || "";
      var target = href.split("/").pop();
      if (target === current) {
        link.setAttribute("aria-current", "page");
      }
    });
  }

  initCatalogGrid();
  initHeaderSearch();
  markCurrentNav();
})();
