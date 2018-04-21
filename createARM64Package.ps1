# Update these two variables with the paths to the ARM64 appx and pfx file used to sign the app.
$appxPath = $args[0]
$pfxFile = $args[1]

# Replace arm64 processor architecture with arm to work around Microsoft Store ingestion issues.
copy $appxPath .\archive.zip
Expand-Archive .\archive.zip -DestinationPath extracted -Force
(Get-Content .\extracted\AppxManifest.xml).replace('ProcessorArchitecture="arm64"', 'ProcessorArchitecture="arm"') | Set-Content .\extracted\AppxManifest.xml

# Create and sign the appx.
makeappx pack /o /m extracted\AppxManifest.xml /f "DistroLauncher-Appx\ARM64\Release\filemap.map.txt" /p $appxPath
signtool sign /v /f $pfxFile /fd SHA256 $appxPath

#Cleanup
Remove-Item .\archive.zip
Remove-Item .\extracted -Force -Recurse
