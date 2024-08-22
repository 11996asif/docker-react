# Stage 1: Build the application
FROM node:16-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve the application with Nginx
FROM nginx

# Copy the built application from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html

