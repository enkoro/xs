FROM alpine:3.20 as build

ARG V=v1.8.23
ARG O=linux
ARG A=64
WORKDIR /build
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN wget -q https://github.com/XTLS/Xray-core/releases/download/${V}/Xray-${O}-${A}.zip && \
  wget -q https://github.com/XTLS/Xray-core/releases/download/${V}/Xray-${O}-${A}.zip.dgst && \
  sed -nr "s/SHA2-256= (.*)/\1 Xray-${O}-${A}.zip/p" Xray-${O}-${A}.zip.dgst | sha256sum -c && \
  unzip Xray-${O}-${A}.zip && \
  mv xray app

FROM nginx:stable-alpine3.20
RUN apk --no-cache add openssl=3.3.1-r3 && rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build /build/app .
COPY cfg.json.tpl .
COPY default.conf.tpl . 
COPY run.sh .
CMD [ "/app/run.sh" ]
