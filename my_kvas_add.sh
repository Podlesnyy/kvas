#!/bin/sh

# Проверка наличия одного аргумента
if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <URL>"
    exit 1
fi

URL="$1"

# Скачивание файла и проверка успешности
content=$(curl -s "$URL")
if [ "$?" -ne 0 ]; then
    echo "Ошибка: не удалось скачать файл"
    exit 1
fi

echo "Файл успешно скачан."

# Обработка каждой строки содержимого файла
echo "$content" | while IFS= read -r line; do
    if [ -n "$line" ]; then
        echo "Y" | kvas add "$line"
    fi
done

echo "Все обработано"