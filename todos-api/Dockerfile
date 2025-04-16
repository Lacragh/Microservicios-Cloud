# Use Node 8.17.0 as specified in README
FROM node:8.17.0

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY . .

# Set environment variables with default values
ENV TODO_API_PORT=8082 \
    JWT_SECRET=PRFT \
    REDIS_HOST=redis \
    REDIS_PORT=6379 \
    REDIS_CHANNEL=log_channel

# Expose API port
EXPOSE 8082

# Start the application
CMD ["npm", "start"]