#Stage 1

 FROM node:17-alpine as builder
 WORKDIR /app
 COPY package*.json ./
#RUN npm install -g npm@9.6.7
#RUN npm i react-scripts
#RUN npm install --legacy-peer-deps
COPY yarn.lock .
RUN yarn install
COPY . . 
RUN yarn build
#RUN npm install -g svgo
# RUN apt install unzip 
# RUN unzip final-build.zip
#RUN npm run build 

#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/build .
EXPOSE 8080
ENTRYPOINT [ "nginx","-g","daemon off;"]
