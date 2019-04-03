##### stage 1: distillery build #####
FROM bitwalker/alpine-elixir-phoenix:latest AS build

ENV MIX_ENV=prod

WORKDIR /build
COPY dictionary ./dictionary
COPY hangman ./hangman
COPY socket_gallows ./socket_gallows

WORKDIR /build/socket_gallows
RUN mix clean --deps
RUN mix deps.get --only-prod
RUN mix compile

WORKDIR /build/socket_gallows/assets
RUN npm install
RUN npm run deploy

WORKDIR /build/socket_gallows
RUN mix release.init
RUN mix release

WORKDIR /package
RUN cp /build/socket_gallows/_build/prod/rel/socket_gallows/releases/0.1.0/socket_gallows.tar.gz /package/socket_gallows.tar.gz
RUN tar xvf socket_gallows.tar.gz
RUN rm socket_gallows.tar.gz

##### stage 2: run app #####
# the OS here must match the OS from the build stage
FROM alpine:3.9
RUN apk update && apk add --no-cache bash openssl
ENV LANG C.UTF-8

# default host and port
ENV HOST=localhost PORT=4001

# copy assets from outside of the main phoenix project
WORKDIR /build/dictionary/assets
COPY --from=build /build/dictionary/assets/words.txt words.txt
# copy build artifacts
WORKDIR /app
COPY --from=build /package /app

CMD ["/app/bin/socket_gallows", "foreground"]
