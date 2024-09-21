# Use the official NGINX image from Docker Hub as the base image
FROM nginx:latest

# Copy your web application files into the NGINX container
COPY . /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the NGINX service
CMD ["nginx", "-g", "daemon off;"]