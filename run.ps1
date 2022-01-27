# check usual path
$MayRootName = @(
    "Genshin Impact"
    "yuanshen"
)
$MayExistPaths = Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $DriverName = $_.Name
    $MayRootName | ForEach-Object { $DriverName + ":\Õ¯¬Á”Œœ∑\‘≠…Ò\" + $_ } 
}

$ScriptRoot=$PSScriptRoot
if(!$ScriptRoot) {
    # for Powershell which is older than 3.0, $PSScriptRoot is not defined
    # use
    $ScriptRoot = Split-Path $MyInvocation.MyCommand.Path
}
$GenshinRoot=""
foreach ($MayExistPath in $MayExistPaths)
{
    Write-Host "Checking $MayExistPath"
    if (Test-Path -path $MayExistPath)
    { 
    # it is
        Write-Host "Exist"
        $GenshinRoot=$MayExistPath
        break
    }
    # not this, try next
    Write-Host "Not exist"
}

# Test has $GenshinRoot alreay been set
if(!$GenshinRoot){
    # if not, ask user input a path
    $GenshinRoot = Read-Host 'Input Genshi Root Path(where you can found launcher.exe)'
}

Write-Host '$GenshinRoot is '"$GenshinRoot"
$Config1Path="$GenshinRoot/config.ini"
$Config2Path="$GenshinRoot/Genshin Impact Game/config.ini"

# Check if both two config file exist
if(!(Test-Path $Config1Path)) {
    Write-Host "$Config1Path not exist"
    exit
}
if(!(Test-Path $Config2Path)) {
    Write-Host "$Config2Path not exist"
    exit
}

# Get-IniContent and Out-IniFile are copied from:
# https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/
function Get-IniContent ($filePath)
{
    $ini = @{}
    switch -regex -file $FilePath
    {
        "^\[(.+)\]" # Section
        {
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" # Comment
        {
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" # Key
        {
            $name,$value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function Out-IniFile($InputObject, $filePath)
{
    # note: changed origin function:
    # do not create new file, store backup
    Copy-Item $filePath "$filePath.Backup"
    Remove-Item $filePath
    $outFile = $filePath # New-Item -ItemType file -Path $filePath
    foreach ($i in $InputObject.keys)
    {
        if (!($($InputObject[$i].GetType().Name) -eq "Hashtable"))
        {
            #No Sections
            Add-Content -Path $outFile -Value "$i=$($InputObject[$i])"
        } else {
            #Sections
            Add-Content -Path $outFile -Value "[$i]"
            Foreach ($j in ($InputObject[$i].keys | Sort-Object))
            {
                if ($j -match "^Comment[\d]+") {
                    Add-Content -Path $outFile -Value "$($InputObject[$i][$j])"
                } else {
                    Add-Content -Path $outFile -Value "$j=$($InputObject[$i][$j])"
                }

            }
            Add-Content -Path $outFile -Value ""
        }
    }
}

$Config1 = Get-IniContent $Config1Path
$Config2 = Get-IniContent $Config2Path

Write-Host "Current config:"
Write-Host " $GenshinRoot/config.ini[launcher]:"
Write-Host "  cps=$($Config1["launcher"].cps)"
Write-Host "  channel=$($Config1["launcher"].channel)"
Write-Host "  sub_channel=$($Config1["launcher"].sub_channel)"
Write-Host " $GenshinRoot/Genshin Impact Game/config.ini[General]"
Write-Host "  cps=$($Config2["General"].cps)"
Write-Host "  channel=$($Config2["General"].channel)"
Write-Host "  sub_channel=$($Config2["General"].sub_channel)"

if($Config1["launcher"].cps -eq "bilibili") {
    Write-Host "It's bilibili server, swith to mihoyo server"
    $Config1["launcher"].cps="mihoyo"
    $Config1["launcher"].channel=1
    $Config1["launcher"].sub_channel=1
    $Config2["General"].cps="mihoyo"
    $Config2["General"].channel=1
    $Config2["General"].sub_channel=1
} else {
    Write-Host "It isn't bilibili server, swith to bilibili server"
    $Config1["launcher"].cps="bilibili"
    $Config1["launcher"].channel=14
    $Config1["launcher"].sub_channel=0
    $Config2["General"].cps="bilibili"
    $Config2["General"].channel=14
    $Config2["General"].sub_channel=0
}


$confirmation = Read-Host "Execute? [y/n]"
while($confirmation -ne "y")
{
    if ($confirmation -eq 'n') {
        Write-Host "Exit"
        exit
    }
    $confirmation = Read-Host "Invalid input, Execute? [y/n]"
}

Out-IniFile $Config1 $Config1Path
Out-IniFile $Config2 $Config2Path

Write-Host "Current config:"
Write-Host " $GenshinRoot/config.ini[launcher]:"
Write-Host "  cps=$($Config1["launcher"].cps)"
Write-Host "  channel=$($Config1["launcher"].channel)"
Write-Host "  sub_channel=$($Config1["launcher"].sub_channel)"
Write-Host " $GenshinRoot/Genshin Impact Game/config.ini[General]"
Write-Host "  cps=$($Config2["General"].cps)"
Write-Host "  channel=$($Config2["General"].channel)"
Write-Host "  sub_channel=$($Config2["General"].sub_channel)"

if (!(Test-Path "$GenshinRoot\Genshin Impact Game\YuanShen_Data\Plugins")) {
    # copy PCGameSDK.dll to Genshin Impact Game, if this dll not exist
    Write-Host "PCGameSDK.dll not exist, copy it"
    Copy-Item $ScriptRoot/PCGameSDK.dll "$GenshinRoot\Genshin Impact Game\YuanShen_Data\Plugins"
}

Write-Host 'Done, Press any key to exit. Specailly, Press "y" to run Genshin Impact launcher';
$key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
if ($key.Character -eq "y") {
    Write-Output "Run Genshin Impact launcher"
    Start-Process "$GenshinRoot/launcher.exe"
}