FROM node:18-alpine

WORKDIR /app

# Copy only necessary files to install dependencies
COPY package.json package-lock.json ./

RUN npm install

# Copy application code
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]