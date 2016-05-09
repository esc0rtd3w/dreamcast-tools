@Echo off
cls
Echo Self-Booting Batch File v1.7
Echo Copyright (C) Pr.Sinister
Echo ============================
Echo *
set SCSI_ID=2,3,0
set MSINFO=11702
set SPEED=12
set BOOTBIN=%2
if "%1"=="" goto usage
if %1==katana set GAMETYPE=katana
if %1==wince set GAMETYPE=wince
if %1==cdda set GAMETYPE=cdda
if %1==winceda set GAMETYPE=winceda
if "%2"=="" set BOOTBIN=1ST_READ.BIN
if %GAMETYPE%==katana goto start
if %GAMETYPE%==wince set BOOTBIN=0WINCEOS.BIN
if %GAMETYPE%==wince goto start
if %GAMETYPE%==cdda goto cdda_start
if %GAMETYPE%==winceda set BOOTBIN=0WINCEOS.BIN
if %GAMETYPE%==winceda goto cdda_start

:usage
Echo USAGE : selfboot [GAMETYPE] [BOOT.BIN (Optional)]
Echo =================================================
Echo GameTypes : Katana - A Katana Game without CDDA
Echo           : WinCE - A WinCE Game without CDDA
Echo           : CDDA - A Katana Game with CDDA
Echo           : WinCEDA - A WinCE Game with CDDA
Echo =================================================
Echo BOOT.BIN  : If this file is not called 1ST_READ.BIN,
Echo           : put the filename.ext as the 2nd parameter
goto blank

:start
Echo Step 1. - Burning the Audio Track
Echo =================================
Echo *
Echo Please insert a CD in your burner and
pause
cdrecord -dev=%SCSI_ID% -multi -audio -speed=%SPEED% audio.raw
Echo Audio Track burn completed!
Echo *
goto binhack

:cdda_start
Echo Step 1. - Burning all of the Audio Tracks
Echo =========================================
Echo *
IF NOT EXIST CDDA\track_01.wav Echo ERROR : NO CDDA TRACKS FOUND!!!
IF NOT EXIST CDDA\track_01.wav goto blank
dir /b /o /s track_*.wav > CDDA.TXT
Echo Please insert a CD in your burner and
pause
cdrecord -dev=%SCSI_ID% -multi -audio -speed=%SPEED% @CDDA.TXT
del CDDA.TXT
Echo Audio Tracks burn completed!
Echo *
goto cdda_binhack

:binhack
Echo Step 2. - Hacking boot sector and binary file
Echo =============================================
Echo *
if %GAMETYPE%==katana cdrecord -dev=%SCSI_ID% -msinfo
if %GAMETYPE%==katana Echo ^^^^^^^^^^^^^^ - This should say 0,%MSINFO%. If it doesn't, your
if %GAMETYPE%==katana Echo CD will not work or you didn't set the MSINFO at the top
if %GAMETYPE%==katana Echo of this batch file
Echo Getting IP.BIN and %BOOTBIN% from "data" directory
IF NOT EXIST data\IP.BIN Echo ERROR : IP.BIN NOT FOUND!!!
IF NOT EXIST data\IP.BIN goto blank
IF NOT EXIST data\%BOOTBIN% Echo ERROR : %BOOTBIN% NOT FOUND!!!
IF NOT EXIST data\%BOOTBIN% goto blank
move data\IP.BIN .
move data\%BOOTBIN% .
Echo %BOOTBIN% > BINHACK.TXT
Echo IP.BIN >> BINHACK.TXT
if %GAMETYPE%==katana Echo %MSINFO% >> BINHACK.TXT
binhack < BINHACK.TXT >NULL
goto move_boot

:cdda_binhack
Echo Step 2. - Hacking boot sector and binary file
Echo =============================================
Echo *
Echo Getting IP.BIN and %BOOTBIN% from "data" directory
move data\IP.BIN .
move data\%BOOTBIN% .
if %GAMETYPE%==cdda Echo Please type %BOOTBIN% for the name of the binary
if %GAMETYPE%==cdda Echo And type IP.BIN for the name of the bootsector
if %GAMETYPE%==cdda cdrecord -dev=%SCSI_ID% -msinfo > MSINFO.TXT
if %GAMETYPE%==cdda cdrecord -dev=%SCSI_ID% -msinfo
if %GAMETYPE%==cdda Echo - ^^^^^^^^^^^^ - This is your msinfo number
if %GAMETYPE%==cdda binhack
if %GAMETYPE%==winceda Echo %BOOTBIN% > BINHACK.TXT
if %GAMETYPE%==winceda Echo IP.BIN >> BINHACK.TXT
if %GAMETYPE%==winceda binhack < BINHACK.TXT
if %GAMETYPE%==winceda del binhack.txt
goto move_boot

:move_boot
Echo Step 3. - Placing %BOOTBIN% in "data" directory
Echo ==================================================
Echo *
move %BOOTBIN% data
goto create_iso

:create_iso
Echo Step 4. - Creating ISO Image from "data" directory
Echo ==================================================
mkisofs -C @MSINFO.TXT -V ECHELON -l -o data.iso data
del MSINFO.TXT
Echo *
goto ipins

:ipins
Echo Step 5. - Injecting bootsector in ISO image
Echo ===========================================
Echo *
Echo IP.BIN > IPINS.TXT
Echo data.iso >> IPINS.TXT
ipins < IPINS.TXT >NULL
del IP.BIN
del IPINS.TXT
goto final_burn

:final_burn
Echo Step 6. - Burning hacked ISO to the CD
Echo ======================================
Echo *
cdrecord -dev=%SCSI_ID% -xa1 -speed=%SPEED% data.iso
del data.iso
goto end

:end
cdrecord -dev=%SCSI_ID% -eject
Echo CD BURNING COMPLETED!
DONE.WAV

:blank
