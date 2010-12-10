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
echo.
echo  [3] - Do an automated ImageX deployment [*NOT IMPLEMENTED YET*]
echo  [4] - Do an automated ImageX capture    [*NOT IMPLEMENTED YET*]
echo.
echo  [5] - Duplicate this USB key
echo.
echo  [6] - Help!                             [*NOT IMPLEMENTED YET*] 
echo  [7] - Exit
echo.
echo.
choice.exe /c:1234567 /n /t:7,10 "Choose from the above options [Default: 7]: "
echo.

if %errorlevel%==1 goto CHOICE_1 
if %errorlevel%==2 goto CHOICE_2 
if %errorlevel%==3 goto CHOICE_3
if %errorlevel%==4 goto CHOICE_4
if %errorlevel%==5 goto CHOICE_5
if %errorlevel%==6 goto CHOICE_6
if %errorlevel%==7 goto CHOICE_7
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
echo [*NOT IMPLEMENTED YET*]
goto finish 

:CHOICE_4
echo.
echo Option Selected: 4 
echo [*NOT IMPLEMENTED YET*]
goto finish 

:CHOICE_5
echo.
echo Option Selected: 5
call Make-WinPE-USB-Clone.cmd
echo.
echo Press any key to return to Main Options Menu . . .
pause >nul
goto start

:CHOICE_6
echo.
echo Option Selected: 6
echo [*NOT IMPLEMENTED YET*] - Call Neil if you must :P
goto finish 

:CHOICE_7 
echo.
echo Option Selected: 7
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