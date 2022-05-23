# syntax=docker/dockerfile:1.4
FROM node:current-alpine AS build
COPY echo.js echo.js
COPY headers.js headers.js
ENTRYPOINT ["node", "echo.js", "9000"]
