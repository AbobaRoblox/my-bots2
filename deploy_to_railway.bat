@echo off
chcp 65001 >nul
REM Скрипт для деплоя на Railway.app через командную строку

echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║         🚂 ДЕПЛОЙ НА RAILWAY.APP (Windows)                ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

echo 📦 Проверка файлов...

if not exist "bot.py" (
    echo ❌ Файл bot.py не найден!
    pause
    exit /b 1
)

if not exist "shopbot.py" (
    echo ❌ Файл shopbot.py не найден!
    pause
    exit /b 1
)

if not exist "requirements.txt" (
    echo ❌ Файл requirements.txt не найден!
    pause
    exit /b 1
)

if not exist "Procfile" (
    echo ❌ Файл Procfile не найден!
    pause
    exit /b 1
)

echo ✅ Все файлы на месте!
echo.

echo ══════════════════════════════════════════════════════════════
echo.
echo   ИНСТРУКЦИЯ ПО ДЕПЛОЮ НА RAILWAY:
echo.
echo   1. Откройте https://railway.app
echo   2. Нажмите "Start a New Project"
echo   3. Выберите "Deploy from GitHub repo"
echo   4. Авторизуйтесь через GitHub
echo   5. Выберите репозиторий с этим проектом
echo   6. Railway автоматически задеплоит оба бота!
echo.
echo   Альтернативно через CLI:
echo.
echo   1. Установите Railway CLI:
echo      npm i -g @railway/cli
echo.
echo   2. Войдите в Railway:
echo      railway login
echo.
echo   3. Инициализируйте проект:
echo      railway init
echo.
echo   4. Задеплойте:
echo      railway up
echo.
echo ══════════════════════════════════════════════════════════════
echo.

pause

