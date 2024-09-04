<#

============= Script by AcioWDK ============
================ 16/05/2023 ================

=============== Version 1.3 ================

=============== What it does ===============

- Assigning phone numbers in teams
- Gets users from Column A and assigns numbers from Column B - in order 
- Teams Admin required

--------------------------------------------
CSV sample - DO NOT CHANGE HEADER NAME 
--------------------------------------------
name	                    number

Jhon.snow	                2231231
Jhon.snow	                2231231
Chaubey.Locki	            3213122
Jhon.snow	                2231231
Jhon.snow	                2231231
Chaubey.Locki	            3213122
Chaubey.Locki	            3213122




- default .csv name: Teams_CSV_Assign_Numbers-To_Users.csv
- default .csv path: .\Desktop
#>


if(-not(get-module -ListAvailable -name MicrosoftTeams)){
    Write-Warning "Teams Module for powershell is not installed"
    Install-Module -Name MicrosoftTeams -Force -AllowClobber 
}

Import-Module MicrosoftTeams
Connect-MicrosoftTeams | out-null

$color=@('gray','Black','DarkGreen','DarkCyan','DarkRed','DarkMagenta','DarkYellow','Gray','DarkGray','Blue','Green','Cyan','Magenta','White')
$notFound = @()
$DesktopPath = [Environment]::GetFolderPath("Desktop")+"\Teams_CSV_Assig1n_Numbers-To_Users.csv"


try {
    $csvData = Import-Csv -Path $DesktopPath
    if ($csvData[0].PSObject.Properties.Name[0] -notlike "name" -or $csvData[0].PSObject.Properties.Name[1] -notlike "number") {
        Write-Warning "Wrong Headers!"
        Write-Host "ColumnA: $($csvData[0].PSObject.Properties.Name[0]) | must be: name" -ForegroundColor red
        Write-Host "ColumnB: $($csvData[0].PSObject.Properties.Name[1]) | must be: number" -ForegroundColor red
        Pause
        exit
    }
}
catch {
    Write-Warning "The CSV could not be found at: $DesktopPath 
******** Please check the location and the name of the file to match the above ********" 
    Pause
    exit
}
Write-Host ""



#where magic happens
foreach ($user in $csvData) {
    
    $username = $user.name
    $number = $user.number

    try {
        Set-CsPhoneNumberAssignment -Identity $username -PhoneNumber $number -PhoneNumberType OperatorConnect
        Write-host  "Number:  " $number "   |   " $username -ForegroundColor (Get-Random($color))
    }
    catch {
        $notFound += $username
    }

}

Write-Host ""

if($notFound){
    Write-Warning "Couldn't find the following users, check spelling or if the user is still active"
    Write-Host ""
    $notFound 
    Write-Host ""
}


Pause 