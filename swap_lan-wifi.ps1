# ===========================================---INFO---=====================================================

# Swap between predefined wifi-lan or choose the wifi

# ======---User inputs---======
# none

# script by AcioWDK
# ===========================================================================================================




if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments 
  Break
}

#DEFAULTS
$lanAdapter = "Ethernet 3"
$SSID = "yourWifi"
$choice = Read-Host "Type 'n' for choices" 

if($choice -eq 'n'){
#========================================
#               Lan part
#========================================
Get-NetAdapter | select name, InterfaceDescription, status
$allAdapters = Get-NetAdapter | select name, InterfaceDescription, status 


for($index = 0; $index -lt $allAdapters.Count; $index++){
  Write-Host [($index+1)] ($allAdapters[$index]).name
}
Write-Host [ 0 ] "Exit`n"

$lanAdapter = Read-Host "Select the Ethernet Adapter"
Write-Host ""
if($lanAdapter -eq 0){
  exit
}
$lanAdapter = ($allAdapters[$lanAdapter-1]).name


#========================================
#               Wlan part
#========================================


$wifi = $(netsh.exe wlan show networks)
$ListOfSSID = ($wifi | Select-string -pattern "\w*SSID.*: (.*)" -allmatches).Matches | where{$_.Groups[1].Value -ne ""} |ForEach-Object {$_.Groups[1].Value}

for($index = 0; $index -lt $ListOfSSID.Count; $index++){
  Write-Host [($index+1)] ($ListOfSSID[$index]) 
}
Write-Host [ 0 ] "Exit`n"

$SSID = Read-Host "Select the Wi-fi"
Write-Host ""
if($SSID -eq 0){
  exit
}
$SSID = $ListOfSSID[$SSID-1]

write-host  $SSID " <=====> " $lanAdapter
}


$lanState = Get-NetAdapter -Name $lanAdapter | ? status -eq 'up'


#========================================
#                Magic
#========================================

if ( $lanState )
{
    # TODO switch on wifi
    write-host 'Enabled... Disable now'
    Get-NetAdapter -Name $lanAdapter | ? status -NE disabled | Disable-NetAdapter -Confirm:$false
    netsh wlan connect name=$SSID
}
else
{
    # TODO switch off wifi
    Write-Host 'Disabled... Enable now'
    Get-NetAdapter -Name $lanAdapter | ? status -EQ disabled | Enable-NetAdapter -Confirm:$false
    netsh wlan disconnect
}



start-sleep 1
