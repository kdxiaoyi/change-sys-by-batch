@echo off
echo.
if NOT EXIST api\Android_Debug_Bridge\adb.exe (
    set errorcode=CSBB/ADB:no_adb.adb
    call subbatch\errorscreen.bat
)
if NOT EXIST api\Android_Debug_Bridge\fastboot.exe (
    set errorcode=CSBB/ADB:no_adb.fastboot
    call subbatch\errorscreen.bat
)
if NOT EXIST api\Android_Debug_Bridge\adbWinApi.dll (
    set errorcode=CSBB/ADB:no_adb.dll.adbWinApi
    call subbatch\errorscreen.bat
)
if NOT EXIST api\Android_Debug_Bridge\AdbWinUsbApi.dll (
    set errorcode=CSBB/ADB:no_adb.dll.AdbWinUsbApi
    call subbatch\errorscreen.bat
)
cls
goto menu

:menu
cls
echo ^> Android Debug Bridge / Choice Mode
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] Run Adb.exe
echo.    [2] Run Fastboot.exe
echo.    [3] 将Adb注册到系统(这样你就可以在任何地方打开adb了)
echo.    [4] 终止ADB Daemon Service
echo.
echo     [0] EXIT
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
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
if %ERRORLEVEL%==3 (
    set sure=t
    goto reg
    )
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
if "%RunByNoAdmin%"=="1" (
    echo.
    echo  :(  没有足够的权限
    echo.
    echo RunByNoAdmin=TRUE
    echo.
    ping 127.0.0.1 -n 4 >nul
    goto menu 
)
set i=3
cls
echo.
echo   请稍后……我们正在处理请求……
echo.
echo 1/%i%^> Stop ADB Daemon Service .
tasklist /FI "imagename eq adb.exe"
for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq adb.exe" /nh') DO api\ntsd.exe -c q -p %%i
echo 2/%i%^> Copy Adb files .
set input=00000
set password=%random%%random%
if not EXIST %windir%\Adb.exe set sure=f
if "%sure%"=="t" goto sure
attrib -r -a -s %windir%\Adb.setup_log.txt
del %windir%\Adb.setup_log.txt /q /f
copy api\Android_Debug_Bridge\adb.exe %windir%
copy api\Android_Debug_Bridge\fastboot.exe %windir%
copy api\Android_Debug_Bridge\AdbWinUsbApi.dll %windir%
copy api\Android_Debug_Bridge\AdbWinUsbApi.dll %windir%
attrib +r +a +s %windir%\Adb.exe
attrib +r +a +s %windir%\fastboot.exe
attrib +r +a +s %windir%\AdbWinUsbApi.dll
attrib +r +a +s %windir%\AdbWinUsbApi.dll
ATTRIB -r -a -s %windir%\Adb.setup_log.txt
echo 3/%i%^> Output log .
echo Android Debug Bridge >>%windir%\Adb.setup_log.txt
echo  ^>Setup Time >>%windir%\Adb.setup_log.txt
echo    %time% >>%windir%\Adb.setup_log.txt
echo  ^>the Number of adb files >>%windir%\Adb.setup_log.txt
echo    4 files >>%windir%\Adb.setup_log.txt
echo     - adb.exe >>%windir%\Adb.setup_log.txt
echo     - fastboot.exe >>%windir%\Adb.setup_log.txt
echo     - adbwinapi.dll >>%windir%\Adb.setup_log.txt
echo     - adbwinusbapi.dll >>%windir%\Adb.setup_log.txt
echo  ^>the SHA256 of adb files (Only data) >>%windir%\Adb.setup_log.txt
echo     - adb.exe          ^<-^> 4B15C1632B0FA74AD114EA963B9D34099728E536DA5B31D80A28F6AFD7029A65 >>%windir%\Adb.setup_log.txt
echo     - fastboot.exe     ^<-^> 342169964160EB3A831AF06BC1662E4166ED45565F798AA1C1609659ED9392FC >>%windir%\Adb.setup_log.txt
echo     - adbwinapi.dll    ^<-^> C70AAEAB8F8D3D2BBFB7E868E82D5F184504BBB2FB721C517D436CCFB5B8CB41 >>%windir%\Adb.setup_log.txt
echo     - adbwinusbapi.dll ^<-^> FB7161D37CC56CB570979E09D76A399208968F3B60E2C31C5B8CC90D42C2C113 >>%windir%\Adb.setup_log.txt
echo. >>%windir%\Adb.setup_log.txt
echo. >>%windir%\Adb.setup_log.txt
echo. >>%windir%\Adb.setup_log.txt
echo Setup Tool made by Bilibili@kdXiaoyi (Home papge : space.bilibili.com/1987247870) >>%windir%\Adb.setup_log.txt
ATTRIB +r +a +s %windir%\Adb.setup_log.txt
echo.
echo Setup Okay
echo.
api\taskbarmsg.exe 600000;;CSBB：[安装ADB]已完成#@2;;任务[安装ADB]已完成\n \n你可以点击我来打开报告信息。\n位置%windir%\Adb.setup_log.txt;;notepad.exe %windir%\Adb.setup_log.txt
ping 127.0.0.1 -n 6 >nul
goto menu

:sure
echo.
echo 已经安装了adb。
echo.
echo  键入验证码以再次安装
echo     ^> %password% ^<
echo.
set /p input=Captcha Code Here ^> 
echo.
if NOT "%password%"=="%input%" (
    echo.
    echo  验证码错误。
    ping 127.0.0.1 -n 3 >nul
    goto menu
)
set sure=t
goto reg