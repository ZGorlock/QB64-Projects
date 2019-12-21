_TITLE "Soduko Solver"
SCREEN 12
crlf$ = CHR$(13) + CHR$(10)
GOSUB makebg
DO
    REDIM SHARED puzzle(9, 9)
    DIM SHARED finflag
    DO
        _LIMIT 64
        GOSUB board
        COLOR 15, 0
        LOCATE 1, 1
        PRINT "Enter what you know then press Enter"
        k$ = INKEY$
        IF k$ >= CHR$(49) AND k$ <= CHR$(57) THEN puzzle(xsector, ysector) = VAL(k$)
        IF k$ = CHR$(8) THEN puzzle(xsector, ysector) = 0
        IF k$ = (CHR$(0) + CHR$(80)) THEN ysector = ysector + 1
        IF k$ = (CHR$(0) + CHR$(72)) THEN ysector = ysector - 1
        IF k$ = (CHR$(0) + CHR$(77)) THEN xsector = xsector + 1
        IF k$ = (CHR$(0) + CHR$(75)) THEN xsector = xsector - 1
        IF k$ = CHR$(3) THEN
            copypuzzle$ = "-------------------------------" + crlf$
            FOR colcopy = 1 TO 9
                copypuzzle$ = copypuzzle$ + "|"
                FOR rowcopy = 1 TO 9
                    IF puzzle(rowcopy, colcopy) = 0 THEN
                        copypuzzle$ = copypuzzle$ + "   "
                    ELSE
                        copypuzzle$ = copypuzzle$ + " " + LTRIM$(RTRIM$(STR$(puzzle(rowcopy, colcopy)))) + " "
                    END IF
                    IF (rowcopy / 3) = INT((rowcopy / 3)) THEN copypuzzle$ = copypuzzle$ + "|"
                NEXT rowcopy
                IF (colcopy / 3) = INT((colcopy / 3)) THEN copypuzzle$ = copypuzzle$ + crlf$ + "-------------------------------"
                copypuzzle$ = copypuzzle$ + crlf$
            NEXT colcopy
            _CLIPBOARD$ = copypuzzle$
        END IF
        IF NOT (xsector = 0 AND ysector = 0) THEN
            IF xsector < 1 THEN xsector = 1
            IF xsector > 9 THEN xsector = 9
            IF ysector < 1 THEN ysector = 1
            IF ysector > 9 THEN ysector = 9
        END IF
        DO WHILE _MOUSEINPUT
            IF _MOUSEBUTTON(1) THEN
                x = _MOUSEX
                y = _MOUSEY
                DO
                    xsector = INT((x - 144) / 32)
                    IF xsector < 1 OR xsector > 9 THEN
                        xsector = 0
                        ysector = 0
                        EXIT DO
                    END IF
                    ysector = INT((y - 64) / 32)
                    IF ysector < 1 OR ysector > 9 THEN
                        xsector = 0
                        ysector = 0
                        EXIT DO
                    END IF
                    EXIT DO
                LOOP
            END IF
        LOOP
        _DISPLAY
    LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(27)
    IF k$ = CHR$(27) THEN SYSTEM
    xsector = 0
    ysector = 0
    puzzle = solve(1, 1)
    finflag = 0
    GOSUB board
    COLOR 15, 0
    LOCATE 1, 1
    IF puzzle THEN
        PRINT "The puzzle has been completed!"
    ELSE
        PRINT "This puzzle was unsolvable or an exception has occured!"
    END IF
    PRINT
    PRINT "Press Escape to exit, Enter to do another puzzle"
    _DISPLAY
    DO
        _LIMIT 64
        k$ = INKEY$
        IF k$ = CHR$(3) THEN
            copypuzzle$ = "-------------------------------" + crlf$
            FOR colcopy = 1 TO 9
                copypuzzle$ = copypuzzle$ + "|"
                FOR rowcopy = 1 TO 9
                    IF puzzle(rowcopy, colcopy) = 0 THEN
                        copypuzzle$ = copypuzzle$ + "   "
                    ELSE
                        copypuzzle$ = copypuzzle$ + " " + LTRIM$(RTRIM$(STR$(puzzle(rowcopy, colcopy)))) + " "
                    END IF
                    IF (rowcopy / 3) = INT((rowcopy / 3)) THEN copypuzzle$ = copypuzzle$ + "|"
                NEXT rowcopy
                IF (colcopy / 3) = INT((colcopy / 3)) THEN copypuzzle$ = copypuzzle$ + crlf$ + "-------------------------------"
                copypuzzle$ = copypuzzle$ + crlf$
            NEXT colcopy
            _CLIPBOARD$ = copypuzzle$
        END IF
    LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(27)
LOOP UNTIL k$ = CHR$(27)
SYSTEM

makebg:
FOR drawx = 176 TO 464 STEP 32
    PSET (drawx, 96), 7
    DRAW "D289"
NEXT drawx
FOR drawy = 96 TO 384 STEP 32
    PSET (176, drawy), 7
    DRAW "R289"
NEXT drawy
FOR darken1x = 175 TO 463 STEP 96
    PSET (darken1x, 96), 7
    DRAW "D288"
NEXT darken1x
FOR darken2x = 177 TO 465 STEP 96
    PSET (darken2x, 96), 7
    DRAW "D288"
NEXT darken2x
FOR darken1y = 95 TO 383 STEP 96
    PSET (176, darken1y), 7
    DRAW "R288"
NEXT darken1y
FOR darken2y = 97 TO 385 STEP 96
    PSET (176, darken2y), 7
    DRAW "R288"
NEXT darken2y
PCOPY 0, 1
RETURN

board:
PCOPY 1, 0
xprint = 0
yprint = 0
DO
    FOR printx = 182 TO 470 STEP 32
        xprint = xprint + 1
        IF xprint = 10 THEN EXIT DO
        yprint = 0
        DO
            FOR printy = 105 TO 393 STEP 32
                yprint = yprint + 1
                IF yprint = 10 THEN EXIT DO
                IF (((printx - 182) / 32) + 1) = xsector AND (((printy - 105) / 32) + 1) = ysector THEN
                    COLOR 0, 15
                    PAINT (printx, printy), 15, 7
                ELSE
                    COLOR 15, 0
                END IF
                _PRINTMODE _KEEPBACKGROUND
                IF puzzle(xprint, yprint) <> 0 THEN _PRINTSTRING (printx, printy), STR$(puzzle(xprint, yprint))
            NEXT printy
            EXIT DO
        LOOP
    NEXT printx
    EXIT DO
LOOP
RETURN

FUNCTION checkRow (row, num)
checkRow = -1
FOR colx = 1 TO 9
    IF puzzle(row, colx) = num THEN checkRow = 0
NEXT colx
END FUNCTION

FUNCTION checkCol (col, num)
checkCol = -1
FOR rowx = 1 TO 9
    IF puzzle(rowx, col) = num THEN checkCol = 0
NEXT rowx
END FUNCTION

FUNCTION checkBox (row, col, num)
checkBox = -1
rowx = INT(((row - 1) / 3)) * 3
colx = INT(((col - 1) / 3)) * 3
FOR r = 1 TO 3
    FOR c = 1 TO 3
        IF puzzle((rowx + r), (colx + c)) = num THEN checkBox = 0
NEXT c, r
END FUNCTION

FUNCTION solve (row, col)
solve = -1
finflag = row
IF finflag > 9 THEN EXIT FUNCTION
IF puzzle(row, col) > 0 THEN
    IF col < 9 THEN
        puzzle = solve(row, (col + 1))
    ELSE
        puzzle = solve((row + 1), 1)
    END IF
    IF finflag > 9 THEN EXIT FUNCTION
ELSE
    FOR num = 1 TO 9
        IF checkRow(row, num) AND checkCol(col, num) AND checkBox(row, col, num) THEN
            puzzle(row, col) = num
            IF col < 9 THEN
                puzzle = solve(row, (col + 1))
            ELSE
                puzzle = solve((row + 1), 1)
            END IF
            IF finflag > 9 THEN EXIT FUNCTION
        END IF
    NEXT num
    puzzle(row, col) = 0
    solve = 0
END IF
END FUNCTION