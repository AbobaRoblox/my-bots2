@echo off
chcp 65001 >nul
echo Добавление скриптов в автозагрузку...

set "SCRIPT_DIR=%~dp0"
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

echo Копирование start_bot.vbs в автозагрузку...
copy "%SCRIPT_DIR%start_bot.vbs" "%STARTUP_FOLDER%\start_bot.vbs" >nul

echo Копирование start_shopbot.vbs в автозагрузку...
copy "%SCRIPT_DIR%start_shopbot.vbs" "%STARTUP_FOLDER%\start_shopbot.vbs" >nul

echo.
echo Готово! Скрипты добавлены в автозагрузку.
echo Они будут запускаться при каждом входе в систему скрыто.
echo.
pause

