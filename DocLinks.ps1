# DOCLinks
# powershell script
# can be executed during user logon: activated in gpedit.msc  user - windows - scripts
# Icon DocLinks.ico shall be in same directory as the script
# Free Icons from https://icon-icons.com/
#
# attention: 
# power shell scrips must be allowed - this is usually not default 
# you can do this by executing as administrator: set-executionpolicy remotesigned
#
# V0.1 20230310 ri
#
# DOCLinks reads files and links with extension $extensions from $folderPath and presents in a context menu in notifocation tray
# When leftclicking the icon in notification tray, the list of files in $folderPath are shown as menu items and can be executed by rightclick
#

$folderPath = "C:\user\DOCLinks"
$extensions = @(".pdf", ".jpg", ".txt", ".odt", ".ods", ".lnk")

Add-Type -AssemblyName System.Windows.Forms

$contextMenuStrip = New-Object System.Windows.Forms.ContextMenuStrip

$files = Get-ChildItem $folderPath | Where-Object { $_.Extension -in $extensions }

foreach ($file in $files) {
    $fileName = $file.Name
    $filePath = $file.FullName
   
    $toolStripItem = New-Object System.Windows.Forms.ToolStripMenuItem($fileName)
    
    # Erstellen einer temporären Funktion mit einem Skriptblock
    $tempOpenFileFunc = [ScriptBlock]::Create("Start-Process '$filePath'")
    
    # Übergeben der temporären Funktion an die anonyme Funktion
    $toolStripItem.Add_Click($tempOpenFileFunc)
    $contextMenuStrip.Items.Add($toolStripItem)

    # Debug
    # Write-Host $filePath 
}

$exitMenuItem = New-Object System.Windows.Forms.ToolStripMenuItem("Exit")
$exitMenuItem.add_Click({ [System.Environment]::Exit(0) })
$contextMenuStrip.Items.Add($exitMenuItem)

$notifyIcon = New-Object System.Windows.Forms.NotifyIcon

# Symbol for the form 
$iconPath = Join-Path $PSScriptRoot ".\DocLinks.ico"
$notifyIcon.Icon = New-Object System.Drawing.Icon($iconPath)

# Verknüpfe das Context Menu
$notifyIcon.ContextMenuStrip = $contextMenuStrip
$notifyIcon.Visible = $true

[System.Windows.Forms.Application]::Run()