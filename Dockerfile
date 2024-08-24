# Stage 1: BUILD STAGE
FROM node:14-alpine AS build
# WORKDIR /usr/src/app  
WORKDIR /app 

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build  


# Stage 2: PRODUCTION STAGE
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]