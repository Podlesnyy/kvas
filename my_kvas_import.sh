#!/bin/sh

# Проверка наличия одного аргумента (URL файла)
if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <URL файла>"
    exit 1
fi

FILE_URL="$1"
FILE_PATH="/tmp/$(basename "$FILE_URL")"

echo "Удаление старого файла: $FILE_PATH"
rm -f "$FILE_PATH"

echo "Скачивание файла из $FILE_URL..."


# Скачивание файла с использованием параметра -f для обработки ошибок HTTP
curl -s -f -o "$FILE_PATH" "$FILE_URL"
if [ "$?" -ne 0 ]; then
    echo "Ошибка: не удалось скачать файл из $FILE_URL"
    exit 1
fi

# Проверка, что файл существует и не пустой
if [ ! -s "$FILE_PATH" ]; then
    echo "Ошибка: файл не найден или пустой: $FILE_PATH"
    exit 1
fi

echo "Файл успешно скачан: $FILE_PATH"
echo "Выполнение команды kvas import..."
kvas import "$FILE_PATH"
if [ "$?" -ne 0 ]; then
    echo "Ошибка: команда kvas import завершилась с ошибкой."
    # Удаляем файл в любом случае
    rm -f "$FILE_PATH"
    exit 1
fi

echo "Команда kvas import выполнена успешно."
echo "Удаление скачанного файла: $FILE_PATH"
rm -f "$FILE_PATH"

echo "Все операции завершены успешно."