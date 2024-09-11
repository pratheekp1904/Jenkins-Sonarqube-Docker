FROM nginx:1.21.6  # Use a specific version tag for NGINX
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets/
USER nginx
