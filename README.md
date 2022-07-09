![Sphinx-Book](./src/_static/logo.svg)

[Sphinx-Book](https://github.com/anthony-teinturier/sphinx-book) is a custom
ready-to-run container containing the [Sphinx](https://github.com/sphinx-doc/sphinx)
documentation generator combined with the [MyST-Parser](https://github.com/executablebooks/MyST-Parser)
that allows you to write documentation using a rich flavor of Markdown.

The container image is built on top of the [sphinxdoc/sphinx:latest](https://hub.docker.com/r/sphinxdoc/sphinx)
image. It provides the following additional Python packages:

* [sphinx-book-theme](https://github.com/executablebooks/sphinx-book-theme)—A
  Sphinx theme with a clean design, support for interactive content, and a
  modern book-like look and feel.
* [myst-parser](https://github.com/executablebooks/MyST-Parser)—A rich and
  extensible flavor of Markdown meant for technical documentation and
  publishing.

You can build this container image, using the following `make` command:

```shell-session
make image
```

The default container runtime is [docker](https://docs.docker.com/). You can
override it by specifying a custom `RUNTIME` value to the `make` command:

```shell-session
make RUNTIME=podman image
```

**In running container, the `root` user is used as default. You are expected to
use Docker in [Rootless mode](https://docs.docker.com/engine/security/rootless/)
to mitigate potential vulnerabilities in the daemon and the container runtime.**

## Sphinx documentation

In order to build HTML pages, you should have a collection of [Markdown](https://jupyterbook.org/reference/cheatsheet.html)
files in the `src/` folder. At least two files are required:

* `src/index.md`—This file defines the structure of your documentation.
* `src/conf.py`—This file defines the configuration of your documentation.

In addition, one sub-directory is required:

* `src/_static/`—This folder is used for custom site assets.

The main function of the landing page `index.md` is to serve as a welcome
page and to contain the root of the "table of contents tree" (or `toctree`).
The table of content is defined by linking files inside the `toctree` directive:

````markdown
```{toctree}
:maxdepth: 1

path/page-one.md
path/page-two.md
```
````

**Despite you are using Markdown for your `index.md` landing page, the `toctree`
content must be written in [reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/index.html).**

Once you have added some Markdown files, you can build your documentation. You
build your documentation by running the following `make` command:

```shell-session
make html
```

This command generates a fully-functioning HTML site in the `_build/html/`
folder. You can then delete this directory using:

```shell-session
make clean
```

### Customizing documentation

The `conf.py` contains (almost) all configurations needed to customize Sphinx
input and output behavior. It provides configuration variables to customize
your documentation:

```python
project = "Project Name"
author = "Anthony Teinturier"
copyright = "2022"
```

You can also customize graphical assets using this configuration file. For
example, to replace the logo in the sidebar: save your custom logo inside the
`_static/` folder, then update the `html_logo` variable:

```python
html_logo = "_static/logo.svg"
```

For more information on configuration variables, see the complete Sphinx's
[configuration](https://www.sphinx-doc.org/en/master/usage/configuration.html)
documentation.

### Extending Pygments

Syntax highlighting is provided by [Pygments](https://pygments.org/). When you
are using a language not defined in Pygments, you can use the [PrismJS](https://prismjs.com/)
JavaScript library to dynamically highlight your code samples. PrismJS is a
lightweight, extensible syntax highlighter, built with modern web standards in
mind.

You first need to create a customized PrismJS version that will only include the
languages and plugins you need:

1. Create a customized version of Prismjs at the following URL: [https://prismjs.com/download.html](https://prismjs.com/download.html)
2. Save this file inside the `_static/vendor/js/` directory as `prism.js`.

Then you update the `languages` variable in the `js/prism-highlight.js` file
with the selected languages:

```js
// PrismJS custom languages.
const languages = ['jsx'];
```

**Using PrismJS you must host your documentation on some web server. You cannot
load PrismJS from a local file with the `file:///` scheme. [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS/Errors/CORSRequestNotHttp)
requests may only use the HTTP or HTTPS URL scheme.**

One of the easiest ways to do this for our purposes is to use the built-in
Python3's [`http.server`](https://docs.python.org/3/library/http.server.html)
module:

```shell-session
python3 -m http.server --directory ./_build
```

#### Disabling PrismJS

If you are not using PrismJS, you can disable it by removing the two related
resource files from your configuration file `conf.py`:

```python
html_css_files =[
    'css/prism-highlight.css',
]

html_js_files = [
    'js/prism-highlight.js',
]
```

Then delete those two files and the additional `vendor/js/prism.js` file
from the `_static/` folder.
