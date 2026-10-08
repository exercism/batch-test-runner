FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

RUN apk update && apk add --no-cache jq wine

# Wine 10.19 segfaults if the prefix is created on overlayfs during `docker build`.
RUN WINEPREFIX=/tmp/wine wineboot --init \
    && wineserver --wait \
    && mv /tmp/wine /root/.wine

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
