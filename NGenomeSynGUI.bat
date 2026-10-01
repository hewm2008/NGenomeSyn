@echo off
setlocal EnableExtensions EnableDelayedExpansion
title NGenomeSyn GUI

rem ============================================================
rem  NGenomeSyn GUI launcher - Windows
rem  Keep this file CRLF and ASCII only.
rem ============================================================

set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"

if exist "%DIR%\dist\NGenomeSynGUI\NGenomeSynGUI.exe" (
    start "" "%DIR%\dist\NGenomeSynGUI\NGenomeSynGUI.exe"
    exit /b 0
)
if exist "%DIR%\NGenomeSynGUI\NGenomeSynGUI.exe" (
    start "" "%DIR%\NGenomeSynGUI\NGenomeSynGUI.exe"
    exit /b 0
)

set "PY="
where py >nul 2>&1 && set "PY=py -3"
if not defined PY where python >nul 2>&1 && set "PY=python"
if not defined PY (
    echo.
    echo [ERROR] Python 3.9 or newer was not found in PATH.
    echo         Install it from https://www.python.org/downloads/ and
    echo         tick Add-python-to-PATH during setup.
    echo.
    pause
    exit /b 1
)

%PY% -c "import PySide6" >nul 2>&1
if errorlevel 1 (
    echo [1/2] Installing PySide6 - this takes 1 to 2 minutes...
    %PY% -m pip install PySide6 1>nul 2>&1
    if errorlevel 1 %PY% -m pip install --user PySide6 1>nul 2>&1
    if errorlevel 1 %PY% -m pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple PySide6 1>nul 2>&1
    %PY% -c "import PySide6" >nul 2>&1
    if errorlevel 1 (
        echo.
        echo [ERROR] PySide6 install failed. Try this by hand:
        echo         python -m pip install PySide6
        echo.
        pause
        exit /b 1
    )
)

echo [2/2] Checking the Perl engine...
%PY% "%DIR%\gui\main.py" --selftest
if errorlevel 1 (
    echo.
    echo [ERROR] Self-test failed - fix the problem shown above.
    echo         The engine needs Perl; on Windows unzip portable
    echo         Strawberry Perl into gui_runtime\perl\
    echo.
    pause
    exit /b 1
)

rem  pythonw from the SAME interpreter: a system-wide pythonw belonging to
rem  another Python without PySide6 would show no window at all.
set "PYW="
set "PYEXE="
for /f "delims=" %%P in ('%PY% -c "import sys;print(sys.executable)" 2^>nul') do set "PYEXE=%%P"
if defined PYEXE set "PYW=!PYEXE:python.exe=pythonw.exe!"
if not exist "!PYW!" set "PYW="

if defined PYW (
    start "" "!PYW!" "%DIR%\gui\main.py"
) else (
    start "NGenomeSyn GUI" %PY% "%DIR%\gui\main.py"
)
exit /b 0
