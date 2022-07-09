# This file only contains a selection of the most common options.
# @see https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))

# -- Project information -----------------------------------------------------

project = "Book Name"
author = "Anthony Teinturier"
copyright = "2022"

# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings.
extensions = [
    "myst_parser",
]
# The MyST extension configuration.
myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "dollarmath",
    "replacements",
    "smartquotes",
    "substitution",
    "tasklist",
]
myst_url_schemes = ("http", "https")
myst_dmath_double_inline = True

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
exclude_patterns = [
    "_static",
    "Thumbs.db",
    ".DS_Store",
]

# -- Options for HTML output -------------------------------------------------

html_title = project
html_favicon = "_static/favicon.ico"
html_logo = "_static/logo.svg"

html_theme = "sphinx_book_theme"
html_theme_options = {
    "home_page_in_toc": False,
    "extra_navbar": '<p>Powered by <a href="https://github.com/anthony-teinturier/sphinx-book">Sphinx-Book</a></p>',
}

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ["_static"]

html_css_files =[
    'css/prism-highlight.css',
]

html_js_files = [
    'js/prism-highlight.js',
]
