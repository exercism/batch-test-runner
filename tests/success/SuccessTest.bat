@echo off
REM ---------------------------------------------------
REM testThatGreeterReturnsTheCorrectGreeting
REM ---------------------------------------------------

REM Initalize result variable
set "slug=Success"
set "result="
set "expected=Hello, World!"

REM Check if file exist, if not exit with code 2
if exist %~dp0%slug%.bat (
    REM Run the program and save the output to stdout.bin
    CALL %~dp0%slug%.bat > stdout.bin
    
    REM Assign to result varriable the output from stdout.bin
    set /p result=<stdout.bin

    REM Delete stdout.bin
    del stdout.bin

) else (
    REM Errorlevel = 2: The system cannot find the file specified. 
    REM                 Indicates that the file cannot be found in specified location.
    echo Could not find "%~dp0%slug%.bat" or "%slug%.bat"
    exit /b 2

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
