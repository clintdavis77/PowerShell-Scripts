$pages = 5
$pagenum = 1
$startpage = "http://www.reddit.com/r/earthporn"
$nextpage = ""
$linksfile = "C:\Users\Clint\Desktop\test\links.txt"

remove-item $linksfile

while ($pagenum -le $pages) {
    $startpage
    try
    {
       $IOTD = ((Invoke-WebRequest -Uri $startpage).Links | Where href -like “*.jpg” ).href | Get-Unique
    $IOTD
    foreach ($IO in $IOTD)
    {
        $IO | out-file $linksfile -Append
        #Start-BitsTransfer -Source $IO -Destination C:\Users\Clint\Desktop\test

    }
    $nextpage = ((Invoke-WebRequest –Uri $startpage).Links | Where-Object {$_.href -like “http*”} | Where rel -eq “nofollow next”).href
    $startpage = $nextpage
    Start-Sleep -s 5
    $pagenum++
    }
    catch [System.Exception]
{
    Write-Host "Other exception"
    write-host system.exception

}
finally
{
    Write-Host "cleaning up ..."
}
}


<#
$IOTD = ((Invoke-WebRequest -Uri ‘http://www.reddit.com/r/earthporn’).Links | Where href -like “*.jpg” ).href | Get-Unique
$IOTD
foreach ($IO in $IOTD)
{
    
    Start-BitsTransfer -Source $IO -Destination C:\Users\Clint\Desktop\test

}
#>