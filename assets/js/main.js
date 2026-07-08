(function () {
  document.documentElement.classList.add("js");

  function titleFor(type) {
    var labels = {
      abstract: "Abstract",
      bug: "Bug",
      caution: "Caution",
      danger: "Danger",
      error: "Error",
      example: "Example",
      failure: "Failure",
      faq: "FAQ",
      help: "Help",
      important: "Important",
      info: "Info",
      note: "Note",
      problem: "Problem",
      question: "Question",
      success: "Success",
      tip: "Tip",
      todo: "Todo",
      warning: "Warning"
    };

    if (labels[type]) {
      return labels[type];
    }

    return type.charAt(0).toUpperCase() + type.slice(1).replace(/-/g, " ");
  }

  function upgradeCallouts() {
    var quotes = document.querySelectorAll(".page__content blockquote");

    quotes.forEach(function (quote, index) {
      var first = quote.firstElementChild;

      if (!first || first.tagName.toLowerCase() !== "p") {
        return;
      }

      var text = first.textContent.trimStart();
      var match = text.match(/^\[!\s*([a-zA-Z-]+)\s*\]([+-]?)(?:\s*(.*))?/);

      if (!match) {
        return;
      }

      var type = match[1].toLowerCase();
      var foldMark = match[2];
      var isCollapsible = foldMark === "-" || foldMark === "+";
      var isExpanded = foldMark !== "-";
      var markerLine = first.textContent.split(/\r?\n/)[0];
      var customTitle = markerLine
        .replace(/^\s*\[!\s*[a-zA-Z-]+\s*\][+-]?\s*/, "")
        .trim();
      var title = document.createElement(isCollapsible ? "button" : "div");
      var titleText = document.createElement("span");
      var firstHtmlParts = first.innerHTML.split(/<br\s*\/?>/i);
      var remainingHtml = firstHtmlParts.slice(1).join("<br>");
      var content = document.createElement("div");
      var contentId = "callout-content-" + index;

      quote.classList.add("callout", "callout-" + type);
      quote.dataset.callout = type;

      title.className = "callout__title";
      if (isCollapsible) {
        title.className += " callout__toggle";
        title.type = "button";
        title.setAttribute("aria-controls", contentId);
        quote.classList.add("callout--collapsible");
        quote.dataset.calloutFold = foldMark;
      }

      titleText.textContent = customTitle || titleFor(type);
      title.appendChild(titleText);
      quote.insertBefore(title, first);

      if (remainingHtml.trim()) {
        first.innerHTML = remainingHtml.trimStart();
      } else {
        first.remove();
      }

      content.className = "callout__content";
      content.id = contentId;

      while (title.nextSibling) {
        content.appendChild(title.nextSibling);
      }

      quote.appendChild(content);

      if (isCollapsible) {
        function setExpanded(expanded) {
          title.setAttribute("aria-expanded", String(expanded));
          content.hidden = !expanded;
          quote.classList.toggle("is-collapsed", !expanded);

          if (expanded && window.MathJax && typeof window.MathJax.typesetPromise === "function") {
            window.MathJax.typesetPromise([content]);
          }
        }

        title.addEventListener("click", function () {
          setExpanded(title.getAttribute("aria-expanded") !== "true");
        });

        setExpanded(isExpanded);
      }
    });
  }

  upgradeCallouts();
})();
