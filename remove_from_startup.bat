@echo off
chcp 65001 >nul
echo Удаление скриптов из автозагрузки...

set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

if exist "%STARTUP_FOLDER%\start_bot.vbs" (
    del "%STARTUP_FOLDER%\start_bot.vbs"
    echo start_bot.vbs удален из автозагрузки
)

if exist "%STARTUP_FOLDER%\start_shopbot.vbs" (
    del "%STARTUP_FOLDER%\start_shopbot.vbs"
    echo start_shopbot.vbs удален из автозагрузки
)

echo.
echo Готово! Скрипты удалены из автозагрузки.
echo.
pause

