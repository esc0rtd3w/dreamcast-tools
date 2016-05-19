
Self-BooTDATA Pack by Familyguy			(v1.4)
All-32bit edition 2012


This pack is meant to easily selfboot a games in 45000LBA data/data mode.
It doesn't support CDDA tracks, but if you don't mind playing with no sound it'll work.
WinCE games should works, but it's untested.


==============

USE:

1) Run Gdi2Data.bat and follow the instructions, it'll extract the data from your gdi image files into
   the data folder, and put the ip.bin in the root folder of the pack.
   It also supports non-gdi dumps, but you'll have to manually specify some parameters.
   TIP: The starting LBA of the last data track can be found by running gdinfo_FG
        on the ip.bin (or track03.iso) of the game. gdinfo_FG.exe is in the Utilities folder.
2) Downsample the content to fit a cd if needed
3) COPY about 65MB of data to the data1 folder (only if the games fits tight)
4) Apply any non-lba based hack the game requires (game-specific copy protection)
   Go to the Ripping Database to find if your game is protected: http://www.bucanero.com.ar/dreamcast/ripdb/?
5) Run SELFBOOT.bat
6) Burn with alcohol or Nero, old nero versions seem not to support the tweaks used
7) PLAY !

* You can add a 0.0 file to the data folder as a dummy, it won't apear in the filesystem.
** You can add a sorttxt.txt file to the root directory of the pack to sort your backup.
*** You can add a logo.png to the root directory of the pack to add it to the boot screen.

Note:	The BOOT.BIN specified in the ip.bin must be in the DATA folder, for binhacking purpose.
	Duplicated files will be burnt once!


============== 

To help you downsample and mess with files, some utilities were included in the Utilities Folder

==============

ADX(folder):  Downsampling tools for ADX files
              Use: Read ADX\ADXLoopCalculator.txt for info on how to downsample and loop adx files
		   A batch file to downsample wav files in 22050Hz as been included.

bin2iso:      Convert a bin file to a iso file, to use with extract.exe
              Use: bin2iso <binfile.bin> <ouput_isofile.iso>

DUMMY:        Create a file of any lenght, to create a 0.0
              Use: Dummy <FILENAME> <size_in_bytes>

extract:      Extract the content of a iso.
              Use: extract <Iso_with_TOC> <Iso_with_files> <Iso_with_files_physical_start sector>
                   Exemple for a 5 track DC game: extract track03.iso track05.iso <track05_physical_start_sector>
	           Exemple for a 3 track DC game: extract track03.iso
	      REM: The physical start sector is the LBA of the track+150  (ex: track03.iso physical start sector is 45150)
		   The disc TOC can be found in its gdi file, or by analysing its ip.bin with gdinfo_fg.exe

IP.BINHACK:   Automatic Hacking of IP.BIN and/or BOOT.BIN with support for CDDA and WINCEOS!
              Use: Run with a ip.bin in the same folder, the hacked ip.bin will be named ip.hak, the BOOT.bin 
                   specified in the ip.bin must be in the DATA folder.
              REM: AUTO.BINHACK in the root folder of the pack is the same, but with no "pause", for automated purpose.

Makesort:     Convert a isobuster filelist.txt (relative path) to a sorttxt.txt (with 0.0) usable with mkisofs
              Use: Run and follow the directions

gdinfo_FG:    Gather informations from the ip.bin and outputs it in a "game info.txt" file
              Use: Run with a ip.bin in the same folder, OR Drag and Drop a file to it (ex: track03.iso)
		   It can also retreive the disc TOC from the ip.bin

dc_sorts.rar: A collection of sort files for many games, simply rename to sorttxt.txt 
	      and put them in the root folder of the pack to use them.

ISOFIX1.3:    Can create a fixed.iso file with a readable filesystem from track03.bin or <track03.bin+dummy+LastDataTrack.bin>
              To use with isobuster to create a filelist.txt (relative path)
              Use: Run, follow the directions (track03.bin start sector is 45000).


AFS(folder):  Contain tools to mess with AFS files

	AFSCompactor: Compact AFS files by removing unused data. Save about 0.5MB per AFS, losslessly. 
                      USE: Run, follow the directions, the 1 option doesn't work, choose 2048.
                      TIP: It's suggested to select the pack folder, check "process folder recursively" and choose 2048.

	AFSUTILS:     Can extract and create AFS files.

	IDXCREATOR    Can create a IDX file that matches a modified AFS.

Gz(folder):   A batch file to re-encode GZ files using high compression using. 7z

==============

I hope you'll find them useful

************************


THANKS:

Thanks to Xzyx987X for the nrgheader technique, ECHELON for the BINHACK program, M$ for bat files,
Neoblast and Indiket for the FILL program, Indiket for the NRGHEADER program, DarkFalz for the 
ADX/Sort/AFS Tools I included in the pack, JJ1ODM for the bin2iso program and Manic & Sizious for 
their AFS Tools.

I hope you'll like this little pack, I spent a lot of time on it, trust me.

FamilyGuy 2008