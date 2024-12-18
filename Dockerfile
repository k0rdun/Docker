# Используем легковесный базовый образ
FROM python:3.11-alpine

# Устанавливаем зависимости для работы с PostgreSQL
RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir flask psycopg2-binary flask-migrate \
    && apk del .build-deps

# Создаем и настраиваем рабочую директорию
WORKDIR /app

# Копируем все необходимые файлы приложения в контейнер
COPY . /app

# Устанавливаем переменные окружения
ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV DATABASE_URL=postgresql://user:password@db:5432/mydb

# Создаем непривилегированного пользователя
RUN adduser -D flaskuser
USER flaskuser

# Открываем порт для приложения
EXPOSE 5000

# Запуск приложения
CMD ["sh", "-c", "flask db upgrade && flask run --host=0.0.0.0"]
