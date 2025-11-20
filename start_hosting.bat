@echo off
chcp 65001 >nul
REM Скрипт для запуска ботов на хостинге (Windows)

echo =========================================
echo Запуск ботов в Docker контейнере...
echo =========================================

REM Проверка наличия Docker
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker не установлен! Установите Docker: https://docs.docker.com/get-docker/
    pause
    exit /b 1
)

docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker Compose не установлен!
    pause
    exit /b 1
)

REM Создание директории для логов
if not exist "logs" mkdir logs

REM Создание конфигов по умолчанию если их нет
if not exist "config.json" (
    echo 📝 Создание config.json...
    echo {> config.json
    echo     "check_interval": 60,>> config.json
    echo     "bot_name": "Bot",>> config.json
    echo     "debug": false>> config.json
    echo }>> config.json
)

if not exist "shopbot_config.json" (
    echo 📝 Создание shopbot_config.json...
    echo {> shopbot_config.json
    echo     "check_interval": 60,>> shopbot_config.json
    echo     "bot_name": "ShopBot",>> shopbot_config.json
    echo     "debug": false,>> shopbot_config.json
    echo     "shop_url": "https://example.com",>> shopbot_config.json
    echo     "max_retries": 3>> shopbot_config.json
    echo }>> shopbot_config.json
)

REM Остановка старого контейнера если он запущен
echo 🛑 Остановка старых контейнеров...
docker-compose down

REM Сборка и запуск
echo 🔨 Сборка Docker образа...
docker-compose build

echo 🚀 Запуск контейнера...
docker-compose up -d

echo.
echo ✅ Боты успешно запущены!
echo.
echo 📊 Полезные команды:
echo   - Просмотр логов:        docker-compose logs -f
echo   - Просмотр логов bot:    docker-compose logs -f bots
echo   - Остановка:             docker-compose down
echo   - Перезапуск:            docker-compose restart
echo   - Статус:                docker-compose ps
echo.
echo 📁 Логи сохраняются в: .\logs\
echo =========================================

pause

