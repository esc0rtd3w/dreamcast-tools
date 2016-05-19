@ echo off
title=FamilyGuy's SelfBootDATA Pack! - SELFBOOT v1.4 - All-32bit edition
ECHO.
ECHO   FG's SB DATA Pack! - SELFBOOT v1.4 - All-32bit edition
echo.
ECHO     This .bat Will create a 45000LBA data/data
ECHO     backup from extracted files with no need
ECHO     to apply LBA hacks to the bins. However
ECHO     some non-LBA based copy protection might need
ECHO     to be cracked in order for the backup to works.
ECHO     GO to the DCRipping Database for a list of
ECHO     copy protections.
ECHO     http://www.bucanero.com.ar/dreamcast/ripdb/?
ECHO.
ECHO     Put around 65 megs in the data1 folder and
ECHO     ALL the files in the data folder Duplicated
ECHO     files will be burnt only once.
ECHO.
ECHO     You can add a 0.0 dummy file in data to accelarate 
ECHO     loadings, it won't apear in the filesystem.
ECHO. 
ECHO     The ip.bin must be in the root folder.
ECHO.
ECHO     FamilyGuy 2008 - 2012
ECHO.
ECHO Press any key to start ...
Pause >nul

@IF not exist ip.bin goto ERROR
@goto GO


:ERROR
@ echo.
@ ECHO     No ip.bin in the folder
@ ECHO     You should put the ip.bin in this folder.
@ ECHO.
@ pause >nul
REM @ exit

:GO


:ip.binhack
ECHO.
ECHO     Running IP.BINHACK on the ip.bin ...
ECHO.
copy "Utilities\AUTO.BINHACK\bincon.exe" bincon.exe >nul
copy "Utilities\AUTO.BINHACK\BINHACK.EXE" BINHACK.EXE >nul
copy "Utilities\AUTO.BINHACK\cdda.exe" cdda.exe >nul
copy "Utilities\AUTO.BINHACK\dahack.exe" dahack.exe >nul
copy "Utilities\AUTO.BINHACK\SPLIT.EXE" SPLIT.EXE >nul
copy "Utilities\AUTO.BINHACK\AUTO.BINHACK.bat" AUTO.BINHACK.bat >nul
call AUTO.BINHACK.bat
del bincon.exe >nul
del BINHACK.EXE >nul
del cdda.exe >nul
del dahack.exe >nul
del SPLIT.EXE >nul
del AUTO.BINHACK.bat >nul
ECHO.
ECHO     IP.HAK created !

if exist logo.png goto LOGO
goto Data0

:LOGO
ECHO.
ECHO     LOGO.PNG detected...
copy "-=Isos=-\logoinsert.exe" logoinsert.exe >nul
copy "-=Isos=-\pngtomr.exe" pngtomr.exe >nul
copy "-=Isos=-\libpng.dll" libpng.dll >nul
pngtomr logo.png logo.mr >nul
ECHO     LOGO.PNG converted into LOGO.MR
logoinsert.exe logo.mr ip.hak >nul
del logoinsert.exe
del pngtomr.exe
del libpng.dll
del logo.mr
ECHO     LOGO.MR inserted in IP.HAK !

:Data0
IF EXIST "sorttxt.txt" goto SORT1
goto Data1

:Data1
Echo.
Echo     Building 1st session ...
Echo ON
@ ECHO.
@ mkisofs -V SELFBOOT -duplicates-once -hide 0.0 -l -o data1.iso data1
@ ECHO.
@ ECHO.
@ ECHO.
@ ECHO data1.iso | Fill.exe
@ ECHO.
@ ECHO.
@ ECHO   Done!
@ ECHO.
@ ECHO OFF
GOTO KEEPON

:SORT1
Echo.
Echo     Building 1st session ...
ECHO.
ECHO     Sorttxt.txt detected ...
ECHO ON
@ ECHO.
@ mkisofs -V SELFBOOT -duplicates-once -hide 0.0 -l -sort sorttxt.txt -o data1.iso data1
@ ECHO.
@ ECHO.
@ ECHO.
@ ECHO data1.iso | Fill.exe
@ ECHO.
@ ECHO.
@ ECHO   Done!
@ ECHO.
@ ECHO OFF

:KEEPON
IF EXIST "sorttxt.txt" goto SORT2
GOTO DATA2 

:SORT2
Echo.
Echo     Building 2de session ...
ECHO.
ECHO     Sorttxt.txt detected ...
ECHO ON
@ ECHO.
@ mkisofs -C 0,45000 -V SELFBOOT -G ip.hak -M data1.iso -duplicates-once -l -sort sorttxt.txt -hide 0.0 -o data2.iso data
@ ECHO.
@ ECHO.
@ ECHO   Done!
@ ECHO.
@ ECHO OFF
GOTO MERGE

:DATA2
Echo.
Echo     Building 2de session ...
ECHO ON
@ ECHO.
@ mkisofs -C 0,45000 -V SELFBOOT -G ip.hak -M data1.iso -duplicates-once -l -hide 0.0 -o data2.iso data
@ ECHO.
@ ECHO.
@ ECHO   Done!
@ ECHO.
@ ECHO OFF

:Merge
ECHO.
ECHO     Merging the isos ...
ECHO.
copy "-=Isos=-\NRG\leadin" leadin >nul
copy "-=Isos=-\NRG\nrgheader" nrgheader >nul
copy "-=Isos=-\NRG\nrgheader.exe" nrgheader.exe >nul
copy /b leadin+data1.iso+data2.iso+nrgheader SelfBoot.nrg
ECHO     Hacking the nrgheader ...
ECHO.
ECHO SelfBoot.nrg | NRGHEADER

:clean
ECHO     Cleaning Files ...
del nrgheader.exe >nul
del del leadin >nul
del nrgheader >nul
del data1.iso >nul
del data2.iso >nul
del ip.hak
ECHO.
ECHO     DONE !

ECHO.
ECHO     The backup is now done! Run it in NullDC (using DEAMON tools)
ECHO     or burn it to a disc to test it out! If it doesn't work,
ECHO     go to the Dreamcast Ripping DataBase to find if your 
ECHO     game as a non-lba based copy protection.
ECHO.
ECHO     Thanks to Xzyx987X for the nrgheader technique,
ECHO     ECHELON for the BINHACK program, M$ for bat files,
ECHO     Neoblast and Indiket for the Fill.exe program
ECHO     and Indiket for the NRGHEADER program ! 
Echo.
ECHO     FamilyGuy 2008
ECHO. 
ECHO     Press any KEY to quit ...
PAUSE >nul
REM EXIT


