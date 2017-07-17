$folderToScan = "\\192.168.1.4\Root\something"
 
$files = Get-ChildItem $folderToScan -File

for ($i=0; $i -lt $files.Count; $i++) {
    Write-Host($files[$i].BaseName)

    $testPath = $folderToScan + "\" + $files[$i].BaseName
    $testResult = Test-Path $testPath

    If ($testResult -eq $false){
        Write-Host("Create")
        New-Item $testPath -ItemType directory
    }

    Move-Item $files[$i].FullName $testPath
}