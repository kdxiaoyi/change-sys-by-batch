call main.bat
::::::施工ing...::::::
@echo off
title Change System By Batch - SETTINGS
goto csbb/settings.menu

:csbb/settings.menu
cls
echo ^> SETTINGS
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] 
echo.
echo     [0] EXIT
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0 /N /M 从中选择一项^>
if %ERRORLEVEL%==1 goto csbb/settings.exit
goto csbb/settings.menu

:csbb/settings.exit
if not "%tempFiles%"=="%temp%\CSBB" (
    exit /b 0
) else (
    title Change System By Batch - [%ver%]
    call main.bat
)
rem 这里检测到了无法正常退出
rem 但是既然有错误就不能调用errorScreen.bat来显示错误信息
rem 所以这里搬了代码并且精简了一下
color F4
set errorcode=CSBB.settings:exit.error.cannot
set v=
for /f "tokens=1" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=2" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=3" %%i in ('ver') do (set v=%v% %%i)
for /f "tokens=4" %%i in ('ver') do (set v=%v% %%i)
title Stopped by a error ^| ERRORCODE^>%Errorcode%
set CrashFile="%temp%\CSBB\Crash-s\%guid%\"
md %CrashFile%
echo Crash Report >>"%CrashFile%\CRASH_REPORT.log"
echo ================================================= >>"%CrashFile%\CRASH_REPORT.log"
echo  ^> Oh,no,this is the 115414th crash report! >>"%CrashFile%\CRASH_REPORT.log"
echo. >>"%CrashFile%\CRASH_REPORT.log"
echo Time                   = %time2% >>"%CrashFile%\CRASH_REPORT.log"
echo Errorcode              = %errorcode% >>"%CrashFile%\CRASH_REPORT.log"
echo SysBit                 = x%SysBit% >>"%CrashFile%\CRASH_REPORT.log"
echo SysVer                 = %v% >>"%CrashFile%\CRASH_REPORT.log"
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
echo Sub.End () >>"%CrashFile%\CRASH_REPORT.log"
cls
echo.
echo    : (
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      100 %% complete
echo.
echo            If you want to feed back, give me those info:
echo            E-Mail Address : popo0713@foxmail.com
echo            Stop code : %errorcode%
echo.
echo  Any key to open error info.
echo   ERROR_INFO_FILE=%CrashFile%
pause>nul
api\OpenURL.exe -e -u %CrashFile%
exit 1 /b

