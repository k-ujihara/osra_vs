pushd "%~dp0"
Set $1=%~1
Set $2=%~2
if "%$1%" == "" Set $1=%~dp0\..\..
Set objdir=%~dp0
Set testdir=%$1%\testsuite
Set OCRAD=%~dp0\ocrad.exe
Set OCRADCHECK=%~dp0\ocradcheck.exe
if exist tmp rmdir /Q /S tmp
mkdir tmp
cd tmp

Set in=%testdir%\test.pbm
Set ouf=%testdir%\test.ouf
Set txt=%testdir%\test.txt
Set utxt=%testdir%\test_utf8.txt
Set fail=0

echo testing ocrad-%$2% ...

GOTO Lines123

for %%i in ( "-q -T-0.1" "-q -T 1.1" "-q -u -2,-1,1,1" "-q -u 1,1,1,1" ) do (
	"%OCRAD%" %%~i "%in%" > nul
	if errorlevel 1 echo - && Set fail=1 else echo .
)

"%OCRAD%" "%in%" > out
fc "%txt%" out
echo .
"%OCRAD%" < "%in%" > out
fc "%txt%" out
echo .

"%OCRAD%" -F utf8 "%in%" > out
fc "%utxt%" out
echo .
"%OCRAD%" -F utf8 < "%in%" > out
fc "%utxt%" out
echo .

"%OCRAD%" -u 0,0,1,1 "%in%" > out
fc "%txt%" out
echo .
"%OCRAD%" -u 0,0,1,1 - < "%in%" > out
fc "%txt%" out
echo .

"%OCRAD%" -u -1,-1,1,1 "%in%" > out
fc "%txt%" out
echo .
"%OCRAD%" - -u -1,-1,1,1 < "%in%" > out
fc "%txt%" out
echo .

type "%in%" > in2
type "%in%" >> in2
type "%txt%" > txt2
type "%txt%" >> txt2
type "%utxt%" > utxt2
type "%utxt%" >> utxt2
"%OCRAD%" < in2 > out
fc txt2 out
echo .
"%OCRAD%" -F utf8 < in2 > out
fc utxt2 out
echo .
del /Q in2 txt2 utxt2

:Lines123

Rem lines 1, 2, 3
echo\ > coords
echo  71,109,17,26 >> coords
echo  92,109,17,26 >> coords
echo 114,109,15,26 >> coords
echo 132,109,17,26 >> coords
echo 152,109,18,26 >> coords 
echo 172,109,19,26 >> coords 
echo 193,109,17,26 >> coords 
echo 214,109,17,26 >> coords
echo 234,108,17,27 >> coords 
echo 253,109,18,26 >> coords 
echo 274,109,17,26 >> coords 
echo  68,153,29,27 >> coords
echo  97,153,24,27 >> coords 
echo 126,153,23,27 >> coords 
echo 153,153,27,27 >> coords 
echo 183,153,24,27 >> coords
echo 210,153,23,27 >> coords 
echo 237,153,27,27 >> coords 
echo 266,153,30,27 >> coords 
echo 298,153,13,27 >> coords
echo 313,153,20,27 >> coords 
echo 335,153,29,27 >> coords 
echo 365,153,23,27 >> coords 
echo 391,153,34,27 >> coords
echo 426,153,30,27 >> coords 
echo  69,189,30,35 >> coords 
echo 102,197,26,27 >> coords 
echo 132,197,24,27 >> coords
echo 159,197,26,34 >> coords 
echo 188,197,26,27 >> coords 
echo 217,197,20,27 >> coords 
echo 241,197,24,27 >> coords
echo 266,197,30,27 >> coords 
echo 297,197,28,27 >> coords 
echo 326,197,37,27 >> coords 
echo 364,197,27,27 >> coords
echo 390,197,28,27 >> coords
echo 420,197,21,27 >> coords
Set produced_chars=
Set expected_chars=0ol23456789ABcDEFGHIJKLMNÑopQRsTuvwxYz
CALL :test_chars

GOTO :End


:framework_failure
echo "failure in testing framework"
EXIT /b 1

:test_chars
	echo\ > expected_chars
	echo %expected_chars% >> expected_chars
	echo\ > produced_chars
	
	for /f %%c in ( coords ) do (
		%OCRAD% -u%%c %in% >$tmp
		Set /P $$tmp=<$tmp
		del /Q $tmp
		CALL Set produced_chars=%%produced_chars%%%%$$tmp%%
		Set $$tmp=
	)
	if not "%expected_chars%" == "%produced_chars%" (
		echo expected %expected_chars%
		echo produced %produced_chars%
		Set fail = 1
	)
	echo .
	EXIT /b 

:End
popd
pause
