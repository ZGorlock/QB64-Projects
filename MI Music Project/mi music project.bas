SCREEN 0
SCREEN 12
_TITLE "Super Awesome English Music Project"
CLS
PRINT "Octave:"
PRINT
PRINT "An octave is the interval between one musical pitch and another with half or double its frequency. The higher an octave number, the higher the pitch. So a (C-note in octave 6) will sound higher than a (C-note in octave 1)."
PRINT "     *An octave is one of the simplest intervals in music."
SLEEP
PLAY "o6c"
SLEEP
PLAY "o1c"
SLEEP
CLS
PRINT "Note:"
PRINT
PRINT "A Note is the pitch and duration of a sound."
SLEEP
PRINT
PRINT
PRINT
PRINT "Some types of notes are:"
SLEEP
PRINT
PRINT "Whole Note: a note having the value of 4 beats."
SLEEP
PLAY "O3C2"
SLEEP
PRINT
PRINT "Half Note: A note having the length of half of a whole note."
SLEEP
PLAY "O3C4"
SLEEP
PRINT
PRINT "Quarter Note: A note having the value of a fourth of a whole note."
SLEEP
PLAY "O3C8"
SLEEP
PRINT
PRINT "Eighth Note: A note having the value of an eighth of a whole note."
SLEEP
PLAY "O3C16"
SLEEP
CLS
PRINT "Tone:"
PRINT
PRINT "The quality or character of sound."
SLEEP
CLS
PRINT "Scale:"
PRINT
PRINT "A scale is a series of notes that differ in pitch."
SLEEP
PLAY "O3C O3D O3E O3F O3G O3A O3B"
SLEEP
CLS
PRINT "Monotone:"
PRINT
PRINT "A Monotone is when a note is repeated."
PRINT "     *We learned the prefix mono- before."
SLEEP
PLAY "O4D5 O4D5 O4D5 O4D5"
SLEEP
CLS
PRINT "Chord:"
PRINT
PRINT "A chord is a combination of three or more notes that blend harmoniously when played together."
SLEEP
PLAY "O3A, O3C, O3E"
SLEEP
CLS
PRINT "The following toy is a note-grid. It is a 16x16 grid and each space represents a particular note."
PRINT
PRINT "The verticals represents different notes in a scale (like what we talked about before)."
PRINT
PRINT "The horizontals represent time. Right now, each box is set to a length of 1/8 of a second."
PRINT "This does not neccesarily mean that they are eighth notes as there is no established meter."
PRINT
PRINT
PRINT "We are going to try and make a:"
PRINT "     -Note"
PRINT "     -Scale"
PRINT "     -Monotone"
PRINT "     -Chord"
PRINT "     -and play with it, because it's awesome"
SLEEP
DIM SHARED grid(16, 16), grid2(16, 16), cur
CONST maxx = 820
CONST maxy = 820
SCREEN _NEWIMAGE(maxx, maxy, 32)
cleargrid
DO
    IF TIMER - t# > 1 / 8 THEN cur = (cur + 1) AND 15: t# = TIMER
    IF cur <> oldcur THEN
        figuregrid
        drawgrid
        playgrid
        oldcur = cur
    END IF
    domousestuff
    in$ = INKEY$
    IF in$ = "C" OR in$ = "c" THEN cleargrid
LOOP UNTIL in$ = CHR$(27)

SUB drawgrid
scale! = maxx / 16
scale2 = maxx \ 16 - 2
FOR y = 0 TO 15
    y1 = y * scale!
    FOR x = 0 TO 15
        x1 = x * scale!
        c& = _RGB32(grid2(x, y) * 64 + 64, 0, 0)
        LINE (x1, y1)-(x1 + scale2, y1 + scale2), c&, BF
    NEXT x
NEXT y
END SUB

SUB figuregrid
FOR y = 0 TO 15
    FOR x = 0 TO 15
        grid2(x, y) = grid(x, y)
    NEXT x
NEXT y
FOR y = 1 TO 14
    FOR x = 1 TO 14
        IF grid(x, y) = 1 AND cur = x THEN
            grid2(x, y) = 2
            IF grid(x - 1, y) = 0 THEN grid2(x - 1, y) = 1
            IF grid(x + 1, y) = 0 THEN grid2(x + 1, y) = 1
            IF grid(x, y - 1) = 0 THEN grid2(x, y - 1) = 1
            IF grid(x, y + 1) = 0 THEN grid2(x, y + 1) = 1
        END IF
    NEXT x
NEXT y
END SUB

SUB domousestuff
DO WHILE _MOUSEINPUT
    IF _MOUSEBUTTON(1) THEN
        x = _MOUSEX \ (maxx \ 16)
        y = _MOUSEY \ (maxy \ 16)
        grid(x, y) = 1 - grid(x, y)
    END IF
LOOP
END SUB

SUB playgrid
n$ = "L16 "
scale$ = "o1fo1go1ao2co2do2fo2go2ao3co3do3fo3go3ao4co4do4fo"
FOR y = 15 TO 0 STEP -1
    IF grid(cur, y) = 1 THEN
        note$ = MID$(scale$, 1 + (15 - y) * 3, 3)
        n$ = n$ + note$ + ","
    END IF
NEXT y
n$ = LEFT$(n$, LEN(n$) - 1)
PLAY n$
END SUB

SUB cleargrid
FOR y = 0 TO 15
    FOR x = 0 TO 15
        grid(x, y) = 0
    NEXT x
NEXT y
END SUB