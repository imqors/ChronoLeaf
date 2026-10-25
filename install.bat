@echo off
setlocal EnableExtensions EnableDelayedExpansion
title ChronoLeaf 2.2.1 build by imqors.com

set "BASE_URL=https://github.imqors.com/chronoleaf"
set "WORK=%TEMP%\chronoleaf_build_%RANDOM%_%RANDOM%"
set "OUTDIR=%USERPROFILE%\Desktop\ChronoLeaf"
set "PYTHON="

echo ========================================
echo ChronoLeaf 2.2.1 build by imqors.com
echo ========================================
echo Source : %BASE_URL%
echo Output : %OUTDIR%
echo.

where curl >nul 2>nul
if errorlevel 1 (
   echo [ERROR] curl is required. Windows 10 1803 or newer is recommended.
    goto :fail
)

if exist "%WORK%" rmdir /s /q "%WORK%"
mkdir "%WORK%" || goto :fail
mkdir "%WORK%\assets" || goto :fail
cd /d "%WORK%" || goto :fail

echo [1/6] Downloading sources...
curl -fL --retry 2 --retry-delay 1 -o chronoleaf.py "%BASE_URL%/chronoleaf.py"
if errorlevel 1 goto :dl_fail
curl -fL --retry 2 --retry-delay 1 -o requirements.txt "%BASE_URL%/requirements.txt"
if errorlevel 1 goto :dl_fail
curl -fL --retry 2 --retry-delay 1 -o assets\chronoleaf.png "%BASE_URL%/assets/chronoleaf.png"
if errorlevel 1 goto :dl_fail
curl -fL --retry 2 --retry-delay 1 -o assets\chronoleaf.ico "%BASE_URL%/assets/chronoleaf.ico"
if errorlevel 1 goto :dl_fail

for %%F in (chronoleaf.py requirements.txt assets\chronoleaf.png assets\chronoleaf.ico) do if not exist "%%F" goto :dl_fail

echo [2/6] Finding a compatible installed Python...
where py >nul 2>nul
if not errorlevel 1 (
    for %%V in (3.12 3.11 3.13 3.10 3.9 3.8) do (
        py -%%V -c "import sys; print(sys.version)" >nul 2>nul
        if not errorlevel 1 if not defined PYTHON set "PYTHON=py -%%V"
    )
)
if not defined PYTHON (
    for %%P in (python.exe python3.exe) do (
        where %%P >nul 2>nul
        if not errorlevel 1 if not defined PYTHON set "PYTHON=%%P"
    )
)
if not defined PYTHON (
   echo [ERROR] No compatible Python found.
    echo Install Python 3.8-3.13 from https://www.python.org/downloads/windows/
    goto :fail
)
echo Using: %PYTHON%
%PYTHON% -c "import sys; print(sys.version)"
if errorlevel 1 goto :fail

echo [3/6] Installing build tools and application dependencies...
%PYTHON% -m ensurepip --upgrade >nul 2>nul
%PYTHON% -m pip install --upgrade pip setuptools wheel
if errorlevel 1 goto :fail
%PYTHON% -m pip install -r requirements.txt
if errorlevel 1 (
   echo [WARN] requirements.txt failed; trying the known Flet desktop runtime.
    %PYTHON% -m pip install "flet==0.27.6" "flet-desktop==0.27.6"
    if errorlevel 1 goto :fail
)
%PYTHON% -m pip install --upgrade pyinstaller
if errorlevel 1 goto :fail

echo [4/6] Checking Python source...
%PYTHON% -m py_compile chronoleaf.py
if errorlevel 1 goto :fail

echo [5/6] Building EXE...
%PYTHON% -m PyInstaller --clean --noconfirm --onefile --windowed ^
  --name ChronoLeaf ^
  --icon assets\chronoleaf.ico ^
  --add-data "assets;assets" ^
  --collect-all flet ^
  --collect-all flet_desktop ^
  chronoleaf.py
if errorlevel 1 goto :fail

echo [6/6] Copying output...
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
copy /y "dist\ChronoLeaf.exe" "%OUTDIR%\ChronoLeaf.exe" >nul
if errorlevel 1 goto :fail

cd /d "%TEMP%"
rmdir /s /q "%WORK%" 2>nul
echo.
echo ========================================
echo BUILD SUCCESSFUL
echo ========================================
echo EXE      : %OUTDIR%\ChronoLeaf.exe
echo Publisher: imqors.com
echo Data     : %USERPROFILE%\.chronoleaf_data.json
echo ========================================
start "" "%OUTDIR%"
pause
exit /b 0

:dl_fail
echo.
echo [ERROR] Could not download all files from %BASE_URL%
echo Check the source URL and that all files exist.
goto :cleanup_fail

:fail
echo.
echo [ERROR] BUILD FAILED.
:cleanup_fail
cd /d "%TEMP%" 2>nul
if exist "%WORK%" rmdir /s /q "%WORK%" 2>nul
pause
exit /b 1
