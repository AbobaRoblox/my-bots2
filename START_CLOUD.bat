@echo off
chcp 65001 >nul
REM Мастер настройки облачного хостинга для Windows

echo ╔════════════════════════════════════════════════════════════╗
echo ║                                                            ║
echo ║     ☁️ МАСТЕР НАСТРОЙКИ ОБЛАЧНОГО ХОСТИНГА ☁️             ║
echo ║                                                            ║
echo ║     Боты будут работать 24/7 даже когда ПК выключен       ║
echo ║                                                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

echo 🎯 Что вы получите:
echo.
echo   ✅ Боты работают 24/7 (круглосуточно)
echo   ✅ Работают даже когда компьютер выключен
echo   ✅ Доступны по WiFi/интернету
echo   ✅ Автоматический перезапуск при ошибках
echo   ✅ БЕСПЛАТНО ($5 кредитов каждый месяц)
echo   ✅ Управление через браузер
echo.

echo ══════════════════════════════════════════════════════════════
echo.

echo 📋 ПЛАН ДЕЙСТВИЙ:
echo.
echo   Шаг 1: Создать GitHub аккаунт (если нет)
echo   Шаг 2: Загрузить проект на GitHub
echo   Шаг 3: Подключить Railway.app
echo   Шаг 4: Задеплоить боты
echo   Шаг 5: Готово! Боты в облаке!
echo.

echo ══════════════════════════════════════════════════════════════
echo.

:MENU
echo.
echo 🚀 ВЫБЕРИТЕ ДЕЙСТВИЕ:
echo.
echo   1 - Показать подробную инструкцию
echo   2 - Загрузить проект на GitHub
echo   3 - Открыть Railway.app в браузере
echo   4 - Открыть GitHub в браузере
echo   5 - Показать список файлов для загрузки
echo   6 - Проверить установку Git
echo   0 - Выход
echo.

set /p choice="Введите номер: "

if "%choice%"=="1" goto INSTRUCTION
if "%choice%"=="2" goto GITHUB_UPLOAD
if "%choice%"=="3" goto OPEN_RAILWAY
if "%choice%"=="4" goto OPEN_GITHUB
if "%choice%"=="5" goto SHOW_FILES
if "%choice%"=="6" goto CHECK_GIT
if "%choice%"=="0" goto END

echo ❌ Неверный выбор!
goto MENU

:INSTRUCTION
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║              📖 ПОДРОБНАЯ ИНСТРУКЦИЯ                       ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo ШАГ 1: СОЗДАТЬ GITHUB АККАУНТ
echo ────────────────────────────────
echo   Если у вас нет GitHub:
echo   1. Откройте: https://github.com/signup
echo   2. Зарегистрируйтесь (бесплатно)
echo   3. Подтвердите email
echo.
echo ШАГ 2: ЗАГРУЗИТЬ ПРОЕКТ НА GITHUB
echo ─────────────────────────────────────
echo   Способ 1 (С Git):
echo   1. Запустите опцию "2" в меню
echo   2. Следуйте инструкциям
echo.
echo   Способ 2 (Без Git, через браузер):
echo   1. Откройте: https://github.com/new
echo   2. Создайте репозиторий: my-bots
echo   3. "uploading an existing file"
echo   4. Перетащите все файлы проекта
echo   5. "Commit changes"
echo.
echo ШАГ 3: ПОДКЛЮЧИТЬ RAILWAY
echo ─────────────────────────
echo   1. Откройте: https://railway.app
echo   2. "Login with GitHub"
echo   3. Разрешите доступ
echo.
echo ШАГ 4: ДЕПЛОЙ
echo ─────────────
echo   1. "New Project"
echo   2. "Deploy from GitHub repo"
echo   3. Выберите: my-bots
echo   4. "Deploy Now"
echo   5. Готово! Боты запущены!
echo.
echo ШАГ 5: ПРОВЕРКА
echo ───────────────
echo   1. Railway → Deployments
echo   2. "View Logs"
echo   3. Вы увидите: "Bot запускается..."
echo.
pause
goto MENU

:GITHUB_UPLOAD
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║           📤 ЗАГРУЗКА ПРОЕКТА НА GITHUB                    ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Проверка Git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git не установлен!
    echo.
    echo 📥 Скачайте Git:
    echo    https://git-scm.com/download/win
    echo.
    echo После установки Git перезапустите этот скрипт.
    echo.
    echo ═══════════════════════════════════════════════════════
    echo.
    echo 💡 Альтернатива (БЕЗ Git):
    echo    1. Откройте: https://github.com/new
    echo    2. Создайте репозиторий: my-bots
    echo    3. "uploading an existing file"
    echo    4. Перетащите ВСЕ файлы из этой папки
    echo    5. "Commit changes"
    echo.
    start https://github.com/new
    pause
    goto MENU
)

echo ✅ Git установлен
echo.
echo ═══════════════════════════════════════════════════════════════
echo   ИНСТРУКЦИЯ:
echo ═══════════════════════════════════════════════════════════════
echo.
echo   1. Создайте репозиторий на GitHub:
echo      https://github.com/new
echo.
echo   2. Имя: my-bots (или любое другое)
echo.
echo   3. Скопируйте URL (выглядит так):
echo      https://github.com/username/my-bots.git
echo.
echo ═══════════════════════════════════════════════════════════════
echo.

set /p open_github="Открыть GitHub для создания репозитория? (y/n): "
if /i "%open_github%"=="y" (
    start https://github.com/new
    echo.
    echo ⏳ Дождитесь создания репозитория на GitHub...
    echo.
    pause
)

echo.
set /p REPO_URL="Введите URL вашего репозитория: "

if "%REPO_URL%"=="" (
    echo ❌ URL не указан!
    pause
    goto MENU
)

echo.
echo 📦 Инициализация Git...
git init

echo.
echo 📝 Добавление файлов...
git add .

echo.
echo 💾 Создание коммита...
git commit -m "Initial commit: Cloud-ready Python bots"

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
echo 🎉 Следующий шаг: Деплой на Railway
echo    Выберите опцию "3" в меню
echo.
pause
goto MENU

:OPEN_RAILWAY
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║              🚂 ОТКРЫТИЕ RAILWAY.APP                       ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo 📝 Инструкция для Railway:
echo.
echo   1. Войдите через GitHub (Login with GitHub)
echo   2. Нажмите "New Project"
echo   3. "Deploy from GitHub repo"
echo   4. Выберите репозиторий: my-bots
echo   5. "Deploy Now"
echo   6. Railway автоматически:
echo      ✅ Установит зависимости
echo      ✅ Запустит bot.py
echo      ✅ Запустит shopbot.py
echo   7. Проверьте логи: Deployments → View Logs
echo.
echo 🌐 Открываю Railway.app в браузере...
echo.
start https://railway.app
echo.
echo ✅ Railway открыт в браузере
echo.
pause
goto MENU

:OPEN_GITHUB
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║              🐙 ОТКРЫТИЕ GITHUB                            ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Что делать на GitHub?
echo.
echo   Вариант 1: Создать новый репозиторий
echo   ─────────────────────────────────────
echo     1. https://github.com/new
echo     2. Имя: my-bots
echo     3. "Create repository"
echo.
echo   Вариант 2: Загрузить файлы в существующий
echo   ──────────────────────────────────────────
echo     1. Откройте ваш репозиторий
echo     2. "Add file" → "Upload files"
echo     3. Перетащите все файлы
echo     4. "Commit changes"
echo.
echo 🌐 Открываю GitHub в браузере...
echo.
start https://github.com
echo.
echo ✅ GitHub открыт в браузере
echo.
pause
goto MENU

:SHOW_FILES
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║          📁 СПИСОК ФАЙЛОВ ДЛЯ ЗАГРУЗКИ                     ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo ✅ ОБЯЗАТЕЛЬНЫЕ файлы:
echo    ─────────────────────
echo    📄 bot.py
echo    📄 shopbot.py
echo    📄 requirements.txt
echo    📄 Procfile
echo    📄 runtime.txt
echo.
echo ✅ РЕКОМЕНДУЕМЫЕ файлы:
echo    ────────────────────
echo    📄 config.json (создается автоматически, но можно добавить)
echo    📄 shopbot_config.json (создается автоматически)
echo    📄 railway.json
echo    📄 .python-version
echo.
echo 📂 Папка examples/ - НЕ обязательна
echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo 💡 Совет: Загрузите ВСЕ файлы из этой папки на GitHub
echo    Railway автоматически найдет нужные файлы
echo.
pause
goto MENU

:CHECK_GIT
cls
echo ╔════════════════════════════════════════════════════════════╗
echo ║              🔍 ПРОВЕРКА GIT                               ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git НЕ установлен
    echo.
    echo 📥 Скачайте Git для Windows:
    echo    https://git-scm.com/download/win
    echo.
    echo После установки:
    echo   1. Перезагрузите этот скрипт
    echo   2. Используйте опцию "2" для загрузки на GitHub
    echo.
    set /p open_git="Открыть страницу загрузки Git? (y/n): "
    if /i "%open_git%"=="y" (
        start https://git-scm.com/download/win
    )
) else (
    echo ✅ Git установлен
    echo.
    git --version
    echo.
    echo 🎉 Всё готово для загрузки на GitHub!
    echo    Используйте опцию "2" в меню
)
echo.
pause
goto MENU

:END
echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo 📚 ПОЛЕЗНЫЕ ССЫЛКИ:
echo.
echo   📖 Инструкция:     ОБЛАЧНЫЙ_ХОСТИНГ_ИНСТРУКЦИЯ.txt
echo   📖 Подробно:       CLOUD_HOSTING_FREE.md
echo   🚂 Railway:        https://railway.app
echo   🐙 GitHub:         https://github.com
echo.
echo ══════════════════════════════════════════════════════════════
echo.
echo Спасибо за использование! 🚀
echo.
pause
exit

