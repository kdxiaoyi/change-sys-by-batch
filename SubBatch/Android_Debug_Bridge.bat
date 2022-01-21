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
echo  Made by kdXiaoyi. %y%版权所有
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
    for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq adb.exe" /nh') DO api\ntsd.exe -c q -p %%i
rem ↑FOR /F "options"          %variable IN ('command')                                   DO command command-parameters
    echo.
    echo Finish Work
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
set i=
cls
echo.
echo   请稍后……我们正在处理请求……
echo.
echo 1/%i%^> Stop ADB Daemon Service .
tasklist /FI "imagename eq adb.exe"
for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq adb.exe" /nh') DO api\ntsd.exe -c q -p %%i
echo 2/%i%^> Copy Adb files .
copy api\Android_Debug_Bridge\adb.exe %windir%\system32\
copy api\Android_Debug_Bridge\fastboot.exe %windir%\system32\
copy api\Android_Debug_Bridge\AdbWinUsbApi.dll %windir%\system32\
copy api\Android_Debug_Bridge\AdbWinUsbApi.dll %windir%\system32\
echo 3/%i%^> Output log .
echo Android Debug Bridge >>%windir%\system32\Adb.setup_log.txt
echo  ^>Setup Time >>%windir%\system32\Adb.setup_log.txt
echo    %time% >>%windir%\system32\Adb.setup_log.txt
echo  ^>the Number of adb files >>%windir%\system32\Adb.setup_log.txt
echo    4 files >>%windir%\system32\Adb.setup_log.txt
echo     - adb.exe >>%windir%\system32\Adb.setup_log.txt
echo     - fastboot.exe >>%windir%\system32\Adb.setup_log.txt
echo     - adbwinapi.dll >>%windir%\system32\Adb.setup_log.txt
echo     - adbwinusbapi.dll >>%windir%\system32\Adb.setup_log.txt
echo  ^>the SHA256 of adb files (Only data) >>%windir%\system32\Adb.setup_log.txt
echo     - adb.exe          ^<-^> 4B15C1632B0FA74AD114EA963B9D34099728E536DA5B31D80A28F6AFD7029A65 >>%windir%\system32\Adb.setup_log.txt
echo     - fastboot.exe     ^<-^> 342169964160EB3A831AF06BC1662E4166ED45565F798AA1C1609659ED9392FC >>%windir%\system32\Adb.setup_log.txt
echo     - adbwinapi.dll    ^<-^> C70AAEAB8F8D3D2BBFB7E868E82D5F184504BBB2FB721C517D436CCFB5B8CB41 >>%windir%\system32\Adb.setup_log.txt
echo     - adbwinusbapi.dll ^<-^> FB7161D37CC56CB570979E09D76A399208968F3B60E2C31C5B8CC90D42C2C113 >>%windir%\system32\Adb.setup_log.txt
echo. >>%windir%\system32\Adb.setup_log.txt
echo. >>%windir%\system32\Adb.setup_log.txt
echo. >>%windir%\system32\Adb.setup_log.txt
echo Setup Tool made by Bilibili@kdXiaoyi (Home papge : space.bilibili.com/1987247870) >>%windir%\system32\Adb.setup_log.txt
echo.
echo Setup Okay
echo.
ping 127.0.0.1 -n 6 >nul
notepad.exe Adb.setup_log.txt
goto menu