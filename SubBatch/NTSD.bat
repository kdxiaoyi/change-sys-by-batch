@REM 命令核心：
@REM api\ntsd.exe -c q -p [pid]
@REM 快速杀PID
@REM
@REM api\ntsd.exe -p [pid]
@REM 调试PID
@REM
@REM for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq [imagename]" /nh') DO start /wait "CSBB/ntsd:kill.imagename" api\ntsd.exe -c q -p %%i
@REM 搜寻镜像名为[imagename]的PID并传递到NTSD(去杀进程)
@REM
@echo off
if NOT EXIST api\ntsd.exe (
    set errorcode=CSBB/ntsd:no.ntsd.file
    goto error
)
if NOT "%isgotuac%"=="1" (
    cls
    echo.
    echo    错误：权限不足。
    echo  [User] ^< Need:[UAC-Admin]
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
)

:menu
cls
echo ^> NTSD menu
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] NTSD 强杀进程 (镜像名模式)
echo.    [2] NTSD 强杀进程 (PID模式)
echo.    [3] NTSD 快速调试 (镜像名模式)
echo.    [4] NTSD 快速调试 (PID模式)
echo.    [5] 列出所有进程
echo.    [6] 根据镜像名取PID
echo.    [7] 根据PID取镜像名
echo.
echo  WARING:NTSD现在基本废掉。服务进程无法调试，杀软等特殊进程拒绝访问
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
api\choice.exe /c 01234567 /N /M 从中选择一项^>
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 goto imagename.kill
if %ERRORLEVEL%==3 goto pid.kill
if %ERRORLEVEL%==4 goto imagename.debug
if %ERRORLEVEL%==5 goto pid.debug
if %ERRORLEVEL%==6 goto tasklist.all
if %ERRORLEVEL%==7 goto imagename.to.pid
if %ERRORLEVEL%==8 goto pid.to.imagename
goto menu

:tasklist.all
cls
tasklist | more /e /c /p /s
echo.
echo Finish Work.
pause>nul
goto menu

:imagename.to.pid
cls
echo.
echo  键入想要转换的进程图像名
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "imagename eq %input%" >nul
echo.
for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq %input%" /nh') DO echo %input% -^> %%i
echo.
echo Finish Work.
ping 127.0.0.1 -n 9 >nul
goto menu

:pid.to.imagename
cls
echo.
echo  键入想要转换的进程PID
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "pid eq %input%" >nul 2>nul
echo.
for /F "delims=, tokens=1" %%i IN ('tasklist /fo csv /fi "pid eq %input%" /nh') DO echo %input% -^> %%i
echo.
echo Finish Work.
ping 127.0.0.1 -n 9 >nul
goto menu

:imagename.kill
cls
echo.
echo  键入想要杀掉的进程图像名
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "imagename eq %input%"
echo.
for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq %input%" /nh') DO start /wait "CSBB/ntsd:kill.imagename" api\ntsd.exe -c q -p %%i
echo.
echo Finish Work.
ping 127.0.0.1 -n 3 >nul
goto menu

:pid.kill
cls
echo.
echo  键入想要杀掉的进程PID
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "pid eq %input%"
echo.
start /wait "CSBB/ntsd:kill.pid" api\ntsd.exe -p %input%
echo.
echo Finish Work.
ping 127.0.0.1 -n 3 >nul
goto menu

:imagename.debug
cls
echo.
echo  键入想要调试的进程图像名
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "imagename eq %input%"
echo.
for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq %input%" /nh') DO start /wait "CSBB/ntsd:debug.imagename" api\ntsd.exe -c q -p %%i
echo.
echo Finish Work.
ping 127.0.0.1 -n 3 >nul
goto menu

:pid.debug
cls
echo.
echo  键入想要调试的进程PID
echo.
set /p input=^> 
echo.
tasklist /fo csv /fi "pid eq %input%"
echo.
start /wait "CSBB/ntsd:debugs.pid" api\ntsd.exe -p %input%
echo.
echo Finish Work.
ping 127.0.0.1 -n 3 >nul
goto menu

:Error
rem 显示崩溃信息
color F4
title Stopped by a error ^| ERRORCODE^>%Errorcode%
rem 写出崩溃信息
set i=1
set CrashFile="%temp%\CSBB\Crash-s\%Random%%Random%%Random%%Random%%Random%\"
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
rem 打印崩溃信息
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% % complete
echo.
echo            If you want to feed back, give me this info:
echo            E-Mail Address : popo0713@foxmail.com
echo            Stop code : %errorcode%
echo.
echo  Any key to open error info.
echo   ERROR_INFO_FILE=%CrashFile%
pause>nul
api\OpenURL.exe -u https://game.bilibili.com/linkfilter/?url=%CrashFile%
exit 65535