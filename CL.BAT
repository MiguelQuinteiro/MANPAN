clipper %1 /w /b /d >compila.txt
if not errorlevel 1 rtlink file %1 LIB CLD
if errorlevel 1 edit compila.txt /h
