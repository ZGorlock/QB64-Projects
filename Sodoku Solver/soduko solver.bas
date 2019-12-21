_TITLE "Soduko Solver"
SCREEN 12
DO
    REDIM puzzle(9, 9)
    REDIM guess(9, 9, 9)
    REDIM set(9)

    puzzle(1, 1) = 4
    puzzle(1, 2) = 0
    puzzle(1, 3) = 0
    puzzle(1, 4) = 0
    puzzle(1, 5) = 0
    puzzle(1, 6) = 0
    puzzle(1, 7) = 6
    puzzle(1, 8) = 7
    puzzle(1, 9) = 0
    puzzle(2, 1) = 0
    puzzle(2, 2) = 8
    puzzle(2, 3) = 9
    puzzle(2, 4) = 0
    puzzle(2, 5) = 0
    puzzle(2, 6) = 1
    puzzle(2, 7) = 3
    puzzle(2, 8) = 2
    puzzle(2, 9) = 5
    puzzle(3, 1) = 0
    puzzle(3, 2) = 3
    puzzle(3, 3) = 0
    puzzle(3, 4) = 2
    puzzle(3, 5) = 0
    puzzle(3, 6) = 0
    puzzle(3, 7) = 0
    puzzle(3, 8) = 0
    puzzle(3, 9) = 0
    puzzle(4, 1) = 0
    puzzle(4, 2) = 0
    puzzle(4, 3) = 4
    puzzle(4, 4) = 0
    puzzle(4, 5) = 8
    puzzle(4, 6) = 5
    puzzle(4, 7) = 7
    puzzle(4, 8) = 0
    puzzle(4, 9) = 0
    puzzle(5, 1) = 0
    puzzle(5, 2) = 6
    puzzle(5, 3) = 1
    puzzle(5, 4) = 0
    puzzle(5, 5) = 3
    puzzle(5, 6) = 0
    puzzle(5, 7) = 8
    puzzle(5, 8) = 5
    puzzle(5, 9) = 0
    puzzle(6, 1) = 0
    puzzle(6, 2) = 0
    puzzle(6, 3) = 5
    puzzle(6, 4) = 4
    puzzle(6, 5) = 6
    puzzle(6, 6) = 0
    puzzle(6, 7) = 1
    puzzle(6, 8) = 0
    puzzle(6, 9) = 0
    puzzle(7, 1) = 0
    puzzle(7, 2) = 0
    puzzle(7, 3) = 0
    puzzle(7, 4) = 0
    puzzle(7, 5) = 0
    puzzle(7, 6) = 8
    puzzle(7, 7) = 0
    puzzle(7, 8) = 4
    puzzle(7, 9) = 0
    puzzle(8, 1) = 6
    puzzle(8, 2) = 4
    puzzle(8, 3) = 8
    puzzle(8, 4) = 5
    puzzle(8, 5) = 0
    puzzle(8, 6) = 0
    puzzle(8, 7) = 2
    puzzle(8, 8) = 3
    puzzle(8, 9) = 0
    puzzle(9, 1) = 0
    puzzle(9, 2) = 2
    puzzle(9, 3) = 3
    puzzle(9, 4) = 0
    puzzle(9, 5) = 0
    puzzle(9, 6) = 0
    puzzle(9, 7) = 0
    puzzle(9, 8) = 0
    puzzle(9, 9) = 7

    DO
        _LIMIT 64
        CLS
        GOSUB drawboard
        GOSUB printboard
        PRINT "Enter what you know then press Enter"
        k$ = INKEY$
        IF k$ >= CHR$(49) AND k$ <= CHR$(57) THEN puzzle(xsector, ysector) = VAL(k$)
        IF k$ = CHR$(8) THEN puzzle(xsector, ysector) = 0
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
    LOOP UNTIL k$ = CHR$(13)
    DO
        FOR ychecker = 1 TO 9
            FOR setter = 1 TO 9
                set(setter) = setter
            NEXT setter
            FOR xcheck = 1 TO 9
                IF puzzle(xcheck, ychecker) <> 0 THEN set(puzzle(xcheck, ychecker)) = 0
            NEXT xcheck
            FOR guessupdatex = 1 TO 9
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatex, ychecker) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatex, ychecker, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatex, ychecker, 0) = guess(guessupdatex, ychecker, 0) + 1
                            guess(guessupdatex, ychecker, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdatex
        NEXT ychecker
        FOR xchecker = 1 TO 9
            FOR setter = 1 TO 9
                set(setter) = setter
            NEXT setter
            FOR ycheck = 1 TO 9
                IF puzzle(xchecker, ycheck) <> 0 THEN set(puzzle(xchecker, ycheck)) = 0
            NEXT ycheck
            FOR guessupdatey = 1 TO 9
                FOR sets = 1 TO 9
                    IF puzzle(xchecker, guessupdatey) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(xchecker, guessupdatey, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(xchecker, guessupdatey, 0) = guess(xchecker, guessupdatey, 0) + 1
                            guess(xchecker, guessupdatey, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdatey
        NEXT xchecker
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 1 TO 3
            FOR blockchecky1 = 1 TO 3
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 1 TO 3
            FOR guessupdateyblock = 1 TO 3
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 4 TO 6
            FOR blockchecky1 = 1 TO 3
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 4 TO 6
            FOR guessupdateyblock = 1 TO 3
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 7 TO 9
            FOR blockchecky1 = 1 TO 3
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 7 TO 9
            FOR guessupdateyblock = 1 TO 3
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 1 TO 3
            FOR blockchecky1 = 4 TO 6
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 1 TO 3
            FOR guessupdateyblock = 4 TO 6
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 4 TO 6
            FOR blockchecky1 = 4 TO 6
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 4 TO 6
            FOR guessupdateyblock = 4 TO 6
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 7 TO 9
            FOR blockchecky1 = 4 TO 6
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 7 TO 9
            FOR guessupdateyblock = 4 TO 6
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 1 TO 3
            FOR blockchecky1 = 7 TO 9
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 1 TO 3
            FOR guessupdateyblock = 7 TO 9
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 4 TO 6
            FOR blockchecky1 = 7 TO 9
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 4 TO 6
            FOR guessupdateyblock = 7 TO 9
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        FOR setter = 1 TO 9
            set(setter) = setter
        NEXT setter
        FOR blockcheckx1 = 7 TO 9
            FOR blockchecky1 = 7 TO 9
                IF puzzle(blockcheckx1, blockchecky1) <> 0 THEN set(puzzle(blockcheckx1, blockchecky1)) = 0
            NEXT blockchecky1
        NEXT blockcheckx1
        FOR guessupdatexblock = 7 TO 9
            FOR guessupdateyblock = 7 TO 9
                FOR sets = 1 TO 9
                    IF puzzle(guessupdatexblock, guessupdateyblock) = 0 AND set(sets) <> 0 THEN
                        setchecker = 0
                        FOR setcheck = 1 TO 9
                            IF guess(guessupdatexblock, guessupdateyblock, setcheck) = set(sets) THEN setchecker = 1
                        NEXT setcheck
                        IF setchecker = 0 THEN
                            guess(guessupdatexblock, guessupdateyblock, 0) = guess(guessupdatexblock, guessupdateyblock, 0) + 1
                            guess(guessupdatexblock, guessupdateyblock, set(sets)) = set(sets)
                        END IF
                    END IF
                NEXT sets
            NEXT guessupdateyblock
        NEXT guessupdatexblock
        updates = 0
        FOR guesspuzzlex = 1 TO 9
            FOR guesspuzzley = 1 TO 9
                IF guess(guesspuzzlex, guesspuzzley, 0) = 1 AND guess(guesspuzzlex, guesspuzzley, 1) <> 0 THEN
                    FOR findset = 1 TO 9
                        IF guess(guesspuzzlex, guesspuzzley, findset) <> 0 THEN puzzle(guesspuzzlex, guesspuzzley) = guess(guesspuzzlex, guesspuzzley, findset)
                    NEXT findset
                    updates = 1
                END IF
            NEXT guesspuzzley
        NEXT guesspuzzlex

        OPEN "x.txt" FOR OUTPUT AS #1
        FOR y = 1 TO 9
            FOR x = 1 TO 9
                PRINT #1, puzzle(x, y);
            NEXT x
            PRINT #1, ""
        NEXT y
        CLOSE #1
        REDIM guesser(9, 9)
        FOR x = 1 TO 9
            FOR y = 1 TO 9
                guesser(x, y) = guess(x, y, 0)
            NEXT y
        NEXT x
        OPEN "y.txt" FOR OUTPUT AS #1
        FOR y = 1 TO 9
            FOR x = 1 TO 9
                PRINT #1, guesser(x, y);
            NEXT x
            PRINT #1, ""
        NEXT y
        CLOSE #1
        SLEEP

    LOOP UNTIL updates = 0
    done = 1
    FOR checkdonex = 1 TO 9
        FOR checkdoney = 1 TO 9
            IF puzzle(checkdonex, checkdoney) = 0 THEN done = 0
        NEXT checkdoney
    NEXT checkdonex
    DO
        _LIMIT 64
        CLS
        GOSUB drawboard
        GOSUB printboard
        IF done = 1 THEN PRINT "The puzzle has been completed"
        IF done = 0 THEN
            PRINT "This puzzle was either unsolvable or required guesswork"
            PRINT "I have solved it as far as I can"
        END IF
        PRINT
        PRINT "Press Escape to exit, Enter to do another puzzle"
        k$ = INKEY$
        _DISPLAY
    LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(27)
LOOP UNTIL k$ = CHR$(27)
SYSTEM

drawboard:
FOR drawx = 176 TO 464 STEP 32
    PSET (drawx, 96), 7
    DRAW "D288"
NEXT drawx
FOR drawy = 96 TO 384 STEP 32
    PSET (176, drawy), 7
    DRAW "R288"
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
RETURN

printboard:
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
                IF puzzle(xprint, yprint) <> 0 THEN _PRINTSTRING (printx, printy), STR$(puzzle(xprint, yprint))
            NEXT printy
            EXIT DO
        LOOP
    NEXT printx
    EXIT DO
LOOP
RETURN