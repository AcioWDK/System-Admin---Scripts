# ===================================================================================

#@github.com/AcioWDK


# what it does:

# Creates both inbound and Outbound rules in firewall to BLOCK all connections.
# You can find the rules by searching for the app name

# ===================================================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$testform = New-Object System.Windows.Forms.Form
$testform.Text = 'Firewall Rules'
$testform.Size = New-Object System.Drawing.Size(280,130)
$testform.StartPosition = 'CenterScreen'

$okb = New-Object System.Windows.Forms.Button
$okb.Location = New-Object System.Drawing.Point(175,55)
$okb.Size = New-Object System.Drawing.Size(75,25)
$okb.Text = 'Add'
$okb.DialogResult = [System.Windows.Forms.DialogResult]::OK
$testform.AcceptButton = $okb
$testform.Controls.Add($okb)

$lb = New-Object System.Windows.Forms.Label
$lb.Location = New-Object System.Drawing.Point(10,10)
$lb.Size = New-Object System.Drawing.Size(240,20)
$lb.Text = 'Please path to the app (including .exe):'
$testform.Controls.Add($lb)

$tb = New-Object System.Windows.Forms.TextBox
$tb.Location = New-Object System.Drawing.Point(10,30)
$tb.Size = New-Object System.Drawing.Size(240,20)
$testform.Controls.Add($tb)

$testform.Topmost = $true
$testform.Add_Shown({$tb.Select()})
$rs = $testform.ShowDialog()


if ($rs -eq [System.Windows.Forms.DialogResult]::OK)
{
$appPath = $tb.Text
$appPath = $appPath.Replace("`"","")
$appName = Get-ChildItem $appPath
$appBasename = $appName.BaseName

$outboundDisplayName = $appBasename +"OutBound"
$inboundDisplayName = $appBasename +"InbBound"

    New-NetFirewallRule -Program $appPath -Action Block -Profile Domain, Private, Public -DisplayName $outboundDisplayName -Description “Block $appBasename Outbound” -Direction Outbound 
    Write-Host "outcount created for $appbasename"    
    New-NetFirewallRule -Program $appPath -Action Block -Profile Domain, Private, Public -DisplayName $inboundDisplayName -Description “Block $appBasename Inbound” -Direction Inbound
    Write-Host "inbound created for $appbasename"



}

