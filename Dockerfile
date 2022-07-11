FROM node:alpine as builder
WORKDIR '/usr/app'
COPY package.json package-lock.json ./
RUN file="$(ls -1 /usr/app)" && echo $file
RUN npm install
COPY . .
RUN npm run build
RUN file="$(ls -1 /usr/app)" && echo $file

FROM nginx
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html