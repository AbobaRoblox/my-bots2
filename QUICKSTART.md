# ⚡ Быстрый старт

## 🖥️ Для Windows (локально)

```bash
# 1. Добавить в автозагрузку (от имени администратора)
add_to_startup.bat

# Готово! Боты будут запускаться автоматически
```

---

## 🐳 Для хостинга (Docker)

### Linux/Mac
```bash
chmod +x start_hosting.sh
./start_hosting.sh
```

### Windows
```bash
start_hosting.bat
```

### Или используйте Make
```bash
make up
```

---

## 📊 Управление

```bash
# Просмотр логов
docker-compose logs -f

# Остановка
docker-compose down

# Перезапуск
docker-compose restart

# Статус
docker-compose ps
```

---

## ⚙️ Настройка

Отредактируйте конфигурационные файлы:

**config.json** (для bot.py):
```json
{
    "check_interval": 60,
    "bot_name": "Bot",
    "debug": false
}
```

**shopbot_config.json** (для shopbot.py):
```json
{
    "check_interval": 60,
    "bot_name": "ShopBot",
    "debug": false,
    "shop_url": "https://example.com",
    "max_retries": 3
}
```

---

## 📁 Структура проекта

```
📂 проект/
├── 🐍 bot.py              # Основной бот
├── 🐍 shopbot.py          # Бот для магазина
├── 🐳 Dockerfile          # Docker образ
├── 🐳 docker-compose.yml  # Конфигурация Docker
├── ⚙️  supervisord.conf    # Управление процессами
├── 📝 config.json         # Настройки bot.py
├── 📝 shopbot_config.json # Настройки shopbot.py
├── 📦 requirements.txt    # Python зависимости
├── 📂 logs/               # Логи обоих ботов
└── 📖 README.md           # Полная документация
```

---

## 🔥 Добавьте свой код

### В bot.py

Найдите функцию `do_work()`:

```python
def do_work():
    """Выполнение основной работы бота"""
    try:
        logger.info("Выполняется работа бота...")
        
        # 👇 ВАШ КОД ЗДЕСЬ 👇
        # Например:
        # result = requests.get("https://api.example.com")
        # data = result.json()
        # process_data(data)
        
        return True
    except Exception as e:
        logger.error(f"Ошибка: {e}", exc_info=True)
        return False
```

То же самое для `shopbot.py`!

---

## 🆘 Проблемы?

1. **Проверьте логи**: `./logs/`
2. **Включите debug**: `"debug": true` в config.json
3. **Запустите вручную**: `python bot.py`

---

**Готово!** 🎉

Для подробной информации смотрите [README.md](README.md) и [HOSTING.md](HOSTING.md)

