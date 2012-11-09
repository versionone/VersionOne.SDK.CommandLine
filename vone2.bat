REM Thanks to http://with-love-from-siberia.blogspot.com/2009/09/cmdbat-getoptions.html

REM Example: vone3 /s:http://yourserver/rest-1.v1/Data /u:user /p:password /a:Member/20 [/c:set] /f:Phone /v:"1 800 VersionOne"

setlocal

call :getoptions %*

IF "%opts_/s%"=="" SET opts_/s=http://localhost/VersionOne.Web/rest-1.v1/Data
IF "%opts_/u%"=="" SET opts_/u=admin
IF "%opts_/p%"=="" SET opts_/p=admin
IF "%opts_/a%"=="" SET opts_/a="Member/20"
IF "%opts_/c%"=="" SET opts_/c=set
IF "%opts_/f%"=="" SET opts_/f=Name
IF "%opts_/v%"=="" SET opts_/v=new

curl -X POST --basic -u %opts_/u%:%opts_/p% %opts_/s%/%opts_/a% --data "<Asset><Attribute name='%opts_/f%' act='%opts_/c%'>%opts_/v%</Attribute></Asset>"

:getoptions
@echo off

if not defined getoptions_name set getoptions_name=opts
if not defined getoptions_help set getoptions_help=getoptions_help

set getoptions_i=0

set %getoptions_name%_total=0
set %getoptions_name%_count=0

:getoptions_loop_start

for /f "usebackq delims=: tokens=1,*" %%a in ( `echo %~1^|findstr "^/[a-z0-9_][a-z0-9_]*"` ) do (
    for %%h in ( /h /help /man ) do (
        if /i "%%~a" == "%%h" if defined getoptions_autohelp (
            call :%getoptions_help% %%~a
            set getoptions_exit=1
            goto :EOF
        )
    )

    if "%%~b" == "" (
        rem set %getoptions_name%_%%a=%%a
        call :getoptions_set "%getoptions_name%_%%a" "%%~a"
    ) else (
        rem set %getoptions_name%_%%a=%%b
        call :getoptions_set "%getoptions_name%_%%a" "%%~b"
    )

    goto getoptions_loop_continue
)

if "%~1" == "" goto getoptions_loop_break

set /a %getoptions_name%_count+=1

set /a getoptions_i+=1
rem set %getoptions_name%_%getoptions_i%=%1
call :getoptions_set "%getoptions_name%_%getoptions_i%" "%~1"

:getoptions_loop_continue
set /a %getoptions_name%_total+=1

shift
goto getoptions_loop_start
:getoptions_loop_break

set getoptions_i=

goto :EOF

:getoptions_set
set %~1=%~2
goto :EOF

:getoptions_help
echo.Usage:
echo.    %~n0 OPTIONS
echo.
echo.  where OPTIONS are in format like
echo.  VALUE or /NAME:VALUE
goto :EOF