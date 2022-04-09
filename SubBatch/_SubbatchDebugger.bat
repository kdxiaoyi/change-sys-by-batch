@echo off
title Change System By Batch - Debugger (Subbatch)
goto menu
:Debug
title Change System By Batch - Debugger (Subbatch:%WantDebugSubbatch%)
echo 设置版本号与年份
set ver=Debugging
set y=2099
echo UAC状态设置
bcdedit >>nul
if '%errorlevel%' NEQ '0' (
    set RunByNoAdmin=1
    set IsGotUAC=0
    set IsGetUAC=0
    set IsGotUACAdmin=0
    set IsGetUACAdmin=0
) else (
    set IsGotUAC=1
    set IsGetUAC=1
    set IsGotUACAdmin=1
    set IsGetUACAdmin=1
)
echo 拓展延迟变量……
SetLocal EnabledElayedExpansion
echo 配置临时目录
set tmp="%temp%\CSBB"
set tmp\="%temp%\CSBB\"
set tempFiles="%temp%\CSBB"
set tempFiles\="%temp%\CSBB\"
echo 修改屏幕大小
mode CON: COLS=80 LINES=30
echo 检测系统位数
set SysBit=UNKNOW
if EXIST %windir%\SysWOW64\ (
    rem x64
    set SysBit=64
) ELSE (
    rem x86
    set SysBit=86
)
echo SysBit=x%SysBit%
echo 导航到默认执行目录
if not "%s%"=="1" cd /d ..
call subbatch\%WantDebugSubbatch%.bat
:menu
set WantDebugSubbatch=233
cls
echo ^> Debugger (SUBBATCH)
echo ===============================================================================
echo.
echo  在下方键入想要调试的Subbatch (不带.bat)
echo.
echo ===============================================================================
set /p WantDebugSubbatch=^> 
if %WantDebugSubbatch%_==main_ (
    if exist main.bat (call main.bat) else (
        cd ..
        call main.bat
    )
)
if not EXIST "%WantDebugSubbatch%.bat" (
    if exist subbatch\%WantDebugSubbatch%.bat (
        set s=1
        goto Debug
    )
    echo.
    echo 无效的名称。
    pause>nul
    goto menu
) else goto Debug