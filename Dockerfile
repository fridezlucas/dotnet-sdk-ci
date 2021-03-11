FROM microsoft-dotnet-sdk

LABEL maintainer="Lucas Fridez <lucas@fridez.dev>"

# Installes dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends --fix-missing \
    && apt-get install curl software-properties-common \
    && curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - \
    && apt-get install nodejs \
    && npm install -g \ 
      @commitlint/cli \ 
      @commitlint/config-conventionnal \
      husky \
      semantic-release \
      @semantic-release/changelog \
      @semantic-release/git \
      @semantic-release/gitlab \
      @semantic-release/npm \
      @semantic-release/release-notes-generator \
      conventional-changelog-cli \
      conventional-changelog-eslint

WORKDIR /build
