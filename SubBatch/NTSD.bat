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
    call subbatch\errorscreen.bat
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
