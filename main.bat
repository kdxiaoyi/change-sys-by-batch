goto HEAD

:head
@echo off
cls
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
    set ERRORCODE=API.Choice.ErrorEffect
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
color 