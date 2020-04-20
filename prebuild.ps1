
$Rel = "focal"
$Version = "2004.2020.422.0"
bash create-wsl-app-install.tar.gz.sh $Rel
mkdir DistroLauncher-Appx/x64
mkdir DistroLauncher-Appx/ARM64

Get-Content DistroLauncher-Appx/MyDistro.appxmanifest | %{$_ -replace "%Version%",$Version} | %{$_ -replace "%Platform%","x64"} | Set-Content -Encoding UTF8 -Path DistroLauncher-Appx/x64/Ubuntu.appxmanifest
Get-Content DistroLauncher-Appx/MyDistro.appxmanifest | %{$_ -replace "%Version%",$Version} | %{$_ -replace "%Platform%","arm64"} | Set-Content -Encoding UTF8 -Path DistroLauncher-Appx/ARM64/Ubuntu.appxmanifest