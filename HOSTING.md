# 🌐 Руководство по размещению на хостинге

Подробное руководство по размещению ботов на различных хостингах.

---

## 📋 Оглавление

1. [VPS/Dedicated сервер](#vpsdedicated-сервер)
2. [Heroku](#heroku)
3. [Railway](#railway)
4. [DigitalOcean](#digitalocean)
5. [AWS EC2](#aws-ec2)
6. [Бесплатные варианты](#бесплатные-варианты)

---

## 1. VPS/Dedicated сервер

### Подходит для:
- Ubuntu, Debian, CentOS
- Любой VPS провайдер (Timeweb, REG.RU, Beget и др.)

### Установка

```bash
# 1. Подключитесь к серверу
ssh user@your-server-ip

# 2. Установите Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 3. Установите Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 4. Клонируйте проект
git clone <ваш-репозиторий>
cd <папка-проекта>

# 5. Настройте конфигурацию
nano config.json
nano shopbot_config.json

# 6. Запустите
chmod +x start_hosting.sh
./start_hosting.sh
```

### Автозапуск при перезагрузке

```bash
# Создайте systemd service
sudo nano /etc/systemd/system/bots.service
```

Содержимое файла:
```ini
[Unit]
Description=Python Bots
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/path/to/your/project
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
```

Активируйте:
```bash
sudo systemctl enable bots.service
sudo systemctl start bots.service
```

---

## 2. Heroku

⚠️ **Внимание**: Heroku больше не предоставляет бесплатный тарифный план.

### Установка Heroku CLI

```bash
# На Linux/Mac
curl https://cli-assets.heroku.com/install.sh | sh

# На Windows
# Скачайте установщик с https://devcenter.heroku.com/articles/heroku-cli
```

### Создайте файл heroku.yml

```yaml
build:
  docker:
    web: Dockerfile
```

### Создайте файл Procfile (альтернатива Docker)

```
bot: python bot.py
shopbot: python shopbot.py
```

### Деплой

```bash
# Войдите в Heroku
heroku login

# Создайте приложение
heroku create your-app-name

# Установите buildpack для Docker
heroku stack:set container

# Деплой
git push heroku main

# Запустите worker (не web)
heroku ps:scale bot=1 shopbot=1
```

---

## 3. Railway

🚂 **Railway** - современная платформа с бесплатным тарифом ($5 в месяц бесплатно).

### Через Web интерфейс

1. Зайдите на [railway.app](https://railway.app)
2. Нажмите "New Project"
3. Выберите "Deploy from GitHub repo"
4. Выберите ваш репозиторий
5. Railway автоматически обнаружит Dockerfile
6. Нажмите "Deploy"

### Через CLI

```bash
# Установите Railway CLI
npm i -g @railway/cli

# Войдите
railway login

# Инициализируйте проект
railway init

# Деплой
railway up
```

### Переменные окружения

В веб-интерфейсе Railway:
- Variables → Add Variable
- Добавьте нужные переменные

---

## 4. DigitalOcean

### Droplet (VPS)

1. Создайте Droplet с Docker pre-installed
2. Следуйте инструкциям для [VPS/Dedicated сервера](#vpsdedicated-сервер)

### App Platform

1. Зайдите в App Platform
2. Create App → From GitHub
3. Выберите репозиторий
4. Выберите Dockerfile
5. Deploy

---

## 5. AWS EC2

### Запуск EC2 инстанса

```bash
# 1. Создайте EC2 инстанс (Amazon Linux 2 или Ubuntu)
# 2. Подключитесь по SSH
ssh -i your-key.pem ec2-user@your-instance-ip

# 3. Установите Docker
sudo yum update -y
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# 4. Установите Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 5. Клонируйте и запустите
git clone <your-repo>
cd <project>
docker-compose up -d
```

---

## 6. Бесплатные варианты

### Oracle Cloud (Always Free)

**Преимущества:**
- Бесплатно навсегда
- 2 виртуальные машины
- 1GB RAM каждая

**Установка:**
1. Зарегистрируйтесь на [oracle.com/cloud/free](https://www.oracle.com/cloud/free/)
2. Создайте VM инстанс
3. Следуйте инструкциям для VPS

### Google Cloud Platform (Free Tier)

**Бесплатно:**
- $300 кредитов на 90 дней
- e2-micro инстанс бесплатно

**Установка:**
1. Зарегистрируйтесь на [cloud.google.com](https://cloud.google.com)
2. Создайте Compute Engine VM
3. Следуйте инструкциям для VPS

### Render.com

**Бесплатно:**
- 750 часов в месяц
- Спящий режим после 15 минут бездействия

**Установка:**
1. Зарегистрируйтесь на [render.com](https://render.com)
2. New → Web Service
3. Connect GitHub repository
4. Render автоматически обнаружит Dockerfile
5. Deploy

### Fly.io

**Бесплатно:**
- 3 shared-cpu-1x VM
- 160GB storage

**Установка:**
```bash
# Установите CLI
curl -L https://fly.io/install.sh | sh

# Войдите
fly auth login

# Запустите
fly launch

# Деплой
fly deploy
```

---

## 🔧 Общие настройки

### Переменные окружения

Создайте файл `.env`:
```env
BOT_CHECK_INTERVAL=60
BOT_DEBUG=false
SHOPBOT_CHECK_INTERVAL=60
SHOPBOT_URL=https://example.com
```

В docker-compose.yml:
```yaml
services:
  bots:
    env_file:
      - .env
```

### Мониторинг

Добавьте Healthcheck в Dockerfile:
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import sys; sys.exit(0)"
```

### Логирование

Для сохранения логов на хостинге:
```yaml
services:
  bots:
    volumes:
      - ./logs:/app/logs
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

---

## 🆘 Типичные проблемы

### Контейнер не запускается

```bash
# Проверьте логи
docker-compose logs

# Проверьте ошибки сборки
docker-compose build --no-cache
```

### Недостаточно памяти

В docker-compose.yml:
```yaml
services:
  bots:
    deploy:
      resources:
        limits:
          memory: 256M
```

### Боты падают

Проверьте логи Supervisor:
```bash
docker-compose exec bots cat /var/log/supervisor/supervisord.log
```

---

## 📝 Рекомендации

1. **Используйте .env файлы** для чувствительных данных
2. **Настройте мониторинг** (например, UptimeRobot)
3. **Делайте бэкапы** конфигов и логов
4. **Используйте CI/CD** для автоматического деплоя
5. **Мониторьте ресурсы** (CPU, RAM, диск)

---

## 🔐 Безопасность

1. **Не коммитьте** `.env` файлы и конфиги с паролями
2. **Используйте SSH ключи** вместо паролей
3. **Настройте firewall** на сервере
4. **Обновляйте систему** регулярно
5. **Используйте секреты** для чувствительных данных

```bash
# Добавьте в .gitignore
echo "config.json" >> .gitignore
echo "shopbot_config.json" >> .gitignore
echo ".env" >> .gitignore
```

---

**Готово!** Теперь ваши боты работают на хостинге 24/7! 🎉
