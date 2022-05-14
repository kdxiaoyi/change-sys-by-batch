if NOT "%isgotuac%"=="1" (
    cls
    echo.
    echo    错误：权限不足。
    echo  [User] ^< Need:[UAC-Admin]
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
)
@REM Data\AeroGlass\Aero.exe /silent /norestart
for /f %%i in ('api\getGuid.exe') do set GUID=%%i
md "%tmp%\7zip\%GUID%\"
md "%tmp%\areoGlass\"
if EXIST "%tmp%\areoGlass\aero.tool" del /f /q "%tmp%\areoGlass\aero.tool"
start "7-zip ^| Unzipped files" /wait /D %tmp%\areoGlass\ api\7zip\7z.exe x -y -w{"%tmp%\7zip\%GUID%\"} "%cd%\Data\AeroGlass\aero.tool.dataZ"
if not EXIST "%tmp%\areoGlass\aero.tool" (
    echo.
    echo    错误：解压数据失败。
    echo.
    ping 127.0.0.1 -n 5 >nul
    call main.bat
)
rename "%tmp%\areoGlass\aero.tool" "%tmp%\areoGlass\aero.tool.exe"
"%tmp%\areoGlass\aero.tool.exe" /silent /norestart
regedit /s Data\AeroGlass\aero.Rdata
del /q /f "C:\AeroGlass\win8rp.png"
del /q /f "C:\AeroGlass\win8rp.png.layout"
del /q /f "%tmp%\areoGlass\aero.tool.exe"
del /q /f "%tmp%\7zip\%GUID%\"
echo.
echo 已安装AeroGlass补丁。
echo.
echo 任意键返回……
pause>nul
call main.bat