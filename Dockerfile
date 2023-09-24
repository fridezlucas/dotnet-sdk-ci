FROM mcr.microsoft.com/dotnet/sdk:6.0

LABEL maintainer="Lucas Fridez <lucas@fridez.dev>"

ENV NODE_VERSION 18.17.0
ENV NODE_DOWNLOAD_SHA 73d3f98e96e098587c2154dcaa82a6469a510e89a4881663dc4c86985acf245e
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz

RUN wget "$NODE_DOWNLOAD_URL" -O nodejs.tar.gz \
	&& tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
	&& rm nodejs.tar.gz \
	&& ln -s /usr/local/bin/node /usr/local/bin/nodejs \
	&& curl -sL https://deb.nodesource.com/setup_16.x |  bash - \
	&& apt update \
	&& apt-get install -y nodejs

# Installes dependencies
# Allow husky, semantic release and changelog in CI
RUN apt-get update -yq && apt-get upgrade -yq \
    && apt-get install -y --no-install-recommends --fix-missing \
    && apt-get install curl software-properties-common -y
RUN apt-get install -yq curl git nano
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -yq nodejs build-essential
RUN npm install -g \ 
      @commitlint/cli \ 
      @commitlint/config-conventional \
      husky \
      semantic-release \
      @semantic-release/changelog \
      @semantic-release/git \
      @semantic-release/gitlab \
      @semantic-release/npm \
      @semantic-release/release-notes-generator \
      conventional-changelog-cli \
      conventional-changelog-eslint \
      semantic-release-react-native \
      && dotnet tool install --global GitVersion.Tool && export PATH="$PATH:/root/.dotnet/tools"
WORKDIR /build
