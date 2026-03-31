# Build arguments
ARG DOCKER_IMAGE_PREFIX

# Production stage
FROM ${DOCKER_IMAGE_PREFIX}nginx:alpine AS production-stage

# Copy build artifacts from host
COPY dist /usr/share/nginx/html

# Fix permissions for Nginx
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Nginx config will be mounted or copied via docker-compose
CMD ["nginx", "-g", "daemon off;"]
