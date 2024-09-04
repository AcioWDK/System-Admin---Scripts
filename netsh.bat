::===========================================---INFO---=====================================================

::Full net adapters reset, flushdns, flush ip, reboot

::======---User inputs---======
::None

::Logs date, script_name, runAs
@echo off
color 0d
for /f "delims=" %%n in ('whoami') do set name=%%n
echo %date%_%time% --- %~nx0 has been run by %name% >> C:\Temp\ScriptsFlag.log

::script by AcioWDK
::===========================================================================================================



ipconfig /release >> C:\TEMP\%~nx0.log
ipconfig /renew >> C:\TEMP\%~nx0.log
ipconfig /flushdns >> C:\TEMP\%~nx0.log
netsh int ip reset >> C:\TEMP\%~nx0.log
::shutdown -r -t 5 >> C:\TEMP\%~nx0.log