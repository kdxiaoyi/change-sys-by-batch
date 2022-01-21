@echo off
echo.
if NOT EXIST api\Android_Debug_Bridge\adb.exe (
    set errorcode=CSBB/ADB:no_adb.adb
    goto error
)
if NOT EXIST api\Android_Debug_Bridge\fastboot.exe (
    set errorcode=CSBB/ADB:no_adb.fastboot
    goto error
)
if NOT EXIST api\Android_Debug_Bridge\adbWinApi.dll (
    set errorcode=CSBB/ADB:no_adb.dll.adbWinApi
    goto error
)
if NOT EXIST api\Android_Debug_Bridge\AdbWinUsbApi.dll (
    set errorcode=CSBB/ADB:no_adb.dll.AdbWinUsbApi
    goto error
)
cls
goto menu

:menu
cls
echo ^> Android Debug Bridge / Choice Mode
echo ===================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] Run Adb.exe
echo.    [2] Run Fastboot.exe
echo.    [3] 将Adb注册到系统(这样你就可以在任何地方打开adb了)
echo.    [4] 终止ADB Daemon Service
echo.
echo     [0] EXIT
echo  Made by kdXiaoyi. 2022版权所有
echo ===================================================================
echo SysBit=x%sysbit%
api\choice.exe /c 12304 /N /M 从中选择一项^>
cls
if %ERRORLEVEL%==1 (
    echo 这里提交的参数将作为adb.exe的参数。
    echo 你可以使用[#exit] （小写，不带括号）退出
    goto adb
)
if %ERRORLEVEL%==2 (
    echo 这里提交的参数将作为fastboot.exe的参数。
    echo 你可以使用[#exit] （小写，不带括号）退出
    goto fb
)
if %ERRORLEVEL%==3 goto reg
if %ERRORLEVEL%==4 call main.bat
if %ERRORLEVEL%==5 (
    echo STOPPING SERVICE ...
    tasklist /FI "imagename eq adb.exe"
    echo.
    taskkill /f /im adb.exe
    echo OKAY.
    ping 127.0.0.1 -n 4 >nul
    goto menu
)
goto menu

:error
color F4
title Stopped by a error ^| ERRORCODE^>%Errorcode%
set i=1
set CrashFile=%temp%\CSBB\Crash-s\%random%%RANDOM%%Random%
md %CrashFile%
echo Crash Report >>"%CrashFile%\CRASH_REPORT.log"
echo ================================================= >>"%CrashFile%\CRASH_REPORT.log"
set i=20
echo  ^> Oh,no,this is the 115414th crash report! >>"%CrashFile%\CRASH_REPORT.log"
echo. >>"%CrashFile%\CRASH_REPORT.log"
echo Time = %time2% >>"%CrashFile%\CRASH_REPORT.log"
echo Errorcode = %errorcode% >>"%CrashFile%\CRASH_REPORT.log"
echo SysBit = x%SysBit% >>"%CrashFile%\CRASH_REPORT.log"
echo SysVer =  >>"%CrashFile%\CRASH_REPORT.log"
Ver >>"%CrashFile%\CRASH_REPORT.log"
set i=50
echo Lang = %LANG% >>"%CrashFile%\CRASH_REPORT.log"
echo SysDrive = %SystemDrive% >>"%CrashFile%\CRASH_REPORT.log"
echo PROCESSOR ARCHITECTURE = %PROCESSOR_ARCHITECTURE% >>"%CrashFile%\CRASH_REPORT.log"
echo OS Center = %OS% >>"%CrashFile%\CRASH_REPORT.log"
echo Command Spec = %ComSpec% >>"%CrashFile%\CRASH_REPORT.log"
echo Temp File = %temp% >>"%CrashFile%\CRASH_REPORT.log"
echo App Ver = %AppVer% >>"%CrashFile%\CRASH_REPORT.log"
echo CPU NAME = %PROCESSOR_ARCHITECTURE% >>"%CrashFile%\CRASH_REPORT.log"
echo CPU INFO = %PROCESSOR_ARCHITEW6432% >>"%CrashFile%\CRASH_REPORT.log"
echo. >>"%CrashFile%\CRASH_REPORT.log"
set i=98
echo Sub.End () >>"%CrashFile%\CRASH_REPORT.log"
set i=100
cls
echo.
echo    : (
echo.
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% % complete
echo.
echo    If you want to feed back (Up a Issues) , give me these info:
echo    E-Mail Address : popo0713@foxmail.com
echo    Stop code : %errorcode%
echo.
echo  Any key to open error info.
echo   ERROR_INFO_FILE=%CrashFile%
pause>nul
api\OpenURL.exe -u file:///%CrashFile%
exit

:adb
set input=-help
set /p input= #ADB ^> 
if "%input%"=="#exit" goto menu
api\Android_Debug_Bridge\adb.exe %input%
echo.
goto adb

:fb
set input=-help
set /p input= #FASTBOOT ^> 
if "%input%"=="#exit" goto menu
api\Android_Debug_Bridge\FASTBOOT.exe %input%
echo.
goto fb

:reg