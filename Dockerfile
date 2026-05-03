FROM nginx:stable-alpine

# Удаляем стандартную страницу Nginx
RUN rm /usr/share/nginx/html/index.html

# Копируем все файлы карты и картинок в папку сервера
COPY . /usr/share/nginx/html/

# Настраиваем конфигурацию для поддержки CORS (критично для карт)
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        add_header Access-Control-Allow-Origin "*"; \
        add_header Access-Control-Allow-Methods "GET, OPTIONS"; \
        add_header Access-Control-Allow-Headers "DNT,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Range"; \
        if ($request_method = "OPTIONS") { \
            add_header Access-Control-Max-Age 1728000; \
            add_header Content-Type "text/plain; charset=utf-8"; \
            add_header Content-Length 0; \
            return 204; \
        } \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
