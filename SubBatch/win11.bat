if NOT "%isgotuac%"=="1" (
    cls
    echo.
    echo    错误：权限不足。
    echo  [User] ^< Need:[UAC-Admin]
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
) else (goto win11/menu)

:win11/menu
cls
echo ^> Windows 11 专区
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo       ! 这是专门为Win11用户编写的功能，其它系统请酌情使用。
echo.
echo     [S] 安装StartAllBack(Win11资源管理器调校工具)
echo.
echo     [1] 任务栏
echo.
echo     [0] EXIT
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 01 /N /M 从中选择一项^>
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 goto win11/taskbar
if %ERRORLEVEL%==3 goto win11/startallback
goto win11/menu

:win11/taskbar
cls
echo ^> Windows 11 专区 - 任务栏
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo     [1] 任务栏大小
echo     [2] 任务栏位置
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 120 /N /M 从中选择一项^>
if %ERRORLEVEL%==1 goto win11/taskbar.size
if %ERRORLEVEL%==2 goto win11/taskbar.pos
if %ERRORLEVEL%==3 goto win11/menu
goto win11/taskbar

:win11/taskbar.size
echo.
echo 键入一个大小值（默认为1）
set size=1
api\choice.exe /c 102 /N /M 从0~2选择一项^>
if %ERRORLEVEL%==1 set size=1
if %ERRORLEVEL%==2 set size=0
if %ERRORLEVEL%==3 set size=2
if "%size%"=="-1" set size=1
rem Reg改变任务栏大小
rem HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarSi [DWORD 32] = %size%
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v TaskbarSi /t REG_DWORD /d %size% /f
echo Reg操作结束
echo Restart Explorer
taskkill /f /im explorer.exe
start explorer.exe
echo Finished.
ping 127.0.0.1 -n 5 >nul
goto win11/taskbar

:win11/taskbar.pos
echo.
echo U=上方 D=下方 
echo 由于微软限制，左右方向会出BUG
echo 键入一个值（默认为U）
set p=-1
api\choice.exe /c UDLR /N /M 从[U,D]选择一项^>
if %ERRORLEVEL%==1 set p=01
if %ERRORLEVEL%==2 set p=03
if %ERRORLEVEL%==4 set p=02
if %ERRORLEVEL%==3 set p=04
if "%p%"=="-1" set p=03
rem 01=任务栏上 03=任务栏下
for /f "tokens=1-2*" %%A in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings^|find /i "Settings"') do (
  rem 列出指定注册表2进制的全部数据并储存进变量
  set settings=%%C
)
echo 原先：%settings%
rem 拼凑变量中第25-26字符处数据
set settings=%settings:~0,24%%p%%settings:~26%
echo 将改为：%settings%
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d %settings% /f
echo 现在数据：
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings |find /i "Settings"
echo Restart Explorer
taskkill /f /im explorer.exe
start explorer.exe
echo Finished.
ping 127.0.0.1 -n 5 >nul
goto win11/taskbar

:win11/StartAllBack
cls
echo ^> Windows 11 专区 - StartAllBack
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo     StartAllBack是一种可以让你高度自定义Win11资源管理器的工具。
echo       - 开始菜单：怀念win7吗？一键滚回
echo       - 任务栏项：让任务栏滚回win10！
echo       - 资源窗口：新版不好看？改
echo 做的好像营销号有没有?
echo.
echo  *可能需要互联网连接
echo.
echo     [X] 取消    [Y] 安装
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c XY /N /M 从中选择一项^>
if %ERRORLEVEL%==2 goto win11/StartAllBack.install else goto win11/menu

:win11/StartAllBack.install
@REM api\taskbarmsg.exe 9000;;即将打开外部网站 - CSBB/WIN11#@0;;StartAllBack 3.5 repacked 网盘分享;; ;;data\startallback.ico
rem  api更换需要重写
api\taskbarmsg.exe "即将打开外部网站 - CSBB/WIN11" "StartAllBack 3.5 repacked 网盘分享" 2 "" data\startallback.ico
api\openurl.exe -u https://pan.huang1111.cn/s/6KAziN