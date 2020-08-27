Set-ExecutionPolicy AllSigned

$multiplelines = @"

#########################################################################
#                                                                       #
#                  KM                       ,ok0KNWW                    #
#                        KM               :NMMMMMMMM                    #
#                       KM  ..             WMMMMMMMMM                   #
#                   KM      KM             WMMMMMMMMM                   #
#                   KM    KM               WMMMMMMMMM                   #
#                   KM  KM  ..             WMMMMMMMMM                   #
#                   KM  ..  KM             WMMMMMMMMM                   #
#                   KM  KM  KM             WMMMMMMMMM                   #
#                   KMNXWM  KM             WMMMMMMMMK                   #
#                   KMMMMMKONM             WMMMMMMMW                    #
#                   KMMMMMMMMM             WMMMMMMM x                   #
#                   lMMMMMMMMM             WMMMMMN xK                   #
#                    MMMMMMMMMl           ,WMMMP dXM:                   #
#                    lMMMMMMMMx .        ,,,aaadXMMd                    #
#                     lNMMMMMMW: XOxolcclodOKMMMMWc                     #
#                       lXMMMMMNc lMMMMMMMMMMMMNo.                      #
#                         llONMMM0c lMMMMMMNOo'                         #
#                              'lMN;. lMWl'                             #
#                                                                       #
#        Unifi controller as a Windows Service Upgrade Installer        #
#########################################################################

"@

Write-Host $multiplelines

echo "Unifi Upgrade Script"
echo "Uninstalling previous Unifi Service"
Get-ChildItem "C:\Program Files\Java" -recurse | where {$_.Name -eq "java.exe"} | % {
$x64Java = $_.FullName
 }
Set-Location "$env:USERPROFILE\Ubiquiti UniFi\"
Get-Service "UniFi*" | Stop-Service
& $x64Java -jar lib\ace.jar uninstallsvc
choco upgrade -y ubiquiti-unifi-controller --version 5.14.23

echo "Installing Unifi Service"
Get-ChildItem "C:\Program Files\Java" -recurse | where {$_.Name -eq "java.exe"} | % {
$x64Java = $_.FullName
 }
Set-Location "$env:USERPROFILE\Ubiquiti UniFi\"
& $x64Java -jar lib\ace.jar installsvc
Get-Service "UniFi*" | Start-Service

echo "Removing default shortcuts"
Remove-Item –path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Ubiquiti UniFi" –recurse
Remove-Item –path "$env:USERPROFILE\Desktop\Unifi.lnk" –recurse
