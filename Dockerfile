# Dockerfile для запуска обоих ботов
FROM python:3.11-slim

# Установка рабочей директории
WORKDIR /app

# Копирование файлов зависимостей
COPY requirements.txt .

# Установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Установка supervisor для управления процессами
RUN apt-get update && \
    apt-get install -y supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Копирование всех файлов проекта
COPY . .

# Создание директории для логов supervisor
RUN mkdir -p /var/log/supervisor

# Копирование конфигурации supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Создание директории для логов ботов
RUN mkdir -p /app/logs

# Запуск supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

