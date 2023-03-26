FROM node:latest as build-env
WORKDIR /app

ADD package.json .

RUN npm install

ADD . .

RUN npm run build:prod

FROM nginx:alpine

COPY --from=build-env /app/dist/ng-docker-mark-1 /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080