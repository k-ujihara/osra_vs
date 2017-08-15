@setlocal
pushd %~dp0

if exist build\* goto :End

set A=%~dp0
set A=%A:\=\\%
set A=%A::=\:%

mkdir build
copy SolutionDir.props.txt build\SolutionDir.props

pushd build
sed -i "s/__SOLUTION_BASE__/%A%/g" SolutionDir.props
popd

:End
popd
@endlocal
