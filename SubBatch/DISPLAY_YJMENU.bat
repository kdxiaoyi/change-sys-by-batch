cls
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