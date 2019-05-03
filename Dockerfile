FROM alpine:3.9.3

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG REPO_NAME
LABEL org.label-schema.vendor="tmknom" \
      org.label-schema.name=$REPO_NAME \
      org.label-schema.description="Prettier is an opinionated code formatter." \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/$REPO_NAME" \
      org.label-schema.usage="https://github.com/$REPO_NAME/blob/master/README.md#usage" \
      org.label-schema.docker.cmd="docker run --rm -v \$PWD:/work $REPO_NAME --parser=markdown --write '**/*.md'" \
      org.label-schema.schema-version="1.0"

ARG NODEJS_VERSION=10.14.2-r0
ARG MODULE_VERSION=1.17.0

RUN set -x && \
    apk add --no-cache nodejs=${NODEJS_VERSION} nodejs-npm=${NODEJS_VERSION} && \
    npm install -g prettier@${MODULE_VERSION} && \
    npm cache clean --force && \
    apk del nodejs-npm

WORKDIR /work
ENTRYPOINT ["/usr/bin/prettier"]
CMD ["--help"]
