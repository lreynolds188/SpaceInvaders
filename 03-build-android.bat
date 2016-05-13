@ECHO OFF
set ORG=%CD%
cd ..\env
call 00-var.bat
cd %ORG%

rem for %%* in (.) do SET pkg=%%~n*
SET pkg=%ORG%\builds\game.love
SET assets=%LOVE_ANDROID%\assets\game.love
SET dbg=%LOVE_ANDROID%\bin\love_android_sdl2-debug.apk

copy /Y %pkg% %assets%
cd %LOVE_ANDROID%
call ant debug
copy /Y %dbg% %ORG%\builds\debug.apk
pause
