FROM node:14.17.0-alpine3.13 as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build:prod

# production stage
FROM registry.cn-shanghai.aliyuncs.com/lwmeng/nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
