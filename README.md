# Руководство по настройке Flutter-окружения и публикации проекта
### Шаг 1: Подготовка инструментов разработки

    Загрузка Flutter SDK
    Перейдите на официальный ресурс Flutter и выберите версию для Windows. Следуйте рекомендациям для новичков ("рекомендованный" вариант установки).

    Интеграция с VS Code
    Если редактор не установлен:

        Скачайте его с сайта Microsoft.

        После установки откройте панель расширений (Ctrl+Shift+X), найдите плагин Flutter и активируйте его.

    Инициализация SDK
    Используйте комбинацию Ctrl+Shift+P → введите Flutter: New Project. Если путь к SDK не обнаружен, согласитесь на автоматическую загрузку недостающих компонентов.

### Шаг 2: Конфигурация системных параметров

    Автоматическая настройка: VS Code обычно добавляет путь к SDK в переменные среды. Для ручной проверки:

        Перейдите:
        Панель управления → Система → Дополнительные параметры → Переменные среды.

        В разделе Path укажите полный путь к папке bin внутри каталога Flutter (например, C:\flutter\bin).

### Шаг 3: Генерация проекта

##### Вариант A: Через терминал

    Откройте встроенный терминал (Ctrl+`).

    Перейдите в целевую директорию:
    cd путь/к/папке

    Выполните:
    flutter create my_app

    Запустите эмулятор клавишей F5.

##### Вариант B: Через интерфейс VS Code

    Вызовите командную палитру (Ctrl+Shift+P).

    Выберите Flutter: New Project → укажите имя и расположение.

    После создания структуры файлов нажмите F5 для запуска.

### Шаг 4: Интеграция с GitHub
##### 4.1 Установка Git

    Скачайте установщик для Windows с официального сайта.

    Запустите инсталлятор, сохраняя параметры по умолчанию.

##### 4.2 Настройка Git

    Откройте Git Bash и выполните:
    git config --global user.name "Ваше Имя"
    git config --global user.email "ваша_почта@example.com"

##### 4.3 Загрузка проекта через Git Bash

    Создайте репозиторий на GitHub:

        Залогиньтесь на github.com.

        Нажмите New в разделе Repositories.

        Укажите название (например, my_app) и нажмите Create repository.

    Инициализируйте Git в проекте:
    # Перейдите в папку проекта
    cd путь/к/вашему/проекту

    # Инициализация репозитория
    git init

    # Добавьте все файлы проекта
    git add .

    # Создайте первый коммит
    git commit -m "Initial commit"

    Привяжите удаленный репозиторий:
    git remote add origin https://github.com/ваш_логин/название_репозитория.git

    Загрузите код на GitHub:
    git push -u origin main

    Проверка статуса

    Чтобы убедиться, что изменения сохранены:
    git status


# Лабораторная работа 2
https://github.com/Luxurys-Lukuchi/Fllatermob/tree/main/laba2
