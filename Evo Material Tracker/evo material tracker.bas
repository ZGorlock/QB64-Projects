_SCREENHIDE
SCREEN _NEWIMAGE(640, 800, 32)
icon& = _LOADIMAGE("image\icon.jpg", 32)
_ICON icon&
_TITLE "Evo Material Tracker"
REDIM SHARED names(44) AS STRING
REDIM SHARED ids(44) AS SINGLE
REDIM SHARED pics(44) AS LONG
REDIM SHARED info(44, 2) AS SINGLE
REDIM SHARED rows(8, 6) AS SINGLE
REDIM SHARED locs(44) AS loc
DIM SHARED x, y, click AS SINGLE
DIM SHARED font1, font2, font3 AS LONG
OPEN "ids.txt" FOR INPUT AS #1
FOR getid = 1 TO 44
    LINE INPUT #1, id$
    ids(getid) = VAL(id$)
    pics(getid) = _LOADIMAGE("image\" + LTRIM$(RTRIM$(id$)) + ".jpg")
NEXT getid
CLOSE #1
OPEN "names.txt" FOR INPUT AS #1
FOR getnames = 1 TO 44
    LINE INPUT #1, names(getnames)
NEXT getnames
CLOSE #1
OPEN "data.txt" FOR INPUT AS #1
FOR getdata = 1 TO 44
    LINE INPUT #1, have$
    LINE INPUT #1, need$
    info(getdata, 1) = VAL(have$)
    info(getdata, 2) = VAL(need$)
NEXT getdata
CLOSE #1
OPEN "rows.txt" FOR INPUT AS #1
FOR row = 1 TO 8
    LINE INPUT #1, getrow$
    FOR riprow = 1 TO 6
        rows(row, riprow) = VAL(MID$(getrow$, (riprow - 1) * 3 + 1, 3))
NEXT riprow, row
CLOSE #1
font1 = _LOADFONT("VeraMono.ttf", 8, "MONOSPACE")
font2 = _LOADFONT("VeraMono.ttf", 10, "MONOSPACE")
font3 = _LOADFONT("VeraMono.ttf", 14, "MONOSPACE")
FOR rows = 1 TO 8
    FOR cols = 1 TO 6
        IF rows(rows, cols) = 0 THEN EXIT FOR
        location = getlocinarray(rows(rows, cols))
        IF location > 0 THEN CALL getlocs((cols - 1) * 100 + 20, (rows - 1) * 100 + 1, location)
NEXT cols, rows
_SCREENSHOW

TYPE loc
    picx AS SINGLE
    picy AS SINGLE
    namex AS SINGLE
    namey AS SINGLE
    infox AS SINGLE
    infoy AS SINGLE
    numberx AS SINGLE
    numbery AS SINGLE
    haveplusx AS SINGLE
    haveplusy AS SINGLE
    haveminusx AS SINGLE
    haveminusy AS SINGLE
    needplusx AS SINGLE
    needplusy AS SINGLE
    needminusx AS SINGLE
    needminusy AS SINGLE
END TYPE

DO
    _LIMIT 16
    CLS
    _FONT font3
    _PRINTMODE _KEEPBACKGROUND
    COLOR ctorgb&(15)
    _PRINTSTRING (1, 1), "Dragons-"
    _PRINTSTRING (1, 100), "Masks-"
    _PRINTSTRING (1, 400), "Sprites-"
    _PRINTSTRING (1, 600), "Keepers-"
    _PRINTSTRING (1, 700), "Crystals-"
    FOR putrows = 1 TO 8
        FOR putcols = 1 TO 6
            CALL putevo(putrows, putcols)
    NEXT putcols, putrows
    DO WHILE _MOUSEINPUT
        x = _MOUSEX
        y = _MOUSEY
        click = _MOUSEBUTTON(1)
    LOOP
    IF click = -1 AND oldclick = 0 THEN
        FOR boxx = 1 TO 8
            FOR boxy = 1 TO 6
                location = getlocinarray(rows(boxx, boxy))
                saveloc = location
                IF isonbox(x, y, locs(location).haveplusx, locs(location).haveplusy, locs(location).haveplusx + 10, locs(location).haveplusy + 10) THEN
                    button = 1
                ELSE IF isonbox(x, y, locs(location).haveminusx, locs(location).haveminusy, locs(location).haveminusx + 10, locs(location).haveminusy + 10) THEN
                        button = 2
                    ELSE IF isonbox(x, y, locs(location).needplusx, locs(location).needplusy, locs(location).needplusx + 10, locs(location).needplusy + 10) THEN
                            button = 3
                        ELSE IF isonbox(x, y, locs(location).needminusx, locs(location).needminusy, locs(location).needminusx + 10, locs(location).needminusy + 10) THEN
                                button = 4
                            END IF
                        END IF
                    END IF
                END IF
                IF button > 0 THEN EXIT FOR
            NEXT boxy
            IF button > 0 THEN EXIT FOR
        NEXT boxx
    END IF
    IF click = 0 AND oldclick = -1 THEN
        DO
            SELECT CASE button
                CASE 1
                    IF isonbox(x, y, locs(saveloc).haveplusx, locs(saveloc).haveplusy, locs(saveloc).haveplusx + 10, locs(saveloc).haveplusy + 10) THEN info(saveloc, 1) = info(saveloc, 1) + 1
                CASE 2
                    IF isonbox(x, y, locs(saveloc).haveminusx, locs(saveloc).haveminusy, locs(saveloc).haveminusx + 10, locs(saveloc).haveminusy + 10) THEN info(saveloc, 1) = info(saveloc, 1) - 1
                CASE 3
                    IF isonbox(x, y, locs(saveloc).needplusx, locs(saveloc).needplusy, locs(saveloc).needplusx + 10, locs(saveloc).needplusy + 10) THEN info(saveloc, 2) = info(saveloc, 2) + 1
                CASE 4
                    IF isonbox(x, y, locs(saveloc).needminusx, locs(saveloc).needminusy, locs(saveloc).needminusx + 10, locs(saveloc).needminusy + 10) THEN info(saveloc, 2) = info(saveloc, 2) - 1
                CASE ELSE
                    EXIT DO
            END SELECT
            GOSUB updatedata
            EXIT DO
        LOOP
        button = 0
    END IF
    oldclick = click
    _DISPLAY
LOOP

updatedata:
OPEN "data.txt" FOR OUTPUT AS #1
FOR printx = 1 TO 44
    FOR printy = 1 TO 2
        IF info(printx, printy) < 0 THEN info(printx, printy) = 0
        PRINT #1, info(printx, printy)
NEXT printy, printx
CLOSE #1
RETURN

SUB getlocs (x, y, s)
locs(s).picx = x + 30
locs(s).picy = y + 30
locs(s).namex = x + 3
locs(s).namey = y + 70
locs(s).infox = x + 32.5
locs(s).infoy = y + 20
locs(s).numberx = x + 32
locs(s).numbery = y + 69
locs(s).haveplusx = x + 20
locs(s).haveplusy = y + 30
locs(s).haveminusx = x + 20
locs(s).haveminusy = y + 40
locs(s).needplusx = x + 70
locs(s).needplusy = y + 30
locs(s).needminusx = x + 70
locs(s).needminusy = y + 40
END SUB

SUB putevo (r, c)
location = getlocinarray(rows(r, c))
IF location = 0 THEN EXIT SUB
LINE (locs(location).infox, locs(location).infoy)-STEP(35, 10), ctorgb&(15), BF
LINE (locs(location).namex, locs(location).namey)-STEP(94, 8), ctorgb&(15), BF
LINE (locs(location).haveplusx, locs(location).haveplusy)-STEP(10, 20), ctorgb&(15), BF
LINE (locs(location).needplusx, locs(location).needplusy)-STEP(10, 20), ctorgb&(15), BF
PSET (locs(location).haveminusx, locs(location).haveminusy), ctorgb&(0)
DRAW "R10L5BU2U6D3L3R6L3BD10L3R6L3BU4BR44R10L5BU2U6D3L3R6L3BD10L3R6L3BU4"
COLOR ctorgb&(0)
_FONT font2
toprint$ = LTRIM$(RTRIM$(STR$(info(location, 1)))) + "/" + LTRIM$(RTRIM$(STR$(info(location, 2))))
_PRINTSTRING (centerprint(35, (LEN(toprint$) * _FONTWIDTH), locs(location).infox), locs(location).infoy), toprint$
_FONT font1
_PRINTSTRING (centerprint(94, (LEN(names(location)) * _FONTWIDTH), locs(location).namex + 1), locs(location).namey), names(location)
_PUTIMAGE (locs(location).picx, locs(location).picy)-(locs(location).picx + 39, locs(location).picy + 39), pics(location)
COLOR ctorgb&(15)
_PRINTSTRING (locs(location).numberx, locs(location).numbery - _FONTHEIGHT), LTRIM$(RTRIM$(STR$(ids(location))))
END SUB

FUNCTION centerprint (area, length, offset)
centerprint = ((area - length) / 2) + offset
IF length > area THEN centerprint = offset
END FUNCTION

FUNCTION fill$ (n)
FOR k = 1 TO n
    fill$ = fill$ + CHR$(219)
NEXT k
END FUNCTION

FUNCTION ctorgb& (c)
SELECT CASE c
    CASE 0
        ctorgb& = 4278190080
    CASE 1
        ctorgb& = 4278190248
    CASE 2
        ctorgb& = 4278233088
    CASE 3
        ctorgb& = 4278233256
    CASE 4
        ctorgb& = 4289200128
    CASE 5
        ctorgb& = 4289200296
    CASE 6
        ctorgb& = 4289221632
    CASE 7
        ctorgb& = 4289243304
    CASE 8
        ctorgb& = 4283716692
    CASE 9
        ctorgb& = 4283716860
    CASE 10
        ctorgb& = 4283759700
    CASE 11
        ctorgb& = 4283759868
    CASE 12
        ctorgb& = 4294726740
    CASE 13
        ctorgb& = 4294726908
    CASE 14
        ctorgb& = 4294769748
    CASE 15
        ctorgb& = 4294769916
    CASE ELSE
        ctorgb& = 4278190080
END SELECT
END FUNCTION

FUNCTION getlocinarray (id)
FOR getlocinarray = 1 TO 44
    IF ids(getlocinarray) = id THEN EXIT FOR
    IF getlocinarray = 44 THEN
        getlocinarray = 0
        EXIT FOR
    END IF
NEXT getlocinarray
END FUNCTION

FUNCTION isonbox (x, y, x1, y1, x2, y2)
isonbox = -1
IF x < x1 OR x > x2 THEN isonbox = 0
IF y < y1 OR y > y2 THEN isonbox = 0
END FUNCTION