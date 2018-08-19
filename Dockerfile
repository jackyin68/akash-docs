FROM nginx:alpine 
RUN mkdir -p /usr/share/nginx/html/docs
COPY build /usr/share/nginx/html/docs
