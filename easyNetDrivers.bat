::===========================================---INFO---=====================================================

::Maps network drives

::======---User inputs---======
::%Path% = paste the path of the drive you want to map
::EX: \\server\folder$\subfolder

::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by AcioWDK
::===========================================================================================================

echo Paste the path of the network drive you want to map
echo If you want to exit, don't paste anything and press enter
echo:

goto :netdrive

:netdrive

set netDrivePath=[]

set /p netDrivePath=Path: 

IF %netDrivePath% EQU [] EXIT


net use * %netDrivePath%


goto netdrive

