@echo off
set _input=
set /p _input=Your computer will now restart, are you sure? [Y/N]

if [%_input%]==[Y] reboot.bat
if [%_input%]==[y] reboot.bat
if [%_input%]==[N] goto cancelExit
if [%_input%]==[n] goto cancelExit
goto cancelExit

:cancelExit
echo Exit cancelled!
echo.
goto end

:end