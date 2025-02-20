@echo off
setlocal enabledelayedexpansion

:: Check if 0
if exist "C:\NexusPlayRev" (
    echo Proud on you. thx to Get NexusPlay


    echo Terminating PluginLoader_noconsole.exe if running...
    taskkill /f /im PluginLoader_noconsole.exe 2>nul

    :: Download 1
    echo Downloading 1
    curl -L -o "%TEMP%\PluginLoader_noconsole.exe" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/PluginLoader_noconsole.exe"
    if exist "%TEMP%\PluginLoader_noconsole.exe" (
        echo 1 finished
        :: Check if the file exists in the nexus folder and replace it
        if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\PluginLoader_noconsole.exe" (
            echo Replacing existing PluginLoader_noconsole.exe
            del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\PluginLoader_noconsole.exe"
        )
        move "%TEMP%\PluginLoader_noconsole.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
        :: Remove the downloaded file after moving it
        del "%TEMP%\PluginLoader_noconsole.exe"
    ) else (
        echo Failed to download 1
    )

    :: Download 2
    echo Downloading 2
    curl -L -o "%TEMP%\homebrew.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/homebrew.zip"
    if exist "%TEMP%\homebrew.zip" (
        echo Unzipping 2
        :: Check if
        if exist "%USERPROFILE%\homebrew" (
            echo Replacing existing homebrew folder
            rmdir /s /q "%USERPROFILE%\homebrew"
        )
        powershell -command "Expand-Archive -Path '%TEMP%\homebrew.zip' -DestinationPath '%USERPROFILE%'"
    ) else (
        echo Failed to download 2
    )

    :: Download 3
    echo Downloading 3
    curl -L -o "%TEMP%\CEF.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/CEF.zip"
    if exist "%TEMP%\CEF.zip" (
        echo Unzipping 3
        :: Check if
        if exist ".cef-dev-tools-size.vdf" (
            echo Replacing existing CEF folder
            rmdir /s /q ".cef-dev-tools-size.vdf"
        )
        if exist ".cef-enable-remote-debugging" (
            echo Replacing existing CEF folder
            rmdir /s /q ".cef-enable-remote-debugging"
        )
        if not exist "C:\Steam" (
            mkdir "C:\Steam"
        )
        powershell -command "Expand-Archive -Path '%TEMP%\CEF.zip' -DestinationPath 'C:\Steam'"
    ) else (
        echo Failed to download 3
    )

    :: Download and extract
    echo Downloading 413080.zip
    curl -L -o "%TEMP%\413080.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/413080.zip"
    if exist "%TEMP%\413080.zip" (
        echo Unzipping 413080.zip into "config" folders under "C:\Steam\steamapps\common\Steam Controller Configs"
        set "target_path=C:\Steam\steamapps\common\Steam Controller Configs"
        if exist "!target_path!" (
            :: Iterate
            for /d %%d in ("!target_path!\*") do (
                :: Check if
                if exist "%%d\config" (
                    echo Replacing existing config folder in %%d
                    rmdir /s /q "%%d\config"
                )
                mkdir "%%d\config"
                echo Extracting to %%d\config
                powershell -command "Expand-Archive -Path '%TEMP%\413080.zip' -DestinationPath '%%d\config'"
            )
        ) else (
            echo Target path "!target_path!" does not exist.
        )
    ) else (
        echo Failed to download 413080.zip
    )

    :: Download NexusPlaySetup
    echo Downloading NexusPlaySetup.bat
    curl -L -o "%TEMP%\NexusPlaySetup.bat" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/NexusPlaySetup.bat"
    if exist "%TEMP%\NexusPlaySetup.bat" (
        echo Checking if NexusPlaySetup.bat exists in Startup folder
        if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\NexusPlaySetup.bat" (
            echo Replacing existing NexusPlaySetup.bat in Startup folder
            del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\NexusPlaySetup.bat"
        )
        move "%TEMP%\NexusPlaySetup.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
    ) else (
        echo Failed to download NexusPlaySetup.bat
    )

    echo All operations completed.
) else (
    echo Shame on you. Get NexusPlay
)

endlocal
