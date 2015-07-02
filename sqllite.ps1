#C:\Users\Clint\Downloads\PSSQLite-master\PSSQLite-master\PSSQLite

# One time setup
    # Download the repository
    # Unblock the zip
    # Extract the PSSQLite folder to a module path (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules\)

    Import-Module C:\Users\Clint\Downloads\PSSQLite-master\PSSQLite-master\PSSQLite    #Alternatively, Import-Module \\Path\To\PSSQLite

# Get commands in the module
    Get-Command -Module PSSQLite

# Get help for a command
    Get-Help Invoke-SQLiteQuery -Full

# Create a database and a table
    $Query = "CREATE TABLE NAMES (fullname VARCHAR(20) PRIMARY KEY, surname TEXT, givenname TEXT, BirthDate DATETIME)"
    $DataSource = "C:\Users\Clint\Desktop\Names.SQLite"

    Invoke-SqliteQuery -Query $Query -DataSource $DataSource

# View table info
    Invoke-SqliteQuery -DataSource $DataSource -Query "PRAGMA table_info(NAMES)"

# Insert some data, use parameters for the fullname and birthdate
    $query = "INSERT INTO NAMES (fullname, surname, givenname, birthdate) VALUES (@full, 'Cookie', 'Monster', @BD)"

    Invoke-SqliteQuery -DataSource $DataSource -Query $query -SqlParameters @{
        full = "Cookie Monster"
        BD   = (get-date).addyears(-3)
    }

# View the data
    Invoke-SqliteQuery -DataSource $DataSource -Query "SELECT * FROM NAMES"

#Build up some fake data to bulk insert, convert it to a datatable
    $DataTable = 1..10000 | %{
        [pscustomobject]@{
            fullname = "Name $_"
            surname = "Name"
            givenname = "$_"
            BirthDate = (Get-Date).Adddays(-$_)
        }
    } | Out-DataTable

#Insert the data within a single transaction (SQLite is faster this way)
    Invoke-SQLiteBulkCopy -DataTable $DataTable -DataSource $DataSource -Table Names -NotifyAfter 1000 -verbose

#View all the data!
    Invoke-SqliteQuery -DataSource $DataSource -Query "SELECT * FROM NAMES"