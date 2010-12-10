@echo off
cls

echo **********************************************************
echo **                                                      **
echo ** 1) DO NOT REMOVE THE ORIGINAL USB KEY!               **
echo **                                                      **
echo **  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=  **
echo **                                                      ** 
echo ** 2) INSERT A BLANK USB KEY (at least 256mb)           **
echo **    WARNING: ALL DATA ON THIS NEW KEY WILL BE WIPED!  **
echo **    eg. For E: just type the letter E                 **
echo **                                                      **
echo **********************************************************
echo.
echo What is the drive letter for the new key? (if unsure check 'My Computer')
set _input=
set /p _input=Enter the new USB drive letter only: 
echo.
echo.

echo select volume %_input% > U:\PETools\diskpartcfgs\_usbclone.tmp
echo clean >> U:\PETools\diskpartcfgs\_usbclone.tmp
echo create partition primary >> U:\PETools\diskpartcfgs\_usbclone.tmp
echo select partition 1 >> U:\PETools\diskpartcfgs\_usbclone.tmp
echo active >> U:\PETools\diskpartcfgs\_usbclone.tmp
echo format quick fs=ntfs >> U:\PETools\diskpartcfgs\_usbclone.tmp

echo [Step 1]
echo - Preparing USB drive (%_input%)...
diskpart /s U:\PETools\diskpartcfgs\_usbclone.tmp >nul
del U:\PETools\diskpartcfgs\_usbclone.tmp >nul
echo - Result: Done - drive is bootable
echo.
echo [Step 2]
echo - Copying Files [10%%]...
robocopy U:\boot %_input%:\boot >nul
echo - Copying Files [20%%]...
robocopy U:\EFI %_input%:\EFI >nul
echo - Copying Files [30%%]...
robocopy U:\PEMenu %_input%:\PEMenu >nul
echo - Copying Files [40%%]...
robocopy U:\PETools %_input%:\PETools >nul
echo - Copying Files [50%%]...
robocopy U:\sources %_input%:\sources >nul
echo - Copying Files [60%%]...
mkdir %_input%:\_MyImages >nul
mkdir %_input%:\_MyFiles >nul
echo - Copying Files [70%%]...
copy U:\bootmgr %_input%:\bootmgr >nul
echo - Copying Files [80%%]...
copy U:\changelog.txt %_input%:\changelog.txt >nul
echo - Copying Files [90%%]...
copy U:\commands.cmd %_input%:\commands.cmd >nul
echo - Copying Files [100%%]...
copy U:\usbdrive.flg %_input%:\usbdrive.flg >nul
echo - Result: Completed - Files copied