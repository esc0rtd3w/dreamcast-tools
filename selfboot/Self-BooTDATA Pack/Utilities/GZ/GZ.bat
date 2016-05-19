for %%1 in (*) do (
7za.exe a -tgzip %%~n1.GZ %%1 -mpass=4 -mfb=255
)
del 7za.gz 
del sprite_fg.gz
del GZ.GZ
ren *.gz *.GZ
pause