FROM nginx:latest
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets/

# Ensure the necessary directories exist and have correct permissions
RUN mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx

USER nginx
