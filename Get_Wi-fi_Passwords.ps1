# ===========================================---INFO---=====================================================

# List all stored wi-fi passwords

# ======---User inputs---======
# none

# script by AcioWDK
# ===========================================================================================================





$wifi = $(netsh.exe wlan show profiles)
 
if ($wifi -match "There is no wireless interface on the system."){
    Write-Output $wifi
    exit 
}
$count = 0
$ListOfSSID = ($wifi | Select-string -pattern "\w*All User Profile.*: (.*)" -allmatches).Matches | ForEach-Object {$_.Groups[1].Value}
$NumberOfWifi = $ListOfSSID.count
Write-Warning "Wi-fi passwords: "
foreach ($SSID in $ListOfSSID){
    try {
        $passphrase = ($(netsh.exe wlan show profiles name=`"$SSID`" key=clear) |
                    Select-String -pattern ".*Key Content.*:(.*)" -allmatches).Matches |
                        ForEach-Object {$_.Groups[1].Value}
        $count +=1
    }
    catch {
        continue
    }
    
    Write-Output "$SSID : $passphrase"
}

if($count -eq 0){
  Write-Host "Could not find any Wi-fi with passwords" -ForegroundColor Red
}
