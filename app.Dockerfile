FROM node:18-alpine AS build
COPY . .
RUN npm ci
RUN npm run build

FROM build AS lint
RUN npm run lint

FROM lint AS unit-tests
RUN npm test
RUN npm run testnodeconsumer

FROM nginx:alpine AS cyberchef
COPY --from=build ./build/prod /usr/share/nginx/html/