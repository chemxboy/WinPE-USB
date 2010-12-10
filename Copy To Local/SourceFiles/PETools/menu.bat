@echo off
mode con:cols=90 lines=35
COLOR 1E

:start 
cls
echo.
echo ########################################################
echo #                                                      #
echo #    CAMDEN SCHOOLS IT ENGINEERS WINDOWS PE UTILITY    #
echo #              by Neil Bourne-Harris (CSITS)           #
echo #                                                      #
echo ########################################################
echo.
echo                    MAIN OPTIONS MENU
echo                    -----------------
echo.
echo  Select an option:
echo.
echo  [1] - Launch ImageX GUI
echo  [2] - Launch Ghost GUI
echo  [3] - Duplicate this USB key
echo.
echo  [x] - Exit
echo.
echo.
choice.exe /c:123x /n /t:x,10 "Choose from the above options [Default: x]: "
echo.

if %errorlevel%==1 goto CHOICE_1 
if %errorlevel%==2 goto CHOICE_2 
if %errorlevel%==3 goto CHOICE_3
if %errorlevel%==4 goto CHOICE_x
goto start 
goto error 

:CHOICE_1 
echo.
echo Option Selected: 1
call gimagex.bat
echo.
echo Press any key to return to Main Options Menu . . .
pause >nul
goto start

:CHOICE_2 
echo.
echo Option Selected: 2
call ghost.bat
echo.
echo Press any key to return to Main Options Menu . . .
pause >nul
goto start 

:CHOICE_3
echo.
echo Option Selected: 3
call Make-WinPE-USB-Clone.cmd
echo.
echo Press any key to return to Main Options Menu . . .
pause >nul
goto start


:CHOICE_x 
echo.
echo Option Selected: x
echo You can relaunch the main options menu at any time by typing: "menu"
echo at the command prompt.
goto end 

:error 
echo An error has occured.
goto end 

:finish 
echo.
echo Options Menu Exited!
goto end 

:end