FROM node:20-slim

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --production

COPY . .
EXPOSE 4040

CMD [ "node", "index.js" ]