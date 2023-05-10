@echo off

setlocal EnableDelayedExpansion

rem Перевірка наявності ffmpeg
set FFMPEG_PATH=%~dp0ffmpeg.exe
if not exist "!FFMPEG_PATH!" (
  echo Помилка: ffmpeg не знайдено, дял коректної роботивстановіть цю біблотеку
  pause
  exit /b 1
)

set /p OPTION=Виберіть опцію (1 або 2): 

if %OPTION% EQU 1 (
  rem Опція 1: конвертувати файл
  for %%i in (*.mp4) do (
    echo Конвертування файла -  %%i 
    echo  %%~ni
    md %%~ni
    ffmpeg -i "%%i" -c:v libx264 -c:a aac -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./%%~ni/index.m3u8"
  )
) else if %OPTION% EQU 2 (
  rem Опція 2: використати вхідний відео- та аудіо-кодек без перекодування
  for %%i in (*.mp4) do (
    echo Обробка файлу без перекодування -  %%i 
    echo  %%~ni
    md %%~ni
    ffmpeg -i "%%i" -codec copy -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./%%~ni/index.m3u8"
  )
) else (
  echo Помилка: невірна опція.
  pause
  exit /b 1
)

echo Виконання завершено.
pause
