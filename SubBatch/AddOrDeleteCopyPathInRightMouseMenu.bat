cls
echo.
if "%IsGotUAC%" NEQ "1" (
    echo    错误：权限不足。
    echo  [User] ^< Need:[UAC-Admin]
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
)
set input=00000
set password=%random%%random%
echo  [复制文件路径(^&A)]菜单 - 操作说明
echo.
echo  没有就自动添加，有就会删掉
echo  如果[D:\]有[右键菜单.ico]则会以这个作为右键菜单的图标
echo.
echo  键入验证码完成请求
echo     ^> %password% ^<
echo.
set /p input=Captcha Code Here ^> 
echo.
if "%password%"=="%input%" (
    rem 验证码正确
    echo Good Captcha Code
    goto AODCPIRMM/work
) ELSE (
    echo 验证码错误
)
rem 这后面接验证码完成后的通用操作
goto AODCPIRMM/back

:AODCPIRMM/back
echo.
echo 任意键返回……
pause>nul
call main.bat

:AODCPIRMM/work
for /f "tokens=2 delims=[" %%i in ('ver') do (
    for /f "tokens=2,3 delims=. " %%j in ("%%i") do if %%j LSS 10 (
        set input=156
    ) else (
        set input=-5302
    )
)
if exist "D:\右键菜单.ico" (
    reg query "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)">nul 2>nul && (reg delete "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)" /f >nul & echo 已执行删除操作 & goto AODCPIRMM/back) || (reg add "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)" /v "icon" /t REG_SZ /d "%cd%\右键菜单.ico" /f & reg add "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)\command" /ve /t REG_SZ /d "cmd /c echo \"%%1\"<nul|clip" /f & echo 安装完毕! & goto AODCPIRMM/back)
) else (
    reg query "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)">nul 2>nul && (reg delete "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)" /f >nul & echo 已执行删除操作 & goto AODCPIRMM/back) || (reg add "HKCR\AllFilesystemObjects\shell\复制文件路径(&A)\command" /ve /t REG_SZ /d "cmd /c echo \"%%1\"<nul|clip" /f & echo 安装完毕! & goto AODCPIRMM/back)
)
goto AODCPIRMM/back