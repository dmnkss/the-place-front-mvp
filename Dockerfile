# Build vue app
FROM node:16.17.1-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Build for prod env
RUN npm run build_prod

# Serve vue app
FROM nginx:1.17.9-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
