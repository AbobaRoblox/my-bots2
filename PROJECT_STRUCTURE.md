# 📂 Структура проекта

```
📦 гайд/
│
├── 🤖 БОТЫ (Основные файлы)
│   ├── bot.py                      # Основной бот с улучшениями
│   └── shopbot.py                  # Бот для магазина с улучшениями
│
├── 🪟 WINDOWS АВТОЗАПУСК
│   ├── start_bot.vbs               # VBS для скрытого запуска bot.py
│   ├── start_shopbot.vbs           # VBS для скрытого запуска shopbot.py
│   ├── add_to_startup.bat          # Добавить в автозагрузку Windows
│   └── remove_from_startup.bat     # Удалить из автозагрузки Windows
│
├── 🐳 DOCKER ХОСТИНГ
│   ├── Dockerfile                  # Docker образ для обоих ботов
│   ├── docker-compose.yml          # Конфигурация Docker Compose
│   ├── supervisord.conf            # Supervisor для управления процессами
│   ├── start_hosting.sh            # Запуск на Linux/Mac
│   ├── start_hosting.bat           # Запуск на Windows
│   ├── stop_hosting.sh             # Остановка на Linux/Mac
│   ├── stop_hosting.bat            # Остановка на Windows
│   └── Makefile                    # Makefile для удобного управления
│
├── ⚙️ КОНФИГУРАЦИЯ
│   ├── config.json                 # Настройки bot.py (создается автоматически)
│   ├── shopbot_config.json         # Настройки shopbot.py (создается автоматически)
│   └── requirements.txt            # Python зависимости
│
├── 📚 ДОКУМЕНТАЦИЯ
│   ├── README.md                   # Полная документация (главный файл)
│   ├── QUICKSTART.md               # Быстрый старт
│   ├── HOSTING.md                  # Руководство по хостингу
│   ├── PROJECT_STRUCTURE.md        # Этот файл
│   └── .gitignore                  # Игнорируемые файлы для Git
│
├── 💡 ПРИМЕРЫ (examples/)
│   ├── telegram_bot_example.py     # Пример Telegram бота
│   ├── api_request_example.py      # Пример работы с API
│   └── README.md                   # Документация по примерам
│
└── 📊 ЛОГИ (logs/) - создается автоматически
    ├── bot_YYYYMMDD.log           # Логи bot.py
    ├── shopbot_YYYYMMDD.log       # Логи shopbot.py
    ├── bot_error.log              # Ошибки bot.py (Docker)
    ├── bot_output.log             # Вывод bot.py (Docker)
    ├── shopbot_error.log          # Ошибки shopbot.py (Docker)
    └── shopbot_output.log         # Вывод shopbot.py (Docker)
```

---

## 📖 Быстрая навигация

### 🚀 Для начала работы
1. **Локально на Windows**: `add_to_startup.bat`
2. **На хостинге**: `start_hosting.bat` или `start_hosting.sh`
3. **Быстрый старт**: смотрите `QUICKSTART.md`

### 📚 Документация
- **Основная**: `README.md` - полная документация со всеми деталями
- **Быстрый старт**: `QUICKSTART.md` - минимальная инструкция
- **Хостинг**: `HOSTING.md` - подробно про различные хостинги
- **Примеры**: `examples/README.md` - готовые примеры кода

### 🛠️ Настройка
- **bot.py**: редактируйте `config.json`
- **shopbot.py**: редактируйте `shopbot_config.json`
- **Зависимости**: добавляйте в `requirements.txt`

### 🐳 Docker команды
```bash
# Простые
make up          # Запуск
make down        # Остановка
make logs-follow # Логи

# Или через скрипты
./start_hosting.sh   # Linux/Mac
start_hosting.bat    # Windows
```

---

## 🎯 Что где находится?

### Хочу запустить локально на Windows
→ `add_to_startup.bat`

### Хочу запустить на хостинге/сервере
→ `start_hosting.sh` или `start_hosting.bat`

### Хочу посмотреть логи
→ папка `logs/`

### Хочу изменить настройки
→ `config.json` или `shopbot_config.json`

### Хочу примеры кода
→ папка `examples/`

### Хочу узнать как работать с разными хостингами
→ `HOSTING.md`

### Хочу быстро начать
→ `QUICKSTART.md`

---

## 📝 Примечания

- ✅ Все конфигурационные файлы создаются автоматически при первом запуске
- ✅ Логи ротируются по дням (новый файл каждый день)
- ✅ Docker контейнер запускает оба бота одновременно
- ✅ Supervisor автоматически перезапускает упавшие процессы
- ✅ Все скрипты работают как на Windows, так и на Linux/Mac

---

## 🔥 Улучшения в боте

### Было (старая версия):
```python
import time
print("Bot запущен")
while True:
    time.sleep(60)
```

### Стало (новая версия):
```python
✅ Логирование в файлы
✅ Обработка ошибок
✅ Конфигурационные файлы
✅ Graceful shutdown
✅ Повторные попытки при ошибках
✅ Мониторинг итераций
✅ Debug режим
✅ Автоматический перезапуск
```

---

**Проект готов к использованию! 🎉**

