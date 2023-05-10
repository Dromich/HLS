@echo off

setlocal EnableDelayedExpansion

rem Check for ffmpeg
set FFMPEG_PATH=%~dp0ffmpeg.exe
if not exist "!FFMPEG_PATH!" (
  echo Error: ffmpeg not found. Please install this library to use the script.
  pause
  exit /b 1
)

echo [1] Convert files, more load on the computer;
echo [2] Use input video and audio codecs without reencoding. Less load on the computer

set /p OPTION=Choose an option (1 or 2): 

if %OPTION% EQU 1 (
  rem Option 1: Convert files

  for %%i in (*.mp4) do (
    echo Converting file -  %%i 
    echo  %%~ni
    md %%~ni
    ffmpeg -i "%%i" -c:v libx264 -c:a aac -b:a 196k -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./%%~ni/index.m3u8"
  )
) else if %OPTION% EQU 2 (
  rem Option 2: Use input video and audio codecs without reencoding
  for %%i in (*.mp4) do (
    echo Processing file without reencoding -   %%i 
    echo  %%~ni
    md %%~ni
    ffmpeg -i "%%i" -codec copy -start_number 0 -hls_time 2 -hls_list_size 0 -f hls "./%%~ni/index.m3u8"
  )
) else (
  echo Error: invalid option.
  pause
  exit /b 1
)

echo Execution completed.
pause
