@ECHO Off
TITLE=*** AUTO.BINHACK!v3 ***   -   All-32bit edition   -   FamilyGuy 2012
ECHO.
ECHO       *** IP.BINHACK!v3 ***             
ECHO.
ECHO     This program will hack an
ECHO     IP.BIN to a 45000 LBA and
ECHO     won't modify the BOOT.BIN
ECHO.
ECHO     If LBA.BIN is detected it
ECHO     will hack the BOOT.BIN in
ECHO    CDDA mode to the LBA stated
ECHO            in LBA.BIN
ECHO.
ECHO     If WINCEOS is detected it
ECHO     will hack the BOOT.BIN in
ECHO           WINCEOS mode.
ECHO.
ECHO     The BOOT.BIN specified in
ECHO     the IP.BIN must be in the
ECHO      data folder. The hacked 
ECHO     file will be named IP.HAK
ECHO.
ECHO  To use with any type of backups
ECHO WIDELY based on ECHELON's binhack
ECHO.
ECHO.
ECHO Checking files ...
IF not exist ip.bin goto error
goto GO

:GO
SPLIT IP.BIN FG 96 12 4 16 >nul
Set /p boot=<FG.2
FOR %%1 IN (%boot%) DO set bn=%%~n1
if exist LBA.BIN Set /p LBA=<LBA.BIN
GOTO BINHACK

:error
ECHO.
ECHO No ip.bin in this folder !
ECHO.
ECHO Nothing Hacked !
pause >nul
exit

:BINHACK
if not exist data\%boot% goto ERROR2
goto KEEP

:ERROR2
ECHO.
ECHO  The %boot% specified in the
ECHO ip.bin is not in the data folder
ECHO.
Echo         Nothing hacked !
DEL FG.* >nul
PAUSE >nul
EXIT

:KEEP
COPY /B DATA\%boot% %boot% > nul

ECHO.
ECHO Binhacking ...
ECHO.
COPY IP.BIN IP.tmp >nul
ECHO %boot% > binhack.tab
Echo ip.tmp >> binhack.tab
if %boot%==0WINCEOS.BIN (
ECHO WINCEOS detected !
goto BH
)
if not exist LBA.BIN (
Echo 45000 >>binhack.tab
ECHO Hacking %boot% in DATA/DATA mode!
)
if exist LBA.BIN (
TYPE LBA.BIN >>binhack.tab
ECHO Hacking %boot% in CDDA mode according to LBA=%LBA% ...
)

:BH
if %boot%==0WINCEOS.BIN (
if not exist 0WINCEOS.BAK ren 0WINCEOS.BIN 0WINCEOS.BAK
bincon 0WINCEOS.BAK 0WINCEOS.BIN
)
if exist LBA.BIN (
if not exist %bn%.BAK ren %boot% %bn%.BAK
copy /Y %bn%.BAK %boot% >nul
dahack %boot% <LBA.BIN >nul
cdda %boot% >nul
)
BINHACK <BINHACK.TAB >nul
SPLIT IP.tmp GF 112 16 >nul
copy /b GF.1+FG.4+GF.3 IP.HAK >nul
if %boot%==0WINCEOS.BIN (
ren IP.HAK IP.KAH
split ip.KAH OS 62 1 >nul
del ip.KAH >nul
ECHO 0 > 1.txt
split 1.txt SO 1 >nul
copy /B OS.1+SO.1+OS.3 IP.HAK >nul
)
ren IP.HAK IP.KAH
split ip.KAH VGA 61 1 >nul
del ip.KAH >nul
ECHO 1 >0.txt
split 0.txt AGV 1 >nul
copy /B VGA.1+AGV.1+VGA.3 IP.HAK >nul
if %boot%==0WINCEOS.BIN copy /Y %boot% data\%boot% >nul
if exist LBA.BIN copy /Y %boot% data\%boot% >nul
DEL %boot% >nul
del ip.tmp >nul
del binhack.tab >nul
del VGA.* >nul
del AGV.* >nul
DEL FG.* >nul
DEL GF.* >nul
del 0.txt >nul
if %boot%==0WINCEOS.BIN (
del OS.* >nul
del SO.* >nul
del 1.txt >nul
)

ECHO.
ECHO DONE !
