@ECHO OFF
set ORG=%CD%
cd ..\env
call 00-var.bat
cd %ORG%
7za a -tzip builds/game.love * -xr!*.love -xr!*.bat -xr!*.apk -xr!*.ini -xr!*.exe -xr!*.7z -xr!builds\
pause
