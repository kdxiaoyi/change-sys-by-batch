rem 设置版本号
rem 20xx.xx指20xx年的x月第x个更新
set ver=Dev.2022.5a
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
more /E /T4 Data\Texts\about_us.helptext
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
echo.    [2] 系统实用
echo     [3] #部分木马病毒专杀/预防工具#                              (Test Version)
echo     [S] 启动 Windows 系统评估
echo.
echo.    [A] About us
echo     [Q/E] EXIT
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c P12AQE3SH /N /M 从中选择一项^>
if %ERRORLEVEL%==0 (
    rem 用户中断操作。
    echo NO TRUE CHOICE INTUT
)
if %ERRORLEVEL%==255 (
    rem CHOICE.exe发出错误状态码
    set ERRORCODE=CSBB/API:Choice.ErrorEffect
    call subbatch\errorscreen.bat
)
if %ERRORLEVEL%==1 (
    rem 模拟崩溃
    set errorcode=CSBB/main:Debug.BOOM
    call subbatch\errorscreen.bat
)
if %ERRORLEVEL%==2 goto sys_show/menu
if %ERRORLEVEL%==3 goto sysUsefull/menu
if %ERRORLEVEL%==4 goto CSBB/about
if %ERRORLEVEL%==5 goto CSBB/exit.sure
if %ERRORLEVEL%==6 goto CSBB/exit.sure
if %ERRORLEVEL%==7 call SubBatch\Virus_Defender.bat
if %ERRORLEVEL%==8 call SubBatch\winsat.bat
if %ERRORLEVEL%==9 api\openurl.exe https://gitee.com/kdXiaoyi/changing-sys-by-bat/blob/master/LICENSE/
goto CSBB/menu

:sys_show/menu
cls
echo ^> 系统外观菜单
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [A] 禁用快捷方式小箭头
echo.    [B] 启用↑
echo     [1] 右键菜单中的显卡设置菜单管理
echo     [U] 弹出[成功升级Windows]窗口
echo     [C] 右键菜单中新增/移除[复制路径]选项
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0AB1UC /N /M 从中选择一项^>
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
goto sys_show_menu

:sysUsefull/menu
cls
echo ^> 系统实用
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [A] Android Debug Bridge
echo.    [C] 清理垃圾
echo.    [D] 删除系统缓存
echo.    [E] 删除系统缓存(精简版)
echo     [R] #内存清理管理#                                          (BETA VERSION)
echo     [N] Ntsd - Microsoft Windows Debugger
echo     [T] 配置镜像劫持
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0CANRT /N /M 从中选择一项^>
if %ERRORLEVEL%==1 goto CSBB/menu
if %ERRORLEVEL%==2 (
    cls
    echo.
    echo  清理垃圾中...
    echo.
    rem temp目录
    del %temp%\*.* /q
    del %tmp%\*.* /q
    rem .TMP/log 文件
    del C:\*.tmp /q
    del D:\*.log /q
    del C:\*.tmp /q
    del D:\*.log /q
    rem 常见缓存目录
	del /q /f /s "%LOCALAPPDATA%\microsoft\windows\wer\reportArchive\*.*"
	del /q /f /s "%LOCALAPPDATA%\microsoft\windows\wer\reportQueue\*.*"
	rem 应用崩溃后报告文件
    del %windir%\temp\*.* /q
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
echo     [3] 反注册↑
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
rem 进行延迟变量拓展(允许使用[!]作为延迟变量)
SetLocal EnabledElayedExpansion
if "%ERRORLEVEL%"=="3" (
    if not "%isgotuacadmin%"=="1" (
        cls
        echo.
        echo    错误：权限不足。
        echo  [User] ^< Need:[UAC-Admin]
        echo.
        ping 127.0.0.1 -n 5 >nul
        goto sysUsefull/ramEmpty.menu
    )
    echo Working...
    echo ^> 注册释放内存为服务
    echo ================================================================================
    echo 安装释放内存API为驻留API……
    copy api\ramEmpty.exe "%windir%\system32\"
    attrib +r +a +s "%windir%\system32\ramEmpty.exe"
    echo 实现RamEmpty自启动……
    if exist "%ALLUSERSPROFILE%\CSBB\API.Stay\ramEmpty_.bat" (
        echo.
        echo 你可能已经安装过服务了。强制继续可能会出现问题。
        echo.
        echo 强制继续：[Ctrl]+[C]      确定：[Y]
        echo.
        api\choice /c Y /N /M (Y/Ctrl+C)^>
        if %ERRORLEVEL%==1 goto sysUsefull/ramEmpty.menu
    )
    md "%ALLUSERSPROFILE%\CSBB\API.Stay\"
    echo.
    echo "%windir%\system32\ramEmpty.exe" * >"%ALLUSERSPROFILE%\CSBB\API.Stay\ramEmpty_.bat"
    echo 键入一个整数值。这将作为释放内存操作运行的频率(分钟)。
    echo *默认30分钟
    echo *这必须是一个1-599940之间的整数(int)
    set /p input=^> 
    if "!input!"=="" set input=30
    schtasks create /ru SYSTEM /sc daily /d * /m * /tn AutoCleanRAM /rt !input! /rl highest /tr "%ALLUSERSPROFILE%\CSBB\API.Stay\ramEmpty_.bat"
)
rem 进行延迟变量拓展(允许使用[!]作为延迟变量)
SetLocal EnabledElayedExpansion
if "%ERRORLEVEL%"=="4" (
    if not "%isgotuacadmin%"=="1" (
        cls
        echo.
        echo    错误：权限不足。
        echo  [User] ^< Need:[UAC-Admin]
        echo.
        ping 127.0.0.1 -n 5 >nul
        goto sysUsefull/ramEmpty.menu
    )
    echo Working...
    echo ^> 反注册释放内存为服务
    echo ================================================================================
    api\choice.exe /c YN /N /M 卸载释放内存API为驻留API?(Y/N)^> 
    if %ERRORLEVEL%==1 (
        attrib -r -a -s "%windir%\system32\ramEmpty.exe"
        del /f /q "%windir%\system32\ramEmpty.exe"
    )
    echo 卸载RamEmpty自启动……
    del /f /q "%ALLUSERSPROFILE%\CSBB\API.Stay\ramEmpty_.bat"
    sc stop AutoCleanRAM 1:5:20 "Stop service for unsetup AutoCleanRAM"
    sc delete AutoCleanRAM
)
ping 127.0.0.1 -n 3 >nul
goto sysUsefull/ramEmpty.menu
