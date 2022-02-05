rem 设置版本号
set ver=Dev.2022.21a
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
rem 初始化API调用
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
goto CSBB/api.load

:Error
rem 显示崩溃信息
color F4
title Stopped by a error ^| ERRORCODE^>%Errorcode%
rem 写出崩溃信息
set i=1
set CrashFile="%temp%\CSBB\Crash-s\%Random%%Random%%Random%%Random%%Random%\"
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
echo .
echo     This program ran into a problem and needs to restart. We're just
echo     collecting some error info, and then we'll show them for you.
echo.
echo      %i% % complete
echo.
echo            If you want to feed back, give me this info:
echo            E-Mail Address : popo0713@foxmail.com
echo            Stop code : %errorcode%
echo.
echo  Any key to open error info.
echo   ERROR_INFO_FILE=%CrashFile%
pause>nul
api\OpenURL.exe -e -u %CrashFile%
exit

:CSBB/about
cls
echo ^> About us
echo ================================================================================
more /E /T4 texts\about_us.helptext
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
echo     [3] 部分木马病毒专杀/预防工具
echo     [S] 启动 Windows 系统评估
echo.
echo.    [A] About us
echo     [Q/E] EXIT
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c P12AQE3S /N /M 从中选择一项^>
if %ERRORLEVEL%==0 (
    rem 用户中断操作。
    echo NO TRUE CHOICE INTUT
)
if %ERRORLEVEL%==255 (
    rem CHOICE.exe发出错误状态码
    set ERRORCODE=CSBB/API:Choice.ErrorEffect
    goto Error
)
if %ERRORLEVEL%==1 (
    rem 模拟崩溃
    set errorcode=CSBB/main:Debug.BOOM
    goto error
)
if %ERRORLEVEL%==2 goto sys_show/menu
if %ERRORLEVEL%==3 goto sysUsefull/menu
if %ERRORLEVEL%==4 goto CSBB/about
if %ERRORLEVEL%==5 goto CSBB/exit.sure
if %ERRORLEVEL%==6 goto CSBB/exit.sure
if %ERRORLEVEL%==7 call SubBatch\Virus_Defender.bat
if %ERRORLEVEL%==8 call SubBatch\winsat.bat
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
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0AB1U /N /M 从中选择一项^>
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
goto sys_show_menu

:sysUsefull/menu
cls
echo ^> 系统实用
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [A] Android Debug Bridge
echo.    [C] 清理垃圾
echo     [N] Ntsd - Microsoft Windows Debugger
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0CAN /N /M 从中选择一项^>
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
    del %windir%\temp\*.* /q
)
if %ERRORLEVEL%==3 call SubBatch\Android_Debug_Bridge.bat
if %ERRORLEVEL%==4 call SubBatch\ntsd.bat
goto sysUsefull/menu