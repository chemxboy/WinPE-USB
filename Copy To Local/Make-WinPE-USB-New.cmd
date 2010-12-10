@echo off
cls
setlocal

set _input=
set BuildFiles=BuildFiles
set SourceFiles=SourceFiles

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
echo *********[ !!! W A R N I N G !!! ] **********
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
echo *********[ !!! W A R N I N G !!! ] **********
echo *                                           *
echo *  DO NOT EXECUTE THIS FILE ON THE SERVER!  *
echo *                                           *
echo *********************************************
echo Exiting...
goto end
)
echo Insert USB device and press any to continue . . .
pause >nul
echo.
echo What is the drive letter assigned to the USB device? eg. E
set /p _input=(Check 'My Computer' to be sure): 
echo.
echo [Step 1]
echo.
echo - Preparing USB device (%_input%:)...
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
"%BuildFiles%\robocopy.exe" "%CD%\%SourceFiles%" "%_input%:" /E >nul
"%BuildFiles%\bootsect.exe" /nt60 %_input%: >nul

echo - Result: Completed - Files copied.
echo.
echo.
echo ** YOUR BOOTABLE WINDOWS PE USB KEY IS READY! **
echo.

:end
echo PRESS ANY KEY TO EXIT . . .
pause >nul