#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Bot - автоматически запускается при старте системы
Улучшенная версия с логированием и обработкой ошибок
"""

import time
import sys
import logging
import os
from datetime import datetime
from pathlib import Path
import json

# Настройка путей
BASE_DIR = Path(__file__).resolve().parent
LOG_DIR = BASE_DIR / "logs"
CONFIG_FILE = BASE_DIR / "config.json"

# Создаём директорию для логов
LOG_DIR.mkdir(exist_ok=True)

# Настройка логирования
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / f"bot_{datetime.now().strftime('%Y%m%d')}.log", encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("Bot")


def load_config():
    """Загрузка конфигурации из файла"""
    default_config = {
        "check_interval": 60,
        "bot_name": "Bot",
        "debug": False
    }
    
    if CONFIG_FILE.exists():
        try:
            with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
                config = json.load(f)
                logger.info("Конфигурация загружена из файла")
                return {**default_config, **config}
        except Exception as e:
            logger.error(f"Ошибка при загрузке конфигурации: {e}")
    
    # Создаём файл конфигурации по умолчанию
    with open(CONFIG_FILE, 'w', encoding='utf-8') as f:
        json.dump(default_config, f, indent=4, ensure_ascii=False)
    logger.info("Создан файл конфигурации по умолчанию")
    
    return default_config


def do_work():
    """Выполнение основной работы бота"""
    try:
        # Здесь будет ваша логика бота
        logger.info("Выполняется работа бота...")
        
        # Пример: можете добавить свою логику здесь
        # Например, проверка чего-либо, отправка данных и т.д.
        
        return True
    except Exception as e:
        logger.error(f"Ошибка при выполнении работы: {e}", exc_info=True)
        return False


def main():
    """Основная функция бота"""
    logger.info("=" * 50)
    logger.info("Bot запускается...")
    logger.info("=" * 50)
    
    # Загружаем конфигурацию
    config = load_config()
    check_interval = config.get("check_interval", 60)
    
    if config.get("debug"):
        logger.setLevel(logging.DEBUG)
        logger.debug("Режим отладки включен")
    
    logger.info(f"Интервал проверки: {check_interval} секунд")
    
    # Основной цикл работы
    iteration = 0
    try:
        while True:
            iteration += 1
            logger.info(f"Итерация #{iteration}")
            
            # Выполняем работу
            success = do_work()
            
            if success:
                logger.info("Работа выполнена успешно")
            else:
                logger.warning("Работа выполнена с ошибками")
            
            # Ждём до следующей итерации
            logger.info(f"Ожидание {check_interval} секунд до следующей проверки...")
            time.sleep(check_interval)
            
    except KeyboardInterrupt:
        logger.info("Получен сигнал остановки (KeyboardInterrupt)")
    except Exception as e:
        logger.error(f"Критическая ошибка: {e}", exc_info=True)
        sys.exit(1)
    finally:
        logger.info("Bot остановлен")
        logger.info("=" * 50)
        sys.exit(0)


if __name__ == "__main__":
    main()

