_TITLE "Siezure Machine"
SCREEN 0
WIDTH 128, 64
DO
    FOR i = 1 TO 128
        RANDOMIZE TIMER
        tcolor = INT(RND * 30 + 1)
        COLOR tcolor, 0
        PRINT CHR$(219);
    NEXT i
    _DELAY .1
LOOP