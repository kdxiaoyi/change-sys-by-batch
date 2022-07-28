@echo off
title CSBB - 创建发行版
cls
echo.
echo 正在创建发行版
echo =============================
timeout /t 1 /nobreak >nul
echo [%time%/INFO] Start working...
echo [%time%/INFO] 创建输出目录
set output=..\CSBB-Release
del /f /q %output%\
md %output%\
timeout /t 1 /nobreak >nul
echo [%time%/INFO] 复制工作文件 ^| xcopy :
xcopy "%cd%" ..\CSBB-Release\ /E /H /Y /F
echo [%time%/INFO] 删除Git操作历史与配置文件 ^| del :
del %output%\.git\ /F /Q /S
echo [%time%/INFO] 删除不必要文件 ^| del
del %output%\.github\ /F /Q /S
del %output%\_config.yml /F /Q
del %output%\api_version.html /F /Q
del %output%\!_创建发行版.BAT /F /Q
del %output%\.git\ /Q
del %output%\.github\ /Q
cd ..
cd /d CSBB-Release\
echo [%time%/INFO] 移除空文件夹 ^| PS/remove-item
attrib -r -s -h .git /S /D
echo A|powershell remove-item .\.git\
attrib -r -s -h .github /S /D
echo A|powershell remove-item .\.github\
echo [%time%/INFO] 打包文件 ^| 7z :
start "打包文件" /wait api\7zip\7z.exe a -bt output_packed.zip %cd%
echo [%time%/INFO] 创建发行版结束
echo [%time%/CONFIRM] 打开工作目录？
echo [%time%/CONFIRM] Y=打开   N=取消
choice /c YN /n /M 键入^> 
if %errorlevel%_==1_ (
	echo [%time%/INFO] 打开工作目录
	explorer.exe /select,output_packed.zip
)
exit /b 0