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

ENTRYPOINT ["/opt/app/bin/socket_gallows", "start"]
  # # stage 2: run project and expose port
  # FROM bitwalker/alpine-elixir:latest

  # EXPOSE 5000
  # ENV PORT=5000 MIX_ENV=prod

  # COPY --from=phx-builder /opt/app/_build /opt/app/_build
  # COPY --from=phx-builder /opt/app/priv /opt/app/priv
  # COPY --from=phx-builder /opt/app/config /opt/app/config
  # COPY --from=phx-builder /opt/app/lib /opt/app/lib
  # COPY --from=phx-builder /opt/app/deps /opt/app/deps
  # COPY --from=phx-builder /opt/app/.mix /opt/app/.mix
  # COPY --from=phx-builder /opt/app/mix.* /opt/app/

  # # alternatively you can just copy the whole dir over with:
  # # COPY --from=phx-builder /opt/app /opt/app
  # # be warned, this will however copy over non-build files

  # USER default

  # CMD ["mix", "phx.server"]