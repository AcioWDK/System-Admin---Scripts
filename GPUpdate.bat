
::===========================================---INFO---=====================================================

::GPUpdate & Action run

::======---User inputs---======
::None


::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by Stefan Ungureanu
::===========================================================================================================


echo GPUpdate:
gpupdate /force /boot 


echo Actions:
timeout /t 2

cd\

:: 1 - Application Deployment Evaluation Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000121}" /NOINTERACTIVE

:: 2 - Discovery Data Collection Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000003}" /NOINTERACTIVE

:: 3 - File Collection Cycle 

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000010}" /NOINTERACTIVE

:: 4 - Hardware Inventory Cycle 

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000001}" /NOINTERACTIVE

:: 5 - Machine Policy Retrieval Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000021}" /NOINTERACTIVE

:: 6 - Machine Policy Evaluation Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000022}" /NOINTERACTIVE

:: 7 - Software Inventory Cycle 

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000002}" /NOINTERACTIVE

:: Software Metering Usage Report Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000031}" /NOINTERACTIVE

:: 8 - Software Update Deployment Evaluation Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000114}" /NOINTERACTIVE

:: Software Update Scan Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000113}" /NOINTERACTIVE

:: 9 - User Policy Retrieval Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000026}" /NOINTERACTIVE

:: 10 - User Policy Evaluation Cycle 

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000027}" /NOINTERACTIVE

:: Windows Installer Source List Update Cycle

WMIC /node:%computername% /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000032}" /NOINTERACTIVE


timeout /t 5
::uncomment the below line for auto reboot
::shutdown /r /t 0











