#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Пример интеграции с Telegram ботом
Замените содержимое bot.py или shopbot.py этим кодом
"""

import time
import sys
import logging
import os
from datetime import datetime
from pathlib import Path
import json

# Установите: pip install python-telegram-bot
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, filters, ContextTypes

# Настройка путей
BASE_DIR = Path(__file__).resolve().parent
LOG_DIR = BASE_DIR / "logs"
CONFIG_FILE = BASE_DIR / "telegram_config.json"

# Создаём директорию для логов
LOG_DIR.mkdir(exist_ok=True)

# Настройка логирования
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / f"telegram_bot_{datetime.now().strftime('%Y%m%d')}.log", encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("TelegramBot")


def load_config():
    """Загрузка конфигурации"""
    default_config = {
        "telegram_token": "YOUR_TELEGRAM_BOT_TOKEN",
        "admin_ids": [],  # ID администраторов
        "debug": False
    }
    
    if CONFIG_FILE.exists():
        try:
            with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
                config = json.load(f)
                logger.info("Конфигурация загружена")
                return {**default_config, **config}
        except Exception as e:
            logger.error(f"Ошибка загрузки конфигурации: {e}")
    
    with open(CONFIG_FILE, 'w', encoding='utf-8') as f:
        json.dump(default_config, f, indent=4, ensure_ascii=False)
    logger.info("Создан файл конфигурации по умолчанию")
    
    return default_config


async def start_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Обработчик команды /start"""
    await update.message.reply_text(
        "👋 Привет! Я бот.\n\n"
        "Доступные команды:\n"
        "/start - начать работу\n"
        "/help - помощь\n"
        "/status - статус бота"
    )
    logger.info(f"Пользователь {update.effective_user.id} запустил бота")


async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Обработчик команды /help"""
    await update.message.reply_text(
        "📖 Помощь:\n\n"
        "Просто отправьте мне сообщение, и я отвечу!"
    )


async def status_command(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Обработчик команды /status"""
    await update.message.reply_text(
        "✅ Бот работает нормально!\n"
        f"🕐 Время: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    )


async def message_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Обработчик текстовых сообщений"""
    user_message = update.message.text
    user_id = update.effective_user.id
    
    logger.info(f"Получено сообщение от {user_id}: {user_message}")
    
    # Ваша логика обработки сообщений
    response = f"Вы написали: {user_message}"
    
    await update.message.reply_text(response)


async def error_handler(update: Update, context: ContextTypes.DEFAULT_TYPE):
    """Обработчик ошибок"""
    logger.error(f"Ошибка: {context.error}", exc_info=context.error)


def main():
    """Основная функция"""
    logger.info("=" * 50)
    logger.info("Telegram Bot запускается...")
    logger.info("=" * 50)
    
    # Загружаем конфигурацию
    config = load_config()
    token = config.get("telegram_token")
    
    if token == "YOUR_TELEGRAM_BOT_TOKEN":
        logger.error("❌ Укажите токен бота в telegram_config.json!")
        sys.exit(1)
    
    if config.get("debug"):
        logger.setLevel(logging.DEBUG)
    
    try:
        # Создаём приложение
        application = ApplicationBuilder().token(token).build()
        
        # Регистрируем обработчики
        application.add_handler(CommandHandler("start", start_command))
        application.add_handler(CommandHandler("help", help_command))
        application.add_handler(CommandHandler("status", status_command))
        application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, message_handler))
        application.add_error_handler(error_handler)
        
        logger.info("✅ Бот запущен и готов к работе!")
        
        # Запускаем бота
        application.run_polling(allowed_updates=Update.ALL_TYPES)
        
    except KeyboardInterrupt:
        logger.info("Получен сигнал остановки")
    except Exception as e:
        logger.error(f"Критическая ошибка: {e}", exc_info=True)
        sys.exit(1)
    finally:
        logger.info("Telegram Bot остановлен")
        logger.info("=" * 50)


if __name__ == "__main__":
    main()

