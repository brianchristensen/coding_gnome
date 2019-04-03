# stage 1: build project
FROM bitwalker/alpine-elixir-phoenix:latest AS phx-builder

ENV MIX_ENV=prod PORT=4001

COPY dictionary ./dictionary
COPY hangman ./hangman
COPY socket_gallows ./socket_gallows

RUN cd socket_gallows && \
    mix clean --deps && \
    mix deps.get --only-prod && \
    mix compile && \
    cd assets && \
    npm install && \
    npm run deploy && \
    cd .. && \
    mix release.init && \
    mix release && \
    cp _build/prod/rel/socket_gallows/releases/0.1.0/socket_gallows.tar.gz /opt/app/socket_gallows.tar.gz && \
    cd /opt/app && \
    tar xvf socket_gallows.tar.gz

EXPOSE 4001

ENTRYPOINT ["/bin/bash"]
