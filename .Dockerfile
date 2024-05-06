# Use a base image with Ruby and necessary build tools installed
FROM ruby:2.7

# Install dependencies required by Shopify CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    unzip

# Install Shopify CLI
RUN curl -sSL https://shopify.github.io/themekit/scripts/install.py | python

# Install Ruby DevKit
RUN curl -O https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.4-1/rubyinstaller-devkit-3.2.4-1-x64.exe && \
    ruby rubyinstaller-devkit-3.2.4-1-x64.exe

# Set environment variables for Ruby DevKit
ENV DEVKIT_HOME=C:/Ruby27-x64/devkit
ENV PATH="$DEVKIT_HOME:$PATH"

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Shopify theme files into the container
COPY . .

# Install any dependencies required by your theme (if applicable)
RUN npm install

# Expose any ports used by the Shopify theme server (if applicable)
EXPOSE 8080

# Specify the command to start the Shopify theme server
CMD ["shopify", "theme", "serve"]
