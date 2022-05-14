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
goto IFEO/menu

rem 镜像劫持配置的注册表
rem  HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options

rem 添加 abc.exe 的劫持为 123.exe
rem reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\abc.exe" /t REG_SZ /v debugger /d 123.exe
rem 删除 abc.exe 的劫持配置
rem reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\abc.exe" /f

:ifeo/menu
cls
echo ^> 镜像劫持管理
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [A] 新增镜像劫持配置项
echo.    [D] 删除镜像劫持配置项
@REM echo     [L] 列出所有镜像劫持配置
echo.
echo     [H] 了解什么是镜像劫持
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0HAD /N /M 从中选择一项^>
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 (
    cls
    echo ^> 什么是镜像劫持?
    echo ================================================================================
    more /E /T4 Data\Texts\HelpForIFEO.helptext
    echo.
    pause >nul
)
cls
if %ERRORLEVEL%==3 goto ifeo/add
if %ERRORLEVEL%==4 goto ifeo/del
if %ERRORLEVEL%==5 goto ifeo/list
goto ifeo/menu

:ifeo/list
echo ^> 镜像劫持管理 ^> 所有已配置
echo ================================================================================
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\" /s /t REG_SZ /f "debugger" /d
echo ================================================================================
echo 任意键返回……
pause>nul
goto ifeo/menu

:ifeo/add
echo ^> 镜像劫持管理 ^> 添加
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    在下方键入要求的信息…… 
echo.
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
set /p input=被劫持的镜像名^> 
set /p i=劫持到的程序名(会在运行里面打开)^> 
echo.
echo From    : %input%
echo To      : %i%
echo Time    : %time%
echo Date    : %date%
for /f %%o in ('api\GetGUID.exe') do (set GUID=%%o)
echo Code    : %guid%
echo Command : Add
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%input%" /t REG_SZ /v debugger /d %i%
ping 127.0.0.1 -n 5 >nul
goto ifeo/menu

:ifeo/del
echo ^> 镜像劫持管理 ^> 删除
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    在下方键入要求的信息…… 
echo.
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
set /p input=要删去的被劫持的镜像名^> 
echo.
echo From    : %input%
echo To      : Null
echo Time    : %time%
echo Date    : %date%
for /f %%o in ('api\GetGUID.exe') do (set GUID=%%o)
echo Code    : %guid%
echo Command : Delete
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%input%" /f
ping 127.0.0.1 -n 5 >nul
goto ifeo/menu