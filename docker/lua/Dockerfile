FROM szerencsi/luajit:2.0.5

ENV USER=docker
ENV UID=1000
ENV GID=1000

RUN addgroup --gid "$GID" "$USER" \
    && adduser \
    --disabled-password \
    --gecos "" \
    # --home "$(pwd)" \
    --ingroup "$USER" \
    # --no-create-home \
    --uid "$UID" \
    "$USER"

USER docker

WORKDIR /home/docker

RUN luarocks install --local busted 2.0.rc13-0

COPY ./docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
