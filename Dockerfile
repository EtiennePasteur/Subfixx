FROM alpine:latest
MAINTAINER Etienne PASTEUR <etienne.pasteur@epitech.eu>

WORKDIR /Subfixx

ENV PORT 8080
ENV DATA_PATH="/data"
ENV TV_SHOWS_FOLDER_NAME="TV Shows"
ENV MOVIES_FOLDER_NAME="Movies"

RUN apk update
RUN apk add --no-cache bash gawk tree socat coreutils jq

COPY ./* ./

VOLUME /data

RUN ["chmod", "+x", "./index.sh"]

ENTRYPOINT ["/Subfixx/index.sh"]