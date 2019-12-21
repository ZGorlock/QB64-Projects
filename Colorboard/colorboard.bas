_TITLE "Colorboard"
SCREEN _NEWIMAGE(640, 480, 32)

DEFLNG A-Z

REDIM k(140)
REDIM x(140)
REDIM y(140)
REDIM cr(140)
REDIM cg(140)
REDIM cb(140)
REDIM d(140)
REDIM s(140)

CLS
PAINT (1, 1), _RGBA(255, 255, 255, 255)
FOR xgrid = 0 TO 639 STEP 16
    FOR ygrid = 0 TO 479 STEP 16
        drawgrid = griddraw(xgrid, ygrid)
    NEXT ygrid
NEXT xgrid
PCOPY 0, 1
DO
    _LIMIT 64
    k$ = INKEY$
    CLS
    PCOPY 1, 0
    FOR starter = 1 TO 140
        IF k(starter) = 0 THEN
            RANDOMIZE TIMER
            maybepick = INT(RND * 3000 + 1)
            IF maybepick = 1 THEN
                k(starter) = 1
                SELECT CASE starter
                    CASE 1 TO 40
                        x(starter) = ((starter - 1) * 16)
                        y(starter) = -16
                        RANDOMIZE TIMER
                        c = INT(RND * 4 + 1)
                        d(starter) = 3
                        RANDOMIZE TIMER
                        s(starter) = INT(RND * 8 + 1)
                    CASE 41 TO 70
                        x(starter) = 656
                        y(starter) = ((starter - 41) * 16)
                        RANDOMIZE TIMER
                        c = INT(RND * 4 + 1)
                        d(starter) = 4
                        RANDOMIZE TIMER
                        s(starter) = INT(RND * 8 + 1)
                    CASE 71 TO 110
                        x(starter) = ((starter - 71) * 16)
                        y(starter) = 496
                        RANDOMIZE TIMER
                        c = INT(RND * 4 + 1)
                        d(starter) = 1
                        RANDOMIZE TIMER
                        s(starter) = INT(RND * 8 + 1)
                    CASE 111 TO 140
                        x(starter) = -16
                        y(starter) = ((starter - 111) * 16)
                        RANDOMIZE TIMER
                        c = INT(RND * 4 + 1)
                        d(starter) = 2
                        RANDOMIZE TIMER
                        s(starter) = INT(RND * 8 + 1)
                END SELECT
                SELECT CASE c
                    CASE 1
                        cr(starter) = 252
                        cg(starter) = 84
                        cb(starter) = 84
                    CASE 2
                        cr(starter) = 84
                        cg(starter) = 252
                        cb(starter) = 84
                    CASE 3
                        cr(starter) = 84
                        cg(starter) = 84
                        cb(starter) = 252
                    CASE 4
                        cr(starter) = 252
                        cg(starter) = 252
                        cb(starter) = 84
                END SELECT
            END IF
        END IF
    NEXT starter
    FOR cubes = 1 TO 140
        IF k(cubes) = 1 THEN
            koff = 0
            SELECT CASE d(cubes)
                CASE 1
                    y(cubes) = y(cubes) - s(cubes)
                    IF y(cubes) <= -160 THEN koff = 1
                CASE 2
                    x(cubes) = x(cubes) + s(cubes)
                    IF x(cubes) >= 800 THEN koff = 1
                CASE 3
                    y(cubes) = y(cubes) + s(cubes)
                    IF y(cubes) >= 640 THEN koff = 1
                CASE 4
                    x(cubes) = x(cubes) - s(cubes)
                    IF x(cubes) <= -160 THEN koff = 1
            END SELECT
            IF koff = 1 THEN
                k(cubes) = 0
            ELSE
                drawcube = cubedraw(x(cubes), y(cubes), cr(cubes), cg(cubes), cb(cubes), d(cubes), s(cubes))
            END IF
        END IF
    NEXT cubes
    IF k$ = (CHR$(0) + CHR$(133)) THEN
        SELECT CASE max
            CASE 0
                _FULLSCREEN
                max = 1
            CASE 1
                _FULLSCREEN _OFF
                max = 0
        END SELECT
    END IF
    _DISPLAY
LOOP UNTIL k$ = CHR$(27)
SYSTEM

FUNCTION cubedraw (x, y, r, g, b, d, s)
REDIM xx(16)
REDIM yx(16)
FOR a = 2 TO 10
    SELECT CASE d
        CASE 1
            yx(a) = y + (16 * (a - 1))
            xx(a) = x
        CASE 2
            xx(a) = x - (16 * (a - 1))
            yx(a) = y
        CASE 3
            yx(a) = y - (16 * (a - 1))
            xx(a) = x
        CASE 4
            xx(a) = x + (16 * (a - 1))
            yx(a) = y
    END SELECT
NEXT a
FOR cube = 1 TO 10
    SELECT CASE cube
        CASE 1
            LINE (x, y)-(x + 15, y + 15), _RGBA(r, g, b, 255), BF
        CASE 2
            LINE (xx(2), yx(2))-(xx(2) + 15, yx(2) + 15), _RGBA(r, g, b, 235), BF
        CASE 3
            LINE (xx(3), yx(3))-(xx(3) + 15, yx(3) + 15), _RGBA(r, g, b, 215), BF
        CASE 4
            LINE (xx(4), yx(4))-(xx(4) + 15, yx(4) + 15), _RGBA(r, g, b, 195), BF
        CASE 5
            LINE (xx(5), yx(5))-(xx(5) + 15, yx(5) + 15), _RGBA(r, g, b, 175), BF
        CASE 6
            LINE (xx(6), yx(6))-(xx(6) + 15, yx(6) + 15), _RGBA(r, g, b, 155), BF
        CASE 7
            LINE (xx(7), yx(7))-(xx(7) + 15, yx(7) + 15), _RGBA(r, g, b, 135), BF
        CASE 8
            LINE (xx(8), yx(8))-(xx(8) + 15, yx(8) + 15), _RGBA(r, g, b, 115), BF
        CASE 9
            LINE (xx(9), yx(9))-(xx(9) + 15, yx(9) + 15), _RGBA(r, g, b, 95), BF
        CASE 10
            LINE (xx(10), yx(10))-(xx(10) + 15, yx(10) + 15), _RGBA(r, g, b, 75), BF
    END SELECT
NEXT cube
END FUNCTION

FUNCTION griddraw (x, y)
PSET (x, y), _RGBA(1, 1, 1, 255)
DRAW "R15 D15 L15 U15"
LINE (x, y)-(x + 15, y + 15), _RGBA(1, 1, 1, 255)
LINE (x + 15, y)-(x, y + 15), _RGBA(1, 1, 1, 255)
PAINT (x + 7, y + 4), _RGBA(1, 1, 1, 64), _RGBA(1, 1, 1, 255)
PAINT (x + 12, y + 7), _RGBA(1, 1, 1, 128), _RGBA(1, 1, 1, 255)
PAINT (x + 4, y + 7), _RGBA(1, 1, 1, 128), _RGBA(1, 1, 1, 255)
PAINT (x + 7, y + 12), _RGBA(1, 1, 1, 255), _RGBA(1, 1, 1, 255)
END FUNCTION