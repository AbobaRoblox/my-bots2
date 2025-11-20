# 📚 Примеры использования

В этой папке находятся примеры для различных сценариев использования ботов.

## 🤖 Примеры

### 1. Telegram Bot (`telegram_bot_example.py`)

Пример бота для Telegram с обработкой команд и сообщений.

**Установка зависимостей:**
```bash
pip install python-telegram-bot
```

**Использование:**
1. Создайте бота через [@BotFather](https://t.me/botfather)
2. Получите токен
3. Создайте `telegram_config.json`:
```json
{
    "telegram_token": "YOUR_BOT_TOKEN",
    "admin_ids": [123456789],
    "debug": false
}
```
4. Запустите: `python telegram_bot_example.py`

**Функции:**
- Обработка команд `/start`, `/help`, `/status`
- Обработка текстовых сообщений
- Логирование всех действий
- Graceful shutdown

---

### 2. API Request Bot (`api_request_example.py`)

Пример бота для работы с REST API.

**Установка зависимостей:**
```bash
pip install requests
```

**Использование:**
1. Создайте `api_config.json`:
```json
{
    "api_url": "https://api.example.com/data",
    "api_key": "your_api_key",
    "check_interval": 60,
    "timeout": 10,
    "max_retries": 3,
    "debug": false
}
```
2. Запустите: `python api_request_example.py`

**Функции:**
- HTTP запросы с повторными попытками
- Обработка таймаутов и ошибок
- Настраиваемый интервал проверки
- Логирование всех запросов

---

## 🔧 Как использовать примеры

### Вариант 1: Замена существующего кода

Скопируйте содержимое примера в `bot.py` или `shopbot.py`:

```bash
cp examples/telegram_bot_example.py bot.py
```

### Вариант 2: Создание нового бота

1. Скопируйте пример:
```bash
cp examples/api_request_example.py my_custom_bot.py
```

2. Добавьте в `supervisord.conf`:
```ini
[program:custom_bot]
command=python -u /app/my_custom_bot.py
directory=/app
autostart=true
autorestart=true
stderr_logfile=/app/logs/custom_bot_error.log
stdout_logfile=/app/logs/custom_bot_output.log
```

3. Обновите `docker-compose.yml` если нужно

---

## 💡 Дополнительные примеры

### Web Scraping

```python
# pip install beautifulsoup4 requests

import requests
from bs4 import BeautifulSoup

def scrape_website(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Парсинг данных
    titles = soup.find_all('h1')
    for title in titles:
        print(title.text)
```

### Database Integration

```python
# pip install psycopg2-binary  # для PostgreSQL
# pip install pymongo  # для MongoDB

import psycopg2

def save_to_database(data):
    conn = psycopg2.connect(
        host="localhost",
        database="mydb",
        user="user",
        password="password"
    )
    cur = conn.cursor()
    cur.execute("INSERT INTO table (column) VALUES (%s)", (data,))
    conn.commit()
    cur.close()
    conn.close()
```

### Отправка Email

```python
# pip install smtplib

import smtplib
from email.mime.text import MIMEText

def send_email(subject, body, to_email):
    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = 'your@email.com'
    msg['To'] = to_email
    
    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login('your@email.com', 'password')
        server.send_message(msg)
```

---

## 📖 Полезные библиотеки

### Web & API
- `requests` - HTTP запросы
- `aiohttp` - асинхронные HTTP запросы
- `httpx` - современные HTTP запросы

### Telegram
- `python-telegram-bot` - Telegram Bot API
- `aiogram` - асинхронный Telegram фреймворк
- `telethon` - Telegram Client API

### Парсинг
- `beautifulsoup4` - парсинг HTML/XML
- `lxml` - быстрый парсинг
- `scrapy` - фреймворк для веб-скрейпинга

### Базы данных
- `psycopg2` - PostgreSQL
- `pymongo` - MongoDB
- `redis` - Redis
- `sqlalchemy` - ORM для SQL баз

### Автоматизация браузера
- `selenium` - управление браузером
- `playwright` - современная автоматизация
- `pyppeteer` - Chrome DevTools Protocol

---

## 🚀 Шаблон для вашего бота

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import sys
import logging
from datetime import datetime
from pathlib import Path
import json

# Настройка
BASE_DIR = Path(__file__).resolve().parent
LOG_DIR = BASE_DIR / "logs"
CONFIG_FILE = BASE_DIR / "my_config.json"

LOG_DIR.mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(
            LOG_DIR / f"my_bot_{datetime.now().strftime('%Y%m%d')}.log",
            encoding='utf-8'
        ),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger("MyBot")


def load_config():
    """Загрузка конфигурации"""
    default_config = {
        "check_interval": 60,
        "debug": False
    }
    
    if CONFIG_FILE.exists():
        with open(CONFIG_FILE, 'r', encoding='utf-8') as f:
            return {**default_config, **json.load(f)}
    
    with open(CONFIG_FILE, 'w', encoding='utf-8') as f:
        json.dump(default_config, f, indent=4, ensure_ascii=False)
    
    return default_config


def do_work(config):
    """Ваша логика здесь"""
    logger.info("Выполняется работа...")
    
    # ВАШ КОД
    
    return True


def main():
    logger.info("=" * 50)
    logger.info("MyBot запускается...")
    logger.info("=" * 50)
    
    config = load_config()
    
    iteration = 0
    try:
        while True:
            iteration += 1
            logger.info(f"Итерация #{iteration}")
            
            success = do_work(config)
            
            if success:
                logger.info("✅ Успешно")
            else:
                logger.warning("⚠️ С ошибками")
            
            time.sleep(config["check_interval"])
            
    except KeyboardInterrupt:
        logger.info("Остановка...")
    finally:
        logger.info("Завершено")
        sys.exit(0)


if __name__ == "__main__":
    main()
```

---

**Удачи в разработке! 🎉**

