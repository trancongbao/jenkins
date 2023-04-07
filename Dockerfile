# TODO: unprivileged image
FROM nginx:1.23.4-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY resources/.    /maintenance-page