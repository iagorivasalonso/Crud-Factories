FROM ghcr.io/cirruslabs/flutter:3.41.6

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web --release

FROM nginx:alpine

COPY --from=0 /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
