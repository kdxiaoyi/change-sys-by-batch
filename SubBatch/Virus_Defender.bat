rem ################################################################################
rem 标识节点组成：
rem [(子)命名空间]/[节1].[节2].….[节n]
rem                                                  [CSBB]作为父命名空间时优先用子命名空间
rem Virus_Defender.bat中，命名空间为[vd]
rem ################################################################################
rem 节的组成：
rem /menu.
rem  菜单
rem     .x
rem      意味这是首字母为[x]的检索页
rem /kill.         ([病毒类型].[病毒名])
rem  杀病毒工具
rem     .worm.
rem      蠕虫类
rem     .blackmail.
rem      勒索类
rem ################################################################################

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
goto vd/menu

:vd/menu
cls
echo ^> Virus Defender - 病毒名检索菜单
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo  按首字母来查找对应病毒。支持查找的有：
echo.
echo.    [M] 
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0m /N /M 从中选择一项^>
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 goto vd/menu.M
goto vd/menu

:vd/menu.M
cls
echo ^> Virus Defender - 病毒名检索菜单 -^> 首字母[M]
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] (特征杀^|蠕虫) Microsoft Word.WsF
echo.
echo     [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 01 /N /M 从中选择一项^>
cls
if %ERRORLEVEL%==1 goto vd/menu
if %ERRORLEVEL%==2 goto vd/kill.WORM.Microsoft_Word,WsF
goto vd/menu

:vd/kill.WORM.Microsoft_Word,WsF
echo 原作者：[@福厦高速]，有删改   原作者的版权声明见About菜单。
echo.
echo 本组件适用于查杀特征码为"MICROSOFT_WORD.WSF"的U盘蠕虫病毒
echo 即将清除U盘中的所有快捷方式及病毒脚本
echo 并恢复被恶意隐藏的文件显示
set input=00000
set password=%random%%random%
echo.
echo  键入验证码完成请求
echo     ^> %password% ^<
echo.
set /p input=Captcha Code Here ^> 
echo.
if "%password%"=="%input%" (
    cls
    echo.
    echo 进行中，请稍候...
    echo.
    echo 正在查找病毒脚本...
    if not exist "C:\Users\Administrator\AppData\Roaming\Microsoft Office\Microsoft Word.WsF" (
        echo     您的计算机尚未感染此病毒。
    ) else (
        echo     检测到病毒！
        echo 正在清除病毒...
        for /F "delims=, tokens=2" %%i IN ('tasklist /fo csv /fi "imagename eq WSCRIPT.EXE" /nh') DO start "CSBB/ntsd:kill.imagename" api\ntsd.exe -c q -p %%i
        taskkill /f /t /im wscript.exe >nul 2>nul
        del /f /s /q "C:\Users\Administrator\AppData\Roaming\Microsoft Office\" >nul 2>nul
        echo     已清除病毒！
    )
    echo 正在恢复U盘文件系统...
    echo     此过程可能耗时较长，请耐心等待...
    rem 这一段for /f 参考了[@Batcher]的思路，用wmic获取可移动磁盘盘符
    for /f "tokens=2 delims==" %%D in ('wmic LogicalDisk where "DriveType='2'" get DeviceID /value') do (
        rem %%D就是可移动磁盘盘符了
        del /f /s /q "%%D\Microsoft Word.WsF" >nul 2>nul
        attrib -r -a -s -h %%D\*.* /s /d >nul 2>nul
        echo     已恢复文件显示！
        del %%D\*.lnk /f /s /q >nul 2>nul
        echo     已清除所有无效快捷方式！
    )
    echo.
    echo 查杀完成！按任意键退出...
    pause>nul
) ELSE (
    rem 验证码错误
    echo Bad Captcha Code
    pause>nul
)
rem 这后面接验证码完成后的通用操作
goto vd/menu