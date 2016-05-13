@ECHO OFF
set ORG=%CD%
cd ..\env
call 00-var.bat
cd %ORG%

CD %LOVE%
copy /Y %ORG%\builds\game.love %LOVE%
rmdir /s /q make
mkdir make
copy /b love.exe+%ORG%\builds\game.love .\make\game.exe
copy *.dll .\make\*.dll
mkdir %ORG%\builds\exe
copy make %ORG%\builds\exe\
pause
