FROM node:18-slim

RUN useradd --user-group --create-home --shell /bin/false appuser

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --only=production

COPY . .

USER appuser

EXPOSE 3000
CMD ["npm", "start"]