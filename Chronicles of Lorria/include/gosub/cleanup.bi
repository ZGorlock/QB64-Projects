'shuts down the program properly
cleanup:
DIM freefonts AS _UNSIGNED _BYTE
DIM printerrors AS INTEGER
'create emergency backup
'release image handles
'release sound handles
'release font and sprite handles
'pcopys should be cleared by program
CALL updatesettings
ANIMATIONFREE ANIMATION_ALLANIMATIONS
BUTTONFREE BUTTON_ALLBUTTONS
LAYERFREE LAYER_ALLLAYERS
SPRITEFREE SPRITE_ALLSPRITES
SHEETFREE SPRITE_ALLSHEETS
TEXTBOXFREE TEXTBOX_ALLTEXTBOXES
_FONT 16
FOR freefonts = 1 TO FONT_NUM
    IF fonts(freefonts) > 0 THEN _FREEFONT fonts(freefonts)
NEXT freefonts
FOR printerrors = 1 TO UBOUND(errors)
    PRINT #32766, TRIMnum$(errors(printerrors).err); " ("; TRIMnum$(errors(printerrors).line); ") x"; TRIMnum$(errors(printerrors).count)
NEXT printerrors
PRINT #32766, initTimestamp$; "->"; TIMESTAMP
PRINT #32766, "----------------------------------------------------------------"
CLOSE #32766
CLOSE #32767
CLOSE
KILL "temp\si.tmp"
CLEAR
SYSTEM
RETURN