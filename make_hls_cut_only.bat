for  %%i in (*.mp4) do (  
   echo Нарізка в HLS файлу %%i 
   echo  %%~ni
   md %%~ni
  ffmpeg -i %%i -codec: copy -start_number 0 -hls_time 10 -hls_list_size 0 -f hls ./%%~ni/index.m3u8
  
)
