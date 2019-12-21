SCREEN 0
SCREEN 12
_TITLE "RPS"
OPEN "rps\score.txt" FOR INPUT AS #1
INPUT #1, score
CLOSE #1
OPEN "rps\cpu.txt" FOR INPUT AS #1
INPUT #1, cpu
CLOSE #1
DO
    CLS
    LOCATE 2, 5
    PRINT "Score:"; score
    LOCATE 3, 5
    PRINT "  CPU:"; cpu
    LOCATE 10, 2
    PRINT "What would you like to do"
    LOCATE 11, 10
    PRINT "1-Play"
    LOCATE 12, 10
    PRINT "2-Reset Scores"
    SLEEP
    k$ = INKEY$
    IF k$ = CHR$(49) THEN
        DO
            DO
                CLS
                LOCATE 2, 5
                PRINT "Score:"; score
                LOCATE 3, 5
                PRINT "  CPU:"; cpu
                LOCATE 10, 2
                PRINT "What would you like to pick"
                LOCATE 11, 10
                PRINT "r-Rock"
                LOCATE 12, 10
                PRINT "p-Paper"
                LOCATE 13, 10
                PRINT "s-Scissors"
                SLEEP
                k$ = INKEY$
                IF k$ = CHR$(114) THEN
                    throw$ = "Rock"
                    throw = 1
                    EXIT DO
                END IF
                IF k$ = CHR$(112) THEN
                    throw$ = "Paper"
                    throw = 2
                    EXIT DO
                END IF
                IF k$ = CHR$(115) THEN
                    throw$ = "Scissors"
                    throw = 3
                    EXIT DO
                END IF
            LOOP
            CLS
            LOCATE 2, 5
            PRINT "Score:"; score
            LOCATE 3, 5
            PRINT "  CPU:"; cpu
            LOCATE 10, 10
            PRINT "You chose "; throw$
            _DELAY 1
            RANDOMIZE TIMER
            cpuchose = INT(RND * 3 + 1)
            IF cpuchose = 1 THEN
                cputhrow$ = "Rock"
                cputhrow = 1
            END IF
            IF cpuchose = 2 THEN
                cputhrow$ = "Paper"
                cputhrow = 2
            END IF
            IF cpuchose = 3 THEN
                cputhrow$ = "Scissors"
                cputhrow = 3
            END IF
            LOCATE 11, 10
            PRINT "CPU chose "; cputhrow$
            _DELAY 1
            LOCATE 12, 10
            IF throw = 1 AND cputhrow = 1 THEN
                PRINT "It is a tie!"
            END IF
            IF throw = 1 AND cputhrow = 2 THEN
                PRINT "CPU won!"
                cpu = cpu + 1
            END IF
            IF throw = 1 AND cputhrow = 3 THEN
                PRINT "You win!"
                score = score + 1
            END IF
            IF throw = 2 AND cputhrow = 1 THEN
                PRINT "You win!"
                score = score + 1
            END IF
            IF throw = 2 AND cputhrow = 2 THEN
                PRINT "It is a tie!"
            END IF
            IF throw = 2 AND cputhrow = 3 THEN
                PRINT "CPU won!"
                cpu = cpu + 1
            END IF
            IF throw = 3 AND cputhrow = 1 THEN
                PRINT "CPU won!"
                cpu = cpu + 1
            END IF
            IF throw = 3 AND cputhrow = 2 THEN
                PRINT "You win!"
                score = score + 1
            END IF
            IF throw = 3 AND cputhrow = 3 THEN
                PRINT "It is a tie!"
            END IF
            OPEN "rps\score.txt" FOR OUTPUT AS #1
            WRITE #1, score
            CLOSE #1
            OPEN "rps\cpu.txt" FOR OUTPUT AS #1
            WRITE #1, cpu
            CLOSE #1
            LOCATE 2, 5
            PRINT "Score:"; score
            LOCATE 3, 5
            PRINT "  CPU:"; cpu
            _DELAY 1
            LOCATE 14, 1
            PRINT "Press any key to play again"
            PRINT "Press Escape to go to the main menu"
            DO
                SLEEP
                k$ = INKEY$
                IF k$ = CHR$(27) THEN
                    exitloop = 1
                    EXIT DO
                END IF
            LOOP UNTIL k$ <> ""
            IF exitloop = 1 THEN EXIT DO
        LOOP
    END IF
    IF k$ = CHR$(50) THEN
        DO
            CLS
            LOCATE 10, 2
            PRINT "Are you sure you wish to do this?"
            LOCATE 11, 10
            PRINT "y-Yes"
            LOCATE 12, 10
            PRINT "n-No"
            SLEEP
            k$ = INKEY$
            IF k$ = CHR$(121) THEN
                score = 0
                cpu = 0
                OPEN "rps\score.txt" FOR OUTPUT AS #1
                WRITE #1, score
                CLOSE #1
                OPEN "rps\cpu.txt" FOR OUTPUT AS #1
                WRITE #1, cpu
                CLOSE #1
                CLS
                LOCATE 10, 10
                PRINT "Data Erased"
                LOCATE 12,1
                PRINT "Press any key to return to the main menu"
                SLEEP
                EXIT DO
            END IF
            IF k$ = CHR$(110) THEN
                EXIT DO
            END IF
        LOOP
    END IF
LOOP