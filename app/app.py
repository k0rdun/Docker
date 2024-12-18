from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os

# Создаем объект Flask
app = Flask(__name__)

# Загружаем настройки из переменных окружения
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Инициализируем объект для работы с базой данных и миграциями
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# Импортируем модели
from models import User

@app.route('/')
def index():
    return "!!!!!!!!!!!!!!!!!!!"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

