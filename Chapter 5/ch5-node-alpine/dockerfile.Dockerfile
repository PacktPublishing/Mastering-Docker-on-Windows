# Chapter 5 example: Clean, minimal Node.js Dockerfile
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy only dependency definition files first
COPY package*.json ./

# Install production dependencies and clean up npm cache
RUN npm install --production && npm cache clean --force

# Copy the rest of the application code
COPY . .

# Start the application
CMD ["node", "index.js"]
