rem 设置版本号
set Appver=Dev.0.0.1.0
goto HEAD

:head
@echo off
cls
title CSBB
goto api_load

:menu
cls
echo ^> 主菜单
echo ===================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.
echo.
echo.
echo  Made by kdXiaoyi. 2022版权所有
echo ===================================================================
echo SysBit=x%SysBit%
choice.exe /c 1234567890 /N /M 从中选择一项^>
if %ERRORLEVEL%==0 (
    rem 用户中断操作。
    echo NO TRUE CHOICE INTUT
)
if %ERRORLEVEL%==255 (
    rem CHOICE.exe发出错误状态码
    set ERRORCODE=CSBB/API:Choice.ErrorEffect
    goto Error
)
goto menu

:api_load
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
cd "%cd%\API"
goto menu

:Error
rem 显示崩溃信息
color FC
title Stopped by a error ^| ERRORCODE^>%Errorcode%
rem 写出崩溃信息
set time2=%time%
md "%temp%\CSBB\Crash\"
set CrashFile="%temp%\CSBB\Crash-s\%time2%\"
echo Crash Report >>%CrashFile%
echo ================================================= >>%CrashFile%
echo  ^> Oh,no,this is the 115414th crash report! >>%CrashFile%
echo. >>%CrashFile%
echo Time = %time2% >>%CrashFile%
echo Errorcode = %errorcode% >>%CrashFile%
echo SysBit = x%SysBit% >>%CrashFile%
echo SysVer =  >>%CrashFile%
Ver >>%CrashFile%
echo Lang = %LANG% >>%CrashFile%
echo SysDrive = %SystemDrive% >>%CrashFile%
echo PROCESSOR ARCHITECTURE = %PROCESSOR_ARCHITECTURE% >>%CrashFile%
echo OS Center = %OS% >>%CrashFile%
echo Command Spec = %ComSpec% >>%CrashFile%
echo Temp File = %temp% >>%CrashFile%
echo App Ver = %AppVer% >>%CrashFile%
echo. >>%CrashFile%
echo Sub.End () >>%CrashFile%