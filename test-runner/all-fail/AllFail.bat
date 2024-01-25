@echo off
set year=%~1
set /a isLeap=year %% 2
if %isLeap%==1 (echo true) else (echo false)
