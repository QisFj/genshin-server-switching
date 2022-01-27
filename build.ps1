# this script build a release.
$ErrorActionPreference = "Stop" # see https://stackoverflow.com/a/9949909/6426001
function CheckLastExitCode {
    if (!$?) {
        $LAST = $LASTEXITCODE # store last exit code to avoid Write-Host overwrite
        Write-Host "Last CMD failed" -ForegroundColor Red
        Exit $LAST
    }
}
function CleanLine {
    Write-Host -NoNewline "`r$(" " * 64)`r"
}

Set-Location $PSScriptRoot

# clean output directory
if (Test-Path ./output) {
    Remove-Item ./output -Recurse -Force
}
New-Item -ItemType Directory ./output | Out-Null # see https://stackoverflow.com/a/46586504/6426001

# build pure
Write-Output "pure: building..."
New-Item -ItemType Directory ./output/temp | Out-Null # create temp dir
Copy-Item ./run.ps1 ./output/temp/
Copy-Item ./PCGameSDK.dll ./output/temp/
Copy-Item ./README.md ./output/temp/
Compress-Archive -Path ./output/temp/* -Destination ./output/pure.zip -CompressionLevel Optimal
Remove-Item ./output/temp -Recurse -Force
Write-Output "pure: build success"


# build with helper
Write-Output "with-helper: building..."
New-Item -ItemType Directory ./output/temp | Out-Null # create temp dir
Copy-Item ./run.ps1 ./output/temp/
Copy-Item ./PCGameSDK.dll ./output/temp/
Copy-Item ./README.md ./output/temp/
# ahk output based on ./helper 
Ahk2Exe `
    /in ./helper/genshin.ahk `
    /out ../output/temp/genshin-ahk.exe `
    /compress 0
# CheckLastExitCode not make sense here, just check if the output exists
# ahk2exe compile async, so we need to wait for it
Write-Host -NoNewline "Waiting for ahk compile"
for ($i=0; $i -lt 10; $i++) {
    if (Test-Path ./output/temp/genshin-ahk.exe) {
        break
    }
    CleanLine
    Write-Host -NoNewline "waiting for ahk compile$("." * ($i % 5))"
    Start-Sleep -Seconds 1
}
CleanLine
if (!(Test-Path ./output/temp/genshin-ahk.exe)) {
    Write-Host "ahk compile failed" -ForegroundColor Red
    Exit 1
}
Write-Host "ahk compile success"
Compress-Archive -Path ./output/temp/* -Destination ./output/with-helper.zip -CompressionLevel Optimal
Remove-Item ./output/temp -Recurse -Force
Write-Output "with-helper: build success"
