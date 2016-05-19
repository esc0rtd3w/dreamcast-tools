: This will convert all the wav files in this folder into 22050hZ wav files
: And backup the original wav files in the BAK folder

: FG 2008

FOR %%1 in (*.wav) DO copy %%1 bak\%%1
FOR %%1 in (*.wav) DO sox bak\%%1 -r 22050 %%1
