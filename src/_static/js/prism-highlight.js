document.addEventListener('DOMContentLoaded', (event) => {
  window.Prism = window.Prism || {};
  Prism.manual = true;

  // PrismJS custom languages.
  const languages = [];

  import('../vendor/js/prism.js').then(() => {
    if (languages.length === 0) return;

    const regexPygment = /highlight-([^\s]+)/g
    const selector = languages
      .map(language => `.highlight-${language}`)
      .join(',');

    document.querySelectorAll(selector).forEach(el => {
      const className = [...el.className.matchAll(regexPygment)][0][1];
      const codeBlock = el.querySelector('pre');

      if (codeBlock !== null) {
        codeBlock.classList.add(`language-${className}`);
        Prism.highlightElement(codeBlock);
      }
    });
  });
});
