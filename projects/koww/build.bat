@echo off
zilf koww.zil || set "fail=zilf" && goto :error
zapf koww.zap || set "fail=zapf" && goto :error
frotz koww.z5 || set "fail=frotz" && goto :error
goto :eof

:error
echo [%fail%]: Something went wrong!
pause
exit /b 1
