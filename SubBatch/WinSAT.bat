@echo off
echo.
if NOT EXIST %windir%\system32\winsat.exe (
    set errorcode=CSBB/winSAT:NotTrulyWindowsVersion
    call subbatch\errorscreen.bat
)
goto winsat/menu

rem Win7中WinSAT的帮助文本如下
rem *谷歌翻译地址
rem https://translate.google.cn/?sl=auto&tl=zh-CN&text=%20Windows%20System%20Assessment%20Tool%0A%20%0A%20COMMAND%20LINE%20USAGE%20%3A%0A%20%20%20%20%20%20%20%20%20WINSAT%20%3Cassessment_name%3E%20%5Bswitches%5D%0A%20%0A%20It%27s%20necessary%20to%20supply%20an%20assessment%20name.%20%20In%20contrast%2C%20switches%20are%20optional.%0A%20Valid%20assessment%20names%20already%20seen%20in%20Vista%20include%3A%0A%20%0A%20%20%20%20%20%20%20%20%20formal%20%20%20%20%20%20%20%20%20%20run%20the%20full%20set%20of%20assessments%0A%20%0A%20%20%20%20%20%20%20%20%20dwm%20%20%20%20%20%20%20%20%20%20%20%20%20Run%20the%20Desktop%20Windows%20Manager%20assessment%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20-%20Re-assess%20the%20systems%20graphics%20capabilities%20and%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20restart%20the%20Desktop%20Window%20Manager.%0A%20%0A%20%20%20%20%20%20%20%20%20cpu%20%20%20%20%20%20%20%20%20%20%20%20%20Run%20the%20CPU%20assessment.%0A%20%20%20%20%20%20%20%20%20mem%20%20%20%20%20%20%20%20%20%20%20%20%20Run%20the%20system%20memory%20assessment.%0A%20%20%20%20%20%20%20%20%20d3d%20%20%20%20%20%20%20%20%20%20%20%20%20Run%20the%20d3d%20assessment%0A%20%20%20%20%20%20%20%20%20disk%20%20%20%20%20%20%20%20%20%20%20%20Run%20the%20storage%20assessment%0A%20%20%20%20%20%20%20%20%20media%20%20%20%20%20%20%20%20%20%20%20Run%20the%20media%20assessment%0A%20%20%20%20%20%20%20%20%20mfmedia%20%20%20%20%20%20%20%20%20Run%20the%20Media%20Foundation%20based%20assessment%0A%20%20%20%20%20%20%20%20%20features%20%20%20%20%20%20%20%20Run%20just%20the%20features%20assessment%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20-%20Enumerates%20the%20system%27s%20features.%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20-%20It%27s%20best%20used%20with%20the%20-xml%20%3Cfilename%3E%20switch%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20to%20save%20the%20data.%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20-%20The%20%27eef%27switch%20can%20be%20used%20to%20enumerate%20extra%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20features%20such%20as%20optical%20disks%2C%20memory%20modules%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20and%20other%20items.%0A%20%0A%20PRE-POPULATION%3A%0A%20The%20new%20command-line%20%20options%20for%20pre-populating%20WinSAT%20assessment%20results%20are%20%3A%0A%20%0A%20%20%20%20%20%20%20%20%20Winsat%20prepop%20%5B-datastore%20%3Cdirectory%3E%5D%20%5B%20-graphics%20%7C%20-cpu%20%7C%20-mem%20%7C%20-disk%0A%20%20%7C%20-dwm%20%5D%0A%20%0A%20This%20generates%20WinSAT%20xml%20files%20whose%20filenames%20contain%20%22prepop%22.%20%20For%20example%20%3A%0A%20%0A%20%20%20%20%20%20%20%20%200008-09-26%2014.48.28.542%20Cpu.Assessment%20(Prepop).WinSAT.xml%0A%20%0A%20The%20filename%20pattern%20is%20%3A%0A%20%20%20%20%20%20%20%20%20%25IdentifierDerivedFromDate%25%20%25Component%25.Assessment(Prepop).WinSAT.xml%0A%20%0A%20The%20datastore%20directory%20option%20specifies%20an%20alternative%20target%20location%20for%20generated%20xml%20files.%0A%20If%20no%20location%20is%20specified%2C%20everything%20is%20pre-populated%20to%0A%20%20%20%20%20%20%20%20%20%25WINDIR%25%5Cperformance%5Cwinsat%5Cdatastore.%0A%20%0A%20To%20generate%20a%20full%20set%20of%20result%20xml%20files%2C%20use%20%22winsat%20prepop%22.%0A%20%0A%20It%20is%20also%20possible%20to%20pre-populate%20results%20for%20a%20subsystem%2C%20such%20as%20CPU%2Csubject%20to%20the%20following%20dependencies%3A%0A%20%0A%20%20%20%20%20%20%20%20%20The%20CPU%20assessment%20has%20a%20secondary%20dependency%20on%20the%20Memory%20assessment%0A%20%20%20%20%20%20%20%20%20The%20Memory%20assessment%20has%20a%20secondary%20depenency%20on%20the%20CPU%20assessment%0A%20%20%20%20%20%20%20%20%20The%20Graphics%20assessment%20has%20a%20secondary%20dependency%20on%20both%20CPU%20and%20Memory%20assessments%0A%20%20%20%20%20%20%20%20%20The%20DWM%20assessment%20can%20run%20standalone%0A%20%20%20%20%20%20%20%20%20The%20Disk%20assessment%20can%20run%20standalone%0A%20%0A%20If%20the%20assessment%20for%20a%20secondary%20dependency%20is%20not%20present%2C%20WinSAT%20will%20run%20the%0A%20%0A%20secondary%20assessment%20along%20with%20the%20requested%20primary%20assessment.%0A%20%0A%20For%20example%2C%20%20%22winsat%20prepop%20-cpu%22%20%20will%20run%20both%20the%20CPU%20and%20the%20Memory%20test%2Cif%20the%20xml%20file%20for%20the%20Memory%20test%20is%20not%20present.%0A%20%0A%20OTHER%20NEW%20Win7%20ASSESSMENT%20OPTIONS%20%3A%0A%20%0A%20%20%20%20%20%20%20%20%20dwmformal%20%20%20%20%20%20%20Run%20Desktop%20Windows%20Manager%20assessment%20to%20generate%20the%20WinSAT%20Graphics%20score%0A%20%20%20%20%20%20%20%20%20cpuformal%20%20%20%20%20%20%20Run%20CPU%20assessment%20to%20generate%20the%20WinSAT%20Processor%20score%0A%20%20%20%20%20%20%20%20%20memformal%20%20%20%20%20%20%20Run%20Memory%20assessment%20to%20generate%20the%20WinSAT%20Memory%20(RAM)%20score%0A%20%20%20%20%20%20%20%20%20graphicsformal%20%20Run%20Graphics%20assessment%20to%20generate%20the%20WinSAT%20Gaming%20Graphics%20score%0A%20%20%20%20%20%20%20%20%20diskformal%20%20%20%20%20%20Run%20Disk%20assessment%20to%20generate%20the%20WinSAT%20Primary%20HardDisk%20score%0A%20%0A%20All%20formal%20assessments%20will%20save%20the%20data%20(xml%20files)%20in%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%25WINDIR%25%5Cperformance%5Cwinsat%5Cdatastore.%0A%20%0A%20If%20a%20system%20has%20been%20prepopulated%20(using%20files%20generated%20by%20the%20%22winsat%20prepop%22option)%2Cit%20is%20not%20necessary%20to%20run%20formal%20assessments.%0A%20%0A%20%0A%20SUB-ASSESSMENTS%3A%0A%20While%20investigating%20results%2C%20it%20may%20be%20convenient%20to%20look%20at%20individual%20assessments.%0A%20Options%20for%20running%20Gaming%20Graphics%20sub-assessments%20include%3A%0A%20%0A%20%20%20%20%20%20%20%20%20Winsat%20graphicsformal3d%0A%20%20%20%20%20%20%20%20%20Winsat%20graphicsformalmedia%0A%20%0A%20%20%20%20%20%20%20%20%20DX9%20Variations%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Winsat%20d3d%20-dx9%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-batch%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-alpha%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-tex%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-alu%0A%20%0A%20%20%20%20%20%20%20%20%20DWM%2FDX10%20variations%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Winsat%20d3d%20-dx10%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-alpha%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-tex%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-alu%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-batch%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-geomf4%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-geomf27%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-geomv8%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-gemov32%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20winsat%20d3d%20-dx10%20-cbuffer%0A%20%0A%20OPTIONS%20FOR%20FORMAL%20ASSESSMENTS%20FOR%20SUBSEQUENT%20RUNS%20ON%20THE%20SAME%20MACHINE%3A%0A%20%0A%20The%20default%20behavior%20for%20%22WinSAT%20formal%22%20when%20a%20complete%20set%20of%20winsat%20formal%20files%20is%20presentand%20a%20second%20%22winsat%20formal%22%20run%20is%20requested%20is%20to%0A%20%20%20%20%20%20%20%20%201)%20Run%20incentally%20if%20component%20change%20implies%20that%20an%20assessment%20needs%20to%20be%20re-run%2C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20e.g.%20if%20a%20video%20card%20were%20updated%0A%20%20%20%20%20%20%20%20%202)%20If%20no%20component%20updates%20were%20detected%2C%20re-run%20all%20assessments.%0A%20%0A%20%20%20%20%20%20%20%20%20The%20restart%20option%20enables%20behaviour%20other%20than%20the%20default.%20The%20syntax%20is%20%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Winast%20formal%20-restart%20%5Bclean%7Cnever%5D%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Winsat%20formal%20-restart&op=translate

rem Windows System Assessment Tool
rem  
rem COMMAND LINE USAGE :
rem         WINSAT <assessment_name> [switches]
rem  
rem It's necessary to supply an assessment name.  In contrast, switches are optional.
rem Valid assessment names already seen in Vista include:
rem  
rem         formal          run the full set of assessments
rem  
rem         dwm             Run the Desktop Windows Manager assessment
rem                         - Re-assess the systems graphics capabilities and
rem                           restart the Desktop Window Manager.
rem  
rem         cpu             Run the CPU assessment.
rem         mem             Run the system memory assessment.
rem         d3d             Run the d3d assessment
rem         disk            Run the storage assessment
rem         media           Run the media assessment
rem         mfmedia         Run the Media Foundation based assessment
rem         features        Run just the features assessment
rem                         - Enumerates the system's features.
rem                         - It's best used with the -xml <filename> switch
rem                         to save the data.
rem                         - The 'eef'switch can be used to enumerate extra
rem                         features such as optical disks, memory modules,
rem                         and other items.
rem  
rem PRE-POPULATION:
rem The new command-line  options for pre-populating WinSAT assessment results are :
rem  
rem         Winsat prepop [-datastore <directory>] [ -graphics | -cpu | -mem | -disk| -dwm ]
rem  
rem This generates WinSAT xml files whose filenames contain "prepop".  For example :
rem  
rem         0008-09-26 14.48.28.542 Cpu.Assessment (Prepop).WinSAT.xml
rem  
rem The filename pattern is :
rem         %IdentifierDerivedFromDate% %Component%.Assessment(Prepop).WinSAT.xml
rem  
rem The datastore directory option specifies an alternative target location for generated xml files.
rem If no location is specified, everything is pre-populated to
rem         %WINDIR%\performance\winsat\datastore.
rem  
rem To generate a full set of result xml files, use "winsat prepop".
rem  
rem It is also possible to pre-populate results for a subsystem, such as CPU,subject to the following dependencies:
rem  
rem         The CPU assessment has a secondary dependency on the Memory assessment
rem         The Memory assessment has a secondary depenency on the CPU assessment
rem         The Graphics assessment has a secondary dependency on both CPU and Memory assessments
rem         The DWM assessment can run standalone
rem         The Disk assessment can run standalone
rem  
rem If the assessment for a secondary dependency is not present, WinSAT will run the
rem  
rem secondary assessment along with the requested primary assessment.
rem  
rem For example,  "winsat prepop -cpu"  will run both the CPU and the Memory test,if the xml file for the Memory test is not present.
rem  
rem OTHER NEW Win7 ASSESSMENT OPTIONS :
rem  
rem         dwmformal       Run Desktop Windows Manager assessment to generate the WinSAT Graphics score
rem         cpuformal       Run CPU assessment to generate the WinSAT Processor score
rem         memformal       Run Memory assessment to generate the WinSAT Memory (RAM) score
rem         graphicsformal  Run Graphics assessment to generate the WinSAT Gaming Graphics score
rem         diskformal      Run Disk assessment to generate the WinSAT Primary HardDisk score
rem  
rem All formal assessments will save the data (xml files) in
rem                 %WINDIR%\performance\winsat\datastore.
rem  
rem If a system has been prepopulated (using files generated by the "winsat prepop"option),it is not necessary to run formal assessments.
rem  
rem SUB-ASSESSMENTS:
rem While investigating results, it may be convenient to look at individual assessments.
rem Options for running Gaming Graphics sub-assessments include:
rem  
rem         Winsat graphicsformal3d
rem         Winsat graphicsformalmedia
rem  
rem         DX9 Variations:
rem                 Winsat d3d -dx9
rem                 winsat d3d -batch
rem                 winsat d3d -alpha
rem                 winsat d3d -tex
rem                 winsat d3d -alu
rem  
rem         DWM/DX10 variations:
rem                 Winsat d3d -dx10
rem                 winsat d3d -dx10 -alpha
rem                 winsat d3d -dx10 -tex
rem                 winsat d3d -dx10 -alu
rem                 winsat d3d -dx10 -batch
rem                 winsat d3d -dx10 -geomf4
rem                 winsat d3d -dx10 -geomf27
rem                 winsat d3d -dx10 -geomv8
rem                 winsat d3d -dx10 -gemov32
rem                 winsat d3d -dx10 -cbuffer
rem  
rem OPTIONS FOR FORMAL ASSESSMENTS FOR SUBSEQUENT RUNS ON THE SAME MACHINE:
rem  
rem The default behavior for "WinSAT formal" when a complete set of winsat formal files is presentand a second "winsat formal" run is requested is to
rem         1) Run incrementally if component change implies that an assessment needs to be re-run,                 e.g. if a video card were updated
rem         2) If no component updates were detected, re-run all assessments.
rem  
rem         The restart option enables behaviour other than the default. The syntax is :
rem                 Winast formal -restart [clean|never]
rem                 Winsat formal -restart          Reruns all assessments.
rem                 Winsat formal -restart never   

:winsat/menu
rem Windows System Assessment Tool - %windir%\system32\winsat.exe
cls
echo ^> Windows System Assessment Tool
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [F] 运行 全部 评估
echo.    [D] 运行 DWM性能 评估
echo.    [C] 运行 CPU性能 评估
echo.    [M] 运行 系统内存 评估
echo.    [3] 运行 D3D 评估
echo.    [K] 运行 存储空间 评估
echo.    [E] 运行 媒体性能 评估
echo.    [A] 运行 基于媒体基础的 评估
echo.
if NOT "%winsat/xml.WillSave%"=="1" (
    echo   保存评估报告为XML:[×]
) ELSE (
    echo   保存评估报告为XML:[√]
)
set winsat/xml.saveFile="%temp%\CSBB\.WinSAT\Report\%Random%%Random%%Random%%Random%%Random%"
echo   当前XML保存路径:[%winsat/xml.saveFile%]
echo.    [X] XML评估报告设置
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 0XFDCM3KEA /N /M 从中选择一项^>
cls
if %ERRORLEVEL%==1 call main.bat
if %ERRORLEVEL%==2 goto winsat/xml.settings
if %ERRORLEVEL%==3 set winsat/test.mode=formal&goto winsat/test.cmdline
if %ERRORLEVEL%==4 set winsat/test.mode=dwm&goto winsat/test.cmdline
if %ERRORLEVEL%==5 set winsat/test.mode=cpu&goto winsat/test.cmdline
if %ERRORLEVEL%==6 set winsat/test.mode=mem&goto winsat/test.cmdline
if %ERRORLEVEL%==7 set winsat/test.mode=d3d&goto winsat/test.cmdline
if %ERRORLEVEL%==8 set winsat/test.mode=disk&goto winsat/test.cmdline
if %ERRORLEVEL%==9 set winsat/test.mode=media&goto winsat/test.cmdline
if %ERRORLEVEL%==10 set winsat/test.mode=mfmedia&goto winsat/test.cmdline
goto winsat/menu

:winsat/test.cmdline
title CSBB:Windows性能评估快速调用 - MODE:%winsat/test.mode% ^| 不要关闭这2个黑窗口
MODE con: COLS=75 LINES=1
echo 不要关闭这2个黑窗口……这将花费一些时间……
if NOT "%winsat/xml.WillSave%"=="1" (
    rem 不保存XML报告
    start /WAIT /HIGH WINSAT.EXE %winsat/test.mode%
    title FINISH WORK
    MODE con: COLS=75 LINES=2
    echo 评估完成，任意键返回.
    pause>nul
) ELSE (
    rem 保存XML报告
    md %winsat/xml.saveFile%
    start /WAIT /HIGH WINSAT.EXE WINSAT %winsat/test.mode% -XML %winsat/xml.saveFile%\REPORT_XML.xml
    title FINISH WORK
    MODE con: COLS=75 LINES=2
    echo 评估完成，任意键返回.
    start %winsat/xml.saveFile%\REPORT_XML.xml
    pause>nul
)
cls
mode CON: COLS=80 LINES=30
title Change System By Batch - [%ver%]
goto winsat/menu

:winsat/xml.settings
cls
echo ^> XML评估报告设置
echo ================================================================================
echo         Welcome to [Changing SYS by Bat]
echo.
echo.    [1] 切换[是否保存评估报告为XML]
echo.    [ ] 更改XML保存路径
if "%winsat/xml.WillSave%"=="1" (
    echo.
    echo   保存评估报告为XML:[√]
) ELSE (
    echo.
    echo   保存评估报告为XML:[×]
)
echo   当前XML保存路径:[%winsat/xml.saveFile%]
echo.
echo.    [0] 返回
echo  Made by kdXiaoyi. %y%版权所有
echo ================================================================================
echo SysBit=x%SysBit%
api\choice.exe /c 10 /N /M 从中选择一项^>
cls
if %ERRORLEVEL%==1 (
    echo Pless wait sometimes ...
    echo.
    goto winsat/xml.settings.saveMode
)
if %ERRORLEVEL%==3 (
    echo Pless wait sometimes ...
    echo.
    goto winsat/xml.settings.saveFile
)
if %ERRORLEVEL%==2 goto winsat/menu
goto winsat/xml.settings

:winsat/xml.settings.saveFile
set input=0
set /p input=键入一个地址之后按下回车键^> 
md %input%
if EXIST %input% (
    set winsat/xml.saveFile=%input%
    echo 成功
) ELSE (
    echo.
    echo 非法路径/没有权限。
)
ping 127.0.0.1 -n 4 >nul
goto winsat/xml.settings

:winsat/xml.settings.saveMode
if NOT "%winsat/xml.WillSave%"=="1" (
    echo   [×]-^>[√]
    set winsat/xml.WillSave=1
) ELSE (
    echo   [√]-^>[×]
    set winsat/xml.WillSave=0
)
echo.
echo OKAY!
if NOT "%winsat/xml.WillSave%"=="1" (
    echo   保存评估报告为XML:[×]
) ELSE (
    echo   保存评估报告为XML:[√]
)
ping 127.0.0.1 -n 3>nul
goto winsat/xml.settings