'the credits window
credits:
DO
    _LIMIT setting.lps
    GOSUB resetscreen
    PRINT "credits"
    GETINPUT
    IF ESC THEN GOTO titlescreen
LOOP UNTIL KEYBOARDINPUT
RETURN