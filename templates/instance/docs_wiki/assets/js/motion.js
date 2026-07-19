(function () {
  var root = document.documentElement;
  var motion = root.getAttribute("data-motion") || "sutil";

  if (motion === "nenhum") {
    return;
  }

  if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    return;
  }

  var reveals = document.querySelectorAll("[data-reveal]");
  if ("IntersectionObserver" in window && reveals.length) {
    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            observer.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: "0px 0px -8% 0px" }
    );

    reveals.forEach(function (el) {
      observer.observe(el);
    });
  } else {
    reveals.forEach(function (el) {
      el.classList.add("is-visible");
    });
  }

  if (motion !== "elaborado") {
    return;
  }

  var bar = document.querySelector(".reading-progress");
  if (!bar) {
    return;
  }

  function updateProgress() {
    var doc = document.documentElement;
    var scrollTop = doc.scrollTop || document.body.scrollTop;
    var height = doc.scrollHeight - doc.clientHeight;
    var progress = height > 0 ? (scrollTop / height) * 100 : 0;
    bar.style.width = progress + "%";
  }

  window.addEventListener("scroll", updateProgress, { passive: true });
  updateProgress();
})();
