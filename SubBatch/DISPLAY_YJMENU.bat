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
        set errorcode=csbb/#Unknow_Subname_Space#:#Unknow_Name#
        call subbatch\errorscreen.bat
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
