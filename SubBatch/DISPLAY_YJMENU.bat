cls
echo off
if "%sisbit%"=="86" (
    rem x86
    rem 合乎要求
) ELSE (
    if NOT "%sysbit%"=="64" (
        rem ≠x86          ≠x64
        rem 不合要求
        rem 显示崩溃信息
        goto error
    )
    rem x64
    rem 合要求
)
set input=00000
set password=%random%%random%
echo Are you sure to let it be null ?
echo.
echo   警告：这一切均不可逆！
echo      可逆的话我也不想改注册表，自己搞，233333333333333
echo.
echo  键入验证码完成请求
echo     ^> %password% ^<
echo.
set /p input=Captcha Code Here ^> 
echo.
if "%password%"=="%input%" (
    echo Good captcha code
    echo.
    echo unREGSVRing igfxpph.dll ...
    regsvr32 /u /s igfxpph.dll
    echo OKAY
    echo Regging...
    echo ^> del HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\*
    echo ^> add HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\new\?
    echo ^> del HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\HotKeysCmds
    echo ^> del HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\IgfxTray
    reg delete HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers /f
    reg add HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\new /ve /d {D969A300-E7FF-11d0-A93B-00A0C90F2719}
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v HotKeysCmds /f
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v IgfxTray /f
    echo OKAY
    echo.
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
) ELSE (
    echo Bad Captcha Code !
    echo.
    echo Any key to back.
    pause>nul
)
call main.bat

:error
set errorcode=CSBB/DISPLAY_MENU:SysBit.false_number
color F4
title Stopped by a error ^| ERRORCODE^>%Errorcode%
rem 写出崩溃信息
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
rem 打印崩溃信息
cls
echo.
echo    : (
echo.
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i%% complete
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