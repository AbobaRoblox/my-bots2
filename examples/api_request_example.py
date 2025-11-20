#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Пример работы с API и веб-запросами
Замените содержимое bot.py или shopbot.py этим кодом
"""

import time
import sys
import logging
from datetime import datetime
from pathlib import Path
import json

# Установите: pip install requests
import requests

# Настройка путей
BASE_DIR = Path(__file__).resolve().parent
LOG_DIR = BASE_DIR / "logs"
CONFIG_FILE = BASE_DIR / "api_config.json"

LOG_DIR.mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(LOG_DIR / f"api_bot_{datetime.now().strftime('%Y%m%d')}.log", encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("APIBot")


def load_config():
    """Загрузка конфигурации"""
    default_config = {
        "api_url": "https://api.example.com",
        "api_key": "YOUR_API_KEY",
        "check_interval": 60,
        "timeout": 10,
        "max_retries": 3,
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
    logger.info("Создан файл конфигурации")
    
    return default_config


def make_api_request(url, api_key, timeout=10):
    """Выполнение API запроса"""
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "User-Agent": "Python Bot/1.0"
    }
    
    try:
        response = requests.get(url, headers=headers, timeout=timeout)
        response.raise_for_status()  # Вызовет ошибку для кодов 4xx и 5xx
        
        data = response.json()
        logger.info(f"API запрос успешен: {response.status_code}")
        return data
        
    except requests.exceptions.Timeout:
        logger.error(f"Таймаут при запросе к {url}")
        raise
    except requests.exceptions.ConnectionError:
        logger.error(f"Ошибка соединения с {url}")
        raise
    except requests.exceptions.HTTPError as e:
        logger.error(f"HTTP ошибка: {e}")
        raise
    except Exception as e:
        logger.error(f"Неизвестная ошибка при запросе: {e}")
        raise


def process_data(data):
    """Обработка полученных данных"""
    logger.info("Обработка данных...")
    
    # Ваша логика обработки
    # Например:
    # - Сохранение в базу данных
    # - Отправка уведомлений
    # - Анализ данных
    
    logger.debug(f"Получено записей: {len(data) if isinstance(data, list) else 1}")
    return True


def do_work(config):
    """Основная работа бота"""
    api_url = config.get("api_url")
    api_key = config.get("api_key")
    timeout = config.get("timeout", 10)
    max_retries = config.get("max_retries", 3)
    
    if api_key == "YOUR_API_KEY":
        logger.warning("⚠️ Используется дефолтный API ключ!")
    
    # Попытки с повторами
    for attempt in range(1, max_retries + 1):
        try:
            logger.info(f"Попытка {attempt}/{max_retries}")
            
            # Выполняем запрос
            data = make_api_request(api_url, api_key, timeout)
            
            # Обрабатываем данные
            process_data(data)
            
            logger.info("✅ Работа выполнена успешно")
            return True
            
        except Exception as e:
            logger.error(f"❌ Ошибка на попытке {attempt}: {e}")
            
            if attempt < max_retries:
                wait_time = 5 * attempt  # Увеличиваем время ожидания
                logger.info(f"⏳ Ожидание {wait_time} секунд перед повтором...")
                time.sleep(wait_time)
            else:
                logger.error("❌ Все попытки исчерпаны")
                return False
    
    return False


def main():
    """Основная функция"""
    logger.info("=" * 50)
    logger.info("API Bot запускается...")
    logger.info("=" * 50)
    
    config = load_config()
    check_interval = config.get("check_interval", 60)
    
    if config.get("debug"):
        logger.setLevel(logging.DEBUG)
        logger.debug("Режим отладки включен")
    
    logger.info(f"API URL: {config.get('api_url')}")
    logger.info(f"Интервал проверки: {check_interval} секунд")
    
    iteration = 0
    try:
        while True:
            iteration += 1
            logger.info(f"{'='*30} Итерация #{iteration} {'='*30}")
            
            # Выполняем работу
            success = do_work(config)
            
            if success:
                logger.info("✅ Итерация завершена успешно")
            else:
                logger.warning("⚠️ Итерация завершена с ошибками")
            
            # Ждём до следующей итерации
            logger.info(f"⏳ Ожидание {check_interval} секунд...")
            time.sleep(check_interval)
            
    except KeyboardInterrupt:
        logger.info("Получен сигнал остановки (Ctrl+C)")
    except Exception as e:
        logger.error(f"Критическая ошибка: {e}", exc_info=True)
        sys.exit(1)
    finally:
        logger.info("API Bot остановлен")
        logger.info("=" * 50)
        sys.exit(0)


if __name__ == "__main__":
    main()

