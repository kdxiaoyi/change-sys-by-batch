rem ################################################################################
rem 标识节点组成：
rem [(子)命名空间]/[节1].[节2].….[节n]
rem                                                  [CSBB]作为父命名空间时优先用子命名空间
rem Virus_Defender.bat中，命名空间为[vd]
rem ################################################################################
rem 节的组成：
rem /menu.
rem  菜单
rem     .x
rem      意味这是首字母为[x]的检索页
rem /kill.         ([病毒类型].[病毒名])
rem  杀病毒工具
rem     .worm.
rem      蠕虫类
rem     .blackmail.
rem      勒索类
rem ################################################################################

if not "%isgotuac%"=="1" (
    echo off
    cls
    echo.
    echo    错误：权限不足。
    echo  [User] ^< Need:[UAC-Admin]
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
)
goto vd/menu

:vd/menu
cls
echo ^> Virus Defender - 病毒名检索菜单
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo  按首字母来查找对应病毒。支持查找的有：
echo.
echo.    [M] 
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0m /N /M 从中选择一项^>
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 goto vd/menu.M
goto vd/menu

:vd/menu.M
cls
echo ^> Virus Defender - 病毒名检索菜单 -^> 首字母[M]
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] (特征杀^|蠕虫) Microsoft Word.WsF
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 01 /N /M 从中选择一项^>
cls
if %ERRORLEVEL%==1 goto vd/menu
if %ERRORLEVEL%==2 goto vd/kill.WORM.Microsoft_Word,WsF
goto vd/menu

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

:vd/kill.WORM.Microsoft_Word,WsF
echo 原作者：[@福厦高速]   原作者的版权声明见About菜单。
echo.
echo 