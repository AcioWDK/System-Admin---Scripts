::===========================================---INFO---=====================================================

::What it does:
::sent mails from shared mailboxes will appear in the shared mailbox "sent Items" folder 
::instead of the users "sent items" folder

::======---User inputs---======
::None


::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by AcioWDK
::===========================================================================================================



echo ======================================================================
echo:
echo reg add DelegateSentItemsStyle to "...\Office\16.0\Outlook\Preferences"
echo:
echo ======================================================================
echo:


reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Preferences" /v "DelegateSentItemsStyle" /t REG_DWORD /d 1 /f



pause
