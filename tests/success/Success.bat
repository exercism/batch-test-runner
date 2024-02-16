@echo off
set year=%~1
set /a isLeap=year %% 4
if %isLeap% neq 0 (
    echo false
    exit /b 0
)

set /a isLeap=%year% %% 100
if %isLeap% neq 0 (
    echo true
    exit /b 0
)
    
set /a isLeap=%year% %% 400
if %isLeap% equ 0 (
    echo true
    exit /b 0
)

echo false
