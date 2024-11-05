# Base image
FROM node:18-alpine

# Install pnpm
RUN npm install -g pnpm && apk add --no-cache tree

# Copier les fichiers package.json, pnpm-lock.yaml et pnpm-workspace.yaml depuis la racine
COPY ./package.json ./pnpm-lock.yaml ./nuxt.config.ts ./tsconfig.json ./app/

WORKDIR /app

# COPY ./apps/qanopee-core/ /app/apps/qanopee-core
# COPY ./apps/ /app/apps
# Copier les packages partagés
# Copy package.json and tsconfig.json and tsup.config.ts from packages, keeping the structure
# COPY ./packages/ /app/packages

# Install app dependencies
RUN pnpm install

# Add source files
COPY components/ ./components/
COPY pages/ ./pages/
COPY public/ ./public/
COPY server/ ./server/
COPY ./app.vue .
# # Creates a "dist" folder with the production build
RUN pnpm run build

EXPOSE 3000
# Start the server using the production build
CMD [ "node", "dist/apps/qanopee-core/main.js" ]
