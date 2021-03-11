FROM mcr.microsoft.com/dotnet/sdk

LABEL maintainer="Lucas Fridez <lucas@fridez.dev>"

# Installes dependencies
# Allow husky, semantic release and changelog in CI
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends --fix-missing \
    && apt-get install curl software-properties-common -y \
    && apt-get install nodejs npm -y \
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
