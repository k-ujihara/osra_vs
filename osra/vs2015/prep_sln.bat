@setlocal
pushd %~dp0

if exist build\* goto :End
mkdir build

call :Make_Props SolutionDir SOLUTION_BASE %~dp0

If "%INSTALL_BASE%" == "" Set %INSTALL_BASE%=%PUBLIC%
call :Make_Props InstallBase INSTALL_BASE %INSTALL_BASE%

:End
popd
@endlocal
Goto :REnd

:Make_Props
set A=%~3
set A=%A:\=\\%
set A=%A::=\:%

copy Stub.props.txt build\%~1.props

pushd build
sed -i "s/__PROPERTY__STUB__/%A%/g" %~1.props
sed -i "s/PROPERTY__STUB/%~2/g" %~1.props
popd

exit /b

:REnd
