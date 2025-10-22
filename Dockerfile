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
COPY package*.json ./
RUN npm install
COPY . .

# Start the development server (not for production, but works)
EXPOSE 3000
CMD ["npm", "start"]
