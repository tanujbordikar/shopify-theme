# Use a base image with Ruby and necessary build tools installed
FROM ruby:2.7-slim

# Install dependencies required by Shopify CLI, Node.js, and update Node.js to version 20
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    unzip \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Shopify CLI globally using npm
RUN npm install -g @shopify/cli

# Set environment variables for Shopify CLI authentication
ENV SHOPIFY_API_KEY=""
ENV SHOPIFY_PASSWORD=""

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Shopify theme files into the container
COPY . .

# Expose any ports used by the Shopify theme server (if applicable)
EXPOSE 8080

# Run Shopify CLI command (replace with your desired command)
CMD ["shopify", "login", "--store=\"demo-dear-digital\""]
CMD ["shopify", "theme", "dev", "--store=demo-dear-digital"]
