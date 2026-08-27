// Gneol landing page interactions
(function () {
  "use strict";

  // Install tab switching
  var tabs = document.querySelectorAll(".tab");
  var panels = document.querySelectorAll(".install-panel");

  tabs.forEach(function (tab) {
    tab.addEventListener("click", function () {
      // Deactivate all tabs and panels
      tabs.forEach(function (t) { t.classList.remove("active"); });
      panels.forEach(function (p) { p.classList.remove("active"); });

      // Activate clicked tab + matching panel
      tab.classList.add("active");
      var panelId = "panel-" + tab.getAttribute("data-tab");
      var panel = document.getElementById(panelId);
      if (panel) panel.classList.add("active");
    });
  });
})();
