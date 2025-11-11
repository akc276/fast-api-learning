@echo off
setlocal

@REM Customizable variables
set PORT=44787
@REM set targetDir="%OneDrive%\Documents\Codes\Python\enna\repos"
set targetDir="%CD%\Python\GUI\p3"
set ENNA_CONFIG_PATH="%~dp0\Python\enna\enna_tc_tutorial-main (1)\enna_tc_tutorial-main\config"

set  NODE_TLS_REJECT_UNAUTHORIZED=0
@REM Sets the path for pip.ini file, without it, it won't take index-url
set PIP_CONFIG_FILE=%~dp0\.venv\pip.ini


@REM Sets path variables
set PATH=set PATH=%APPDATA%\npm;C:\Program Files\nodejs;%PATH%

set PATH=%OneDrive%\Documents\Softwares\ffmpeg-2025-10-12-git-0bc54cddb1-full_build\bin;%APPDATA%\npm;C:\Program Files\nodejs;%OneDrive%\Documents\Codes\.venv\Scripts;C:\Program Files\Python312;C:\Program Files\Python312\Scripts;%APPDATA%\Python\Python312\site-packages\PyQtInspect;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\VC\Tools\MSVC\14.16.27023\bin\HostX86\x86;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\Common7\IDE\VC\VCPackages;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\Common7\IDE\CommonExtensions\Microsoft\TestWindow;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\MSBuild\15.0\bin\Roslyn;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\\MSBuild\15.0\bin;C:\Windows\Microsoft.NET\Framework\v4.0.30319;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\Common7\IDE\;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\Common7\Tools\;C:\Bazel;C:\Program Files\Microsoft VS Code\bin;C:\Program Files (x86)\Gpg4win\..\GnuPG\bin;C:\Program Files\CMake\bin;C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;%USERPROFILE%\AppData\Local\Microsoft\WindowsApps;%USERPROFILE%\AppData\Local\Microsoft\WinGet\Packages\Bazel.Bazelisk_Microsoft.Winget.Source_8wekyb3d8bbwe;C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\VC\Tools\MSVC\14.16.27023\bin\Hostx86\x64;C:\Windows\System32;C:\Windows\SysWOW64;C:\Windows\WinSxS;C:\Program Files\7-Zip;C:\Program Files\CMake\bin;C:\WINDOWS\system32;C:\Program Files\Git\bin;C:\Program Files (x86)\GnuPG\bin;C:\Program Files\mosquitto;%PATH%
echo Path for python and pip set

@REM makes project to use global installations
@REM Inside .bat file
for /f "usebackq tokens=*" %%f in (`npm root -g`) do set NODE_PATH=%%f
@REM Outside .bat file
@REM for /f "tokens=* usebackq" %f in (`npm root -g`) do set NODE_PATH=%f                               

@REM Activates python environment
set activate_path="%~dp0Scripts\activate.bat"
echo "Activating python venv" %activate_path%
call %activate_path%


@echo off
echo Setting up env for Node.js
call "C:\Program Files\nodejs\nodevars.bat"
echo Node.js environment loaded!


@REM START - Decide which directory is opened in terminal
set "launchDir=%CD%"
set "batDir=%~dp0"

:: Remove trailing backslash if present
if "%launchDir:~-1%"=="\" set "launchDir=%launchDir:~0,-1%"
if "%batDir:~-1%"=="\" set "batDir=%batDir:~0,-1%"

echo Launch Directory: %launchDir%
echo Batch File Location: %batDir%

if /I "%launchDir%"=="%batDir%" (
    cd %targetDir%
) else (
    cd launchDir
)

@REM END - Decide which directory is opened in terminal



@REM START - Start HTTPS Proxy
netstat -an | find ":%PORT%" >nul

if %errorlevel%==0 (
    echo Port %PORT% is active. Setting https proxy
    set https_proxy=http://127.0.0.1:%PORT%
    set http_proxy=http://127.0.0.1:%PORT%
    git config --global --set http.proxy http://127.0.0.1:%PORT%
    git config --global --set https.proxy http://127.0.0.1:%PORT%

) else (
    echo Port %PORT% is not active.
    set https_prox=
    set http_proxy=
    echo https_proxy = %https_proxy%
    
    git config --global --unset http.proxy
    git config --global --unset https.proxy

)
@REM END - Start HTTPS Proxy

cmd
