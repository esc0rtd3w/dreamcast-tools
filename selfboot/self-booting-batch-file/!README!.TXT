!README!.TXT

                                           .      .
                          THE...           :      :
        _   __  _ ___________·_____________|      |
             __  _\_____    / \_________   /      |
                     /     /    /      /   \      |_____________  __   _
                    /     /____/      __    \      \     _____/ __
                   /     /\    \      /      \      \     \
                  /             \    /        \     /     /
                  \_____________/___/          \_________/
             .  ..   ...    .:... .:\__________/·Ln!·::::::::::


Self-Booting Batch File v1.7
by Pr.Sinister from The Lab
============================

Why this file?
--------------

Ok. I made this file because i wanted to make my old games
Self Booting with as little input as possible. It started out
as working only for Katana games, then i added WinCE games
and the last addition was CDDA games.

Another reason was that in these days, you can't trust anyone
so downloading a nice GUI tool to help you make your games
might be risky. You get hacked and then you wonder why! I'm
not saying that the other tools available are trojans but
a lot of people asked me to fine tune my batch file because
at least you can SEE everything that is being done.

So i did. This file acccepts parameters and then does everything
automatically except for Katana Games with CDDA. Regular Katana
games, WinCE games and WinCE games with CDDA do not need user
input. The Katana games with CDDA only need user input for the 
binhack part.

Requirements
------------

To make this work you need to have the following :

- Echelon's BINHACK.EXE in your path or the current directory
- Echelon's IPINS.EXE in your path or the current directory
- Schilling's CDRECORD Binairies in your path or the current directory
- cygwin1.dll in your path or the current directory
- a "data" subdirectory
- a "cdda" subdirectory


Configuration
-------------

Edit the selfboot.bat and you only have 3 settings
to configure.

SCSI_ID is the LUN for your writer in the form x,y,z
SPEED is the write speed of your burner in the form x
MSINFO is the second -msinfo number you always get with games that
       do not have CDDA. Only write the second number! It usually is
       11700 or 11702 depending on your burner.

How to use this
---------------
USAGE : selfboot [GAMETYPE] [BOOT.BIN (Optional)]
=================================================
GameTypes : Katana - A Katana Game without CDDA
          : WinCE - A WinCE Game without CDDA
          : CDDA - A Katana Game with CDDA
          : WinCEDA - A WinCE Game with CDDA
=================================================
BOOT.BIN  : If this file is not called 1ST_READ.BIN,
          : put the filename.ext as the 2nd parameter

Examples :

G:\>selfboot wince

G:\selfboot>selfboot katana 0.BIN

G:\DC_TEMP>selfboot cdda

Obviously, make sure all gamedata is in the "data" directory and all
CDDA tracks are in the "cdda" directory if the game requires them.

Everything on your hard drive has to be ready for a full burning
and patching operation or your might get errors. If you want to
dummy your game, make sure the dummy is in the right place in the
"data" directory.

Appendix
--------

If you want to dummy a game, you must 1st know how mkisofs sorts
the files and directories. Directories are always burnt 1st. So
if the game has subdirectories, PUT THE 000DUMMY.DAT IN THE 1ST
DIRECTORY AND AT THE DEEPEST LEVEL. 

Examples :

[Dead or Alive 2]

Folder PATH listing for volume DOA2
Volume serial number is 0006FE80 051C:1397
I:.
|   0GDTEX.PVR
|   1ST_READ.BIN
|   
\---DOA2
        000DUMMY.DAT  <--- Place it in here!
        AICADRV.BIN
        ANIME_CM.BIN
        AYA00.APV
        AYA00.BIN
        AYA00.CHR
        AYA00.SUP
        AYA01.APV
        AYA01.BIN
        AYA01.CHR
        AYA01.SUP
        AYA02.APV
        ...

A good utility to create the dummy file is NEWFILE.EXE
It creates an empty file with any size you want. Here
are the steps i take to know how big my file should be.

Example :

[Chu Chu Rocket w/CDDA]

- Unrar to a directory
- Run UNPACK.EXE
- Load up CDRWIN and load the cue sheet.
- Look for Total Disc Time : 43:26:00
- Round up to nearest minute : 44:00:00
- Add 3 Minutes of Self-Boot : 47:00:00
- Substract from CD size : 74 - 47 = 27
- 1 Minute of CD is equal to 8.78 MB
- 27 x 8.78 = 237.06
- 237.06 x 1048 x 1000 = 248438880 bytes (236 MB)
  (NEWFILE.EXE takes values in bytes)
- Run NEWFILE 248438880 000DUMMY.DAT

Contact Info
------------

You can reach me on Efnet in the popular
DC channels. Don't ask me for games cause
i don't have any. Don't ask me where to get
games cause the only places i know of are 
Microplay, Toys 'R' Us, Wal-Mart, and
Future Shop. I got NFL2K1 from Microplay
so if you are looking for it, go there!

P.S. People who get mad at Sega because they
close sites should really stop whining. It's
true that these are bully tactics and that they
shouldn't be able to push NEWS SITES around but
they got the money so they do what ever they want.
That's how society has always worked. I personally
think that if they close sites for saying a game
was released, then they should close down CNN for
reporting murders and drug deals.

