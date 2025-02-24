@echo off
:: Check if running in visible mode, then relaunch hidden
if "%1" neq "hidden" (
    powershell -WindowStyle Hidden -Command "Start-Process '%~0' -ArgumentList 'hidden' -WindowStyle Hidden"
)

:: Check for internet connection
echo Checking for internet connection...
ping 8.8.8.8 -n 1 -w 1000 >nul
if errorlevel 1 (
    echo Please check your internet connection.
    exit /b 1
) else (
    echo Internet connection detected. Continuing...
)

setlocal enabledelayedexpansion

if exist "C:\NexusPlayRev" (
    echo Proud on you. thx to Get NexusPlay

    echo Terminating PluginLoader_noconsole.exe if running...  
    taskkill /f /im PluginLoader_noconsole.exe 2>nul  

    :: Download 1  
    echo Downloading 1  
    curl -L -o "%TEMP%\PluginLoader_noconsole.exe" "https://github.com/NitiveSA/NexusPlay-I/raw/refs/heads/main/PluginLoader_noconsole.exe"  
    if exist "%TEMP%\PluginLoader_noconsole.exe" (  
        echo 1 finished  

        :: Check file size
        for %%F in ("%TEMP%\PluginLoader_noconsole.exe") do set "size=%%~zF"
        set "min_size=14000000"  :: 13.4 MB in bytes (13.4 * 1024 * 1024)

        if !size! lss !min_size! (
            echo File size is less than 13.4 MB. Deleting the file and exiting...
            del "%TEMP%\PluginLoader_noconsole.exe"
            
        ) else (
            echo File size is valid. Continuing...
        )

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
        echo 2 finished  

        :: Check file size
        for %%F in ("%TEMP%\homebrew.zip") do set "size=%%~zF"
        set "min_size=12900000"  :: 12.3 MB in bytes (12.3 * 1024 * 1024)

        if !size! lss !min_size! (
            echo File size is less than 12.3 MB. Deleting the file and exiting...
            del "%TEMP%\homebrew.zip"
            
        ) else (
            echo File size is valid. Continuing...
        )

        :: Unzip homebrew.zip
        echo Unzipping 2  
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
pause
