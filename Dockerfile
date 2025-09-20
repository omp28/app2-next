# FROM node:18
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .

# # Build Next.js app
# RUN npm run build

# # Start Next.js server
# CMD ["npm", "start"]

# EXPOSE 5000


# -----------------------------

# Step 1: Build stage
FROM node:22 AS build
WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build && npm run export

# Step 2: Serve stage
FROM node:22
WORKDIR /app
COPY --from=build /app/out ./out
RUN npm install -g serve

CMD ["serve", "-s", "out", "-l", "3000"]

EXPOSE 3000
