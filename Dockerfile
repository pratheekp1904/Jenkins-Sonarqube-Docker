FROM nginx:1.12.0
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets/
USER nginx
