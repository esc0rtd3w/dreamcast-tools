@Echo off
cls
Echo ==============================================================
Echo =              DC Self-Bootable CD Batch File v3.5           =
Echo =                      Copyright (C) Kamui                   =
Echo ==============================================================

::you need to alter these values before run the Batch file

set SCSI_ID=0,1,0
set WAV_SPEED=4
set ISO_SPEED=4
set CDRWIN_DIR=C:\CDRWIN3\Cdrwin.exe
set InstallPath=c:
set MODE=xa1
::-------------------------------------------------------

set BOOTBIN=%2
set ISONAME=%3
set finalburn=%4
if "%1"=="" goto usage
if %1==katana set GAMETYPE=katana
if %1==wince set GAMETYPE=wince
if %1==cdda set GAMETYPE=cdda
if %1==winceda set GAMETYPE=winceda
if %1==nobinhack set GAMETYPE=nobinhack
if %1==nobinhackda set GAMETYPE=nobinhackda
if %1==no1stburn set GAMETYPE=no1stburn
if %1==no1stburn&binhack set GAMETYPE=no1stburn&binhack
if %1==noip&binhack set GAMETYPE=noip&binhack
if "%2"=="1" set BOOTBIN=1ST_READ.BIN
if "%2"=="0" set BOOTBIN=0WINCEOS.BIN
if "%2"=="" goto usage
if "%3"=="" goto usage
if "%4"=="n" set finalburn=goto cdrwin
if "%4"=="N" set finalburn=goto cdrwin
if "%4"=="" set finalburn=pause
if %GAMETYPE%==katana goto start
if %GAMETYPE%==wince goto start
if %GAMETYPE%==cdda goto cdda_start
if %GAMETYPE%==winceda goto cdda_start
if %GAMETYPE%==nobinhack goto start
if %GAMETYPE%==nobinhackda goto cdda_start
if %GAMETYPE%==no1stburn goto binhack
if %GAMETYPE%==no1stburn&binhack goto nobin_hack
if %GAMETYPE%==noip&binhack goto start

:usage
Echo =                                                            =
Echo =   Selfboot   [GAMETYPE]   [BOOT.BIN]   [CD NAME]   [?]     =
Echo =                                                            =
Echo ==============================================================
Echo =  GameTypes : Katana        -   Katana  Game  without  CDDA =
Echo =            : WinCE         -   WinCE   Game  without  CDDA =
Echo =            : CDDA          -   Katana  Game  with     CDDA =
Echo =            : WinCEDA       -   WinCE   Game  with     CDDA =
Echo =            : NoBinhack     -   No Boot.bin  HACK w/o  CDDA =
Echo =            : NoBinhackDA   -   No Boot.bin  HACK with CDDA =
Echo =            : Noip&binhack  -   No ip.bin & Boot.bin   HACK =
Echo =            : No1stBurn     -   No 1st Session (AUDIO) Burn =
Echo =            : No1stBurn&Binhack - No1stBurn & Boot.bin hack =
Echo ==============================================================
Echo  BOOT.BIN : If this file is not called 1ST_READ.BIN,
Echo           : put the filename.bin as the 2nd parameter
Echo           : WINCEOS BOOT.BIN always name 0WINCEOS.BIN
Echo       [?] : Add N at the end can disable 2nd session Burning
goto blank

:start
Echo =           Step 1. -   Burning the 1ST Audio Track          =
Echo ==============================================================
Echo =              Please insert a CDR in your burner            =
Echo ==============================================================
IF NOT EXIST data\IP.BIN Echo ERROR : GAMEDATA NOT FOUND!!!
IF NOT EXIST data\IP.BIN goto blank
IF NOT EXIST data\%BOOTBIN% Echo ERROR : GAMEDATA NOT FOUND!!!
IF NOT EXIST data\%BOOTBIN% goto blank
pause
cdrecord -dev=%SCSI_ID% -multi -audio -speed=%WAV_SPEED% audio.raw
Echo Audio Track burn completed!
if %GAMETYPE%==katana goto binhack
if %GAMETYPE%==wince goto binhack
if %GAMETYPE%==nobinhack goto nobin_hack
if %GAMETYPE%==noip&binhack goto nobin_hack

:cdda_start
Echo =          Step 1. -  Burning  all  CD Audio Tracks          =
Echo ==============================================================
Echo =             Please insert a CDR in your burner             =
Echo ==============================================================
IF NOT EXIST data\IP.BIN Echo ERROR : GAMEDATA NOT FOUND!!!
IF NOT EXIST data\IP.BIN goto blank
IF NOT EXIST data\%BOOTBIN% Echo ERROR : GAMEDATA NOT FOUND!!!
IF NOT EXIST data\%BOOTBIN% goto blank
copy %InstallPath%\selfboot\cdda\track03.wav track01.wav
move track01.wav cdda
IF NOT EXIST CDDA\track01.wav Echo ERROR : NO CDDA TRACKS FOUND!!!
IF NOT EXIST CDDA\track01.wav goto blank
dir /b /o /s %InstallPath%\selfboot\cdda\track*.wav > CDDATXT.TXT
pause
cdrecord -dev=%SCSI_ID% -multi -audio -speed=%WAV_SPEED% @CDDATXT.TXT
del CDDATXT.TXT
Echo Audio Tracks burn completed!
if %GAMETYPE%==cdda goto binhack
if %GAMETYPE%==nobinhackda goto nobin_hack

:binhack
Echo ==============================================================
Echo =        Step 2. -  Hacking  boot sector and binary file     =
Echo ==============================================================
cdrecord -dev=%SCSI_ID% -msinfo > MSINFO.TXT
Echo Getting IP.BIN and %BOOTBIN% from "data" directory
IF NOT EXIST data\IP.BIN Echo ERROR : IP.BIN NOT FOUND!!!
IF NOT EXIST data\IP.BIN goto blank
IF NOT EXIST data\%BOOTBIN% Echo ERROR : %BOOTBIN% NOT FOUND!!!
IF NOT EXIST data\%BOOTBIN% goto blank
attrib -r %InstallPath%\selfboot\data\*.*
move data\IP.BIN .
move data\%BOOTBIN% .
Echo %BOOTBIN% > BINTXT.TXT
Echo IP.BIN >> BINTXT.TXT
if %GAMETYPE%==katana GetMsinfo -dev=%SCSI_ID% -msinfo >> BINTXT.TXT
if %GAMETYPE%==no1stburn GetMsinfo -dev=%SCSI_ID% -msinfo >> BINTXT.TXT
if %GAMETYPE%==cdda GetMsinfo -dev=%SCSI_ID% -msinfo >> BINTXT.TXT
binhack < BINTXT.TXT
del BINTXT.TXT
goto move_boot

:nobin_hack
Echo ==============================================================
Echo =       Step 2. - Skip Hacking boot sector & binary file     =
Echo ==============================================================
cdrecord -dev=%SCSI_ID% -msinfo > MSINFO.TXT
Echo Checking IP.BIN from "data" directory
IF NOT EXIST data\IP.BIN Echo ERROR : IP.BIN NOT FOUND!!!
IF NOT EXIST data\IP.BIN goto blank
attrib -r %InstallPath%\selfboot\data\*.*
move data\IP.BIN .
if %GAMETYPE%==noip&binhack goto create_iso
copy %InstallPath%\selfboot\data\%BOOTBIN%
Echo %BOOTBIN% > BINTXT.TXT
Echo IP.BIN >> BINTXT.TXT
GetMsinfo -dev=%SCSI_ID% -msinfo >> BINTXT.TXT
binhack < BINTXT.TXT
del BINTXT.TXT
del %BOOTBIN%
goto create_iso

:move_boot
move %BOOTBIN% data
goto create_iso

:create_iso
Echo ==============================================================
Echo =     Step 3. - Creating ISO Image from "data" directory     =
Echo ==============================================================
mkisofs -C @MSINFO.TXT -V %ISONAME% -l -sort sorttxt.txt -o data.iso data
del MSINFO.TXT
goto ipins

:ipins
Echo ==============================================================
Echo =        Step 4. - Injecting bootsector in ISO image         =
Echo ==============================================================
Echo IP.BIN > IPTXT.TXT
Echo data.iso >> IPTXT.TXT
ipins < IPTXT.TXT
del IP.BIN
del IPTXT.TXT
%finalburn%
goto final_burn

:cdrwin
Echo ==============================================================
Echo =     Please use CDRWIN to Burn the 2nd session  DC ISO      =
Echo =                                                            =
Echo =     Check following options before burning  "data.iso"     =
Echo ==============================================================
Echo =                   Record as an       "ISO9660" Image File  =
Echo =                   Disc  Type:        "CDROM-XA"            =
Echo =                   Track Mode:        "MODE2"               =
Echo =                   Close Session:     "Yes"                 =
Echo =                   Write Postgap:     "Yes"                 =
Echo =                   Open  New Session: "No"                  =
Echo ==============================================================
start /w %CDRWIN_DIR%
pause > nul
goto end

:final_burn
Echo ==============================================================
Echo =             Step 5. - Burning DC ISO to the CD             =
Echo ==============================================================
cdrecord -dev=%SCSI_ID% -%MODE% -speed=%ISO_SPEED% data.iso
goto end

:end
Echo ==============================================================
Echo =             DC SelfBootable CD BURN COMPLETED!!            =
Echo ==============================================================
:blank
