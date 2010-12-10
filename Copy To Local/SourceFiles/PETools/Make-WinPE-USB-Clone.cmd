@echo off
cls
setlocal

set _input=
set BuildFiles=U:\PETools\BuildFiles
set SourceFiles=U:

echo.
echo ########################################################
echo #                                                      #
echo #    CAMDEN SCHOOLS IT ENGINEERS WINDOWS PE UTILITY    #
echo #              by Neil Bourne-Harris (CSITS)           #
echo #                                                      #
echo ########################################################
echo.
echo             WINDOWS PE USB DEVICE BUILDER
echo             -----------------------------
echo.


if [%computername%]==[CAM-SCH-SVR-01] (
echo.
echo.
echo.
echo.
echo.
echo ********* [ !!! W A R N I N G !!! ] *********
echo *                                           *
echo *  DO NOT EXECUTE THIS FILE ON THE SERVER!  *
echo *                                           *
echo *********************************************
echo Exiting...
goto end

)
if [%computername%]==[CAM-SCH-SVR-02] (
echo.
echo.
echo.
echo.
echo.
echo ********* [ !!! W A R N I N G !!! ] *********
echo *                                           *
echo *  DO NOT EXECUTE THIS FILE ON THE SERVER!  *
echo *                                           *
echo *********************************************
echo Exiting...
goto end
)
echo !! NOTE: DO NOT REMOVE THIS USB DEVICE !!
echo.
echo Insert a new USB device and press any key to continue . . .
pause >nul
echo.
echo What is the drive letter assigned to the new USB device? eg. E
set /p _input=(Check 'My Computer' to be sure): 
echo.
echo [Step 1]
echo.
echo - Preparing new USB device (%_input%:)...
echo.
echo - Quick Formatting [PRESS ENTER TO CONFIRM AND CONTINUE!]...
format %_input%: /FS:FAT32 /V:WINPE30 /Q >nul
echo - Converting to NTFS...
echo.
convert.exe %_input%: /FS:NTFS >nul
echo - Writing MBR as active...
echo.
"%BuildFiles%\mbrwiz.exe" /vol=%_input%: /active /confirm >nul
echo - Result: Done - drive is bootable
echo.
echo.
echo [Step 2]
echo.
echo - Copying/Updating Files (approx 30 secs)...
echo.
echo _MyFiles > "%BuildFiles%\exclude.txt"
echo _MyImages >> "%BuildFiles%\exclude.txt"
if not exist "%SourceFiles%\_MyFiles" mkdir "%SourceFiles%\_MyFiles" >nul
if not exist "%SourceFiles%\_MyFiles" mkdir "%SourceFiles%\_MyImages" >nul
xcopy "%SourceFiles%\" "%_input%:\" /q /e /i /h /y /exclude:"%BuildFiles%\exclude.txt" >nul
del "%BuildFiles%\exclude.txt" >nul

"%BuildFiles%\bootsect.exe" /nt60 %_input%: >nul

echo - Result: Completed - Files copied.
echo.
echo.
echo ** YOUR NEW BOOTABLE WINDOWS PE USB KEY IS READY! **
echo.

:end
echo PRESS ANY KEY TO EXIT . . .
pause >nul