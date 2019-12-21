REDIM size(2, 4)
REDIM i(4)
REDIM pix(4, 1024, 1024)
REDIM bgfg(4, 2, 1024)


SCREEN 13
FOR i = 1 TO 4
    i(i) = _LOADIMAGE(LTRIM$(STR$(i)) + ".jpg")
NEXT i

SCREEN 12

FOR sizei = 1 TO 4
    size(1, sizei) = _WIDTH(i(sizei))
    size(2, sizei) = _HEIGHT(i(sizei))
NEXT sizei

FOR analyzei = 1 TO 4
    _SOURCE i(analyzei)
    PRINT analyzei
    FOR yanalyze = 1 TO (size(2, analyzei) - 1)
        FOR xanalyze = 1 TO (size(1, analyzei) - 1)
            GOSUB visual
            pix(analyzei, yanalyze, xanalyze) = POINT(xanalyze, yanalyze)
            FOR storecolor = 1 TO UBOUND(bgbf)
                IF bgfg(analyzei, 1, storecolor) = POINT(xanalyze, yanalyze) THEN bgfg(analyzei, 2, storecolor) = bgfg(analyzei, 2, storecolor) + 1
                IF bgfg(analyzei, 2, storecolor) = 0 THEN
                    bgfg(analyzei, 1, storecolor) = POINT(xanalyze, yanalyze)
                    bgfg(analyzei, 2, storecolor) = 1
                END IF
            NEXT storecolor
        NEXT xanalyze
        FOR sortcolor = 1 TO UBOUND(bfgf)
            FOR colorsort = 1 TO UBOUND(bfgf)
                IF bgfg(analyzei, 2, colorsort) > bgfg(analyzei, 2, sortcolor) THEN SWAP bgfg(analyzei, 2, colorsort), bgfg(analyzei, 2, sortcolor)
            NEXT colorsort
        NEXT sortcolor
    NEXT yanalyze
    OPEN "colors.txt" FOR OUTPUT AS #1
    FOR y = 1 TO UBOUND(bgfg)
        PRINT #1, bgfg(analyzei, 1, y); "    "; bgfg(analyzei, 2, y)
    NEXT y
    CLOSE #1
NEXT analyzei

SLEEP
SYSTEM

visual:
_PUTIMAGE (20, 20), i(analyzei)
PSET (20 + xanalyze, 20 + yanalyze), 0
_DISPLAY
RETURN