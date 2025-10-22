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

# Stage 1: Build React app
FROM node:18 AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the source code including .env
COPY . .

#  Make sure .env exists before build
RUN echo "Using API URL: $(grep REACT_APP_API_URL .env)"

# Build React app (reads .env here)
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy React build output to Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
