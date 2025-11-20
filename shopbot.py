#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
ShopBot - автоматически запускается при старте системы
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
CONFIG_FILE = BASE_DIR / "shopbot_config.json"

# Создаём директорию для логов
LOG_DIR.mkdir(exist_ok=True)

# Настройка логирования
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / f"shopbot_{datetime.now().strftime('%Y%m%d')}.log", encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("ShopBot")


def load_config():
    """Загрузка конфигурации из файла"""
    default_config = {
        "check_interval": 60,
        "bot_name": "ShopBot",
        "debug": False,
        "shop_url": "https://example.com",
        "max_retries": 3
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


def do_work(config):
    """Выполнение основной работы shopbot"""
    try:
        # Здесь будет ваша логика shopbot
        logger.info("Выполняется работа shopbot...")
        
        # Пример: можете добавить свою логику здесь
        # Например, проверка магазина, отслеживание товаров и т.д.
        shop_url = config.get("shop_url", "https://example.com")
        logger.debug(f"Проверка магазина: {shop_url}")
        
        # Пример работы с повторными попытками
        max_retries = config.get("max_retries", 3)
        for attempt in range(max_retries):
            try:
                # Ваша логика работы с магазином
                logger.debug(f"Попытка {attempt + 1}/{max_retries}")
                break
            except Exception as e:
                if attempt < max_retries - 1:
                    logger.warning(f"Ошибка при попытке {attempt + 1}: {e}. Повтор...")
                    time.sleep(5)
                else:
                    raise
        
        return True
    except Exception as e:
        logger.error(f"Ошибка при выполнении работы: {e}", exc_info=True)
        return False


def main():
    """Основная функция shopbot"""
    logger.info("=" * 50)
    logger.info("ShopBot запускается...")
    logger.info("=" * 50)
    
    # Загружаем конфигурацию
    config = load_config()
    check_interval = config.get("check_interval", 60)
    
    if config.get("debug"):
        logger.setLevel(logging.DEBUG)
        logger.debug("Режим отладки включен")
    
    logger.info(f"Интервал проверки: {check_interval} секунд")
    logger.info(f"URL магазина: {config.get('shop_url')}")
    
    # Основной цикл работы
    iteration = 0
    try:
        while True:
            iteration += 1
            logger.info(f"Итерация #{iteration}")
            
            # Выполняем работу
            success = do_work(config)
            
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
        logger.info("ShopBot остановлен")
        logger.info("=" * 50)
        sys.exit(0)


if __name__ == "__main__":
    main()

