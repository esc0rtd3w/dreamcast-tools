@echo off
cls
GOTO BEGIN

CopyDog  ver 0.90
c_opydog@hotmail.com
 NAME THIS SCRIPT COPYDOG.BAT
 AT DOS PROMPT TYPE copydog -h help

:BEGIN
 if not '%OS%==' SETLOCAL
 IF %1.==START. GOTO USAGE
 set Cmd=%0 START
 shift
 :get_param
  if %0!==! goto param_got
  set Cmd=%cmd% %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
  for %%F in (0 1 2 3 4 5 6 7 8 9) do shift
  goto get_param
  :param_got
  %COMSPEC% /E:4096 /C %Cmd%
  GOTO CLEAN_UP

:START
 echo Windows version running is:
 ver
 echo.
 echo THIS SCRIPT HAS BEEN TESTED UNDER :
 echo Microsoft Windows 2000 [Version 5.00.2195] 
 echo Windows 98 [Version 4.10.2222]
 echo.
 pause
 ver > {temp}.bat
 echo call %%1 %%2 > microsoft.bat
 echo set winos=%%1 > windows.bat
 call {temp}
 FOR %%F IN ({temp}.bat windows.bat microsoft.bat) DO del %%F

 shift
 :loop
  if %2!==! goto done
  set %1=%2
  shift
  shift
  goto loop
  :done

::***********************************************************************
::         you will need to enter these values to suit your system          
                        SET READ_DRV=
                        SET HOMEPATH=
                        SET CDRWIN=
                        SET SCSIwrit=
                        SET SCSIread=
::***********************************************************************

:assign
 SET BOOT.BIN=%-b%
 SET AUTO_1=%-1%
 SET AUTO_2=%-2%
 SET HACK=%-k%
 SET PATCH=%-p%
 SET GAMENAME=%-g%
 SET DUM_SIZE=%-d%
 SET COPY=%-c%
 SET ISO=%-i%
 SET REC=%-r%
 SET BURNMODE=%-m%
 SET SPEED=%-s%
 SET ISONAME=%-o%
 SET GAMETYPE=%-t%
 SET ONLYaudi=%-a%
:defaults
 IF "%-h%"=="help" goto :FINISHED
 IF "%-b%"==""     SET BOOT.BIN=1ST_READ.BIN
 IF "%-b%"=="1"    SET BOOT.BIN=1ST_READ.BIN
 IF "%-b%"=="0"    SET BOOT.BIN=0WINCEOS.BIN
 IF "%-1%"==""     SET AUTO_1=BLANK
 IF "%-2%"==""     SET AUTO_2=BLANK
 IF "%-k%"==""     SET HACK=TRUE
 IF "%-p%"==""     SET PATCH=TRUE
 IF "%-g%"==""     SET GAMENAME=CopyDog
 IF "%-d%"==""     SET DUM_SIZE=NO
 IF "%-c%"==""     SET COPY=TRUE 
 IF "%-i%"==""     SET ISO=TRUE
 IF "%-r%"==""     SET REC=FALSE
 IF "%-m%"==""     SET BURNMODE=xa1
 IF "%-s%"==""     SET SPEED=2
 IF "%-o%"==""     SET ISONAME=data.iso
 IF "%-t%"==""     SET GAMETYPE=BLANK
 IF "%-a%"==""     SET ONLYaudi=FALSE

 SET FINISH=FALSE
 SET NoDriver=FALSE
 SET DC=BLANK
 SET SCAN_BUS=FALSE
 SET DURATION=1
 SET WhoSays=    USER
 SET AUDIFILE=audio.raw
 SET MESSAGE1=____PUT DC GAME IN YOUR CD READER....then press any key___
 SET MESSAGE2=__________________CHECKING GAMETYPE......_________________
 SET MESSAGE3=__________________No disk / Wrong disk!.._________________
 SET MESSAGE4=Send suggestions for improvements to c_opydog@hotmail.com
 SET MESSAGE5=___PUT BLANK CD IN YOUR CD WRITER.... then press any key__
 SET MESSAGE6=___________Game is already SelfBoot, finishing.___________
 SET MESSAGE7=________Problem with Hacking Bin files...finishing________
 SET MESSAGE8=____Do your hacking manually now...press key when done____
 SET MESSAGE9=______cdrecord write audio unsuccesful.... finishing______
 SET MESSAG11=______________Problem making ISO...finishing______________
 SET MESSAG12=____DOES ISO LOOK A REASONABLE SIZE? press 1[NO] 2[YES]___
 SET MESSAG13=_______Problem with Patching Bootsector...finishing_______
 SET MESSAG14=______________ISO FILE NOT FOUND...finishing______________
 SET MESSAG15=_______cdrecord ISO record unsuccesful.... finishing______
 SET MESSAG16= problem copying track_03.wav to track_01.wav....finishing
 SET MESSAG17=________Making DummyFile, size of %DUM_SIZE% Mbytes  ..WAIT______
 SET MESSAG18=_Required Files: cdda2wav,cdrecord,binhack,mkisofs,ipins._
 SET MESSAG19=___________________Audio file not found____________________
 SET MESSAG20=_____________Extracting cdda game Audio Tracks____________
 SET MESSAG21=Cdrecord - no driver for drive present....try using CDRWIN
 SET MESSAG22=________________ ISO...created succesfully________________
 SET MESSAG23=________________ ISO...patched succesfully________________
 SET MESSAG24=_____________JOB DONE...JOB DONE...JOB DONE...___________
 SET MESSAG25=To Burn Audio: use CDRECORD [press 1] or CDRWIN [press 2] 
 SET MESSAG26=To Record ISO: use CDRECORD [press 1] or CDRWIN [press 2] 
 SET MESSAG27=_______________ BOOT_BIN succesfully hacked_______________
 SET MESSAG28=___________________Audio Burn Succesfull__________________
 SET MESSAG29=______________Copying Game Data...please wait_____________
 SET MESSAG30=___________PROBLEM Copying Game Data...finshing___________
 SET MESSAG31=________________Please Select SCSI Bus ID#________________
 SET MESSAG32=____To burn dummy as AUDIO [press 1] or DATA [press 2]____
 SET MESSAG33=If want to make sorttxt.txt do so now..press key when done

 FOR %%F IN (%HOMEPATH%! %READ_DRV%!) DO IF %%F==! goto FINISHED
 IF NOT EXIST %HOMEPATH%\selfboot\nul GOTO FINISHED
 %HOMEPATH%
 cd %HOMEPATH%\selfboot
 FOR %%F IN (cdrecord.exe binhack.exe mkisofs.exe ipins.exe cdda2wav.exe) DO IF NOT EXIST %%F SET FINISH=TRUE
 IF %FINISH%==TRUE SET MESSAGE=%MESSAG18%
 IF %FINISH%==TRUE goto PROBLEM
 FOR %%F IN (data cdda) DO IF NOT EXIST .\%%F\nul md %%F
 FOR %%F IN (%SCSIwrit%! %SCSIread%!) DO IF %%F==! SET SCAN_BUS=TRUE
 IF %SCAN_BUS%==TRUE SET MESSAGE=%MESSAG31%
 IF %SCAN_BUS%==TRUE goto PROBLEM

 SET RET=BACK0
 SET MESSAGE=%MESSAGE4%
 GOTO GREET
 :BACK0
  IF %winos%==2000 COLOR 9F
  IF %winos%==2000 goto BACK2
  SET RETURN=BACK2
  FOR %%F IN (COL1 COL2) DO SET %%F=00
  FOR %%F IN (COL3 COL4 COL5 COL6) DO SET %%F=3F
  GOTO COLOUR
  :BACK2
   IF %REC%==true GOTO INSERTCD

:INSERTDC
 SET RETURN=BACK3
 SET MESSAGE=%MESSAGE1%
 GOTO PUT
 :BACK3
  pause > nul
  cdrecord -dev%SCSIread% -toc > {record}.dog
  IF ERRORLEVEL 1 GOTO DSK65535
  SET DC=INSERTED

:CHECK
 IF %GAMETYPE%==cdda goto CDDA1
 IF %GAMETYPE%==noncdda goto NONCDDA1
 SET RETURN=BACK4
 SET MESSAGE=%MESSAGE2%
 SET DURATION=75
 GOTO PUT
 :BACK4
  IF NOT %winos%==2000 CTTY nul
  cdda2wav -D %SCSIread%  -q -B -g -H cdda\track > nul
  IF NOT %winos%==2000 CTTY con
  IF errorlevel 1 goto DSK0
  SET WhoSays=Cdda2wav
  if exist .\cdda\track_*.wav goto CDDA1
  if exist .\cdda\track.wav goto CDDA0

  :DSK0
   SET WhoSays=Cdrecord
   type {record}.dog | find "track: " | find "mode: -1" > nul
   IF ERRORLEVEL 1 goto NONCDDA1

  :NONCDDA0
   type {record}.dog | find "track: "  | find "0) 00:02:00 adr" | find "mode: -1" 
   IF ERRORLEVEL 1 goto CDDA1

  :CDDA0
   set GAMETYPE=SELFBOOT
   SET MESSAGE=%MESSAGE6%
   GOTO PROBLEM

  :CDDA1
   set GAMETYPE=     CDDA
   IF %winos%==2000 COLOR CF
   IF %winos%==2000 goto BACK5
   SET RETURN=BACK5
   SET COL1=35
   FOR %%F IN (COL2 COL3) DO SET %%F=00
   FOR %%F IN (COL4 COL5 COL6) DO SET %%F=3F
   GOTO COLOUR
   :BACK5
    goto GAME_IS

  :NONCDDA1
   set GAMETYPE= NON_CDDA
   goto GAME_IS

  :DSK65535
   SET RETURN=BACK6
   SET MESSAGE=%MESSAGE3%
   SET DURATION=25
   GOTO PUT
   :BACK6
    SET RETURN=INSERTDC
    IF %DC%==INSERTED SET RETURN=INSERTCD
    GOTO %RETURN%
   
  :GAME_IS
   VOL %READ_DRV%>{tmp}.BAT
   ECHO SET VOLABEL=%%5>VOLUME.BAT
   CALL {tmp}
   IF "%VOLABEL%"=="" SET VOLABEL=CopyDog
   IF "%VOLABEL%"=="no" SET VOLABEL=CopyDog
   SET RETURN=BACK99
   SET length=%VOLABEL%
   GOTO NwLength
   :BACK99
    SET nVOLABEL=%length% 
    SET MESSAGE=_______%WhoSays% Says %nVOLABEL% is %GAMETYPE%_____
    SET RETURN=BACK7
    SET DURATION=75
    GOTO PUT
    :BACK7
     IF "%-o%"=="" SET ISONAME=%VOLABEL%.iso

IF NOT EXIST %READ_DRV%\%BOOT.BIN% GOTO NEW_BOOT
IF NOT EXIST %READ_DRV%\IP.bin GOTO NO_IPBIN

IF %DUM_SIZE%==NO    goto COPYGAME
IF %DUM_SIZE%==false goto COPYGAME
:DUMMY
 SET RETURN=BACK19
 SET MESSAGE=%MESSAG17%
 SET DURATION=75
 GOTO PUT
 :BACK19
  ECHO E0100 BE 81 00 AC 3C 20 74 FB 3C 09 74 F7 4E 66 31 C9 >{$}
  ECHO E0110 66 31 C0 66 6B C9 0A 66 01 C1 AC 2C 30 3C 0A 72 >>{$}
  ECHO E0120 F2 66 C1 E1 14 66 91 66 BB 30 09 00 00 66 31 D2 >>{$}
  ECHO E0130 66 F7 F3 66 F7 E3 66 50 B4 3C 31 C9 BA 5A 01 CD >>{$}
  ECHO E0140 21 93 B8 00 42 5A 59 CD 21 B4 40 31 C9 31 D2 CD >>{$}
  ECHO E0150 21 B4 3E CD 21 B8 00 4C CD 21 24 24 00 >>{$}
  FOR %%F IN (N{_}.COM RCX 005D W Q) DO ECHO %%F>>{$}
  DEBUG <{$} >NUL
  {_}.COM %DUM_SIZE%
  SET RETURN=BACK91
  SET MESSAGE=%MESSAG32%
  GOTO PUT
  :BACK91
   SET RETURN=BACK90
   GOTO DECIDE
   :BACK90
    IF %CHOICE%==2 MOVE $$ .\data\000DUMMY.DAT
    IF %CHOICE%==1 MOVE $$ .\dummy.raw
    IF %CHOICE%==1 SET AUDIFILE=dummy.raw
    SET DUM_SIZE=false

:COPYGAME
 IF %ONLYaudi%==true goto COPYFIN
 IF %COPY%==false goto COPYFIN
 SET RETURN=BACK93
 SET MESSAGE=%MESSAG29%
 GOTO PUT
 :BACK93
  IF NOT %winos%==2000 ctty nul
  xcopy /v /y /e /I /c /h %READ_DRV%\*.* %HOMEPATH%\selfboot\data > nul
  IF errorlevel 1 SET FINISH=TRUE
  IF NOT %winos%==2000 GOTO K0
  echo n|comp %READ_DRV%\*.* %HOMEPATH%\selfboot\data\*.* > nul
  GOTO K1
  :K0
   fc %READ_DRV%\*.* %HOMEPATH%\selfboot\data\*.* | find/c "cannot open" | find "0"
  :K1
   IF errorlevel 1 SET FINISH=TRUE
   IF %FINISH%==TRUE SET MESSAGE=%MESSAG30%
   IF %FINISH%==TRUE goto PROBLEM
   IF NOT EXIST %HOMEPATH%\selfboot\IP.bin MOVE %HOMEPATH%\selfboot\data\ip.bin %HOMEPATH%\selfboot
   IF NOT EXIST %HOMEPATH%\selfboot\%BOOT.BIN% MOVE %HOMEPATH%\selfboot\data\%BOOT.BIN% %HOMEPATH%\selfboot
   IF EXIST %HOMEPATH%\selfboot\data\IP.BIN DEL %HOMEPATH%\selfboot\data\IP.BIN
   IF EXIST %HOMEPATH%\selfboot\data\%BOOT.BIN% DEL %HOMEPATH%\selfboot\data\%BOOT.BIN%
   attrib -r %BOOT.BIN%
   attrib -r ip.bin
   attrib -r -s %HOMEPATH%\selfboot\data\*.*
   FOR %%F IN (%-e1% %-e2% %-e3% %-e4% %-e5% %-e6% %-e7% %-e8% %-e9%) DO del .\data\%%F
   IF NOT %winos%==2000 ctty con
:COPYFIN
 IF %GAMETYPE%==CDDA GOTO CDDA

:INSERTCD
 SET RETURN=BACK9
 SET MESSAGE=%MESSAGE5%
 GOTO PUT
 :BACK9
  pause > nul
  cdrecord -dev%SCSIwrit% -toc > nul 
  IF ERRORLEVEL 1 GOTO DSK65535

IF %REC%==true GOTO REC_ISO
IF %GAMETYPE%==CDDA GOTO OPTION

IF %AUTO_1%==cdrecord GOTO METHOD_1
IF %AUTO_1%==cdrwin   GOTO METHOD_2
IF %AUTO_1%==false    GOTO HACK_BIN
:NON_CDDA
 SET RETURN=BACK10
 SET MESSAGE=%MESSAG25%
 GOTO PUT
 :BACK10
  SET RETURN=BACK11
  GOTO DECIDE
  :BACK11
   GOTO METHOD_%CHOICE%
  :METHOD_1
   cdrecord -dev %SCSIwrit% -checkdrive > nul
   IF errorlevel 1 SET NoDriver=TRUE
   IF %NoDriver%==TRUE SET RETURN=NON_CDDA 
   IF %NoDriver%==TRUE SET MESSAGE=%MESSAG21%
   IF %NoDriver%==TRUE SET DURATION=75
   IF %NoDriver%==TRUE goto PUT
   IF NOT EXIST %HOMEPATH%\selfboot\%AUDIFILE%   SET FINISH=TRUE
   IF %FINISH%==TRUE SET MESSAGE=%MESSAG19%
   IF %FINISH%==TRUE goto PROBLEM
   SET RETURN=AUDIOREC
   SET MESSAGE=______Burning Audio for %GAMETYPE% %nVOLABEL%_____
   GOTO PUT
   :AUDIOREC
    IF NOT %winos%==2000 ctty nul
    cdrecord -dev=%SCSIwrit% -multi -audio -pad speed=%SPEED% %AUDIFILE% > nul
    IF ERRORLEVEL 1 SET FINISH=TRUE
    IF NOT %winos%==2000 ctty con
    IF %FINISH%==TRUE SET MESSAGE=%MESSAGE9%
    IF %FINISH%==TRUE goto PROBLEM
    SET RETURN=BACK97
    SET MESSAGE=%MESSAG28%
    SET DURATION=75
    GOTO PUT
    :BACK97
     GOTO HACK_BIN
  
  :METHOD_2
   IF "%CDRWIN%"=="" goto :FINISHED
   cls
   echo.
   echo      Time to Burn Audio for non cdda game
   echo.
   echo      a) Goto the first icon on the top left: "Record Disc"
   echo      b) Click the icon in the top right corner: "Load tracks"
   echo      c) Click add, then choose the file %AUDIFILE% in your "selfboot"dir. 
   echo      d) Click the tab "Open New Session" near the bottom.
   echo      e) Burn CD.
   echo.
   echo                  EXIT CDRWIN when finished burning Audio
   echo.
   start /w %CDRWIN%
   GOTO HACK_BIN

:CDDA
 SET RETURN=BACK12
 SET MESSAGE=%MESSAG20%
 SET DURATION=50
 GOTO PUT
 :BACK12
  IF EXIST .\cdda\track_*.wav goto WAV_GOT
  :ALTERNTE
   IF "%CDRWIN%"=="" goto :FINISHED  
   cls  
   echo                  Time To Extract cdda game Audio Tracks
   echo. 
   echo      a)Click the Middle Icon on the top row called
   echo         "Extract Disc/Tracks/Sectors".
   echo      b)Choose your CD Reader in which the original
   echo         Utopia Boot-CD Game is inserted.
   echo      c)Choose the Select Tracks option at the top
   echo      d)As you will see in the Track Selection box at the left,
   echo         Audio tracks are represented by Red Circles
   echo      e)Click on Tracks 2 - X, where X is the last CDDA track
   echo      f)For image filename input: %HOMEPATH%\selfboot\cdda\TRACK_
   echo         PRESS START
   echo.
   echo                  EXIT CDRWIN when finished reading audio
   echo.
   start /w %CDRWIN%      
  :WAV_GOT
   IF %AUDIFILE%==dummy.raw move /y .\%AUDIFILE% .\cdda\track_01.wav
   IF %AUDIFILE%==audio.raw copy /y/v .\%AUDIFILE% .\cdda\track_01.wav
   IF NOT EXIST .\cdda\track_01.wav SET FINISH=TRUE
   IF %FINISH%==TRUE SET MESSAGE=%MESSAG16%
   IF %FINISH%==TRUE goto PROBLEM
   GOTO INSERTCD

:OPTION
 IF %AUTO_1%==cdrecord GOTO DOHTEM_1
 IF %AUTO_1%==cdrwin   GOTO DOHTEM_2
 IF %AUTO_1%==false    GOTO HACK_BIN
 SET RETURN=BACK14
 SET MESSAGE=%MESSAG25%
 GOTO PUT
 :BACK14
  SET RETURN=BACK15
  GOTO DECIDE
  :BACK15
   GOTO DOHTEM_%CHOICE%
  :DOHTEM_1
   cdrecord -dev %SCSIwrit% -checkdrive > nul
   IF errorlevel 1 SET NoDriver=TRUE
   IF %NoDriver%==TRUE SET RETURN=OPTION 
   IF %NoDriver%==TRUE SET MESSAGE=%MESSAG21%
   IF %NoDriver%==TRUE SET DURATION=75
   IF %NoDriver%==TRUE goto PUT 
   SET RETURN=RECAUDIO
   SET MESSAGE=______Burning Audio for %GAMETYPE% %nVOLABEL%_____
   GOTO PUT
   :RECAUDIO
    IF NOT %winos%==2000 ctty nul
    dir /o /b /s %HOMEPATH%\selfboot\cdda\track*.wav > {CDDALT}.dog
    cdrecord -dev=%SCSIwrit% -multi  -pad -audio speed=%SPEED% @{CDDALT}.dog > nul
    IF NOT %winos%==2000 ctty con
    IF ERRORLEVEL 1 SET FINISH=TRUE
    IF %FINISH%==TRUE SET MESSAGE=%MESSAGE9%
    IF %FINISH%==TRUE goto PROBLEM
    SET RETURN=BACK95
    SET MESSAGE=%MESSAG28%
    SET DURATION=75
    GOTO PUT
    :BACK95
     goto HACK_BIN

  :DOHTEM_2
   IF "%CDRWIN%"=="" goto :FINISHED
   cls
   echo.
   echo       Time to Burn Audio for cdda game 
   echo.      
   echo       a) Goto the first icon on the top left: "Record Disc"
   echo       b) Click the icon in the top right corner: "Load tracks"
   echo       c) Click add, then choose ALL trackxx.wav files in your "cdda"
   echo          directory. Arrange them in order so they go from track01.wav
   echo          to the end. Click OK to add them to your disc layout.
   echo       d) Click the tab "Open New Session" near the bottom.
   echo       e) Burn this CD.
   echo.
   echo                  EXIT CDRWIN when finished recording
   echo.
   start /w %CDRWIN%
   
:HACK_BIN
 IF %ONLYaudi%==true goto SUCCESS
 IF %HACK%==false SET RETURN=BACK16
 IF %HACK%==false SET MESSAGE=%MESSAGE8%
 IF %HACK%==false GOTO PUT
 :BACK16
  IF %HACK%==false pause > nul 
  IF %HACK%==false goto NO_DUMMY
  echo %BOOT.BIN% > {hackbn}.dog
  echo ip.bin >> {hackbn}.dog
  cdrecord -dev=%SCSIwrit% -msinfo > {somefl}.dog
  ECHO a90>{S}
  ECHO mov si,100>>{S}
  ECHO mov di,100>>{S}
  ECHO cmp byte ptr [si],2c>>{S}
  ECHO jnz 9e>>{S}
  ECHO mov di,ff>>{S}
  ECHO movsb>>{S}
  ECHO loop 96>>{S}
  ECHO mov cx,di>>{S}
  ECHO sub cx,100>>{S}
  ECHO.>>{S}
  ECHO g=90 a7>>{S}
  ECHO w>>{S}
  ECHO q>>{S}
  debug {somefl}.dog<{S}>{N}
  TYPE {somefl}.dog >> {hackbn}.dog
  IF NOT %winos%==2000 ctty nul
  Binhack.exe < {hackbn}.dog > {info}.dog
  IF NOT %winos%==2000 ctty con
  TYPE {info}.dog | find "successfully hacked."
  IF ERRORLEVEL 1 SET FINISH=TRUE
  TYPE {info}.dog | find "File ip.bin successfully created."
  IF ERRORLEVEL 1 SET FINISH=TRUE
  IF %FINISH%==TRUE SET MESSAGE=%MESSAGE7%
  IF %FINISH%==TRUE goto PROBLEM
  move %HOMEPATH%\selfboot\%BOOT.BIN% %HOMEPATH%\selfboot\data
  SET RETURN=BACK17
  SET MESSAGE=%MESSAG27%
  SET DURATION=75
  GOTO PUT
  :BACK17

:NO_DUMMY
 IF %DUM_SIZE%==false goto MAKE_ISO
 cls
 echo.
 echo IF YOU WANT TO DUMMY THE FILE IT SHOULD BE DONE NOW
 echo Run a seperate Dos Session to do this
 echo Name this dummy "000DUMMY.DAT" and place it into the "data" directory
 echo.
 echo Self-Boot and Multisession code requires 3 Minutes of Overhead on the CD
 echo you are burning. So, if you are burning to an 80 Minute CD, Your data
 echo must be approximately 77 Minutes, If you are burning to a 74 Minute CD,
 echo Your data must be approximately 71 Minutes.
 echo.
 echo Alternatively: run this program using syntax: copydog -d [size in Mbytes] 
 echo                eg copydog -d 400
 echo.
 pause

:MAKE_ISO
 IF %ISO%==false goto PATCH_B
 SET RETURN=BACK89
 SET MESSAGE=%MESSAG33%
 GOTO PUT
 :BACK89
  pause > nul
  SET RETURN=BACK98
  SET length=%ISONAME%
  GOTO NwLength
  :BACK98
   SET nISONAME=%length%
   SET RETURN=BACK20   
   SET MESSAGE=_________MAKING %nISONAME%...please wait _________
   GOTO PUT
   :BACK20
    IF NOT %winos%==2000 ctty nul
    cdrecord -dev=%SCSIwrit% -msinfo > {MSINFO}.dog
    mkisofs -C @{MSINFO}.dog -quiet -V %GAMENAME% -l -sort sorttxt.txt -o %ISONAME% data > nul
    IF ERRORLEVEL 1 SET FINISH=TRUE
    IF NOT %winos%==2000 ctty con
    IF NOT EXIST %ISONAME% SET FINISH=TRUE
    IF %FINISH%==TRUE SET MESSAGE=%MESSAG11%
    IF %FINISH%==TRUE goto PROBLEM
    SET RETURN=BACK21
    SET MESSAGE=%MESSAG22%
    SET DURATION=75
    GOTO PUT
    :BACK21

:PATCH_B
 IF %PATCH%==false goto LOOK_ISO
 echo IP.BIN > {patch}.dog
 echo %ISONAME% >> {patch}.dog
 IF NOT %winos%==2000 CTTY nul
 ipins.exe < {patch}.dog > {info}.dog
 TYPE {info}.dog | find "successfully hacked." > nul
 IF ERRORLEVEL 1 SET FINISH=TRUE
 IF NOT %winos%==2000 CTTY con
 IF %FINISH%==TRUE SET MESSAGE=%MESSAG13%
 IF %FINISH%==TRUE goto PROBLEM
 SET RETURN=BACK23
 SET MESSAGE=%MESSAG23%
 SET DURATION=75
 GOTO PUT
 :BACK23

:LOOK_ISO
 IF NOT EXIST %ISONAME% SET FINISH=TRUE
 IF %FINISH%==TRUE SET MESSAGE=%MESSAG14%
 IF %FINISH%==TRUE goto PROBLEM
 SET RETURN=BACK25
 SET MESSAGE=%MESSAG12%
 GOTO PUT
 :BACK25
  DIR  %ISONAME%  | find /I ".iso"
  SET RETURN=BACK26
  GOTO DECIDE
  :BACK26
   IF %CHOICE%==1 GOTO FINISHED

:REC_ISO
 IF %AUTO_2%==cdrecord GOTO TEMDOH_1
 IF %AUTO_2%==cdrwin   GOTO TEMDOH_2
 IF %AUTO_2%==false    GOTO FINISHED
 SET RETURN=BACK27
 SET MESSAGE=%MESSAG26%
 GOTO PUT
 :BACK27
 SET RETURN=BACK28
 GOTO DECIDE
 :BACK28
  GOTO TEMDOH_%CHOICE%
  :TEMDOH_1
   SET RETURN=BACK92
   SET length=%ISONAME%
   GOTO NwLength
   :BACK92
    SET nISONAME=%length%
    SET RETURN=BACK29
    SET MESSAGE=_____________Time to Record %nISONAME%____________
    GOTO PUT
    :BACK29
     IF NOT EXIST %ISONAME% SET FINISH=TRUE
     IF %FINISH%==TRUE SET MESSAGE=%MESSAG14%
     IF %FINISH%==TRUE goto PROBLEM
     IF NOT %winos%==2000 ctty nul
     cdrecord -dev=%SCSIwrit% -%BURNMODE% speed=%SPEED% %ISONAME% > nul
     IF ERRORLEVEL 1 SET FINISH=TRUE
     IF NOT %winos%==2000 ctty con
     IF %FINISH%==TRUE SET MESSAGE=%MESSAG15%
     IF %FINISH%==TRUE goto PROBLEM
     GOTO SUCCESS

  :TEMDOH_2
   cls
   echo                         Time to Record %ISONAME%
   echo. 
   echo       a) Click the 2nd Icon from the Top Right: "File Backup and Tools".
   echo       b) For Backup Tool/Operation: Select "Record an ISO9660 Image File".
   echo       c) Image Filename, Choose %ISONAME%, in the directory you have created it.
   echo       d) Under Recording Options, Select your CD-Recorder. Check the
   echo          following options accordingly:
   echo          Disc Type: CDROM-XA
   echo          Track Mode: MODE2
   echo          SPEED: Whatever You Want
   echo          Finalize/Close Session: Yes
   echo          Write Postgap: Yes 
   echo          Open New Session: No
   echo          Test Mode: No
   echo          Verify Recorded Image: No
   echo       e) Click the start button and you are burning.
   echo.
   echo                 EXIT CDRWIN when finished burning IMAGE
   ECHO.
   start /w %CDRWIN%

   :SUCCESS
    SET RET=FINISHED
    SET MESSAGE=%MESSAG24%
    GOTO GREET

:USAGE
 echo                 CopyDog.bat HAS BEEN TESTED UNDER WIN 98/2000 > CopyDog.txt
 echo.       >> CopyDog.txt
 echo contact: c_opydog@hotmail.com >> CopyDog.txt
 echo.       >> CopyDog.txt
 echo UNZIP: the latest version of cdrecord from: >> CopyDog.txt
 echo        ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/alpha/win32/ >> CopyDog.txt
 echo        into a directory named selfboot >> CopyDog.txt
 echo.	 >> CopyDog.txt
 echo Run DOS session >> CopyDog.txt
 echo Syntax: COPYDOG  [options]    eg copydog -t cdda -e1 voice.afs -d 400 >> CopyDog.txt
 echo. Options: >> CopyDog.txt
 echo  -h help                      prints this usage message >> CopyDog.txt
 echo  -b (name for BOOT.BIN)       default= 1ST_READ.BIN >> CopyDog.txt
 echo                               if 0 is entered 0WINCEOS.BIN is used >> CopyDog.txt
 echo  -1 cdrecord/cdrwin/false     which method to use to burn 1st session on CD >> CopyDog.txt
 echo  -2 cdrecord/cdrwin/false     which method to use to burn 2nd session on CD >> CopyDog.txt
 echo                               false= program will bypass burning -1(audio),-2(game info) session >> CopyDog.txt
 echo                               DEFAULT= program will let you choose later   >>  CopyDog.txt                          
 echo  -k true/false                let you bypass binhack + instead hack maually >> CopyDog.txt
 echo                               DEFAULT= true ie binhack will occur >>  CopyDog.txt
 echo  -p true/false                let you bypass patching bootsector >> CopyDog.txt
 echo                               DEFAULT= true ie patching will occur >>  CopyDog.txt               
 echo  -g (game_name)               name for your game >> CopyDog.txt
 echo  -d (size)/false              size of dummy file in Mbytes >> CopyDog.txt
 echo                               (user will be given option to burn dummy file as audio or data)>> CopyDog.txt
 echo                               -d false    will bypass this stage >>  CopyDog.txt
 echo  -c true/false                will bypass copying of DC game data  >> CopyDog.txt
 echo                               DEFAULT = true ie copying will occur >> CopyDog.txt
 echo  -r true/false                set = true to bypass all stages except burning iso >> CopyDog.txt
 echo                               DEFAULT = false (user must also specify -o (isoname).iso >> CopyDog.txt
 echo  -i true/false                set = false to bypass create ISO image stage >> CopyDog.txt
 echo                               DEFAULT = true >> CopyDog.txt
 echo  -m xa1/xa2                   burnmode, DEFAULT = xa1 >> CopyDog.txt
 echo  -s (speed)                   set to burn speed >> CopyDog.txt
 echo                               DEFAULT = 2 >> CopyDog.txt
 echo  -o (isoname).iso             name for your image file >> CopyDog.txt
 echo                               DEFAULT will use existing DC game label >> CopyDog.txt
 echo  -t cdda/noncdda              type of game to be made selfboot >> CopyDog.txt
 echo                               DEFAULT will decide automatically >> CopyDog.txt
 echo  -a true/false                true = only audio will be burned to CD >> CopyDog.txt
 echo                               DEFAULT = false >> CopyDog.txt
 echo  -e1 -e2 -e3                  exclude these files from original game being copied to selfboot game >> CopyDog.txt
 echo. >> CopyDog.txt
 echo. >> CopyDog.txt
 echo  note: 1. files will be "sorted" according to file sorttxt.txt, which you should >> CopyDog.txt
 echo           put into your selfboot directory >> CopyDog.txt
 echo        2. burning dummyfile as audio will burn the first session as a large audio dummy file >> CopyDog.txt
 echo        3. you should edit copydog.bat in a text editor + save as type "text document" >> CopyDog.txt 
 echo.       >> CopyDog.txt
 echo         ******** edit the following 5 values in copydog.bat ******** >> CopyDog.txt
 echo. >> CopyDog.txt
 echo SET READ_DRV= set this to the drive for your cdrom reader eg D: >> CopyDog.txt
 echo SET HOMEPATH= set this to the drive + directory that directory selfboot exists eg C: >> CopyDog.txt
 echo SET SCSIwrit= run cdrecord -scanbus to find cdrom or scsi device (as Bus,Id,Lun) for cd writer eg 1,0,0 >> CopyDog.txt
 echo SET SCSIread= run cdrecord -scanbus to find cdrom or scsi device (as Bus,Id,Lun) for cd reader eg 0,1,0 >> CopyDog.txt
 echo SET CDRWIN=   set this to where you have installed cdrwin eg C:\CDRWIN3\CDRWIN.EXE >> CopyDog.txt
 echo. >> CopyDog.txt
 GOTO START

:GREET
 IF %winos%==2000 title=CopyDog...CopyDOg...CopyDog...CopyDOg...[version 0.9]...CopyDOg...CopyDog...CopyDOg...CopyDog
 mode con lines=50 cols=80
 echo FB800:0L1F40 03 14 03 15 03 1c > {R}
 echo.e0:450''0''0>> {R}
 echo FB800:960LC80 B1 1C>> {R}
 echo q>>{R}
 debug < {R} > nul
 for %%v in (1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4) do echo.
 echo  __________%MESSAGE%__________  
 for %%v in (1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1      ) do echo.
 SET RETURN=BACK1
 SET DURATION=150
 GOTO DELAY
 :BACK1
  mode con lines=25 cols=80
  GOTO %RET%
 
:NEW_BOOT
 cls
 echo  [ %BOOT.BIN% ] might not be the name of the boot filename,
 echo  To check the boot filename, open up IP.BIN in a hex or
 echo  text editor. Look on the top, It should say something
 echo  similar to: "V.001XX BLAH.BIN". BLAH.BIN would be BOOT.BIN
 echo.
 echo             "BOOT.BIN" not found
 echo            check name for BOOT.BIN
 echo.
 pause
 dir /w %READ_DRV%\*.bin
 echo syntax should be COPYDOG -b "name of BOOT.BIN"
 echo.
 PAUSE
 GOTO FINISHED

:NO_IPBIN
 cls
 echo.
 echo   Note  IP.BIN cannot be found on Accession releases,
 echo   therefore Accession releases cannot be made self-boot
 echo   from this method UNLESS you have patch files.
 echo.
 echo   Copy the patch files to %HOMEPATH%\selfboot NOW, otherwise
 echo   end of program
 echo.
 echo         press any key when finished copying or to terminate.
 pause > nul
 IF NOT EXIST %HOMEPATH%\selfboot\IP.bin     GOTO FINISHED
 IF NOT EXIST %HOMEPATH%\selfboot\%BOOT.BIN% GOTO FINISHED
 GOTO COPYGAME

:DECIDE
 IF NOT %winos%==2000 goto Not2000
 set /p Choice=
 for %%a in (%Choice%) do set Choice=%%a
 set Choice=%Choice:~0,1%
 goto SELECT
 :Not2000
  choice /c12 > nul
  for %%a in (1 2 3) do if errorlevel %%a set Choice=%%a
 :SELECT
  for %%a in (1 2) do if %%a==%Choice% goto %RETURN%
  goto DECIDE

:PUT
 echo 
 command /e:4096 /c for %%v in (1 2) do prompt set time=$t$H$H$H$H$H$H$_ | find /v "prompt" > {file}.bat
 call {file}.bat
 cls
 echo   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 echo   ³%TIME%                                                                     ³
 echo   ³                                                                          ³
 echo   ³        %MESSAGE%        ³
 echo   ³                                                                          ³
 echo   ³                                                                          ³ 
 echo   ³                                                                          ³
 echo   ³:CopyDOg:CopyDOg:CopyDOg:CopyDOg:Ver 0.90:CopyDOg:CopyDOg:CopyDOg:CopyDOg:³
 echo   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 echo.
 echo %message% >> CopyDog.txt

:DELAY
 ECHO. > {count}
 :AGAIN
  ECHO count>> {count}
  FIND.EXE/C "count" < {count} |FIND.EXE "%DURATION%" > nul
  IF errorlevel=1 GOTO AGAIN
  SET DURATION=1
  GOTO %RETURN%

:NwLength
 set Left$={Left$$}
 if exist %Left$%.* del %Left$%.*
 echo set Left$=>%Left$%.bat
 for %%? in (rcx a w) do echo %%?>>%Left$%.scr
 echo f100 17e 20>>tmp$>>%Left$%.scr
 echo e100 "%length%">>%Left$%.scr
 for %%? in (n%Left$%.tmp rcx 10 w q) do echo %%?>>%Left$%.scr
 debug %Left$%.bat < %Left$%.scr > nul
 type %Left$%.tmp >> %Left$%.bat
 echo.>>%Left$%.bat
 call %Left$%
 SET length=[%left$%]
 GOTO %RETURN%

:COLOUR
 ECHO E0100 B8 01 12 B3 31 CD 10 31 DB 66 B8 %COL1% %COL2% %COL3% 00 E8>{T}
 ECHO E0110 08 00 B3 07 66 B8 %COL4% %COL5% %COL6% 00 BA C8 03 93 EE 42>>{T}
 ECHO E0120 93 EE 66 C1 E8 08 EE 66 C1 E8 08 EE C3 >>{T}
 FOR %%_ IN (G Q) DO ECHO %%_>>{T}
 DEBUG<{T}>NUL
 type copydog.txt
 type copydog.txt
 cls
 GOTO %RETURN%

:PROBLEM
 SET RETURN=BACK31
 GOTO PUT
 :BACK31
  IF %SCAN_BUS%==TRUE cdrecord -scanbus | find ") '" | find/v "0,0,0"
  pause > nul

:FINISHED
 IF %winos%==2000 goto FINISH
 FOR %%F IN (COL1 COL2 COL3) DO SET %%F=00
 FOR %%F IN (COL4 COL5 COL6) DO SET %%F=28
 SET RETURN=FINISH
 goto COLOUR
 :FINISH
  exit

:CLEAN_UP
 IF '%OS%==' goto 2000NOT
 :2000
  FOR %%F IN (*.bin volume.bat {*}.*) DO IF EXIST %%F del /Q %%F > nul
  FOR %%F IN (data cdda) DO IF EXIST .\%%F rd /s /Q .\%%F > nul
  copy /y/v copydog.txt "%userprofile%\desktop" > nul
  COLOR 07
  endlocal
  goto END
 :2000NOT
  ctty nul
  FOR %%F IN (cmd) DO SET %%F=
  FOR %%F IN (*.bin volume.bat {*}.*) DO IF EXIST %%F del %%F
  FOR %%F IN (data cdda) DO IF EXIST .\%%F\nul deltree /Y .\%%F
  copy /y/v CopyDog.txt %windir%\desktop
  ctty con

:END
 start copydog.txt
 cls