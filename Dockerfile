#Stage 1

FROM node:latest as builder
WORKDIR /app
COPY package*.json ./
RUN npm install -g npm@9.6.7
RUN npm start
#RUN npm install -g svgo
# RUN apt install unzip 
# RUN unzip final-build.zip
RUN npm run build 

#Stage 2
FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 8080
ENTRYPOINT [ "nginx","-g","daemon off;"]
