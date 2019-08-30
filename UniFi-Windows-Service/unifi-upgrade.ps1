Set-ExecutionPolicy AllSigned
echo "Uninstalling previous Unifi Service"
Get-ChildItem "C:\Program Files\Java" -recurse | where {$_.Name -eq "java.exe"} | % {
$x64Java = $_.FullName
 }
Set-Location "$env:USERPROFILE\Ubiquiti UniFi\"
Get-Service "UniFi*" | Stop-Service
& $x64Java -jar lib\ace.jar uninstallsvc
choco upgrade -y ubiquiti-unifi-controller --version 5.10.27
echo "Removing default shortcuts"
Remove-Item –path "$env:APPDATA/Microsoft/Windows/Start Menu/Programs/Ubiquiti UniFi" –recurse
Remove-Item –path "$env:USERPROFILE/Desktop/Unifi.lnk" –recurse
echo "Installing Unifi Service"
Get-ChildItem "C:\Program Files\Java" -recurse | where {$_.Name -eq "java.exe"} | % {
$x64Java = $_.FullName
 }
Set-Location "$env:USERPROFILE\Ubiquiti UniFi\"
& $x64Java -jar lib\ace.jar installsvc
Get-Service "UniFi*" | Start-Service
