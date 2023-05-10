#!/bin/bash

# перевірка на наявність бібліотеки ffmpeg
if ! command -v ffmpeg &> /dev/null
then
    echo "Бібліотека ffmpeg не знайденo. Будь ласка, встановіть її перед виконанням цього скрипту."
    exit
fi

echo "Оберіть опцію обробки файлу: "
echo "1 - Kонвертувати файли для оптимальної інтернет трансляції[значне навантаження на систему]"
echo "2 - Використати вхідний відео - та аудіо-кодек, без перекодування[мале навантаження на систему]"
read option

if [[ "$option" == "1" ]]; then
    for file in *.mp4; do
        echo "Конвертація в HLS файлу - $file"
        name="${file%.*}"
        mkdir "$name"
        ffmpeg -i "$file" -codec: copy -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./$name/index.m3u8"
    done
elif [[ "$option" == "2" ]]; then
    for file in *.mp4; do
        echo "Нарізка в HLS файлу - $file"
        name="${file%.*}"
        mkdir "$name"
        ffmpeg -i "$file" -c copy -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./$name/index.m3u8"
    done
else
    echo "Некоректна опція"
    exit
fi

echo "Обробка файлів завершена"
