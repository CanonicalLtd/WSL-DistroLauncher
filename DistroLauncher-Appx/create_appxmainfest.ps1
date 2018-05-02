$Template = $args[0]
$Version = $args[1]
$Platform = $args[2]
$ManifestOut = $args[3]

Get-Content $Template | %{$_ -replace "%Version%",$Version} | %{$_ -replace "%Platform%",$Platform} | Set-Content -Encoding UTF8 -Path $ManifestOut
