
# check if path exit
$MayExistPaths=@(
    "M:\网络游戏\原神\Genshin Impact"
    "X:\网络游戏\原神\yuanshen"
)

$GenshinRoot=""
foreach ($MayExistPath in $MayExistPaths)
{
    if (Test-Path -path $MayExistPath)
    { 
    # it is
        $GenshinRoot=$MayExistPath
        break
    }
    # not this, try next
}

# Test has $GenshinRoot alreay been set
if(!$GenshinRoot){
    # if not, ask user input a path
    $GenshinRoot = Read-Host 'Input Genshi Root Path:'
}

Write-Host '$GenshinRoot is '"$GenshinRoot" # log


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

$Config1 = Get-IniContent "$GenshinRoot/config.ini"
$Config1["General"].cps="bilibili"
$Config1["General"].channel=14
$Config1["General"].sub_channel=0
Out-IniFile $Config1 "$GenshinRoot/config.ini"

$Config2 = Get-IniContent "$GenshinRoot/Genshin Impact Game/config.ini"
$Config2["General"].cps="bilibili"
$Config2["General"].channel=14
$Config2["General"].sub_channel=0
Out-IniFile $Config2 "$GenshinRoot/Genshin Impact Game/config.ini"

Copy-Item $PSScriptRoot/PCGameSDK.dll "$GenshinRoot\Genshin Impact Game\YuanShen_Data\Plugins"