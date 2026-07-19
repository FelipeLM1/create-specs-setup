(function () {
  var links = document.querySelectorAll('.sidebar a[href^="#"]');
  if (!links.length) {
    return;
  }

  var sections = [];
  links.forEach(function (link) {
    var id = link.getAttribute("href").slice(1);
    var section = document.getElementById(id);
    if (section) {
      sections.push({ id: id, el: section, link: link });
    }
  });

  if (!sections.length || !("IntersectionObserver" in window)) {
    return;
  }

  var observer = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) {
          return;
        }
        var id = entry.target.id;
        links.forEach(function (link) {
          link.classList.toggle("is-active", link.getAttribute("href") === "#" + id);
        });
      });
    },
    { rootMargin: "-35% 0px -55% 0px", threshold: 0 }
  );

  sections.forEach(function (item) {
    observer.observe(item.el);
  });
})();
