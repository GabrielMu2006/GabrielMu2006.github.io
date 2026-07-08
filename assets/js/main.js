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

    quotes.forEach(function (quote) {
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
      var markerLine = first.textContent.split(/\r?\n/)[0];
      var customTitle = markerLine
        .replace(/^\s*\[!\s*[a-zA-Z-]+\s*\][+-]?\s*/, "")
        .trim();
      var title = document.createElement("div");
      var titleText = document.createElement("span");
      var remainingLines = first.textContent.split(/\r?\n/).slice(1);

      quote.classList.add("callout", "callout-" + type);
      quote.dataset.callout = type;

      title.className = "callout__title";
      titleText.textContent = customTitle || titleFor(type);
      title.appendChild(titleText);
      quote.insertBefore(title, first);

      if (remainingLines.join("\n").trim()) {
        first.textContent = remainingLines.join("\n").trimStart();
      } else {
        first.remove();
      }
    });
  }

  upgradeCallouts();
})();
