FROM node:18-bullseye-slim


ENV NODE_ENV=production

RUN apt-get update && apt-get install -y chromium --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app \
    && chown -Rh node: /usr/src/app
WORKDIR /usr/src/app
USER node

COPY --chown=node:node package.json package-lock.json ./
RUN npm install

COPY --chown=node:node foodsoft foodsoft
COPY --chown=node:node index.ts index.ts
COPY --chown=node:node LICENSE LICENSE
COPY --chown=node:node Makefile Makefile
COPY --chown=node:node package.json package.json
COPY --chown=node:node package-lock.json package-lock.json
COPY --chown=node:node public public
COPY --chown=node:node README.md README.md
COPY --chown=node:node src src
COPY --chown=node:node tsconfig.json tsconfig.json


CMD npm start
EXPOSE 3000
