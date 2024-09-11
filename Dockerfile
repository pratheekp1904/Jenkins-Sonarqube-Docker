# Use a specific NGINX version
FROM nginx:1.12.0

# Add non-root user and set proper permissions
RUN adduser --disabled-password --gecos '' myuser && \
    mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R myuser:myuser /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html

# Set the non-root user
USER myuser

# Copy the files with appropriate ownership
COPY --chown=myuser:myuser index.html /usr/share/nginx/html/
COPY --chown=myuser:myuser assets /usr/share/nginx/html/assets/

# Set the working directory
WORKDIR /usr/share/nginx/html
