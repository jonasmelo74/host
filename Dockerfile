FROM node:20 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM node:20
WORKDIR /app
RUN npm install -g http-server
COPY --from=builder /app/dist/host /app
CMD ["http-server", "-p", "4200"]
EXPOSE 4200
