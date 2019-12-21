SCREEN 0
SCREEN 12
_TITLE "Chaser"
OPEN "chaser\highscore.txt" FOR INPUT AS #1
INPUT #1, highscore
CLOSE #1
box$ = "R600 D440 L600 U440"
face$ = "BL2 D1 U3 BR4 D3"
DO
    DO
        CLS
        PRINT "Your longest time survived is:"; highscore; "seconds"
        LOCATE 12, 27
        PRINT "Print press Space to begin"
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
    LOOP UNTIL k$ = CHR$(32)
    DO
        p = _KEYDOWN(32)
    LOOP UNTIL p = 0
    REDIM chasers(32768)
    REDIM chaserloc(32768)
    locationx = 450
    locationy = 320
    loops = 0
    dd = 1
    every = 0
    t = 0
    chasers = 0
    farth = 40
    REDIM forcemap(307200)
    FOR fmd = 1 TO 307200
        forcemap(307200) = 0
    NEXT fmd
    DO
        _LIMIT 32
        GOSUB drawstuff

        GOSUB chasers
        GOSUB keypresses
    LOOP
LOOP

drawstuff:
loops = loops + 1
CLS
IF loops = 32 THEN
    t = t + 1
    t$ = STR$(t)
    farth = ((80 - (LEN(t$))) / 2)
    loops = 0
END IF
PSET (20, 20)
DRAW box$
LOCATE 1, farth
PRINT t$
PSET (locationx, locationy)
CIRCLE STEP(0, 0), 5, 15


spot = ((640 * (locationy - 1)) + locationx)
forcemap(spot) = 1


DRAW face$
RETURN

forcemap:
fmloops = fmloops + 1
IF (locationx <> oldlocationx) OR (locationy <> oldlocationy) AND fmloops >= 32 THEN
    fmloops = 0
    REDIM forcemap(307200)
    FOR fmx = 1 TO 640
        FOR fmy = 1 TO 480
            spot = ((640 * (fmy - 1)) + fmx)
            d# = SQR((((locationx - fmx) ^ 2) + ((locationy - fmy) ^ 2)))
            d# = d# ^ -1 * 100000
            forcemap(spot) = d#
        NEXT fmy
    NEXT fmx
    oldlocationx = locationx
    oldlocationy = locationy
END IF
RETURN

chasers:
IF chaserloc(1) = 0 THEN
    chasers = 1
    chaserloc(1) = 100000
END IF
chaserloops = chaserloops + 1
IF chaserloops >= 2 AND chasers <> 0 THEN
    chaserloops = 0
    FOR d = 1 TO chasers
        highest = forcemap(chaserloc(d))
        IF forcemap(chaserloc(d) - 1) > highest THEN highest = forcemap(chaserloc(d) - 1)
        IF forcemap(chaserloc(d) + 1) > highest THEN highest = forcemap(chaserloc(d) + 1)
        IF forcemap(chaserloc(d) - 640) > highest THEN highest = forcemap(chaserloc(d) - 640)
        IF forcemap(chaserloc(d) + 640) > highest THEN highest = forcemap(chaserloc(d) + 640)
        chaserloc(d) = highest
    NEXT d
END IF
FOR c = 1 TO chasers
    cspoty = INT((chaserloc(c) / 640))
    cspotx = (((chaserloc(c) / 640) - cspoty) * 640)
    PSET (cspotx, cspoty)
NEXT c
RETURN

keypresses:
pause = _KEYDOWN(32)
up = _KEYDOWN(119)
left = _KEYDOWN(97)
right = _KEYDOWN(100)
down = _KEYDOWN(115)
IF pause = -1 THEN GOSUB pause
IF up = -1 THEN locationy = locationy - 1
IF left = -1 THEN locationx = locationx - 1
IF right = -1 THEN locationx = locationx + 1
IF down = -1 THEN locationy = locationy + 1
RETURN

pause:
DO
    CLS
    LOCATE 15, 36
    PRINT "-PAUSED-"
    DO
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
LOOP
DO
    p = _KEYDOWN(32)
LOOP UNTIL p = 0
RETURN