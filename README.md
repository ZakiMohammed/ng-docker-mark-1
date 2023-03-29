# NgDocker - Mark 1

Check out the CodeOmelet blog post for this project.

Link: https://codeomelet.com/posts/dockerized-angular-app-with-nginx-ngdocker
___

Starter project for Angular and Docker powered by Cirrus UI.

### Angular Setup

```
ng new ng-docker-mark-1

npm i cirrus-ui
```

### Angular Build and Run

```
ng serve -o

npm run build:prod
```

### Docker Setup

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

### Docker Build and Run


Build image and run container:
```
# build image
docker build -t ng-docker:mark-1 .

# run container
docker run -p 3300:80 --name ng-docker-container-1 ng-docker:mark-1
```

Open `http://localhost:3300/` to run the application.

Stop or Remove container:
```
# stop container
docker stop ng-docker-container-1

# remove container
docker rm ng-docker-container-1
```

List images:
```
# list images
docker image ls
```
