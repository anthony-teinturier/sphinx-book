# Your documentation landing page

The main function of the landing page `index.md` is to serve as a welcome
page and to contain the root of the "table of contents tree" (or `toctree`).
The table of content is defined by linking files inside the `toctree` directive:

```{toctree}
:maxdepth: 1
```

**Despite you are using Markdown for your `index.md` landing page, the `toctree`
content must be written in [reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html).**
