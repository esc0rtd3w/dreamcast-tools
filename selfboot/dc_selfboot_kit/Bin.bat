@echo off
cls
echo............................................................................
echo              SCREAMERS BAT FOR BIN2BOOT FOR THE DREAMCAST
echo                         SELF BOOT MADE EASY
echo............................................................................
bin2boot C:\dc\images\*.bin
del tmp_cdi_header.tmp
del tmp_ip.tmp
del tmp_records.tmp
del tmplasttrack.tmp
echo ---------------------------------------------------------------------------
echo NEARLY DONE PLZ WAIT 
echo ---------------------------------------------------------------------------
copy image.cdi  C:\dc\sb
del image.cdi
echo ---------------------------------------------------------------------------
echo                             OK, ALL DONE !!!!!!!!!!!!!!!
echo off
echo                         GO BURN YOUR SELF BOOTING  GAME 
echo off
echo                           PLEASE CLOSE THIS WINDOW !!!!!!
echo off
echo ---------------------------------------------------------------------------
