# Eddie Windows 10 Cleanup Script
# Last Edit 08/30/19

# Open this in powershell ise ran as adminstrator
# Run this command first ---> Set-ExecutionPolicy unrestricted -force

cd c:\users\it\desktop\scripts\
mkdir "c:\layout"
cp -path ".\xml-layouts\eddie.xml" -destination "c:\layout\"
Set-ExecutionPolicy unrestricted -force
get-executionpolicy

# Disables User Account Control
set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system" -Name "EnableLUA" -Value "0"
echo "UAC disabled"

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
echo "Windows firewall disabled"

# Removes windows store app
remove-appxpackage -AllUsers Microsoft.WindowsStore_11811.1001.18.0_x64__8wekyb3d8bbwe

# removes windows mail app
get-appxpackage -all *windowscomm* | remove-appxpackage -allusers

#removes onenote
get-appxpackage -all microsoft.office.onenote | remove-appxpackage -allusers

remove-appxpackage -AllUsers Microsoft.BingWeather_4.23.10923.0_neutral_~_8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.Office.OneNote_2015.9126.21251.0_neutral_~_8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.SkypeApp_12.1811.248.1000_neutral_~_kzf8qxf38zg5c
get-appxpackage -all *skype* | remove-appxpackage -allusers
remove-appxpackage -AllUsers Microsoft.Wallet_1.0.16328.0_neutral_~_8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.WindowsMaps_2017.1003.1829.1000_neutral_~_8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.XboxApp_39.39.21002.0_neutral_~_8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.XboxGameOverlay*

remove-appxpackage -AllUsers Microsoft.XboxIdentityProvider*

remove-appxpackage -AllUsers Microsoft.XboxSpeechToTextOverlay*

remove-appxpackage -AllUsers Microsoft.ZuneMusic*

remove-appxpackage -AllUsers Microsoft.ZuneVideo*

get-appxpackage -all *office* | remove-appxpackage -allusers

#Removes microsoft office hub
get-appxpackage -all -name microsoft.microsoftoffice* | remove-appxpackage -allusers

# Removes Candy Crush
remove-appxpackage -AllUsers Microsoft.WindowsStore_11811.1001.18.0_x64__8wekyb3d8bbwe

# Removes Xbox app
remove-appxpackage -AllUsers Microsoft.XboxApp_44.44.7002.0_x64__8wekyb3d8bbwe

# Removes Edge from the taskbar
$appname = "Microsoft Edge"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}


# Removes Microsoft Store from the taskbar
$appname = "Microsoft Store"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Removes Mail from the taskbar
$appname = "Mail"
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'Unpin from taskbar'} | %{$_.DoIt(); $exec = $true}

# Removes windows 10 office 365 package
Get-AppxPackage -all -Name Microsoft.Office.Desktop | Remove-appxPackage -AllUsers

# Removes Groove Music
remove-appxpackage -AllUsers Microsoft.ZuneMusic_10.18112.10711.0_x64__8wekyb3d8bbwe
get-appxpackage -all microsoft.zune* | remove-appxpackage -allusers

# Removes Xbox
remove-appxpackage -AllUsers Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_x64__8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.XboxGamingOverlay_1.16.1012.0_x64__8wekyb3d8bbwe
remove-appxpackage -AllUsers Microsoft.XboxGameOverlay_1.37.25001.0_x64__8wekyb3d8bbwe
get-appxpackage -all *xbox* | remove-appxpackage -allusers

# Removes Solitaire
remove-appxpackage -AllUsers Microsoft.MicrosoftSolitaireCollection_4.2.11280.0_x86__8wekyb3d8bbwe

# Removes 3d Builder
Remove-AppxPackage -AllUsers Microsoft.3DBuilder_16.0.2611.0_x64__8wekyb3d8bbwe

# Removes 3d Viewer 
Remove-AppxPackage -AllUsers Microsoft.Microsoft3DViewer_5.1811.27012.0_x64__8wekyb3d8bbwe

# Removes some paid microsoft wifi app
Remove-AppxPackage -AllUsers Microsoft.OneConnect_5.1809.2571.0_x64__8wekyb3d8bbwe

# Removes search box from taskbar
set-ItemProperty -path "hkcu:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "0"

# Removes task view from taskbar
set-ItemProperty -path "hkcu:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0"

# Removes people from the taskbar
set-ItemProperty -path "hkcu:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value "0"

reg import C:\Users\it\Desktop\scripts\exe\odbc.reg
reg import C:\Users\it\Desktop\scripts\exe\odbc-64bit.reg
Start-Sleep -s 5
echo " Added ODBC settigns"

# Installs Chrome
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer; Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path\$Installer
echo ' Chrome Installed '



# Installs Java
$Exe = "C:\Users\it\Desktop\scripts\exe\JavaSetup8u201.exe"
$ExeArgs = @(
    "INSTALL_SILENT=1"
    "STATIC=0"
    "AUTO_UPDATE=0"
    "WEB_JAVA=1"
    "WEB_JAVA_SECURITY_LEVEL=H"
    "WEB_ANALYTICS=0"
    "EULA=0"
    "REBOOT=0"
    "NOSTARTMENU=0"
    "SPONSORS=0"
)
$Install = Start-Process $Exe -ArgumentList $ExeArgs -NoNewWindow -Wait -PassThru

echo ' Java Installed '
Start-Sleep -s 5

#Installs silverlight
"C:\Users\it\Desktop\scripts\exe\Silverlight_x64.exe /q" | cmd

echo ' Silverlight Installed '
Start-Sleep -s 30

#Installs adobe acrobat reader dc
C:\Users\it\Desktop\scripts\exe\AcroRdrDC1901020099_en_US.exe /sAll

echo ' Adobe Acrobat Reader Installed '
Start-Sleep -s 30


# Stops the windows update service and disables it
stop-service -name wuauserv
set-service -name wuauserv -startuptype disabled

echo ' Windows Update Disabled '
Start-Sleep -s 5

#Installs teamviewer
start-process -Wait C:\Users\it\Desktop\scripts\exe\teamviewer-eddie.exe /S
echo 'Teamviewer Installed '
Start-Sleep -s 30


#Installs Office 2016
cd '.\office2016-32bit'
".\setup.exe /adminfile office2016.msp" | cmd
$myshell.sendkeys("{ENTER}")
Start-Sleep -s 5
$myshell = New-Object -com "Wscript.Shell"
$myshell.sendkeys("{ENTER}")







