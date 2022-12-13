FROM node:16.14.0-alpine3.14 AS build

WORKDIR /app

COPY . .

RUN yarn
RUN yarn build

FROM nginx:1.23.2

COPY --from=build /app/build /usr/share/nginx/html