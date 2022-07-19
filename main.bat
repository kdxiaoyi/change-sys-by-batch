rem 设置版本号
rem 20xx.xx指20xx年的x月第x个更新
set ver=Dev.2022.7c
set y=2022
goto HEAD

:head
@echo off
cls
title Change System By Batch - [%ver%]
goto getUACAdmin

:CSBB/api.load
rem 修改屏幕大小
mode CON: COLS=80 LINES=30
rem 检测系统位数
set SysBit=UNKNOW
if EXIST %windir%\SysWOW64\ (
    rem x64
    set SysBit=64
) ELSE (
    rem x86
    set SysBit=86
)
echo SysBit=x%SysBit%
rem 进行延迟变量拓展(允许使用[!]作为延迟变量)
SetLocal EnabledElayedExpansion
rem 配置临时目录
set tmp="%temp%\CSBB"
set tmp\="%temp%\CSBB\"
set tempFiles="%temp%\CSBB"
set tempFiles\="%temp%\CSBB\"
md %tempFiles%
goto CSBB/menu

:getUACAdmin
@REM rem 配置path路径
@REM if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
rem 通过访问bcd的方法判断是否有UAC管理员权限
bcdedit >>nul
if "%RunByNoAdmin%"=="1" goto CSBB/api.load
set RunByNoAdmin=0
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)

:UACPrompt
rem 通过VBS方法得到UAC管理员权限
rem mshta是一个快速执行JS/VBS脚本的命令行工具
%1 start "CSBB/GetUACAdmin:getting" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit 0 /b
exit 0 /b

:UACAdmin
cd /d "%~dp0"
echo 当前运行路径是：%CD%
echo 已获取管理员权限
set IsGotUAC=1
set IsGetUAC=1
set IsGotUACAdmin=1
set IsGetUACAdmin=1
goto CSBB/api.load

:CSBB/about
cls
echo ^> About us
echo ================================================================================
more /E /T4 Data\Texts\inside\about_us.helptext
echo ================================================================================
echo 任意键返回……
pause>nul
goto CSBB/menu

:CSBB/exit.sure
cls
echo ^> EXIT Screen
echo ================================================================================
echo.
echo         您确定要退出？
echo.
echo  键入[Y]并回车以完成操作。
echo.
echo Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%sysbit%
set /p input=^> 
if "%input%"=="Y" exit
if "%input%"=="y" exit
goto CSBB/menu

:CSBB/menu
cls
echo ^> 主菜单
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] 系统外观
echo.    [2] 实用工具
echo     [P] 启动 Windows 系统评估
echo.
@REM echo     [S] 设置
echo.    [A] 关于……
echo     [I] 联系我们
echo     [Q/E] EXIT
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c B12PSAIQEL /N /M 从中选择一项^>
if %ERRORLEVEL%==0 (
    rem 用户中断操作。
    echo NO TRUE CHOICE INPUT
)
if %ERRORLEVEL%==255 (
    rem CHOICE.exe发出错误状态码
    set ERRORCODE=CSBB/API:Choice.BackErrorCode
    call subbatch\errorscreen.bat
)
if %ERRORLEVEL%==1 (
    rem 模拟崩溃
    set errorcode=CSBB/main:Debug.BOOM
    call subbatch\errorscreen.bat
)
if %ERRORLEVEL%==12 api\openurl.exe -u https://space.bilibili.com/1987247870
if %ERRORLEVEL%==2 goto sys_show/menu
if %ERRORLEVEL%==3 goto sysUsefull/menu
if %ERRORLEVEL%==4 call SubBatch\winsat.bat
@REM if %ERRORLEVEL%==5 call SubBatch\settings.bat
if %ERRORLEVEL%==6 goto CSBB/about
if %ERRORLEVEL%==7 goto CSBB/Issues
if %ERRORLEVEL%==8 goto CSBB/exit.sure
if %ERRORLEVEL%==9 goto CSBB/exit.sure
if %ERRORLEVEL%==10 api\openurl.exe -u https://gitee.com/kdXiaoyi/changing-sys-by-bat/blob/master/LICENSE/
goto CSBB/menu

:sys_show/menu
cls
echo ^> 系统外观
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [J] 禁用快捷方式小箭头
echo.    [X] 启用↑
echo     [1] 右键菜单中的显卡设置菜单管理
@REM echo     [U] 弹出[成功升级Windows]窗口
echo     [C] 右键菜单中新增/移除[复制路径]选项
echo     [A] 为Windows 8+启用Aero效果
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0JX1UCA /N /M 从中选择一项^>
echo.
if %ERRORLEVEL%==2 (
    rem 杀桌面管理器进程
    echo 警告！ 这将会禁用Aero或毛玻璃效果一段时间，没有恢复请自行前往[个性化]启用！
    echo.
    taskkill /f /im explorer.exe
    taskkill /f /im dwm.exe
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,196" /t reg_sz /f
    attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
    rem 修改iconcache文件
    ren "%userprofile%\AppData\Local\iconcache.db" "%userprofile%\AppData\Local\iconcache_BANNED.db"
    attrib +s +r +h "%userprofile%\AppData\Local\iconcache_BANNED.db"
    start explorer.exe
    start dwm.exe
    echo Change Ok.
    pause
    goto sys_show_menu
)
if %ERRORLEVEL%==3 (
    rem 杀桌面管理器进程
    echo 警告！ 这将会禁用Aero或毛玻璃效果一段时间，没有恢复请自行前往[个性化]启用！
    echo.
    taskkill /f /im explorer.exe
    taskkill /f /im dwm.exe
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f
    attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
    rem 修改iconcache文件
    del /q "%userprofile%\AppData\Local\iconcache.db"
    attrib +s +r +h "%userprofile%\AppData\Local\iconcache.db"
    start explorer.exe
    start dwm.exe
    echo Change Ok.
    pause
    goto sys_show_menu
)
if %ERRORLEVEL%==4 call SubBatch\display_yjmenu.bat
if %ERRORLEVEL%==1 goto CSBB/menu
if %ERRORLEVEL%==5 start /d %windir%\system32 WindowsAnytimeUpgradeResults.exe
if %ERRORLEVEL%==6 call SubBatch\AddOrDeleteCopyPathInRightMouseMenu.bat
if %ERRORLEVEL%==7 call SubBatch\Aero.bat
goto sys_show_menu

:sysUsefull/menu
cls
echo ^> 实用工具
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [A] Android Debug Bridge
echo.    [C] 清理垃圾
echo     [R] #内存清理管理#                                          (BETA VERSION)
echo     [N] Ntsd - Microsoft Windows Debugger
echo     [T] 配置镜像劫持
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0CANRTI /N /M 从中选择一项^>
if %ERRORLEVEL%==1 goto CSBB/menu
if %ERRORLEVEL%==2 (
    cls
    echo.
    echo  清理垃圾中...
    echo.
    echo temp目录/文件
    del %temp%\*.* /q
    del %tmp%\*.* /q
    del C:\*.tmp /q
    del D:\*.log /q
    del C:\*.tmp /q
    del D:\*.log /q
    del %windir%\temp\*.* /q
    echo 应用崩溃后报告文件
	del /q /f /s "%LOCALAPPDATA%\microsoft\windows\wer\reportArchive\*.*"
	del /q /f /s "%LOCALAPPDATA%\microsoft\windows\wer\reportQueue\*.*"
    echo ramEmpty
    api\ramEmpty.exe *
)
if %ERRORLEVEL%==3 call SubBatch\Android_Debug_Bridge.bat
if %ERRORLEVEL%==4 call SubBatch\ntsd.bat
if %ERRORLEVEL%==5 goto sysUsefull/ramEmpty.menu
if %ERRORLEVEL%==6 call subbatch\ImageFileExecutionOptions.bat
goto sysUsefull/menu

:sysUsefull/ramEmpty.menu
cls
echo ^> 内存清理管理
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] 立即释放内存
@REM echo.    [2] 注册释放内存为服务(这样就可以定时释放了)
@REM echo     [3] 反注册↑
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0123 /N /M 从中选择一项^>
@REM cls
if "%ERRORLEVEL%"=="1" goto sysUsefull/menu
if "%ERRORLEVEL%"=="2" (
    echo Working...
    echo ^> 释放内存
    echo ================================================================================
    start "RAM Cleaner" /wait api\ramEmpty.exe *
    echo.
    echo Finish Working.
    ping 127.0.0.1 -n 2 >nul
    goto sysUsefull/ramEmpty.menu
)
goto sysUsefull/ramEmpty.menu

:CSBB/Issues
cls
echo ^> CSBB问题反馈
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] 提交Issues (需要登录到Github)
echo     [2] 提交电子邮件 (需要登录到QQ)
echo     [3] 查看全部的Issues
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0123 /N /M 从中选择一项^>
@REM cls
if "%ERRORLEVEL%"=="1" goto csbb/menu
if "%ERRORLEVEL%"=="2" api\openurl.exe -u http://github.com/kdXiaoyi/change-sys-by-bat/issues/new
if "%ERRORLEVEL%"=="3" api\openurl.exe -u http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme^&email=9cTHzMTDwcPBxcS1hITblpqY
if "%ERRORLEVEL%"=="4" api\openurl.exe -u http://github.com/kdXiaoyi/change-sys-by-bat/issues/
cls
goto csbb/menu