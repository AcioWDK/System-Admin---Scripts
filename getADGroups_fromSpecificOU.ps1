# ===========================================---INFO---=====================================================

# Get all AD-Groups from all specific OUs and sub OUs - while excluding pre-defined sub OUs and exports them on Desktop in a .xlsx
# For example if you have 10 region OUs and multiple group OUs nested within those regions
# you can get all "Admin OU" for all regions without mixing with the other types of groups




# ======---User inputs---======
# none

# script by AcioWDK
# ===========================================================================================================



# Check if the ImportExcel module is installed
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
  Write-Host "ImportExcel module not found. Installing..."
  try {
      # Install the ImportExcel module
      Install-Module -Name ImportExcel -Scope CurrentUser -Force -ErrorAction Stop
      Write-Host "ImportExcel module installed successfully."
  } catch {
      Write-Error "Failed to install ImportExcel module. Exiting script."
      exit 1
  }
} else {
  Write-Host "ImportExcel module is already installed."
}

# Import the ImportExcel module
try {
  Import-Module -Name ImportExcel -ErrorAction Stop
  Write-Host "ImportExcel module imported successfully."
} catch {
  Write-Error "Failed to import ImportExcel module. Exiting script."
  exit 1
}



$DesktopPath = [Environment]::GetFolderPath("Desktop")
$domain = "your.domain"                                 ##### CHANGE #####

$searchbase = "*OU=Filesystem-Groups (L),OU=Groups*"    ##### CHANGE #####

$excludeOU1 = "*OU=Location1*"                          ##### CHANGE #####
$excludeOU2 = "*OU=SubLocation*"                        ##### CHANGE #####
$excludeOU3 = "*OU=Location2*"                          ##### CHANGE #####
$excludeOU4 = "*OU=Location3*"                          ##### CHANGE #####



# Properites to be exported for each group
$properties = @(
  'sAMAccountName',
  'ManagedBy',
  'Description'
)

Get-ADGroup -filter * -Properties $properties -Server $domain | Where-Object {$_.distinguishedName -notlike $excludeOU1 -and $_.distinguishedName -notlike $excludeOU2 -and $_.distinguishedName -notlike $excludeOU3 -and $_.distinguishedName -notlike $excludeOU4 -and $_.distinguishedName -like $searchbase } | Select-Object $properties | Export-Excel -Path $desktopPath"\YourGroupsExcel.xlsx" -Append -FreezeTopRow -AutoSize 



