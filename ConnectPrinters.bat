::===========================================---INFO---=====================================================

::Installs Printer1 and Printer2 printers

::======---User inputs---======
::Select which printer to set as default (default choice: Printer1)
::Type Y if you want a test print


::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by AcioWDK
::===========================================================================================================


echo:
echo =============================--------------==============================
echo                             Hello and welcome
echo =============================--------------==============================
echo:


echo Connecting to Printer1 ( Department, Office )
rundll32 printui.dll PrintUIEntry /in /n \\print.server\Printer1
echo:
echo Printer1 connected.
echo:



echo Connecting to Printer2 ( Department, Office )
rundll32 printui.dll PrintUIEntry /in /n \\print.server\Printer2
echo:
echo Printer2 connected.
echo:

echo:
echo =============================--------------==============================
echo              Please select the Printer you want to set as default
echo =============================--------------==============================
echo:
echo [ 1 ] Printer1
echo [ 2 ] Printer2
echo:
SET /P choice="Type 1 or 2 and press enter: "

2>NUL CALL :Case_%choice%
IF ERRORLEVEL 1 CALL :DEFAULT_Case


rundll32 printui.dll PrintUIEntry /y /n \\print.server\%printer%

echo:
echo Printer %printer% has been set as default.


echo:
echo =============================--------------==============================
echo                  Print a test page on %printer%? (Y/[N])
echo =============================--------------==============================
echo:
set /P testpage=Type "y" to print or "Enter" to skip: 
IF /I "%testpage%" NEQ "Y" GOTO END_Case
echo:
echo Printing on %printer%...
echo:
echo Done!
rundll32 printui.dll PrintUIEntry /k /n \\print.server\%printer%

timeout /t 5



:Case_1
    set printer=Printer1
    GOTO END_Case
:Case_2
    set printer=Printer2
    GOTO END_Case
:DEFAULT_Case
    set printer=Printer1
    GOTO END_Case
:END_Case
    VER > NUL
    GOTO :EOF


