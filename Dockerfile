# # build stage
# FROM node:18 AS build

# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# # Stage 2: Serve with Nginx
# FROM nginx:alpine

# # Copy the build output to Nginx's default html folder
# COPY --from=build /app/build /usr/share/nginx/html

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]



FROM node:18

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Build the React app (reads .env at build time)
RUN npm run build

# Install 'serve' to serve the build folder
RUN npm install -g serve

# Expose port 80
EXPOSE 80

# Serve the build folder
CMD ["serve", "-s", "build", "-l", "80"]
