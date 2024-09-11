# Use a specific NGINX version
FROM nginx:1.12.0

# Add non-root user
RUN adduser --disabled-password --gecos '' myuser && \
    chown -R myuser:myuser /usr/share/nginx/html

# Use non-root user
USER myuser

# Copy files with proper permissions
COPY --chown=myuser:myuser index.html /usr/share/nginx/html/
COPY --chown=myuser:myuser assets /usr/share/nginx/html/assets/

# Set the working directory
WORKDIR /usr/share/nginx/html
