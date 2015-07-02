$page = "http://www.reddit.com/r/earthporn.json"
$count = "0"
$limit = "10"
$after = ""
$linksfile = "C:\Users\Clint\Desktop\eplinks.txt"

Import-Module C:\Users\Clint\Downloads\PSSQLite-master\PSSQLite-master\PSSQLite
$DataSource = "C:\Users\Clint\Desktop\earthpornpics"

Remove-Item $linksfile

$uri = $page + "?" + "count=" + $count + "&limit=" + $limit

$uri


    $response = Invoke-WebRequest -Uri $uri
    $obj = ConvertFrom-Json ($response.Content)
    $after = $obj.data | select after

    $links = $obj.Data.Children.Data | Select Title,Score,num_comments,Url,PermaLink | Where Url -like “*.jpg”

    $after = $after.after

    foreach ($link in $links)
    {
        $link.title
        $link.url | out-file $linksfile -Append

        $query = "INSERT INTO pics (title, url, permalink) VALUES (@title, @url, @permalink)"

    Invoke-SqliteQuery -DataSource $DataSource -Query $query -SqlParameters @{
        title = $link.title
        url = $link.url
        permalink = $link.permalink

    }
    }
    
    <#
    Start-Sleep -Seconds 3

    $count += $limit

    $uri = $page + "?" + "count=" + $count + "&limit=" + $limit + "&after=" + $after
    $uri

    $response = Invoke-WebRequest -Uri $uri
    $obj = ConvertFrom-Json ($response.Content)
    $after = $obj.data | select after

    $links = $obj.Data.Children.Data | Select Title,Score,num_comments,Url,PermaLink | Where Url -like “*.jpg”

    $after
    foreach ($link in $links)
    {
        $link.title
        $link.url | out-file $linksfile -Append
    }
    #>