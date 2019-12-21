'clears the screen and resets screen settings
resetscreen:
IF UBOUND(screenlayer) THEN
    IF screenlayer(1) THEN
        CLS , _RGBA32(0, 0, 0, 0)
        PCOPY LAYER(screenlayer(1)), 0
    ELSE
        CLS , _RGBA32(0, 0, 0, 0)
    END IF
ELSE
    CLS , _RGBA32(0, 0, 0, 0)
END IF
_PRINTMODE _KEEPBACKGROUND
COLOR ctorgb(Textcolor)
_FONT fonts(FONT_DEFAULT)
GOSUB refreshrandom
ON ERROR GOTO errorhandler
IF _EXIT THEN GOSUB cleanup
RETURN