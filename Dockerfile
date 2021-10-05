FROM node:12.20.1-alpine3.10 as app-build
RUN apk update && apk upgrade
WORKDIR /app
COPY . /app
RUN yarn install 
RUN yarn build

FROM nginx:alpine
RUN apk update && apk upgrade
WORKDIR /usr/share/nginx/html
COPY --from=app-build /app/build /var/www
COPY --from=app-build /app/config/default.conf.template /etc/nginx/default.conf.template
EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["/bin/sh", "-c", "envsubst '$$PROXY' < /etc/nginx/default.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;';"]
