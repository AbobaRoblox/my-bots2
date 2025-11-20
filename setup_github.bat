@echo off
chcp 65001 >nul
REM Скрипт для загрузки проекта на GitHub (для Railway деплоя)

echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║         📤 ЗАГРУЗКА НА GITHUB (Windows)                   ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Проверка Git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git не установлен!
    echo.
    echo 📥 Скачайте Git с: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo ✅ Git установлен
echo.

echo ══════════════════════════════════════════════════════════════
echo   ИНСТРУКЦИЯ:
echo ══════════════════════════════════════════════════════════════
echo.
echo   1. Создайте репозиторий на GitHub:
echo      - Откройте https://github.com/new
echo      - Введите имя репозитория (например: my-bots)
echo      - Нажмите "Create repository"
echo.
echo   2. Скопируйте URL репозитория (например):
echo      https://github.com/username/my-bots.git
echo.
echo ══════════════════════════════════════════════════════════════
echo.

set /p REPO_URL="Введите URL вашего GitHub репозитория: "

if "%REPO_URL%"=="" (
    echo ❌ URL не указан!
    pause
    exit /b 1
)

echo.
echo 📦 Инициализация Git репозитория...
git init

echo.
echo 📝 Добавление файлов...
git add .

echo.
echo 💾 Создание коммита...
git commit -m "Initial commit: Python bots with cloud hosting support"

echo.
echo 🔗 Подключение к GitHub...
git remote add origin %REPO_URL%

echo.
echo 📤 Загрузка на GitHub...
git branch -M main
git push -u origin main

echo.
echo ✅ Проект загружен на GitHub!
echo.
echo 🚂 Теперь можно задеплоить на Railway:
echo    1. Откройте https://railway.app
echo    2. "Start a New Project" → "Deploy from GitHub repo"
echo    3. Выберите ваш репозиторий
echo    4. Railway автоматически задеплоит ботов!
echo.

pause

