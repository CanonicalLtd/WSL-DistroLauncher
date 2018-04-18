@echo off

set _KEY=DistroLauncher-Appx\\Ubuntu_TemporaryKey

rem Add path to MSBuild Binaries
set MSBUILD=()
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe" (
    set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" (
	set MSBUILD="%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe" (
	set MSBUILD="%ProgramFiles%\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles(x86)%\MSBuild\14.0\bin" (
    set MSBUILD="%ProgramFiles(x86)%\MSBuild\14.0\bin\msbuild.exe"
    goto :FOUND_MSBUILD
)
if exist "%ProgramFiles%\MSBuild\14.0\bin" (
    set MSBUILD="%ProgramFiles%\MSBuild\14.0\bin\msbuild.exe"
    goto :FOUND_MSBUILD
)

if %MSBUILD%==() (
    echo "I couldn't find MSBuild on your PC. Make sure it's installed somewhere, and if it's not in the above if statements (in build.bat), add it."
    goto :EXIT
) 
:FOUND_MSBUILD
set _MSBUILD_TARGET=Build
set _MSBUILD_CONFIG=Debug

if not exist "%_KEY%".pfx (
    echo "Generating some test certs/keys to test sideloading with."
    echo "This is going to prompt you for a name and password, and then that password again, and then the password again."
    echo "You can enter whatever you want, these should only be used for local testing."
    @rem Creates keys for local testing.
    @rem Note that "CN=%_OWNER%" needs to match the Publisher in your appxmanifest
    makecert -r -h 0 -n "CN=23596F84-C3EA-4CD8-A7DF-550DCE37BCD0" -eku "1.3.6.1.5.5.7.3.3,1.3.6.1.4.1.311.10.3.13" -pe -sv %_KEY%.pvk %_KEY%.cer
    pvk2pfx -pvk %_KEY%.pvk -spc %_KEY%.cer -pfx %_KEY%.pfx

    echo "You will need to install that cert before you can sideload the appx. "
    echo "You can install it with the following command (in an admin window)"
    echo
    echo CertMgr /add %_KEY%.cer /s /r localMachine root
)


:ARGS_LOOP
if (%1) == () goto :POST_ARGS_LOOP
if (%1) == (clean) (
    set _MSBUILD_TARGET=Clean,Build
)
if (%1) == (rel) (
    set _MSBUILD_CONFIG=Release
)
shift
goto :ARGS_LOOP

:POST_ARGS_LOOP
%MSBUILD% %~dp0\DistroLauncher.sln /t:%_MSBUILD_TARGET% /m /nr:true /p:Configuration=%_MSBUILD_CONFIG%;Platform=x64

if (%ERRORLEVEL%) == (0) (
    echo.
    echo Created appx in %~dp0x64\%_MSBUILD_CONFIG%\Ubuntu\
    echo.
)

:EXIT
