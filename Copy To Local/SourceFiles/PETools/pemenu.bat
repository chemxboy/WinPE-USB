@echo off
mode con:cols=100 lines=35
COLOR 1E

if [%ltr%]==[] set ltr=z
path=%path%;%ltr%:\PEMenu

:start 
cls
echo.
echo ################################################
echo #                                              #
echo #      Ghost/ImageX Image Restore Menu         #
echo #                                              #
echo ################################################
echo.
echo  Which session name would you like to start?
echo.
echo.
echo  A - HP ProLiant ML 350 G6
echo  B - *empty*
echo  C - *empty*
echo  D - *empty*
echo.
echo  X - Exit
echo.
echo.
choice.exe /c:ABCDX /n /t:X,10 "Make your selection [Default: X] "

if %errorlevel%==1 goto A 
if %errorlevel%==2 goto B 
if %errorlevel%==3 goto C 
if %errorlevel%==4 goto D 
if %errorlevel%==5 goto X 
goto start 
goto error 

:A 
call :DoJob "PEMenu\diskpartcfgs\HPProLiantML350G6.txt" "Images\HPProLiantML350G6" "HPProLiantML350G6.wim" "TRUE"
echo Reloading BGInfo to display volume changes. . .
call bginfo.bat
goto finish 

:B 
echo This is place holder, there are no tasks for this selection!
goto finish 

:C 
echo This is place holder, there are no tasks for this selection!
goto finish 

:D 
echo This is place holder, there are no tasks for this selection!
goto finish 

:X 
echo.
echo You can launch the menu by typing: "pemenu.bat" at the command prompt.
echo or, you can use the GUI for ImageX by typing: "gimagex.bat" at the command prompt.
goto end 

:error 
echo An error has occured.
goto end 

:finish 
echo Job(s) Finished!
goto end 

rem ## =========================== SUBROUTINE FUNCTIONS ============================ ##
:DoJob 
rem
rem USAGE... call :DoJob "diskpart_instructions_file.txt" "WIM_Folder_Path" "WIM_Filename" "cleanup=TRUE/FALSE"
rem eg...... call :DoJob "dell.txt" "Images\Dell GX270" "GX270_20-04-10-NBH.wim" "TRUE"
rem
echo.
echo - [STAGE 1: DISKPART] Setting up Partitions . . .
echo                        - Using instruction file: %ltr%:\%~1
echo.
diskpart.exe /s "%ltr%:\%~1"
echo.
echo.
echo - [STAGE 2: ROBOCOPY] Copying image to local c: drive . . .
echo                        - Source: %ltr%:\%~2\%~3
echo                        - Destination: C:\
echo.
robocopy.exe "%ltr%:\%~2" C:\ "%~3" /ETA /Z
echo.
echo.
echo - [STAGE 3: IMAGEX APPLY] Applying image . . .
echo                            - Source: C:\%~3 (Image #: 1)
echo                            - Destination: C:
echo.
%ltr%:\PETools\ImageX\imagex.exe /apply "C:\%~3" 1 c:
echo.
echo.
if [%~4]==[] goto DoCleanUp
if [%~4]==[TRUE] goto DoCleanUp
if [%~4]==[FALSE] goto SkipCleanUp
:DoCleanUp
echo - [STAGE 4: DELETING] Removing image from C: drive . . .
echo                        - Deleting File: C:\%~3
echo.
del C:\%~3
echo.
:SkipCleanup
goto :EOF 
rem ## =========================== SUBROUTINE FUNCTIONS ============================ ##

:end 