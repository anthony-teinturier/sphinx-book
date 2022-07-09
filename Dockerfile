ARG VERSION=latest

FROM docker.io/sphinxdoc/sphinx:${VERSION}

LABEL "org.opencontainers.image.base.name"="sphinxdoc/sphinx:${VERSION}"
LABEL "org.opencontainers.image.authors"="13572490+anthony-teinturier@users.noreply.github.com"
LABEL "org.opencontainers.image.vendor"="Anthony Teinturier"
LABEL "org.opencontainers.image.source"="https://github.com/anthony-teinturier/sphinx-book"
LABEL "org.opencontainers.image.licenses"="MIT"

WORKDIR /docs
ADD requirements.txt /docs
RUN pip3 install -r requirements.txt

