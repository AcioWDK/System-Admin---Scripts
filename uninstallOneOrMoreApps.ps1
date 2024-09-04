
# Run this to list the apps names and populate $programList below as needed
# Get-Package -Provider Programs -IncludeWindowsInstaller -Name *

Write-Host "`n"




$count=0
$programList = @(
    
    '#-#'   #INSERT NAMES HERE
    '#-#'
    'zscaler'
    

)

$UniList = @()

$Regpath = @(
    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
)

$installedPrograms = (Get-ItemProperty $Regpath).where({$_.DisplayName})
$result = foreach($program in $programList)
{
    $check = $installedPrograms.DisplayName -match $program
    if($check)
    {
        foreach($match in $check)
        {
           
           $count += 1
           Write-Host "Found $program ------- $match"
           $UniList += $match
            
        }
        continue
    }

    Write-Host "can't find $program" 
    
}

$result
$list = $programList.Count
Write-Host "`n"
Write-Host "Installed: $count of $list programs"

if($count -eq 0)
{
    "`nexiting..."
    start-sleep -seconds 5
    exit

}

for($index = 0; $index -lt $unilist.Count; $index++)
{
 write-host [($index+1)] $unilist[$index]
}
Write-Host [ ($index+1)] All
Write-Host [ ($index+2)] "Exit"


#-----------------------------------------------------------

Write-Host "`n"

$condition = Read-Host "Select a number from the above"
$DeleteEmAll = 0


switch ($condition)
{
 1
 {

  Uninstall-Package -Name $unilist[$condition-1]

 }
 2
 {

 Uninstall-Package -Name $unilist[$condition-1]

 }
 ($index+1)
 {

  foreach($byee in $UniList)
  {
  Uninstall-Package -Name $byee
  }

 }
 ($index+2)
 {

    Write-Host "Exiting..."
    Start-Sleep 1
    exit

 }

}

"`nUninstall completed!"
start-sleep -seconds 5
exit

