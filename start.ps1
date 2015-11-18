echo "Saving global packages before updating..."
node .\saveGlobalPackageList

echo "Downloading nodeJs installer..."
Invoke-WebRequest "https://nodejs.org/dist/v5.1.0/node-v5.1.0-x64.msi" -outfile "nodejs.msi"

echo "Uninstalling nodeJs..."
$appToUninstall = Get-WmiObject -Class Win32_Product -Filter "Name = 'Node.js'"
$appToUninstall.Uninstall()

echo "Cleaning up nodeJs cache"
Cmd /C "echo off; rmdir /S /Q %appdata%\npm-cache"

echo "Cleaning up nodeJs global packages"
Cmd /C "echo off; rmdir /S /Q %appdata%\npm"

echo "Installing nodeJs"
$ia = "/i nodejs.msi", "/passive"
Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList $ia

echo "Forcing npm to check for updates"
npm -g update

echo "Restoring global npm packages"
node .\restoreGlobalPackages.js
