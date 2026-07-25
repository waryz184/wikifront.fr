// Google Translate widget pour Wikifront
// Chargé via extra_javascript dans mkdocs.yml

function googleTranslateElementInit() {
  new google.translate.TranslateElement({
    pageLanguage: 'fr',
    includedLanguages: 'fr,en,de,es,it,pt,nl',
    layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
    autoDisplay: false
  }, 'google_translate_element');
}

document.addEventListener('DOMContentLoaded', function() {
  // Insérer le widget sous la barre de recherche, dans le sidebar
  var search = document.querySelector('.wy-side-nav-search');
  if (search) {
    var container = document.createElement('div');
    container.id = 'google_translate_element';
    container.style.cssText = 'padding: 6px 12px 12px; text-align: center; border-bottom: 1px solid #b1b1b1; margin-bottom: 6px;';
    search.parentNode.insertBefore(container, search.nextSibling);
  }

  // Charger l'API Google Translate
  var script = document.createElement('script');
  script.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';
  script.type = 'text/javascript';
  document.body.appendChild(script);
});