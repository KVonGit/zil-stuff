@echo off
zilf fathers-day.zil || set "fail=zilf" && goto :error
zapf fathers-day.zap || set "fail=zapf" && goto :error
frotz fathers-day.z5 || set "fail=frotz" && goto :error
goto :eof

:error
echo [%fail%]: Something went wrong!
pause
exit /b 1
