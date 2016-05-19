@ECHO OFF
@ECHO Making Shenmue IDX ...
:START
ECHO.
TITLE= MAKING IDX 2 - FamilyGuy '09
ECHO Enter 1 for ShenmueI and 2 for ShenmueII then press enter ...
set /p V=
If %V%==1 GOTO IDX
If %V%==2 GOTO IDX
GOTO ERROR
:IDX
If %V%==1 ECHO Making ShenmueI IDX ...
If %V%==2 ECHO Making ShenmueII IDX ...
for %%f in (*.afs) do (
ECHO. 
ECHO Making %%~nf.idx ...
ECHO.
@ idxmaker -%V% %%f %%~nf.idx 
)
echo Done!
echo.
echo Batch created by FamilyGuy.
echo Thanks to SiZ! and Manic for IDXMAKER.
pause
exit
:ERROR
ECHO.
ECHO You must enter 1 or 2 !
goto start