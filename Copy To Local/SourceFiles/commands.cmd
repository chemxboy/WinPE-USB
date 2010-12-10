@echo off
cls

echo - Setting Resolution to 1024 x 768 (32bit)...
setres.exe h1024 v768 b32 >nul

echo - Setting BGInfo...
call bginfo.bat

echo - Calling Options Menu...
call menu.bat