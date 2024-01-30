@echo off
set year=%~1
set /a isLeap=year %% 4
if %isLeap% neq 0 (echo false) else (
    set /a isLeap=year %% 100
    if %isLeap% neq 0 (echo true) else (
        set /a isLeap=year %% 401
        if %isLeap% neq 0 (echo false) else (echo true)
    )
)
