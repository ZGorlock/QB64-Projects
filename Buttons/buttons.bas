_TITLE "Buttons"
SCREEN 12
_SCREENMOVE _MIDDLE

REDIM putx(30)
REDIM puty(30)
REDIM held(30)
REDIM place(30)

buttons$ = "R100 D50 L100 U50"
buttons = 30
putx(1) = 20
putx(2) = 140
putx(3) = 260
putx(4) = 380
putx(5) = 500
putx(6) = 20
putx(7) = 140
putx(8) = 260
putx(9) = 380
putx(10) = 500
putx(11) = 20
putx(12) = 140
putx(13) = 260
putx(14) = 380
putx(15) = 500
putx(16) = 20
putx(17) = 140
putx(18) = 260
putx(19) = 380
putx(20) = 500
putx(21) = 20
putx(22) = 140
putx(23) = 260
putx(24) = 380
putx(25) = 500
putx(26) = 20
putx(27) = 140
putx(28) = 260
putx(29) = 380
putx(30) = 500
puty(1) = 20
puty(2) = 20
puty(3) = 20
puty(4) = 20
puty(5) = 20
puty(6) = 90
puty(7) = 90
puty(8) = 90
puty(9) = 90
puty(10) = 90
puty(11) = 160
puty(12) = 160
puty(13) = 160
puty(14) = 160
puty(15) = 160
puty(16) = 230
puty(17) = 230
puty(18) = 230
puty(19) = 230
puty(20) = 230
puty(21) = 300
puty(22) = 300
puty(23) = 300
puty(24) = 300
puty(25) = 300
puty(26) = 370
puty(27) = 370
puty(28) = 370
puty(29) = 370
puty(30) = 370

DO
    _LIMIT 32
    action = 0
    DO WHILE _MOUSEINPUT
        click = _MOUSEBUTTON(1)
        x = _MOUSEX
        y = _MOUSEY
        FOR bs = 1 TO buttons
            IF click <> -1 THEN
                IF (x >= putx(bs) AND x <= putx(bs) + 100) AND (y >= puty(bs) AND y <= puty(bs) + 50) THEN place(bs) = 1 ELSE place(bs) = 0
            END IF
            IF click = 0 AND place(bs) = 1 THEN held(bs) = 1 ELSE held(bs) = 0
            IF click = -1 AND place(bs) = 1 THEN held(bs) = 2
            SELECT CASE held(bs)
                CASE 0
                    PSET (putx(bs), puty(bs)), 15
                    DRAW buttons$
                    PAINT (putx(bs) + 1, puty(bs) + 1), 15, 15
                CASE 1
                    PSET (putx(bs), puty(bs)), 7
                    DRAW buttons$
                    PAINT (putx(bs) + 1, puty(bs) + 1), 7, 7
                CASE 2
                    PSET (putx(bs), puty(bs)), 8
                    DRAW buttons$
                    PAINT (putx(bs) + 1, puty(bs) + 1), 8, 8
                    store = bs
            END SELECT
        NEXT bs
        IF oldclick = -1 AND click = 0 THEN
            release = 1
            held = 0
        END IF
        oldclick = click
    LOOP
    FOR bs = 1 TO buttons
        IF release = 1 AND place(bs) = 1 AND bs = store THEN action = bs
    NEXT bs
    release = 0
    _DISPLAY
LOOP UNTIL action <> 0
CLS
PRINT "You pressed button"; action; "!"
_DISPLAY
SLEEP
SYSTEM