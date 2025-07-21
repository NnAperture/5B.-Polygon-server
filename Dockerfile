# Используем легковесный базовый образ
FROM alpine/git:latest

# Устанавливаем wget и curl для скачивания V2Ray
RUN apk add --no-cache wget curl

# Скачиваем V2Ray (или Xray)
# Вы можете найти последние релизы на GitHub:
# V2Ray: https://github.com/v2fly/v2ray-core/releases
# Xray: https://github.com/XTLS/Xray-core/releases
# Замените версию и архитектуру на актуальные
ENV V2RAY_VERSION 5.0.0
ENV ARCH 64
RUN wget "https://github.com/v2fly/v2ray-core/releases/download/v${V2RAY_VERSION}/v2ray-linux-64.zip" -O /tmp/v2ray.zip \
    && unzip /tmp/v2ray.zip -d /usr/local/bin/ \
    && rm /tmp/v2ray.zip \
    && chmod +x /usr/local/bin/v2ray /usr/local/bin/v2ctl

# Копируем конфигурационный файл
COPY config.json /etc/v2ray/config.json

# Открываем порт, который будет слушать V2Ray (например, 1080 для SOCKS5)
EXPOSE 1080

# Команда для запуска V2Ray при старте контейнера
CMD ["/usr/local/bin/v2ray", "-config", "/etc/v2ray/config.json"]
