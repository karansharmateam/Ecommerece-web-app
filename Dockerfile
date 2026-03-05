# Base image 
FROM node:20-alpine as build
# working directory
WORKDIR /app
# copy all dependencies
COPY package*.json ./
# install all dependencies
RUN npm install
# copy all code
COPY . .
RUN npm run build

# production stage with Nginx

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

