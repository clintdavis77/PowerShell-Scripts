$linksfile = "C:\Users\Clint\Desktop\eplinks.txt"
$outputfolder = "C:\Users\Clint\Desktop\precleaned"
$webclient = New-Object System.Net.WebClient

$IOTD = get-content $linksfile
#$IOTD 
$counter = 1
foreach ($IO in $IOTD)
{
    #$IO = $IO.Line.Replace("url          : ","")

    $filename = $outputfolder + "\" + $counter + ".jpg"
    $webclient.DownloadFile($IO,$filename)
    #$webclient.DownloadFileAsync($IO,$filename)
    #Start-BitsTransfer -Source $IO -Destination $filename -Asynchronous
    
    $counter++
}

Remove-Item $linksfile