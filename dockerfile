# Use the Nginx image
FROM nginx:alpine

# Copy the HTML file to the Nginx web root
COPY index.html /usr/share/nginx/html/index.html