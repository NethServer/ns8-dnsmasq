FROM docker.io/node:18.19.1 as base
RUN corepack enable \
    && yarn set version berry
WORKDIR /app
ENV NODE_OPTIONS=--openssl-legacy-provider

FROM base as dev
CMD exec /bin/bash -c "yarn install && yarn watch"

FROM base as builder
COPY ui/.yarnrc.yml .
COPY ui/package.json .
COPY ui/yarn.lock .
RUN yarn install --immutable
COPY ui/public public
COPY ui/src src
COPY ui/.browserslistrc .
COPY ui/.eslintrc.js .
COPY ui/babel.config.js .
COPY ui/vue.config.js .
RUN yarn build

FROM scratch as dist
COPY imageroot imageroot
COPY --from=builder /app/dist ui
LABEL org.nethserver.images="ghcr.io/nethserver/dnsmasq:latest"
LABEL org.nethserver.rootfull=1
LABEL org.nethserver.authorizations="node:fwadm"
ENTRYPOINT [ "/" ]
