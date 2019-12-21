_TITLE "Toast"
SCREEN _NEWIMAGE(640, 480, 32)
DO
    CLEAR
    REDIM toasts(307200)
    DO
        _LIMIT 64
        CLS
        k$ = INKEY$
        PRINT "Enter a value to toast the bread: "; toastdeg$
        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN toastdeg$ = toastdeg$ + k$
        IF k$ = CHR$(8) AND LEN(toastdeg$) <> 0 THEN toastdeg$ = MID$(toastdeg$, 1, (LEN(toastdeg$) - 1))
        IF k$ = (CHR$(0) + CHR$(83)) THEN toastdeg$ = ""
        IF k$ = CHR$(27) THEN SYSTEM
        _DISPLAY
    LOOP UNTIL k$ = CHR$(13)
    toastdeg = VAL(toastdeg$)
    DO
        _LIMIT 10
        CLS
        k$ = INKEY$
        PAINT (1, 1), _RGBA(238, 232, 170, 255)
        u = 0
        FOR x = 0 TO 639
            FOR y = 0 TO 478
                u = u + 1
                nowtoast = toasts(u)
                z = INT(RND * 2 + 1)
                IF z = 1 THEN nowtoast = nowtoast + 1
                IF nowtoast < 40 THEN nowtoast = 40
                PSET (x, y), _RGBA(1, 1, 1, nowtoast)
                toasts(u) = nowtoast
            NEXT y
        NEXT x
        i = i + 1
        _PRINTMODE _KEEPBACKGROUND
        _PRINTSTRING (1, 1), STR$(i)
        IF k$ = CHR$(27) THEN SYSTEM
        _DISPLAY
    LOOP UNTIL i = toastdeg
    _PRINTMODE _KEEPBACKGROUND
    _PRINTSTRING (260, 192), "Toast is ready."
    _DISPLAY
    _DELAY 3
    _PRINTMODE _KEEPBACKGROUND
    _PRINTSTRING (176, 208), "Would you like to toast again? (y/n)"
    _DISPLAY
    DO
        _LIMIT 64
        k$ = INKEY$
    LOOP UNTIL k$ = CHR$(121) OR k$ = CHR$(89) OR k$ = CHR$(110) OR k$ = CHR$(78)
LOOP UNTIL k$ = CHR$(110) OR k$ = CHR$(78)
SYSTEM