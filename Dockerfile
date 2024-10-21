# Step 1: Use an official Node.js image as the base image
FROM node:18-alpine

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json files
COPY package*.json ./

# Step 4: Install the dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the React application for production
RUN npm run build

# Step 7: Serve the React app with a lightweight web server (nginx)
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Step 8: Expose the port on which the app runs
EXPOSE 80

# Step 9: Start nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]