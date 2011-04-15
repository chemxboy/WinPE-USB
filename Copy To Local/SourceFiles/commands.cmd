@echo off
cls

echo.
echo ########################################################
echo #                                                      #
echo #    CAMDEN SCHOOLS IT ENGINEERS WINDOWS PE UTILITY    #
echo #            by Neil Bourne-Harris (SITSS)             #
echo #                                                      #
echo ########################################################
echo.
echo.
echo Please wait. Preparing Windows PE Explorer UI...
echo.

rem ## copy PETools Folder and Files to the %systemdrive%
mkdir %systemdrive%\PETools
xcopy U:\PETools %systemdrive%\PETools /E /I /H /R /Y >nul

rem ## Copy file associations settings
copy %systemdrive%\PETools\Shells\BSExplorer\FE.cfg %systemdrive%\Windows\System32\FE.cfg >nul

rem ## Set Resolution to 1024 x 768 (32bit)
%systemdrive%\PETools\setres.exe h1024 v768 b32 >nul

rem ## Set BGInfo
call %systemdrive%\PETools\bginfo.cmd

rem ## Unzip the common.dll file and place into all necessary folders.
%systemdrive%\PETools\7-Zip\7z.exe x "%systemdrive%\PETools\common.zip" -o"%systemdrive%\PETools\ERDExplorer" -y >nul
%systemdrive%\PETools\7-Zip\7z.exe x "%systemdrive%\PETools\common.zip" -o"%systemdrive%\PETools\FileSearch" -y >nul
%systemdrive%\PETools\7-Zip\7z.exe x "%systemdrive%\PETools\common.zip" -o"%systemdrive%\PETools\SystemRestore" -y >nul

rem ## Hide this command window
%systemdrive%\PETools\ShowConsole.exe HIDE

rem ## Launch Shell
%systemdrive%\PETools\Shells\BSExplorer\Explorer.exe