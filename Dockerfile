FROM nginx:latest
COPY index.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets/

# No USER directive here; NGINX will run as root by default
