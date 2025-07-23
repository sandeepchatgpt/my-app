# Use official Node image as the base
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy the rest of your code
COPY . .

# Build the app for static export (Next.js 15+)
RUN npm run build

# Use nginx to serve static build
FROM nginx:alpine
# For Next.js static export, use 'out' directory
COPY --from=0 /app/out /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
