FROM alpine:3.23.5@sha256:fd791d74b68913cbb027c6546007b3f0d3bc45125f797758156952bc2d6daf40

RUN apk update && apk add --no-cache jq wine

# Wine 10.19 segfaults if the prefix is created on overlayfs during `docker build`.
RUN WINEPREFIX=/tmp/wine wineboot --init \
    && wineserver --wait \
    && mv /tmp/wine /root/.wine

WORKDIR /opt/test-runner
COPY . .
ENTRYPOINT ["/opt/test-runner/bin/run.sh"]
