/**
 * Catálogo da docs wiki — fonte única para listagem, filtros e busca.
 * A skill docs-wiki-page atualiza este arquivo ao criar/editar páginas.
 * Formato .js (não JSON) para funcionar ao abrir index.html via file://.
 */
window.DOCS_WIKI_CATALOG = {
  product: "{{PROJECT_NAME}}",
  pages: [
    {
      id: "home",
      title: "Início",
      description: "Visão geral do produto e ponto de partida da documentação.",
      href: "index.html",
      type: "home",
      tags: ["visão geral"],
      listed: false
    },
    {
      id: "como-usar",
      title: "Como usar esta wiki",
      description: "Orientação rápida para navegar e tirar o máximo desta documentação.",
      href: "pages/como-usar.html",
      type: "onboarding",
      tags: ["ajuda", "navegação", "busca"],
      listed: true
    }
  ]
};
