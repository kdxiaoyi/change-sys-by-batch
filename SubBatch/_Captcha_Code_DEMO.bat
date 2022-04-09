@echo off
title CSBB - Captcha Code Model Demo
:demo/loop
cls
set input=00000
set password=%random%%random%
echo.
echo  Captcha Code Model Demo
echo.
echo  键入验证码完成请求
echo     ^> %password% ^<
echo.
set /p input=Captcha Code Here ^> 
echo.
if "%password%"=="%input%" (
    rem 验证码正确
    echo Good Captcha Code
    pause>nul
) ELSE (
    rem 验证码错误
    echo Bad Captcha Code
    pause>nul
)
rem 这后面接验证码完成后的通用操作
goto Demo/loop