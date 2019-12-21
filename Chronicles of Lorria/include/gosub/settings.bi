'the settings window
settings:
DO
    _LIMIT setting.lps
    GOSUB resetscreen
    PRINT "settings"
    'change lps then reset loops and reget framespeed
    GETINPUT
    IF ESC THEN GOTO titlescreen
LOOP UNTIL KEYBOARDINPUT
RETURN