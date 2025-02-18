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
        :: Check if the file exists in the Startup folder and replace it
        if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\PluginLoader_noconsole.exe" (
            echo Replacing existing PluginLoader_noconsole.exe
            del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\PluginLoader_noconsole.exe"
        )
        move "%TEMP%\PluginLoader_noconsole.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"
    ) else (
        echo Failed to download 1
    )

    :: Download 2
    echo Downloading 2
    curl -L -o "%TEMP%\homebrew.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/homebrew.zip"
    if exist "%TEMP%\homebrew.zip" (
        echo Unzipping 2
        :: Check if the homebrew folder exists and delete it before extracting
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
        :: Check if the CEF folder exists and delete it before extracting
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

    :: Download and extract 413080.zip into the "config" folder inside each folder under the target path
    echo Downloading 413080.zip
    curl -L -o "%TEMP%\413080.zip" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/413080.zip"
    if exist "%TEMP%\413080.zip" (
        echo Unzipping 413080.zip into "config" folders under "C:\Steam\steamapps\common\Steam Controller Configs"
        set "target_path=C:\Steam\steamapps\common\Steam Controller Configs"
        if exist "!target_path!" (
            :: Iterate through all folders under the target path
            for /d %%d in ("!target_path!\*") do (
                :: Check if the "config" folder exists, if not, create it
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

    :: Download NexusPlaySetup.bat and replace it in the Startup folder if it exists
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
pause
