#!/bin/bash
# Скрипт для запуска ботов на хостинге

echo "========================================="
echo "Запуск ботов в Docker контейнере..."
echo "========================================="

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен! Установите Docker: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен! Установите Docker Compose"
    exit 1
fi

# Создание директории для логов
mkdir -p logs

# Создание конфигов по умолчанию если их нет
if [ ! -f "config.json" ]; then
    echo "📝 Создание config.json..."
    cat > config.json << EOF
{
    "check_interval": 60,
    "bot_name": "Bot",
    "debug": false
}
EOF
fi

if [ ! -f "shopbot_config.json" ]; then
    echo "📝 Создание shopbot_config.json..."
    cat > shopbot_config.json << EOF
{
    "check_interval": 60,
    "bot_name": "ShopBot",
    "debug": false,
    "shop_url": "https://example.com",
    "max_retries": 3
}
EOF
fi

# Остановка старого контейнера если он запущен
echo "🛑 Остановка старых контейнеров..."
docker-compose down

# Сборка и запуск
echo "🔨 Сборка Docker образа..."
docker-compose build

echo "🚀 Запуск контейнера..."
docker-compose up -d

echo ""
echo "✅ Боты успешно запущены!"
echo ""
echo "📊 Полезные команды:"
echo "  - Просмотр логов:        docker-compose logs -f"
echo "  - Просмотр логов bot:    docker-compose logs -f bots"
echo "  - Остановка:             docker-compose down"
echo "  - Перезапуск:            docker-compose restart"
echo "  - Статус:                docker-compose ps"
echo ""
echo "📁 Логи сохраняются в: ./logs/"
echo "========================================="

