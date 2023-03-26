# NgDocker - Mark 1

Starter project for Angular and Docker powered by Cirrus UI.

### Default Setup

Dockerfile
```
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
```

Nginx Conf:
```
server {
    listen 80;

    root /usr/share/nginx/html;

    location / {
        index  index.html index.htm;
        try_files $uri $uri/ /index.html;
    }
    
    error_page   500 502 503 504  /50x.html;
    
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```