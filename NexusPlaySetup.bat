@echo off
setlocal enabledelayedexpansion

:: Check if 0
if exist "C:\NexusPlayRev" (
    echo Proud on you. thx to Get NexusPlay

    :: Download 1
    echo Downloading 1
    curl -L -o "%TEMP%\PluginLoader_noconsole.exe" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/PluginLoader_noconsole.exe"
    if exist "%TEMP%\PluginLoader_noconsole.exe" (
        echo 1 finished
        move "%TEMP%\PluginLoader_noconsole.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
    ) else (
        echo Failed to download 1
    )

    :: Download 2
    echo Downloading 2
    curl -L -o "%TEMP%\homebrew.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/homebrew.zip"
    if exist "%TEMP%\homebrew.zip" (
        echo Unzipping 2
        powershell -command "Expand-Archive -Path '%TEMP%\homebrew.zip' -DestinationPath '%USERPROFILE%'"
    ) else (
        echo Failed to download 2
    )

    :: Download 3
    echo Downloading 3
    curl -L -o "%TEMP%\CEF.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/CEF.zip"
    if exist "%TEMP%\CEF.zip" (
        echo Unzipping 3
        if not exist "C:\Steam" (
            mkdir "C:\Steam"
        )
        powershell -command "Expand-Archive -Path '%TEMP%\CEF.zip' -DestinationPath 'C:\Steam'"
    ) else (
        echo Failed to download 3
    )

    :: Download and extract 413080.zip into all folders in the target path
    echo Downloading 413080.zip
    curl -L -o "%TEMP%\413080.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/413080.zip"
    if exist "%TEMP%\413080.zip" (
        echo Unzipping 413080.zip into all folders in "C:\Steam\steamapps\common\Steam Controller Configs"
        set "target_path=C:\Steam\steamapps\common\Steam Controller Configs"
        if exist "!target_path!" (
            for /d %%d in ("!target_path!\*") do (
                echo Extracting to %%d
                powershell -command "Expand-Archive -Path '%TEMP%\413080.zip' -DestinationPath '%%d'"
            )
        ) else (
            echo Target path "!target_path!" does not exist.
        )
    ) else (
        echo Failed to download 413080.zip
    )

    echo All operations completed.
) else (
    echo Shame on you. Get NexusPlay
)

endlocal
pause