# colors for console output
$DebugColor = "DarkGray"
$NoticeColor = "Yellow"
$ErrorColor = "Red"
$SuccessColor = "Green"

# configs
$Configs = @{
    bilibili = @{cps = "bilibili"; channel = 14; sub_channel = 0 }
    mihoyo   = @{cps = "mihoyo"; channel = 1; sub_channel = 1 }
}

# check usual path
$MayRootName = @(
    "Genshin Impact"
    "yuanshen"
)
$MayExistPaths = Get-PSDrive -PSProvider FileSystem | ForEach-Object {
    $DriverName = $_.Name
    $MayRootName | ForEach-Object { $DriverName + ":\???????¡¤\????\" + $_ } 
}

$ScriptRoot = $PSScriptRoot
if (!$ScriptRoot) {
    # for Powershell which is older than 3.0, $PSScriptRoot is not defined
    # use
    $ScriptRoot = Split-Path $MyInvocation.MyCommand.Path
}
$GenshinRoot = ""
foreach ($MayExistPath in $MayExistPaths) {
    Write-Host "Checking $($MayExistPath.PadRight(30))`t" -ForegroundColor $DebugColor -NoNewline
    if (Test-Path -path $MayExistPath) { 
        # it is
        Write-Host "[Exist]" -ForegroundColor $NoticeColor
        $GenshinRoot = $MayExistPath
        break
    }
    # not this, try next
    Write-Host "[Not exist]" -ForegroundColor $ErrorColor
}

# Test has $GenshinRoot alreay been set
if (!$GenshinRoot) {
    # if not, ask user input a path
    $GenshinRoot = Read-Host 'Input Genshi Root Path(where you can found launcher.exe)'
}

Write-Host '$GenshinRoot is '"$GenshinRoot" -ForegroundColor $NoticeColor
$Config1Path = "$GenshinRoot/config.ini"
$Config2Path = "$GenshinRoot/Genshin Impact Game/config.ini"

# Check if both two config file exist
if (!(Test-Path $Config1Path)) {
    Write-Host "Failed to swith, config file: $Config1Path not exist, nothing changed" -ForegroundColor $ErrorColor
    Write-Host 'Press any key to exit';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    exit
}
if (!(Test-Path $Config2Path)) {
    Write-Host "Failed to swith, config file: $Config2Path not exist, nothing changed" -ForegroundColor $ErrorColor
    Write-Host 'Press any key to exit';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    exit
}

# Get-IniContent and Out-IniFile are copied from:
# https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/
function Get-IniContent ($filePath) {
    $ini = @{}
    switch -regex -file $FilePath {
        "^\[(.+)\]" {
            # Section
            $section = $matches[1]
            $ini[$section] = @{}
            $CommentCount = 0
        }
        "^(;.*)$" {
            # Comment
            $value = $matches[1]
            $CommentCount = $CommentCount + 1
            $name = "Comment" + $CommentCount
            $ini[$section][$name] = $value
        }
        "(.+?)\s*=(.*)" {
            # Key
            $name, $value = $matches[1..2]
            $ini[$section][$name] = $value
        }
    }
    return $ini
}

function Out-IniFile($InputObject, $filePath) {
    # note: changed origin function:
    # do not create new file, store backup
    Copy-Item $filePath "$filePath.Backup"
    Remove-Item $filePath
    $outFile = $filePath # New-Item -ItemType file -Path $filePath
    foreach ($i in $InputObject.keys) {
        if (!($($InputObject[$i].GetType().Name) -eq "Hashtable")) {
            #No Sections
            Add-Content -Path $outFile -Value "$i=$($InputObject[$i])"
        }
        else {
            #Sections
            Add-Content -Path $outFile -Value "[$i]"
            Foreach ($j in ($InputObject[$i].keys | Sort-Object)) {
                if ($j -match "^Comment[\d]+") {
                    Add-Content -Path $outFile -Value "$($InputObject[$i][$j])"
                }
                else {
                    Add-Content -Path $outFile -Value "$j=$($InputObject[$i][$j])"
                }

            }
            Add-Content -Path $outFile -Value ""
        }
    }
}

$Config1 = Get-IniContent $Config1Path
$Config2 = Get-IniContent $Config2Path

# print one config
function Show-Conf($prefix, $config) {
    Write-Host "${prefix}cps         =`t$($config.cps)" -ForegroundColor $DebugColor
    Write-Host "${prefix}channel     =`t$($config.channel)" -ForegroundColor $DebugColor
    Write-Host "${prefix}sub_channel =`t$($config.sub_channel)" -ForegroundColor $DebugColor
}

# print all config
function Show-AllConf() {
    Write-Host "Current config:" -ForegroundColor $DebugColor
    Write-Host " $GenshinRoot/config.ini" -ForegroundColor $DebugColor
    Write-Host "  [launcher]" -ForegroundColor $DebugColor
    Show-Conf "  " $Config1["launcher"]
    if ($config1["General"]) {
        Write-Host "  [General]" -ForegroundColor $DebugColor
        Show-Conf "  " $Config1["General"]
    }
    Write-Host " $GenshinRoot/Genshin Impact Game/config.ini" -ForegroundColor $DebugColor
    Write-Host "  [General]" -ForegroundColor $DebugColor
    Show-Conf "  " $Config2["General"]
}

function Update-Conf($config, $updates) {
    foreach ($i in $updates.keys) {
        $config[$i] = $updates[$i]
    }
}

function Update-AllConf($updates) {
    Update-Conf $Config1["launcher"] $updates
    if ($Config1["General"]) {
        Update-Conf $Config1["General"] $updates
    }
    Update-Conf $Config2["General"] $updates
}

Show-AllConf

if ($Config1["launcher"].cps -eq "bilibili") {
    Write-Host "It's bilibili server, swith to mihoyo server." -ForegroundColor $NoticeColor
    Update-AllConf $Configs.mihoyo
}
else {
    Write-Host "It isn't bilibili server, swith to bilibili server." -ForegroundColor $NoticeColor
    Update-AllConf $Configs.bilibili
}


$confirmation = Read-Host "Execute? [y/n]"
while ($confirmation -ne "y") {
    if ($confirmation -eq 'n') {
        Write-Host "Cancel to execute, nothing changed." -ForegroundColor $NoticeColor
        Write-Host 'Press any key to exit';
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
        exit
    }
    $confirmation = Read-Host "Invalid input, Execute? [y/n]"
}

Out-IniFile $Config1 $Config1Path
Out-IniFile $Config2 $Config2Path

Write-Host "Config updated" -ForegroundColor $NoticeColor

Show-AllConf

if (!(Test-Path "$GenshinRoot/Genshin Impact Game/YuanShen_Data/Plugins/PCGameSDK.dll")) {
    # copy PCGameSDK.dll to Genshin Impact Game, if this dll not exist
    Write-Host "PCGameSDK.dll not exist, copy it" -ForegroundColor $NoticeColor
    Copy-Item $ScriptRoot/PCGameSDK.dll "$GenshinRoot/Genshin Impact Game/YuanShen_Data/Plugins"
}

Write-Host 'Success, Press any key to exit.' -ForegroundColor $SuccessColor
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# * won't use bilibili server, if run YuanShn.exe directly *
# Write-Host 'Done, Press any key to exit. Specailly, Press "y" to run Genshin Impact' -ForegroundColor $SuccessColor
# $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
# if ($key.Character -eq "y") {
#     Write-Host "Run Genshin Impact" -ForegroundColor $NoticeColor
#     Start-Process "$GenshinRoot/Genshin Impact Game/YuanShen.exe"
# }
