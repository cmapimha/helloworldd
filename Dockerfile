# Use official Node.js LTS image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Expose port (ACA will map automatically)
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
