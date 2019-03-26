@echo off & color 0e & setlocal enabledelayedexpansion 
set hh=%time:~0,2%
set mi=%time:~3,2%
set ss=%time:~6,2% 
set hhmiss=%hh% :  %mi% : %ss%
set dd=%date:~8,2%
set mm=%date:~5,2%
set yy=%date:~0,4%
set Tss=%TIME:~6,2%
set Tmm=%TIME:~3,2%
set Thh=%TIME:~0,2%
set Thh=%Thh: =0%
set logtime=%yy%-%mm%-%dd%_%Thh%.%Tmm%.%Tss%
set config_file=%~dp0git.config
set rootdirx=%~dp0
set tmpdirx=%~dp0tmp
	
:fileCheck
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start check file...>>"%tmpdirx%/log.txt"
echo 检查文件系统...
if exist %tmpdirx% (
echo TMP文件夹 ok!  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp:%tmpdirx%...>>"%tmpdirx%/log.txt"
) else (
echo TMP文件夹 not founded! %tmpdirx%
echo "不存在TMP文件夹" %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-tmp:%tmpdirx%...>>"%tmpdirx%/log.txt"
echo "创建TMP文件夹" %tmpdirx%
rd  /S /Q %tmpdirx%
md %tmpdirx%
cd  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    file check end...>>"%tmpdirx%/log.txt"
)
echo 文件系统检查完毕
goto gitCheck

:gitCheck
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start check git...>>"%tmpdirx%/log.txt"
git --version > git.local
git config --global credential.helper store
for /f "delims=" %%a in (git.local) do ( 
	for /f "tokens=1* delims=:" %%i in ('call echo %%a^|find /i "version"') do (
		Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %%a>>"%tmpdirx%/log.txt"
		set gitversion=%%a
		)  
) 
echo %gitversion%|find /i "version" >nul && @title  %gitversion% || echo "Git Not Installed Please Install The Last Verson Of Git"
echo %gitversion%|find /i "version" >nul && echo %gitversion% || goto gitInstall
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    finish check git...>>"%tmpdirx%/log.txt"
goto configCheck

:gitInstall
echo start download git...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start download git...>>"%tmpdirx%/log.txt"
powershell -Command "Invoke-WebRequest https://github-production-release-asset-2e65be.s3.amazonaws.com/23216272/42bc4300-3a11-11e9-8a7d-8c1dc79eb654?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190326%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190326T020438Z&X-Amz-Expires=300&X-Amz-Signature=e59031c50622102622068289d189fae2e83e1dbe8b7596f946629665c521f4df&X-Amz-SignedHeaders=host&actor_id=1842578&response-content-disposition=attachment%3B%20filename%3DGit-2.21.0-64-bit.exe&response-content-type=application%2Foctet-stream -OutFile %tmpdirx%/git.exe"
echo start install git...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start install git...>>"%tmpdirx%/log.txt"
start /wait %tmpdirx%/git.exe 
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    installed git...>>"%tmpdirx%/log.txt"
goto gitCheck

:githubAddr
set /p github_addr=Please input github_addr:
find ^"github_addr^" %config_file% >>nul && goto configCheck||echo github_addr not founded && goto githubAddr
goto configCheck

:oschinaAddr
set /p oschina_addr=Please input github_addr:
find ^"oschina_addr^" %config_file% >>nul && goto configCheck||echo github_addr not founded && goto githubAddr
goto configCheck

:configCheck
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    checking config...>>"%tmpdirx%/log.txt"
cd %rootdirx%
for /f "tokens=1,* delims==" %%a in (
'findstr "github_addr=" git.config'
) do (
set github_addr=%%b
)
for /f "tokens=1,* delims==" %%a in (
'findstr "oschina_addr=" git.config'
) do (
set oschina_addr=%%b
)
for /f "tokens=1,* delims==" %%a in (
'findstr "main_repo=" git.config'
) do (
set main_repo=%%b
)
for /f "tokens=1,* delims==" %%a in (
'findstr "sync_dir=" git.config'
) do (
set sync_dir=%%b
goto checkSyncDir
)


 

echo github_addr=%github_addr%
echo oschina_addr=%oschina_addr%
echo main_repo=%main_repo%
if not exist %config_file% cd.>>%config_file%
find ^"github_addr^" %config_file% >>nul &&echo github_addr readed.||echo github_addr not founded && goto githubAddr
find ^"oschina_addr^" %config_file% >>nul &&echo oschina_addr readed.||echo oschina_addr not founded && goto oschinaAddr
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    config ok...>>"%tmpdirx%/log.txt"
pause;



:checkSyncDir
if exist %~dp0%sync_dir% (
echo SYNC文件夹 ok!  %~dp0%sync_dir%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    sync:%~dp0%sync_dir%...>>"%tmpdirx%/log.txt"
) else (
echo sync文件夹 not founded! %~dp0%sync_dir%
echo "不存在sync文件夹" %~dp0%sync_dir%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-sync:%~dp0%sync_dir%...>>"%tmpdirx%/log.txt"
echo "创建sync文件夹" %~dp0%sync_dir%
rd  /S /Q %~dp0%sync_dir%
md %~dp0%sync_dir%
cd  %~dp0%sync_dir%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    file check end...>>"%tmpdirx%/log.txt"
)



:pull
echo github_addr=%github_addr%
echo oschina_addr=%oschina_addr%


:push
echo github_addr=%github_addr%
echo oschina_addr=%oschina_addr%


:del
echo github_addr=%github_addr%
echo oschina_addr=%oschina_addr%

:addall



pause;







