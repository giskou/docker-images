FROM nginx:stable-alpine

EXPOSE 443

RUN apk add -U --no-cache openssl

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
