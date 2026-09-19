@echo off
setlocal enabledelayedexpansion
title ChronoLeaf 2.1.5 remote build

set "BASE_URL=https://github.imqors.com/chronoleaf"
set "WORK=%TEMP%\chronoleaf_build_%RANDOM%"
set "OUTDIR=%USERPROFILE%\Desktop\ChronoLeaf"

echo ========================================
echo ChronoLeaf 2.1.5 remote build
echo ========================================
echo Source : %BASE_URL%
echo Work   : %WORK%
echo Output : %OUTDIR%
echo.

:: ── 1. Проверка curl ──
where curl >nul 2>nul
if errorlevel 1 (
    echo [ERROR] curl not found. Windows 10 1803+ required.
    goto :fail
)

:: ── 2. Подготовка временной папки ──
if exist "%WORK%" rmdir /s /q "%WORK%"
mkdir "%WORK%"
mkdir "%WORK%\assets"
cd /d "%WORK%"

:: ── 3. Скачивание исходников ──
echo [1/5] Downloading sources...
curl -fsSL -o chronoleaf.py    "%BASE_URL%/chronoleaf.py"
if errorlevel 1 goto :dl_fail
curl -fsSL -o requirements.txt "%BASE_URL%/requirements.txt"
if errorlevel 1 goto :dl_fail
curl -fsSL -o assets\chronoleaf.png "%BASE_URL%/assets/chronoleaf.png"
if errorlevel 1 goto :dl_fail
curl -fsSL -o assets\chronoleaf.ico "%BASE_URL%/assets/chronoleaf.ico"
if errorlevel 1 goto :dl_fail

:: ── 4. Проверка, что всё скачалось ──
if not exist chronoleaf.py            goto :dl_fail
if not exist requirements.txt         goto :dl_fail
if not exist assets\chronoleaf.png    goto :dl_fail
if not exist assets\chronoleaf.ico    goto :dl_fail

:: ── 5. Python ──
echo [2/5] Detecting Python...
where py >nul 2>nul
if %errorlevel%==0 (set "PYTHON=py") else (set "PYTHON=python")
%PYTHON% --version >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Python not found.
    goto :fail
)

:: ── 6. Зависимости ──
echo [3/5] Installing dependencies...
%PYTHON% -m pip install --upgrade pip >nul 2>nul
%PYTHON% -m pip install -r requirements.txt
if errorlevel 1 goto :fail

:: ── 7. Компиляция ──
echo [4/5] Compiling chronoleaf.py...
%PYTHON% -m py_compile chronoleaf.py
if errorlevel 1 goto :fail

:: ── 8. Сборка EXE ──
echo [5/5] Building EXE...
%PYTHON% -m PyInstaller --clean --noconfirm --onefile --windowed ^
  --name ChronoLeaf ^
  --icon assets\chronoleaf.ico ^
  --add-data "assets;assets" ^
  --collect-all flet ^
  --collect-all flet_desktop ^
  chronoleaf.py
if errorlevel 1 goto :fail

:: ── 9. Копирование результата ──
if not exist "%OUTDIR%" mkdir "%OUTDIR%"
copy /y "dist\ChronoLeaf.exe" "%OUTDIR%\ChronoLeaf.exe" >nul
if errorlevel 1 goto :fail

:: ── 10. Очистка ──
cd /d "%TEMP%"
rmdir /s /q "%WORK%" 2>nul

echo.
echo ========================================
echo  BUILD SUCCESSFUL
echo ========================================
echo  EXE    : %OUTDIR%\ChronoLeaf.exe
echo  Data   : %USERPROFILE%\.chronoleaf_data.json  (created on first run)
echo ========================================
start "" "%OUTDIR%"
pause
exit /b 0

:dl_fail
echo.
echo [ERROR] Failed to download from %BASE_URL%
echo         Check that the URL is reachable and files exist.
cd /d "%TEMP%"
rmdir /s /q "%WORK%" 2>nul
pause
exit /b 1

:fail
echo.
echo [ERROR] BUILD FAILED
cd /d "%TEMP%"
rmdir /s /q "%WORK%" 2>nul
pause
exit /b 1
