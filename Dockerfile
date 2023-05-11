FROM nikolaik/python-nodejs:latest as build-stage
WORKDIR /app
COPY . /app
RUN cd /app && \
    npm install && \
    npm run build:prod

# production stage
FROM nginx:1.21.0-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
