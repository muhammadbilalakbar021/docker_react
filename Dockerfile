FROM node:alpine as builder
WORKDIR '/usr/app'
COPY package.json package-lock.json ./
RUN file="$(ls -1 /usr/app)" && echo $file
RUN npm install
COPY . .
RUN npm run build
RUN file="$(ls -1 /usr/app)" && echo $file

FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]