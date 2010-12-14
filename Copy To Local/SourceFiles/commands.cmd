@echo off
cls

rem ## Hide this command window
U:\PETools\ShowConsole.exe HIDE

rem ## Copy file associations settings
copy U:\PETools\Shells\BSExplorer\FE.cfg %systemdrive%\Windows\System32\FE.cfg >nul

rem ## Set Resolution to 1024 x 768 (32bit)
U:\PETools\setres.exe h1024 v768 b32 >nul

rem ## Launch Shell
U:\PETools\Shells\BSExplorer\Explorer.exe

rem ## Set BGInfo
call U:\PETools\bginfo.bat

rem ## Load Clamwin antivirus in tasktray
U:\PETools\Clamwin\App\clamwin\bin\ClamTray.exe