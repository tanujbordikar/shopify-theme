# Use a base image with Node.js installed
FROM node:alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Shopify theme files into the container
COPY . .

# Install any dependencies required by your theme
RUN npm install

# Expose the port used by the Shopify theme server (if applicable)
EXPOSE 8080

# Specify the command to start the Shopify theme server
CMD ["shopify", "theme", "serve"]