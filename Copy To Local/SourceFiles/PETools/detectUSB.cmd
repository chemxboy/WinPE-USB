@echo off
title Detecting USB...

rem #####################################################################
rem ## This script will detect if WinPE was booted from a USB key
rem ## If it has been, it will identify the USB drive letter
rem ## and then launch the commands.cmd file at the root of the USB drive
rem ## which loads the shell, followed by any other instructions
rem ## otherwise it will run the startnetwork.cmd which subsequently
rem ## loads  wpeinit to init the network services
rem #####################################################################

if exist U:\usbdrive.flg goto SkipReassignDriveLetter

for %%f in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%f:\usbdrive.flg set ltr=%%f

if %ltr%==*UNKNOWN* (
  title Detecting USB - USB drive letter could not be found!
  start /b %SYSTEMDRIVE%\Windows\System32\startnetwork.cmd
) else (
  title Detecting USB - USB Drive Found: %ltr%:
  echo Detecting USB - USB Drive Found: %ltr%:
  rem ## Reassign the USB/CDROM drive to letter 'U' to avoid clashing drive letters when creating partitions
  echo select volume=%ltr% > X:\changeUSBdrive.txt
  echo assign letter=U >> X:\changeUSBdrive.txt
  echo Reassigning USB/CDROM drive to letter U:...
  echo.
  diskpart /s X:\changeUSBdrive.txt >nul
  del X:\changeUSBdrive.txt
  set ltr=U
  title Detecting USB - USB Drive moved from: %ltr%: to U:
  echo Detecting USB - USB Drive moved from: %ltr%: to U:
  path=%path%;U:\PETools
  rem start /b U:\commands.cmd
  U:\commands.cmd
)
goto end

:SkipReassignDriveLetter
title Detecting USB - USB drive already found and reassigned to: %ltr%:
echo Detecting USB - USB drive already found and reassigned to: %ltr%:
goto end

:end