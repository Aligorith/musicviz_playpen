@REM ffmpeg -y -i 20230803-v02.flac -filter_complex "[0:a]showcqt=s=500x1920:axis=0:cscheme=0.6|0.7|0.1|0.1|0.8|0.5,crop=500:1392:0:4000,setsar=1,transpose=2[vcqt]; [0:a]showwaves=mode=cline[vs]; [vcqt][vs]vstack[v]" -map "[v]" -map "0:a" -c:a mp3 "mv_20230803.mp4"

@ffmpeg -y -i 20230803-v02.flac -filter_complex "[0:a]showwaves=mode=cline[v]" -map "[v]" -map "0:a" -c:a mp3 "mv_20230803.mp4"


ffmpeg -y -i %1 -filter_complex "[0:a]showcqt=s=500x1920:axis=0:cscheme=0.6|0.7|0.1|0.1|0.8|0.5,crop=500:1392:0:4000,setsar=1,transpose=2,hflip[vcqt]; [0:a]showwaves=mode=cline:s=1920x100[vs]; [vcqt][vs]overlay=y=H-100[v]" -map "[v]" -map "0:a" -c:a aac "mv_%1.mp4"

@REM ffmpeg -y -i %1 -filter_complex "[0:a]showcqt=s=500x1920:axis=0:cscheme=0.3|0.01|0.01|0.1|0.01|0.0,crop=500:1392:0:4000,setsar=1,transpose=2[vcqt]; [0:a]showwaves=mode=cline:s=1920x100[vs]; [vcqt][vs]overlay=y=H-100[v]" -map "[v]" -map "0:a" -c:a aac "mv_%1.mp4"


@REM ffmpeg -y -i %1 -filter_complex "[0:a]showcqt=s=500x1920:axis=0,crop=500:1392:0:4000,setsar=1,transpose=2[vcqt]; [0:a]showwaves=mode=cline:s=1920x100[vs]; [vcqt][vs]overlay=y=H-100[v]" -map "[v]" -map "0:a" -c:a aac "mv_%1.mp4"