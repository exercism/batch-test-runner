@echo off
REM ---------------------------------------------------
REM testThatGreeterReturnsTheCorrectGreeting
REM ---------------------------------------------------

REM Initalize result variable
set "slug=Success"
set "result="
set "expected=Hello, World!"

REM Run the program and store the output in the result variable
echo.Looking for "%~dp0%slug%.bat" > log.txt
if exist %~dp0%slug%.bat (
    REM If the file exists in the full path, run it from there
    echo.Found "%~dp0%slug%.bat" > log.txt
    CALL %~dp0%slug%.bat > stdout.bin
    set /p result=<stdout.bin
    del stdout.bin
) else (

    echo.Could not find "%~dp0%slug%.bat" > log.txt
    echo.Looking for "%slug%.bat" > log.txt

    if exist %slug%.bat (
        REM If the file exists in the wildcard search path, run it from there
        echo.Found "%slug%.bat" > log.txt
        CALL %slug%.bat > stdout.bin
        set /p result=<stdout.bin
        del stdout.bin
    ) else (
        REM Errorlevel = 2: The system cannot find the file specified. 
        REM                 Indicates that the file cannot be found in specified location.
        echo Could not find "%~dp0%slug%.bat" or "%slug%.bat"
        exit /b 2
    )
)

REM Check if the result is correct
if "%result%" == "%expected%" (
    REM If the result is correct, exit with code 0
    echo Test passed
    exit /b 0
) else (
    REM If the result is incorrect, exit with code 1
    echo Expected: %expected%
    echo Actually: %result%
    echo Test failed
    exit /b 1
)
