@ ECHO OFF 
set b=%cd% 
cd..
set c=%cd% 
ECHO %b%
ECHO %c%

if "%b:~-1%"==" " set "b=%b:~0,-1%"
if "%c:~-1%"==" " set "c=%c:~0,-1%"


xcopy /y %b%\morn\assets  %c%\JProject\resources\assets /e /r
xcopy /y %b%\bin\ui.swf    %c%\JProject\resources\assets /e /r
xcopy /y %b%\src       %c%\JProject\src /e/r





PAUSE
