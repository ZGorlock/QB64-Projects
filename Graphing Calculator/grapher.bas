_TITLE "Grapher"
SCREEN 12

dimvar:
REDIM p&&(640)
REDIM pcheck(640)
GOTO dimmedvar

DO
    GOTO dimvar
    dimmedvar:
    GOSUB setvar
    DO
        _LIMIT 32
        CLS
        GOSUB drawaxes
        k$ = INKEY$
        IF LEN(k$) THEN
            SELECT CASE ASC(k$)
                CASE 27
                    SYSTEM
                CASE 32
            END SELECT
            IF _KEYDOWN(CVI((CHR$(0) + CHR$(72)))) THEN ymov = ymov + 5
            IF _KEYDOWN(CVI((CHR$(0) + CHR$(75)))) THEN xmov = xmov + 5
            IF _KEYDOWN(CVI((CHR$(0) + CHR$(77)))) THEN xmov = xmov - 5
            IF _KEYDOWN(CVI((CHR$(0) + CHR$(80)))) THEN ymov = ymov - 5
        END IF
        DO
            xloc = _MOUSEX
            yloc = _MOUSEY
            IF _MOUSEBUTTON(1) = -1 THEN
                xmov = ((320 + xmov) - ((320 + mov) - xloc) - 320)
                EXIT DO
            END IF
        LOOP WHILE _MOUSEINPUT

        xmax = 320 + xmov
        xmin = -320 + xmov
        ymax = 240 + ymov
        ymin = -240 + ymov

        REDIM pcheck(640)
        graphcount = 0
        FOR graph = (xmin) TO (xmax)
            graphcount = graphcount + 1
            sqroot = 1
            IF sqroot = 1 AND 22500 - (graph ^ 2) >= 0 THEN
                pcheck(graphcount) = 1
                xvar&& = -1 * SQR(22500 - (graph ^ 2))
                p&&(graphcount) = ((xvar&&) * -1) + (240 + ymov)
                IF pcheck(graphcount - 1) = 1 THEN LINE (((graphcount - 1) + (2 * xmov)), p&&(graphcount - 1))-(((graphcount) + (2 * xmov)), p&&(graphcount)), 15
            END IF
        NEXT graph
        _DISPLAY
    LOOP
LOOP

drawaxes:
IF 320 - ABS(xmov) > 0 THEN LINE ((320 + xmov), 0)-((320 + xmov), 480), 8
IF 240 - ABS(ymov) > 0 THEN LINE (0, (240 + ymov))-(640, (240 + ymov)), 8
RETURN

setvar:
equ$ = ""
mbcheck = 1
xmax = 320
xmin = -320
ymax = 240
ymin = -240
xmov = 0
ymov = 0
RETURN