$files = (Get-ChildItem  C:\Users\Clint\Desktop\precleaned).FullName
$files


foreach ($file in $files)
{
    $filehash = Get-FileHash $file -Algorithm SHA256
    $filehash = "C:\Users\Clint\Desktop\cleaned\" + $filehash.Hash + ".jpg"
    $filehash

    $result = Test-Path $filehash

    #$result

    
    if ($result -eq "True")
    {
        write-host "skipped " + $filehash
    }
    else
    {
    Move-Item -Path $file -Destination $filehash
    }
    
    #-NewName $filehash -LiteralPath $file
}
