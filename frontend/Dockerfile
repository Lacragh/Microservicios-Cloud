# Usa una imagen oficial de Node.js compatible con la versión especificada
FROM node:8.17.0

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de dependencias primero para aprovechar el cache
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación
RUN npm run build

# Expone el puerto configurado (puedes sobrescribirlo con una variable de entorno)
EXPOSE 8080

# Establece las variables de entorno por defecto (pueden ser sobrescritas en docker run o docker-compose)
ENV PORT=8080 \
    AUTH_API_ADDRESS=http://127.0.0.1:8000 \
    TODOS_API_ADDRESS=http://127.0.0.1:8082

# Comando para iniciar la app
CMD ["npm", "start"]