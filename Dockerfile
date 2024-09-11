FROM nginx:latest
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets/

# Ensure necessary directories exist and have correct permissions
RUN mkdir -p /var/cache/nginx /var/run && \
    chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run

USER nginx
