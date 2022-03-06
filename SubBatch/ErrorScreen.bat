:Error
rem 显示崩溃信息
color F4
title Stopped by a error ^| ERRORCODE^>%Errorcode%
rem 写出崩溃信息
set i=0
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% %% complete
echo.
for /f %%o in ('api\GetGUID.exe') do set guid=%%o
set CrashFile="%temp%\CSBB\Crash-s\%guid%\"
md %CrashFile%
echo Crash Report >>"%CrashFile%\CRASH_REPORT.log"
echo ================================================= >>"%CrashFile%\CRASH_REPORT.log"
set i=20
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% %% complete
echo.
echo  ^> Oh,no,this is the 115414th crash report! >>"%CrashFile%\CRASH_REPORT.log"
echo. >>"%CrashFile%\CRASH_REPORT.log"
echo Time                   = %time2% >>"%CrashFile%\CRASH_REPORT.log"
echo Errorcode              = %errorcode% >>"%CrashFile%\CRASH_REPORT.log"
echo SysBit                 = x%SysBit% >>"%CrashFile%\CRASH_REPORT.log"
set v=
for /f "tokens=1" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=2" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=3" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=4" %%i in ('ver') do (set v=%v% %%i)
echo SysVer                 = %v% >>"%CrashFile%\CRASH_REPORT.log"
set i=50
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% %% complete
echo.
echo Lang                   = %LANG% >>"%CrashFile%\CRASH_REPORT.log"
echo SysDrive               = %SystemDrive% >>"%CrashFile%\CRASH_REPORT.log"
echo PROCESSOR ARCHITECTURE = %PROCESSOR_ARCHITECTURE% >>"%CrashFile%\CRASH_REPORT.log"
echo OS Center              = %OS% >>"%CrashFile%\CRASH_REPORT.log"
echo Command Spec           = %ComSpec% >>"%CrashFile%\CRASH_REPORT.log"
echo Temp File              = %temp% >>"%CrashFile%\CRASH_REPORT.log"
echo App Ver                = %AppVer% >>"%CrashFile%\CRASH_REPORT.log"
if %IsGotUAC%_==1_ (echo UAC Admin              = True >>"%CrashFile%\CRASH_REPORT.log") else (echo UAC Admin              = False >>"%CrashFile%\CRASH_REPORT.log")
echo CPU NAME               = %PROCESSOR_ARCHITECTURE% >>"%CrashFile%\CRASH_REPORT.log"
echo CPU INFO               = %PROCESSOR_ARCHITEW6432% >>"%CrashFile%\CRASH_REPORT.log"
echo. >>"%CrashFile%\CRASH_REPORT.log"
set i=98
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% %% complete
echo.
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
echo      %i% %% complete
echo.
echo            If you want to feed back, give me those info:
echo            E-Mail Address : popo0713@foxmail.com
echo            Stop code : %errorcode%
echo.
echo  Any key to open error info.
echo   ERROR_INFO_FILE=%CrashFile%
pause>nul
api\OpenURL.exe -e -u %CrashFile%
exit