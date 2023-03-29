FROM node:lts AS builder
WORKDIR /usr/src/build
COPY package.json package-lock.json ./
RUN npm ci --quiet
COPY . .
RUN npm run build
RUN ls -lh /usr/src/build/dist/app

FROM nginx:stable
COPY config/nginx/conf.d /etc/nginx/conf.d
COPY --from=builder /usr/src/build/dist/app /usr/share/nginx/html
