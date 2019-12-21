SCREEN 0
SCREEN 12
_TITLE "Binary Ticker"
DO
    _LIMIT 5
    FOR i = 1 TO 26
        RANDOMIZE TIMER
        number = INT(RND * 2)
        RANDOMIZE TIMER
        PRINT number;
    NEXT i
LOOP