﻿Function Get-FileName($initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName

# *** Entry Point to Script ***

$filename = Get-FileName -initialDirectory "c:\"

try
{
$filehash = Get-FileHash $filename -Algorithm SHA256
}

catch [system.exception]
{
    write-host system.exception

}


$filename + " - " + $filehash.Hash