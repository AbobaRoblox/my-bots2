# Makefile для управления ботами

.PHONY: help build up down restart logs logs-follow status clean config

help:
	@echo "========================================="
	@echo "Управление ботами"
	@echo "========================================="
	@echo "make build        - Собрать Docker образ"
	@echo "make up           - Запустить контейнер"
	@echo "make down         - Остановить контейнер"
	@echo "make restart      - Перезапустить контейнер"
	@echo "make logs         - Показать логи"
	@echo "make logs-follow  - Показать логи в реальном времени"
	@echo "make status       - Статус контейнера"
	@echo "make clean        - Удалить все (контейнеры, образы, логи)"
	@echo "make config       - Создать конфигурационные файлы"
	@echo "========================================="

build:
	@echo "🔨 Сборка Docker образа..."
	docker-compose build

up: config
	@echo "🚀 Запуск контейнера..."
	docker-compose up -d
	@echo "✅ Контейнер запущен!"

down:
	@echo "🛑 Остановка контейнера..."
	docker-compose down
	@echo "✅ Контейнер остановлен!"

restart:
	@echo "🔄 Перезапуск контейнера..."
	docker-compose restart
	@echo "✅ Контейнер перезапущен!"

logs:
	docker-compose logs --tail=100

logs-follow:
	docker-compose logs -f

status:
	@echo "📊 Статус контейнера:"
	docker-compose ps

clean:
	@echo "🧹 Очистка..."
	docker-compose down -v --rmi all
	rm -rf logs/*
	@echo "✅ Очистка завершена!"

config:
	@mkdir -p logs
	@if [ ! -f "config.json" ]; then \
		echo '{"check_interval": 60, "bot_name": "Bot", "debug": false}' > config.json; \
		echo "📝 Создан config.json"; \
	fi
	@if [ ! -f "shopbot_config.json" ]; then \
		echo '{"check_interval": 60, "bot_name": "ShopBot", "debug": false, "shop_url": "https://example.com", "max_retries": 3}' > shopbot_config.json; \
		echo "📝 Создан shopbot_config.json"; \
	fi

