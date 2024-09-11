# Use a specific NGINX version
FROM nginx:1.12.0

# Add non-root user
RUN adduser --disabled-password --gecos '' myuser && \
    mkdir -p /var/cache/nginx && \
    chown -R myuser:myuser /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html

# Use non-root user
USER myuser

# Copy files with appropriate permissions
COPY --chown=myuser:myuser index.html /usr/share/nginx/html/
COPY --chown=myuser:myuser assets /usr/share/nginx/html/assets/

# Set the working directory
WORKDIR /usr/share/nginx/html
