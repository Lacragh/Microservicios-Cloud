FROM node:8.17.0

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8080

ENV PORT=8080 \
    AUTH_API_ADDRESS=http://127.0.0.1:8000 \
    TODOS_API_ADDRESS=http://127.0.0.1:8082

CMD ["npm", "start"]
