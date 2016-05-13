@ECHO OFF
set ORG=%CD%
cd ..\env
call 00-var.bat
cd %ORG%
%LOVE%\love.exe --console "%CD%"
