// Gneol landing page interactions
(function () {
  "use strict";

  // Newsletter form
  var newsForm = document.getElementById("newsletter-form");
  var newsStatus = document.getElementById("newsletter-status");
  if (newsForm && newsStatus) {
    newsForm.addEventListener("submit", function (e) {
      e.preventDefault();
      var email = document.getElementById("newsletter-email").value.trim();
      newsStatus.classList.remove("error");
      newsStatus.textContent = "Subscribing...";
      fetch("https://formsubmit.co/ajax/tentarclesai@gmail.com", {
        method: "POST",
        headers: { "Content-Type": "application/json", "Accept": "application/json" },
        body: JSON.stringify({ email: email, _subject: "Gneol newsletter subscription" })
      })
        .then(function (r) { return r.json(); })
        .then(function (res) {
          if (res.success === "false" || res.error) throw new Error(res.message || "Error");
          newsStatus.textContent = "✓ Subscribed! Talk soon.";
          newsForm.reset();
        })
        .catch(function () {
          newsStatus.classList.add("error");
          newsStatus.textContent = "Failed to subscribe. Email us: tentarclesai@gmail.com";
        });
    });
  }

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
