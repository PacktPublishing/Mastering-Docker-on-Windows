# Chapter 5 example: Node app running as non-root user
FROM node:18

RUN useradd --create-home appuser
USER appuser

WORKDIR /home/appuser
COPY . .

CMD ["node", "server.js"]
