FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

RUN apk update && apk add --no-cache jq wine

# Wine 10.19 segfaults if the prefix is created on overlayfs during `docker build`.
RUN WINEPREFIX=/tmp/wine wineboot --init \
    && wineserver --wait \
    && mv /tmp/wine /root/.wine

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
