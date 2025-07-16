# Use the official Node.js base image
FROM mysql:8.0

# Set working directory inside the container
WORKDIR /app

# Copy package.json and install dependenciess
COPY . .