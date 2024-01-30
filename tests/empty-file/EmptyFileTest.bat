@echo off
REM ---------------------------------------------------
REM isLeapTest[Custom Empty File Test]
REM ---------------------------------------------------

:Main
    REM Initalize result variable
    set "slug=EmptyFile"

    CALL :CheckEmptyFile

    REM --------------------
    REM Test Case Start \/\/
    REM --------------------
    set "expected=true"
    CALL :Assert 1996
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=false"
    CALL :Assert 2015
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    REM --------------------
    REM Test Case End /\/\/\
    REM --------------------

    CALL :ResolveStatus
    exit /b %errorlevel%
REM End of Main

REM ---------------------------------------------------
REM Assert [..Parameters(up to 9)]
REM ---------------------------------------------------
GOTO :End REM Prevents the code below from being executed
:Assert
set "result="

REM Run the program and capture the output then delete the file
CALL %slug%.bat %~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9 > stdout.bin 2>&1
set /p result=<stdout.bin
del stdout.bin

REM Check if the result is correct
if "%result%" == "%expected%" (
    REM If the result is correct, exit with code 0
    set /a successCount+=1
    exit /b 0
) else (
    REM If the result is incorrect, exit with code 1
    set /a failCount+=1
    exit /b 1
)
GOTO :EOF REM Go back to the line after the call to :Assert

:CheckEmptyFile
REM It's for initialize, not about checking empty file
set successCount=0
set failCount=0

for %%I in (%slug%.bat) do (
    if %%~zI equ 0 (
        set "isEmpty=true"
    ) else (
        set "isEmpty=false"
    )
)
GOTO :EOF REM Go back to the line after the call to :CheckEmptyFile

:ResolveStatus
set "status="
if %isEmpty%==true (
    REM status: Fail
    REM message: The file is empty.
    exit /b 2
) else (
    if %failCount% gtr 0 (
        REM status: Fail
        REM message: The test failed.
        exit /b 1
    ) else (
        if %failCount% equ 0 (
            REM status: Pass
            exit /b 0
        )
    )
)
GOTO :EOF REM Go back to the line after the call to :ExportResultAsJson

:End
