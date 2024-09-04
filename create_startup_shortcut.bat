::===========================================---INFO---=====================================================

::What it does:
::Add URL to start with windows 
::Add App.exe to start with windows

::======---User inputs---======
::None


::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by AcioWDK
::===========================================================================================================


@REM Variables for URL in startup
set URL=https://www.youtube.com/
set URLshortcut=Youtube


@REM Variables for App.exe in startup
set exePath="C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
set exeShortcut=Outlook


@REM =================  Set url to open on startup =================

echo [InternetShortcut] >"%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup\%URLshortcut%.url"
echo URL=%URL% >>"%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup\%URLshortcut%.url"


echo %URLshortcut%.url shortcut created in start-up

@REM  Open from startup for testing                     
start "" "%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup\%URLshortcut%.url"



@REM =================  Set App.exe to open on startup =================

copy %exePath% "%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup"

echo %exeShortcut%.exe shortcut created in start-up

start "" /d "%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup" "%exeShortcut%.EXE"



