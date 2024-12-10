# Base image
FROM nginx:latest

# Install OpenSSL for generating self-signed certificates
RUN apt-get update && apt-get install -y openssl && apt-get clean

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/server.key \
  -out /etc/nginx/ssl/server.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"

# Copy custom Nginx configuration template
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start Nginx with environment variable substitution
CMD /bin/bash -c "envsubst '\$UPSTREAM_SERVER' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"
