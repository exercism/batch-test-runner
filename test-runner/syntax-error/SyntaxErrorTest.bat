@echo off
REM ---------------------------------------------------
REM isLeapTest[Custom Syntax Error Test]
REM ---------------------------------------------------

:Main
    REM Initalize result variable
    set "slug=SyntaxError"

    CALL :CheckEmptyFile

    REM --------------------
    REM Test Case Start \/\/
    REM --------------------
    set "expected=false"
    CALL :Assert 2015
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=false"
    CALL :Assert 1970
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=true"
    CALL :Assert 1996
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=true"
    CALL :Assert 1960
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=false"
    CALL :Assert 2100
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=false"
    CALL :Assert 1900
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=true"
    CALL :Assert 2000
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=true"
    CALL :Assert 2400
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    set "expected=false"
    CALL :Assert 1800
    if %errorlevel%==0 (echo Test passed) else (echo Test failed)

    REM --------------------
    REM Test Case End /\/\/\
    REM --------------------

    CALL :ExportResultAsJson
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

:ExportResultAsJson
set "status="
if %isEmpty%==true (
    set "status=fail"
    set "message=The file is empty."
) else (
    if %failCount% gtr 0 (
        set "status=fail"
        set "message=Leap year not divisible by 4 in common year"
    ) else (
        if %failCount% equ 0 (
            set "status=pass"
        )
    )
)

REM Export result as JSON
if %status%==pass (
(
  echo {
  echo   "version": 1,
  echo   "status": "%status%"
  echo }
) > results.json
) else (
(
  echo {
  echo   "version": 1,
  echo   "status": "%status%",
  echo   "message": "%message%"
  echo }
) > results.json
)
GOTO :EOF REM Go back to the line after the call to :ExportResultAsJson

:End
