$linksfile = "C:\Users\Clint\Desktop\test\links.txt"
$outputfolder = "C:\Users\Clint\Desktop\precleaned"
$webclient = New-Object System.Net.WebClient
Import-Module C:\Users\Clint\Downloads\PSSQLite-master\PSSQLite-master\PSSQLite
$DataSource = "C:\Users\Clint\Desktop\earthpornpics"

$IOTD = get-content $linksfile
$IOTD
$counter = 1

foreach ($IO in $IOTD)
{
    $filename = $outputfolder + "\" + $counter + ".jpg"
    $webclient.DownloadFile($IO,$filename)
    #$webclient.DownloadFileAsync($IO,$filename)
    #Start-BitsTransfer -Source $IO -Destination $filename -Asynchronous
    
    $counter++

}