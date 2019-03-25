@echo off
set hh=%time:~0,2%
set mi=%time:~3,2%
set ss=%time:~6,2% 
set hhmiss=%hh% :  %mi% : %ss%
git --version > git.local

pause;