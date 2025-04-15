#!/bin/sh

# Проверка наличия одного аргумента (URL файла)
if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <URL файла>"
    exit 1
fi

FILE_URL="$1"
# Сохраним файл в /tmp под именем, взятым из URL
FILE_PATH="/tmp/$(basename "$FILE_URL")"

echo "Скачивание файла из $FILE_URL..."

# Скачиваем файл с помощью curl
curl -s -o "$FILE_PATH" "$FILE_URL"
if [ "$?" -ne 0 ]; then
    echo "Ошибка: не удалось скачать файл из $FILE_URL"
    exit 1
fi

echo "Файл успешно скачан: $FILE_PATH"

echo "Выполнение команды kvas import..."
kvas import "$FILE_PATH"
if [ "$?" -ne 0 ]; then
    echo "Ошибка: команда kvas import завершилась с ошибкой."
    exit 1
fi

echo "Команда kvas import выполнена успешно."