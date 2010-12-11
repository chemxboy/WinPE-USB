@echo off
cls

rem Hide this command window
U:\PETools\ShowConsole.exe HIDE

rem echo - Setting Resolution to 1024 x 768 (32bit)...
U:\PETools\setres.exe h1024 v768 b32 >nul

rem echo - Setting BGInfo...
call U:\PETools\bginfo.bat

rem echo - Launching Shell...
U:\PETools\Shells\BSExplorer\Explorer.exe