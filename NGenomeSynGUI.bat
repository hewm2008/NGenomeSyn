@echo off
setlocal EnableExtensions EnableDelayedExpansion
title NGenomeSyn GUI

rem ============================================================
rem  NGenomeSyn GUI launcher - Windows
rem
rem  KEEP THIS FILE CRLF + ASCII.  LF line endings make cmd.exe
rem  mis-parse the multi-line blocks below: double-click then only
rem  flashes and dies with no message.  gui/tests enforces this.
rem ============================================================

rem Optional: hard-code the python.exe that works for you.
rem Example:
rem   set "PY_OVERRIDE=C:\Users\kangy\miniconda3\envs\plant_rnaseq\python.exe"
set "PY_OVERRIDE="

rem This launcher always runs the GUI from source with the same Python
rem that passed the self-test.  It deliberately does NOT auto-launch a
rem bundled PyInstaller exe from dist\: a half-finished build there
rem would make double-click fail.  If you built one with
rem gui\tools\build_windows.py, double-click that exe instead.

set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"
if not defined TEMP set "TEMP=%USERPROFILE%"
set "LOG=%TEMP%\ngs_gui_launcher.log"
echo [%date% %time%] launcher start > "%LOG%"
echo   DIR = %DIR% >> "%LOG%"

set "PY="
set "PYEXE="
set "PYW="
set "HAS_PYSIDE6="
if defined PY_OVERRIDE call :try_py "%PY_OVERRIDE%"
if not defined HAS_PYSIDE6 call :conda_envs
if not defined HAS_PYSIDE6 call :path_python
if not defined PY goto :no_python
set "PYEXE=%PY%"
call :derive_pythonw
echo [py] using %PY% >> "%LOG%"

if not defined HAS_PYSIDE6 (
    echo [1/2] Installing PySide6 - this takes 1 to 2 minutes...
    echo [1/2] installing PySide6 >> "%LOG%"
    call :install_pyside6
    if errorlevel 1 goto :no_pyside6
    "%PY%" -c "import PySide6" >nul 2>&1
    if errorlevel 1 goto :no_pyside6
)

echo [2/2] Checking the Perl engine...
echo [2/2] self-test >> "%LOG%"
"%PY%" "%DIR%\gui\main.py" --selftest >> "%LOG%" 2>&1
if errorlevel 1 goto :selftest_failed

echo [launch] %PYW% >> "%LOG%"
if defined PYW (
    start "" "%PYW%" "%DIR%\gui\main.py"
) else (
    start "NGenomeSyn GUI" "%PY%" "%DIR%\gui\main.py"
)
exit /b 0

rem ----------------------------------------------------------------
rem  interpreter discovery: PY_OVERRIDE, then conda, then PATH
rem ----------------------------------------------------------------

rem :try_py <python.exe> - keep the first interpreter that really runs,
rem and prefer one that already has PySide6.
:try_py
if defined HAS_PYSIDE6 goto :eof
set "CAND=%~1"
if not exist "%CAND%" goto :eof
"%CAND%" -c "import sys" >nul 2>&1
if errorlevel 1 goto :eof
set "PY=%CAND%"
"%CAND%" -c "import PySide6" >nul 2>&1
if errorlevel 1 (
    echo [py] interpreter without PySide6: %CAND% >> "%LOG%"
    goto :eof
)
set "HAS_PYSIDE6=1"
echo [py] interpreter with PySide6: %CAND% >> "%LOG%"
goto :eof

rem :conda_envs - miniconda3/anaconda3 installs, envs before base
:conda_envs
for %%R in (
    "%LOCALAPPDATA%\miniconda3"
    "%USERPROFILE%\miniconda3"
    "%USERPROFILE%\anaconda3"
    "%USERPROFILE%\AppData\Local\Continuum\anaconda3"
    "C:\miniconda3"
    "C:\anaconda3"
    "C:\ProgramData\miniconda3"
    "C:\ProgramData\Anaconda3"
) do call :conda_root "%%~R"
goto :eof

:conda_root
if defined HAS_PYSIDE6 goto :eof
if not exist "%~1\Scripts\conda.exe" goto :eof
for /d %%E in ("%~1\envs\*") do if not defined HAS_PYSIDE6 call :try_py "%%~E\python.exe"
if not defined HAS_PYSIDE6 call :try_py "%~1\python.exe"
goto :eof

rem :path_python - the py launcher first, then python from PATH
:path_python
if defined HAS_PYSIDE6 goto :eof
set "CMD="
where py >nul 2>&1
if not errorlevel 1 set "CMD=py -3"
if not defined CMD (
    where python >nul 2>&1
    if not errorlevel 1 set "CMD=python"
)
if not defined CMD goto :eof
set "CAND="
for /f "delims=" %%P in ('%CMD% -c "import sys;print(sys.executable)" 2^>nul') do if not defined CAND set "CAND=%%P"
if defined CAND call :try_py "%CAND%"
goto :eof

rem pythonw from the SAME interpreter: a system-wide pythonw belonging to
rem another Python without PySide6 would show no window at all.
:derive_pythonw
set "PYW="
set "PYW=!PYEXE:python.exe=pythonw.exe!"
if not exist "!PYW!" set "PYW="
goto :eof

:install_pyside6
"%PY%" -m pip install PySide6 1>>"%LOG%" 2>&1
if not errorlevel 1 goto :eof
"%PY%" -m pip install --user PySide6 1>>"%LOG%" 2>&1
if not errorlevel 1 goto :eof
"%PY%" -m pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple PySide6 1>>"%LOG%" 2>&1
goto :eof

rem ----------------------------------------------------------------
rem  failures: always say something, never close silently
rem ----------------------------------------------------------------

:no_python
echo.
echo [ERROR] No usable Python 3 interpreter was found.
echo         Install Python 3.9+ and tick "Add python to PATH", or
echo         install Miniconda, or set PY_OVERRIDE at the top of this
echo         .bat to a full python.exe path.
echo.
echo         Log: %LOG%
goto :failed

:no_pyside6
echo.
echo [ERROR] PySide6 is missing and could not be installed. Try by hand:
echo           "%PY%" -m pip install PySide6
echo           "%PY%" -m pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple PySide6
echo.
echo         Log: %LOG%
goto :failed

:selftest_failed
echo.
echo [ERROR] Self-test failed - the GUI cannot start safely.
echo         The engine needs Perl. On Windows unzip portable Strawberry
echo         Perl into gui_runtime\perl\ so that
echo         gui_runtime\perl\perl\bin\perl.exe exists.
echo.
echo ----- last 25 log lines -----
powershell -NoProfile -Command "Get-Content '%LOG%' -Tail 25" 2>nul
echo ---------------------------
echo.
goto :failed

:failed
echo.
pause
exit /b 1
