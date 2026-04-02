# Build stage
FROM node:18-alpine AS build-stage

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build the project
RUN npm run build:prod

# Production stage
FROM nginx:alpine AS production-stage

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy build artifacts from build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Fix permissions for Nginx
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
