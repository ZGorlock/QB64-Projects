'$INCLUDE:'commoninit_slim.bi'

a = 100
lps = 2
s = 30

REDIM a(a, 4) AS SINGLE

RANDOMIZE TIMER
FOR x = 1 TO a
    a(x, 1) = INT(RND * 640 + 1)
    a(x, 2) = INT(RND * 480 + 1)
    a(x, 3) = RND * s / lps
    a(x, 4) = SQR(s ^ 2 - a(x, 3) ^ 2)
NEXT x

SCREEN 12

DO
    _LIMIT lps
    CLS

    FOR x = 1 TO a
        p = 0
        w = 0
        r = 0
        FOR y = 1 TO a
            z = distance(a(x, 1), a(x, 2), a(y, 1), a(y, 2))
            IF z < 20 THEN
                r = r + 1
                p = p + a(y, 1)
                w = w + a(y, 2)
            END IF
        NEXT y

        IF p * w THEN
            p = p / r
            w = w / r
            a(x, 3) = p - a(x, 1)
            a(x, 4) = w - a(x, 2)
        END IF

        a(x, 1) = a(x, 1) + (a(x, 3) * s / lps)
        a(x, 2) = a(x, 2) + (a(x, 4) * s / lps)
        PSET (a(x, 1), a(x, 2)), 15
    NEXT x

    _DISPLAY
LOOP UNTIL INKEY$ = CHR$(27)
SYSTEM

'$INCLUDE:'common_slim.bi'