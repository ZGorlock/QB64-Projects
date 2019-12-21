SCREEN 0
SCREEN 12
_TITLE "Jellyfish Catcher"
DIM X, Y, E, K, S, P, C AS INTEGER
DIM J1, J2, J3, B, M AS LONG
SCREEN 13
J1 = _LOADIMAGE("jellyfish catcher\jellyfish1.jpg")
J2 = _LOADIMAGE("jellyfish catcher\jellyfish2.jpg")
J3 = _LOADIMAGE("jellyfish catcher\jellyfish3.jpg")
B = _LOADIMAGE("jellyfish catcher\bucket.jpg")
M = _SNDOPEN("jellyfish catcher\music.mp3")
SCREEN 8
COLOR 0, 15
RANDOMIZE TIMER
E = INT((RND * 21 + 1) * 20)
DO
    _SNDPLAY M
    DO
        CLS
        RANDOMIZE TIMER
        C = INT(RND * 3 + 1)
        SELECT CASE C
            CASE 1
                _PUTIMAGE (X, Y), J1
            CASE 2
                _PUTIMAGE (X, Y), J2
            CASE 3
                _PUTIMAGE (X, Y), J3
        END SELECT
        _PUTIMAGE (E, 100), B
        COLOR 8, 15
        LOCATE 2, 76
        PRINT S
        DO
            K = _KEYHIT
            IF K = 119 THEN
                Y = Y - 5
            END IF
            IF K = 97 THEN
                X = X - 5
            END IF
            IF K = 115 THEN
                Y = Y + 5
            END IF
            IF K = 100 THEN
                X = X + 5
            END IF
            IF X < 1 THEN
                X = 1
            END IF
            IF X > 576 THEN
                X = 576
            END IF
            IF Y < 1 THEN
                Y = 1
            END IF
            IF Y > 136 THEN
                Y = 136
            END IF
            IF X > E AND X < (E + 200) AND Y > 100 THEN
                S = S + 1
                X = 0
                Y = 0
                RANDOMIZE TIMER
                E = INT((RND * 21 + 1) * 20)
            END IF
            IF S > 9999 THEN
                S = 9999
            END IF
            IF K <> 0 THEN EXIT DO
        LOOP
        K = 0
        P = _SNDPLAYING(M)
    LOOP WHILE P = -1
LOOP