@echo off
cls
title CSBB/GetUACAdmin:noAdmin.run.sure
echo ^> 确定要在没有UAC提取的情况下运行吗？
echo ===================================================================
echo.
echo   本程序大部分功能需要UAC提权才可以运行。
echo    如无必要，请直接双击[Main.bat]运行。
echo.
echo  确定请按[Y]并回车以完成操作。
echo    直接回车将会正常运行。
echo.
echo ===================================================================
set /p input=^> 
if 115414-%input%==115414-y goto sure
if 115414-%input%==115414-Y goto sure
echo Bad Input.
set RunByNoAdmin=0
call main.bat

:sure
echo.
set RunByNoAdmin=1
echo RunByNoAdmin=%RunByNoAdmin%
call main.bat