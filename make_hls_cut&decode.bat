for  %%i in (*.mp4) do (  
   echo Нарізка i декодування в HLS файла %%i 
   echo  %%~ni
   md %%~ni
  ffmpeg -i %%i -profile:v baseline -level 3.0  -start_number 0 -hls_time 2 -hls_list_size 0  -f hls ./%%~ni/index.m3u8
  
)
