@echo off & color 0e & setlocal enabledelayedexpansion 
REM if "%1" == "h" goto begin
REM mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin


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
set tmpdirx=%rootdirx%tmp



:gitCheck
cd %rootdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start check git>>"%rootdirx%/log.txt"
cd %rootdirx%
if not exist git.local (
git config --global credential.helper store
git credential-manager uninstall
)
git --version > git.local
for /f "delims=" %%a in (git.local) do ( 
	for /f "tokens=1* delims=:" %%i in ('call echo %%a^|find /i "version"') do (
		Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %%a>>"%rootdirx%/log.txt"
		set gitversion=%%a
		)  
) 
echo %gitversion%|find /i "version" >nul && @title  %gitversion% || echo "Git Not Installed Please Install The Last Verson Of Git"
echo %gitversion%|find /i "version" >nul && echo %gitversion% || goto gitInstall
git config --global credential.helper store
REM git credential-manager uninstall
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    finish check git>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto configCheck


:configCheck
cd %rootdirx%
if not exist git.local (
git config --global credential.helper store
git credential-manager uninstall
)
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    checking config>>"%rootdirx%/log.txt"
for /f "tokens=1,* delims==" %%a in (
'findstr "github_addr=" git.config'
) do (
set github_addr=%%b
echo %%b|find /i ".git" >nul && echo %%b || goto githubAddr
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    github_addr:%%b>>"%rootdirx%/log.txt"
)
for /f "tokens=1,* delims==" %%a in (
'findstr "oschina_addr=" git.config'
) do (
set oschina_addr=%%b
echo %%b|find /i ".git" >nul && echo %%b || goto oschinaAddr
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    oschina_addr:%%b>>"%rootdirx%/log.txt"
)
for /f "tokens=1,* delims==" %%a in (
'findstr "main_repo=" git.config'
) do (
set main_repo=%%b
echo %%b|find /i "oschina" >nul && echo %%b || (echo %%b|find /i "github" >nul && echo %%b || goto mainrepo)
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    main_repo:%%b>>"%rootdirx%/log.txt"
)
for /f "tokens=1,* delims==" %%a in (
'findstr "sync_dir=" git.config'
) do (
set sync_dir=%%b
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    sync_dir:%%b>>"%rootdirx%/log.txt"
)
echo github_addr=%github_addr%
echo oschina_addr=%oschina_addr%
echo main_repo=%main_repo%
if not exist %config_file% cd.>>%config_file%
find ^"github_addr^" %config_file% >>nul &&echo github_addr readed.||echo github_addr not founded && goto githubAddr
find ^"oschina_addr^" %config_file% >>nul &&echo oschina_addr readed.||echo oschina_addr not founded && goto oschinaAddr
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    config ok>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto fileCheck



:fileCheck
@title  ����ļ�ϵͳ...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start check file>>"%rootdirx%/log.txt"
echo ����ļ�ϵͳ...
if exist %tmpdirx% (
echo TMP�ļ��� ok  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp:%tmpdirx%>>"%rootdirx%/log.txt"
) else (
echo TMP�ļ��� not founded! %tmpdirx%
echo "������TMP�ļ���" %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-tmp:%tmpdirx%>>"%rootdirx%/log.txt"
echo "����TMP�ļ���" %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    creat tmp dir:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
cd %rootdirx%
rd  /S /Q %tmpdirx%
md %tmpdirx%
cd  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp dir ok>>"%rootdirx%/log.txt"
)
if exist %tmpdirx%\oschina (

cd %tmpdirx%\oschina
echo oschina ok   %tmpdirx%\oschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp:%tmpdirx%\oschina>>"%rootdirx%/log.txt"
git config --global credential.helper store 
git   pull > %tmpdirx%\oschina_git_log
) else (
echo ochina not founded  %tmpdirx%\oschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-tmp\oschina:%tmpdirx%>>"%rootdirx%/log.txt"
echo "����oschina�ļ���" %tmpdirx%\oschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    creat tmp\oschina dir:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
cd %tmpdirx%
rd  /S /Q %tmpdirx%\oschina
md %tmpdirx%\oschina
cd  %tmpdirx%\oschina
echo git  -C %tmpdirx%\oschina\ clone "%oschina_addr%"  %tmpdirx%\oschina\ 
git config --global credential.helper store
git clone "%oschina_addr%"  %tmpdirx%\oschina\
git pull  > %tmpdirx%\oschina_git_log

Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp\oschina dir ok>>"%rootdirx%/log.txt"
)
REM if exist %tmpdirx%\github (
REM cd  %tmpdirx%\github
REM echo github ok %tmpdirx%\github
REM Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp:%tmpdirx%\github>>"%rootdirx%/log.txt"
REM git config --global credential.helper store
REM git    pull > %tmpdirx%\github_git_log
REM ) else (
REM echo ochina not founded %tmpdirx%\github
REM Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-tmp\github:%tmpdirx%>>"%rootdirx%/log.txt"
REM echo "����oschina�ļ���" %tmpdirx%\github
REM Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    creat tmp\github dir:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
REM cd %tmpdirx%
REM rd  /S /Q %tmpdirx%\github
REM md %tmpdirx%\github
REM cd  %tmpdirx%\github
REM echo git -C %tmpdirx%\github\ clone "%github_addr%" 
REM git   clone "%github_addr%" %tmpdirx%\github\ > %tmpdirx%\github_git_log 
REM git   pull > %tmpdirx%\github_git_log 
REM git config --global credential.helper store
REM Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp\github dir ok>>"%rootdirx%/log.txt"
REM )
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    filesystem ok>>"%rootdirx%/log.txt"
REM set /P github_git_log=<%tmpdirx%\github_git_log
REM echo  %github_git_log% ��������������������������������������������������
set /P oschina_git_log=<%tmpdirx%\oschina_git_log
REM echo  %oschina_git_log% ��������������������������������������������������������
REM echo %github_git_log%|find /i "Already" >nul && echo  %github_git_log% check sucess || echo  goto resetgithub
REM Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %github_git_log% github check sucess>>"%rootdirx%/log.txt"
echo %oschina_git_log%|find /i "Already" >nul && echo %oschina_git_log% check sucess || echo  goto resetoschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %oschina_git_log% oschina check sucess>>"%rootdirx%/log.txt"
echo �ļ�ϵͳ������
ping -n 2 localhost 1>nul 2>nul
REM cls
goto checkSyncDir



:resetgithub
@title  resetgithub...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    github reset>>"%rootdirx%/log.txt"
cd %tmpdirx%
rd  /S /Q %tmpdirx%\github
md %tmpdirx%\github
cd  %tmpdirx%\github
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%     github reset sucess>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto fileCheck

:resetoschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    oschina reset>>"%rootdirx%/log.txt"
cd %tmpdirx%
rd  /S /Q %tmpdirx%\oschina
md %tmpdirx%\oschina
cd  %tmpdirx%\oschina
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%     oschina reset sucess>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto fileCheck


:gitInstall
@title  gitInstall...
cd %rootdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start check file>>"%rootdirx%/log.txt"
echo ����ļ�ϵͳ...
if exist %tmpdirx% (
echo TMP�ļ��� ok  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp:%tmpdirx%>>"%rootdirx%/log.txt"
) else (
echo TMP�ļ��� not founded! %tmpdirx%
echo "������TMP�ļ���" %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-tmp:%tmpdirx%>>"%rootdirx%/log.txt"
echo "����TMP�ļ���" %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    creat tmp dir:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
cd %rootdirx%
rd  /S /Q %tmpdirx%
md %tmpdirx%
cd  %tmpdirx%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    tmp dir ok>>"%rootdirx%/log.txt"
)
echo start download git...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start download git>>"%rootdirx%/log.txt"
powershell -Command "Invoke-WebRequest https://github-production-release-asset-2e65be.s3.amazonaws.com/23216272/42bc4300-3a11-11e9-8a7d-8c1dc79eb654?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190326%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190326T020438Z&X-Amz-Expires=300&X-Amz-Signature=e59031c50622102622068289d189fae2e83e1dbe8b7596f946629665c521f4df&X-Amz-SignedHeaders=host&actor_id=1842578&response-content-disposition=attachment%3B%20filename%3DGit-2.21.0-64-bit.exe&response-content-type=application%2Foctet-stream -OutFile %tmpdirx%/git.exe"
echo start install git...
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    start install git>>"%rootdirx%/log.txt"
start /wait %tmpdirx%/git.exe 
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    installed git>>"%rootdirx%/log.txt"
REM cls
goto gitCheck

:githubAddr
cd %rootdirx%
set /p github_addr=Please input github_addr:
echo github_addr=%github_addr%
rem find ^"github_addr^" %config_file% >>nul && goto configCheck||echo github_addr not founded && goto githubAddr
REM cls
goto erroff

:oschinaAddr
cd %rootdirx%
set /p oschina_addr=Please input github_addr:
echo oschina_addr=%oschina_addr%
rem find ^"oschina_addr^" %config_file% >>nul && goto configCheck||echo github_addr not founded && goto githubAddr
REM cls
goto erroff

:mainrepo
cd %rootdirx%
echo main repo err 
REM cls
goto configCheck


:checkSyncDir
@title  checkSyncDir...
cd %rootdirx%
if exist %rootdirx%%sync_dir% (
echo SYNC start  %rootdirx%%sync_dir%
goto copyFiles
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    sync:%rootdirx%%sync_dir%  ok>>"%rootdirx%/log.txt"
) else (
echo sync�ļ��� not founded! %rootdirx%%sync_dir%
echo "������sync�ļ���" %rootdirx%%sync_dir%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ===err-sync:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
echo "����sync�ļ���" %rootdirx%%sync_dir%
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    creat-sync:%rootdirx%%sync_dir%>>"%rootdirx%/log.txt"
cd %rootdirx%
rd  /S /Q %rootdirx%%sync_dir%
md %rootdirx%%sync_dir%
cd  %rootdirx%%sync_dir%
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/ntxt168/ntxt168.com/master/favicon.ico -OutFile %rootdirx%%sync_dir%/favicon.ico " 
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/ntxt168/ntxt168.com/master/CNAME -OutFile %rootdirx%%sync_dir%/CNAME "
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    sync-dir-check-ok>>"%rootdirx%/log.txt"
REM cls
goto checkSyncDir
)



:copyFiles
set timeremain=15
echo %timeremain%���ʼ
for /L %%a in (
%timeremain%,-1,0
) do (
cls
@title  ʣ��%%a�뿪ʼ...
if %%a lss 10  echo ׼��ͬ����ʱ��������ļ��� ��������������������������������������������
echo     һ��׼�������ˣ�����5����ʱ�䰴����˳�������ʣ��%%a�뿪ʼ...
echo ��    
echo     1.��excel�ļ�-������ļ���-��������������Ϊ��
echo ��    
echo     2.������λ�û��ߵ���ϴα����λ�á���λ��bat�ļ�ͬĿ¼��ntxt168�¡�
echo ��    
echo     3.������ļ����͡�-ѡ����ҳ��ע�ⲻ�ǵ�����ҳ
echo ��    
echo     4.�ļ������롾index��
echo ��    
echo     5.����ϴ��������룬��ʧͼƬ�����������쳣���⣬�밴������Ĳ������в���
echo ��    
echo        һ�������ʱ���������ߡ�
echo        ���������webѡ�
echo        ������������롿ѡ�
echo        �ġ�����ѡ�񽫴��ĵ����Ϊѡ��Unicode��UTF8��������
if %%a lss 10  echo ׼��ͬ����ʱ��������ļ��� ��������������������������������������������

ping -n 2 localhost 1>nul 2>nul
cls
)
if not exist %tmpdirx% (
goto begin
)
if not exist %tmpdirx%\oschina (
goto begin
)
cd %rootdirx%
echo SYNC�ļ��� ok %rootdirx%%sync_dir%
dir /a /b %rootdirx%%sync_dir%|findstr .>nul 2>nul &&  (echo ���ļ�
echo ��ʼ�����ļ� 
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ��ʼ�����ļ�>>"%rootdirx%/log.txt"
xcopy  /Y/E/C %rootdirx%%sync_dir%\*.*  %tmpdirx%\oschina\   
xcopy /Y/E/C  %rootdirx%%sync_dir%\*  %tmpdirx%\oschina\    
echo ɾ��ͬ���ļ�
del  /S /Q %rootdirx%%sync_dir%\*.*
del  /S /Q %rootdirx%%sync_dir%\* 
rd /S /Q %rootdirx%%sync_dir%\index.files\
echo �ļ��������
ping -n 2 localhost 1>nul 2>nul
REM xcopy /Y /V /S /T /E /Q /C /H /U  %rootdirx%%sync_dir%\*.* %tmpdirx%\github\ >>"%rootdirx%/log.txt"
echo ����������׼����Ӳ��ύ
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    ��������>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto addall
) ||  (echo û���ļ�
echo û�з����ļ�,���Բ鿴TMP�ļ��޸�
Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    sync file empty>>"%rootdirx%/log.txt"
ping -n 2 localhost 1>nul 2>nul
REM cls
goto addall
)


:addall
if not exist %tmpdirx% (
echo  û�з���tmpdirx
goto begin
)
if not exist %tmpdirx%\oschina (
echo  û�з���oschina
goto begin
)
echo ׼������ļ�
cd %rootdirx%
cd %tmpdirx%\oschina
git add . >>"%rootdirx%/log.txt"
git status >"%tmpdirx%\oschina_status"
for /f "delims=" %%a in (%tmpdirx%\oschina_status) do ( 
	for /f "tokens=1* delims=:" %%i in ('call echo %%a^|find /i "Changes not staged for commit"') do (
		Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %%a>>"%rootdirx%/log.txt"
		set gitstatus=%%a
		)  
) 
echo %gitstatus%|find /i "Changes not staged for commit" >nul && echo Changes not staged for commit  || echo Changes staged for commit
echo %gitstatus%|find /i "Changes not staged for commit" >nul && git add .   || echo all added nothing to add
echo %gitstatus%|find /i "Changes not staged for commit" >nul && goto commit || goto push


:commit
if not exist %tmpdirx% (
goto begin
)
if not exist %tmpdirx%\oschina (
goto begin
)
cd %rootdirx%
cd %tmpdirx%\oschina
git status >"%tmpdirx%\oschina_status"
for /f "delims=" %%a in (%tmpdirx%\oschina_status) do ( 
	for /f "tokens=1* delims=:" %%i in ('call echo %%a^|find /i "Changes to be committed"') do (
		Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %%a>>"%rootdirx%/log.txt"
		set gitstatus=%%a
		)  
) 
echo %gitstatus%|find /i "Changes to be committed" >nul && echo Changes to be committed || echo no Changes to be committed
echo %gitstatus%|find /i "Changes to be committed" >nul && echo ׼���ύ || goto push
echo ׼���ύ����
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
cd %rootdirx%
REM echo github_addr=%github_addr%
REM echo oschina_addr=%oschina_addr%
cd %tmpdirx%\oschina\
git   commit -m [%yy%-%mm%-%dd%_%Thh%.%Tmm%.%Tss%] >>"%rootdirx%/log.txt"
rem git  -C %tmpdirx%\github\ commit -m [%date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%]
echo �����ύ������׼���ϴ�����
ping -n 2 localhost 1>nul 2>nul
REM cls
goto push

:push

echo start push
if not exist %tmpdirx% (
goto begin
)
if not exist %tmpdirx%\oschina (
goto begin
)
echo ׼������
cd %rootdirx%
REM echo github_addr=%github_addr%
REM echo oschina_addr=%oschina_addr%
cd %tmpdirx%\oschina\
git status >"%tmpdirx%\oschina_status"
for /f "delims=" %%a in (%tmpdirx%\oschina_status) do ( 
	for /f "tokens=1* delims=:" %%i in ('call echo %%a^|find /i "publish your local commits"') do (
		Echo %date:~0,4%-%date:~5,2%-%date:~8,2%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%    %%a>>"%rootdirx%/log.txt"
		set gitstatus=%%a
		)  
) 
echo %gitstatus%|find /i "publish your local commits" >nul && echo publish your local commits || echo ȡ������
echo %gitstatus%|find /i "publish your local commits" >nul && echo ׼���ύ || goto copyFiles
git status >>"%rootdirx%/log.txt" 
git push  origin master >>"%rootdirx%/log.txt"
rem git  -C %tmpdirx%\github\ push origin master
echo  �����ɹ�
ping -n 2 localhost 1>nul 2>nul
REM cls
goto del

:del
echo ɾ��ͬ���ļ�
if not exist %tmpdirx% (
goto begin
)
if not exist %tmpdirx%\oschina (
goto begin
)
if not exist %rootdirx%%sync_dir% (
goto begin
)
echo delete all sync file
ping 127.1 -n 10 >nul
cd %rootdirx%
del  /S /Q %rootdirx%%sync_dir%\*.*
del  /S /Q %rootdirx%%sync_dir%\* 
echo �ļ��������
ping -n 2 localhost 1>nul 2>nul
goto checkSyncDir


:erroff
goto begin







