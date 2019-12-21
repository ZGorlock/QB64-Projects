SCREEN 0
SCREEN 12
_TITLE "---Root Prefix Suffix Buddy---"
bgm& = _SNDOPEN("root prefix suffix buddy\bgm.ogg")
_SNDLOOP bgm&
OPEN "root prefix suffix buddy\score.txt" FOR INPUT AS #1
INPUT #1, score
CLOSE #1
slotmachinerow = 1
REDIM slotmachine1$(22)
OPEN "root prefix suffix buddy\slotmachine1.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
    slotmachinerow = slotmachinerow + 1
    LINE INPUT #1, slotmachine1$(slotmachinerow)
    IF slotmachinerow = 22 THEN EXIT DO
LOOP
CLOSE #1
slotmachinerow = 1
REDIM slotmachine2$(22)
OPEN "root prefix suffix buddy\slotmachine2.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
    slotmachinerow = slotmachinerow + 1
    LINE INPUT #1, slotmachine2$(slotmachinerow)
    IF slotmachinerow = 22 THEN EXIT DO
LOOP
CLOSE #1
slotmachinerow = 1
REDIM slotmachine3$(22)
OPEN "root prefix suffix buddy\slotmachine3.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
    slotmachinerow = slotmachinerow + 1
    LINE INPUT #1, slotmachine3$(slotmachinerow)
    IF slotmachinerow = 22 THEN EXIT DO
LOOP
CLOSE #1
slotmachinerow = 1
REDIM slotmachine4$(22)
OPEN "root prefix suffix buddy\slotmachine4.txt" FOR INPUT AS #1
DO UNTIL EOF(1)
    slotmachinerow = slotmachinerow + 1
    LINE INPUT #1, slotmachine4$(slotmachinerow)
    IF slotmachinerow = 22 THEN EXIT DO
LOOP
CLOSE #1
DO
    esc = 0
    CLS
    LOCATE 25, 1
    PRINT "v1.3.2"
    LOCATE 25, 70
    PRINT "Gorlock897"
    LOCATE 1, 1
    PRINT "What would you like to practice?"
    PRINT "     1-Roots"
    PRINT "     2-Prefixes"
    PRINT "     3-Suffixes"
    PRINT "     i-Controls"
    PRINT "     c-Credits"
    LOCATE 1, 70
    PRINT score
    SLEEP
    keypress$ = INKEY$
    IF keypress$ = CHR$(49) THEN
        DO
            leave = 0
            userinput = 0
            loops = 0
            stopped = 0
            doneyet = 0
            right = 0
            wrong = 0
            lps = 20
            IF esc = 1 THEN
                EXIT DO
            END IF
            DO
                IF leave = 1 THEN
                    EXIT DO
                END IF
                IF esc = 1 THEN
                    EXIT DO
                END IF
                _LIMIT lps
                keypress$ = INKEY$
                IF keypress$ = CHR$(27) THEN
                    esc = 1
                    EXIT DO
                END IF
                IF keypress$ = CHR$(32) THEN
                    userinput = 1
                END IF
                IF userinput = 1 THEN
                    loops = loops + 1
                END IF
                IF userinput = 1 AND loops = 1 THEN
                    PLAY "a30"
                ELSE
                    PLAY "d30"
                END IF
                RANDOMIZE TIMER
                wordchoice = INT(RND * 25 + 1)
                SELECT CASE wordchoice
                    CASE 1
                        word$ = "alter"
                        definition$ = "other"
                    CASE 2
                        word$ = "ann"
                        definition$ = "year"
                    CASE 3
                        word$ = "anthrop"
                        definition$ = "human, man"
                    CASE 4
                        word$ = "arch"
                        definition$ = "leader"
                    CASE 5
                        word$ = "aud"
                        definition$ = "sound"
                    CASE 6
                        word$ = "bell"
                        definition$ = "war"
                    CASE 7
                        word$ = "biblo"
                        definition$ = "book"
                    CASE 8
                        word$ = "cred"
                        definition$ = "believe"
                    CASE 9
                        word$ = "crypt"
                        definition$ = "hidden"
                    CASE 10
                        word$ = "demo"
                        definition$ = "people"
                    CASE 11
                        word$ = "derm"
                        definition$ = "skin"
                    CASE 12
                        word$ = "dic"
                        definition$ = "speak, say"
                    CASE 13
                        word$ = "duc, duct"
                        definition$ = "lead"
                    CASE 14
                        word$ = "dynam"
                        definition$ = "power"
                    CASE 15
                        word$ = "ego"
                        definition$ = "self"
                    CASE 16
                        word$ = "grad"
                        definition$ = "step"
                    CASE 17
                        word$ = "ject"
                        definition$ = "throw"
                    CASE 18
                        word$ = "mit, miss"
                        definition$ = "send"
                    CASE 19
                        word$ = "path"
                        definition$ = "feeling, suffering"
                    CASE 20
                        word$ = "scrib, script"
                        definition$ = "write"
                    CASE 21
                        word$ = "sol"
                        definition$ = "sun"
                    CASE 22
                        word$ = "tang, tact"
                        definition$ = "touch"
                    CASE 23
                        word$ = "temp"
                        definition$ = "time"
                    CASE 24
                        word$ = "vert"
                        definition$ = "turn"
                    CASE 25
                        word$ = "voc"
                        definition$ = "call"
                END SELECT
                IF loops = 1 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 12
                END IF
                IF loops > 1 AND loops <= 5 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 10
                END IF
                IF loops > 5 AND loops <= 7 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine4$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 8
                END IF
                IF loops > 7 AND loops <= 10 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 6
                END IF
                IF loops > 10 AND loops <= 12 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 4
                END IF
                IF loops > 12 AND loops <= 15 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 2
                END IF
                IF loops > 15 AND loops <= 18 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    stopped = 1
                END IF
                IF doneyet = 0 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                END IF
                LOCATE 7, 25
                PRINT word$
                LOCATE 1, 70
                PRINT score
                IF stopped = 1 THEN
                    section = 1
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR11:
                    distractor1$ = distractor$
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR21:
                    distractor2$ = distractor$
                    RANDOMIZE TIMER
                    printplace = INT(RND * 6 + 1)
                    SELECT CASE printplace
                        CASE 1
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 2
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 3
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 4
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                        CASE 5
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 6
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                    END SELECT
                    DO
                        SLEEP
                        keypress$ = INKEY$
                        IF keypress$ = CHR$(27) THEN
                            esc = 1
                            EXIT DO
                        END IF
                        IF keypress$ = CHR$(97) THEN
                            IF printplace = 1 OR printplace = 2 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(98) THEN
                            IF printplace = 3 OR printplace = 4 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(99) THEN
                            IF printplace = 5 OR printplace = 6 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                    LOOP UNTIL leave = 1
                    IF right = 1 THEN
                        LOCATE 6, 17
                        COLOR 10, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    IF wrong = 1 THEN
                        LOCATE 6, 17
                        COLOR 12, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    _DELAY 2
                    EXIT DO
                END IF
            LOOP
        LOOP
    END IF
    IF keypress$ = CHR$(50) THEN
        DO
            leave = 0
            userinput = 0
            loops = 0
            stopped = 0
            doneyet = 0
            right = 0
            wrong = 0
            lps = 20
            IF esc = 1 THEN
                EXIT DO
            END IF
            DO
                IF leave = 1 THEN
                    EXIT DO
                END IF
                IF esc = 1 THEN
                    EXIT DO
                END IF
                _LIMIT lps
                keypress$ = INKEY$
                IF keypress$ = CHR$(27) THEN
                    esc = 1
                    EXIT DO
                END IF
                IF keypress$ = CHR$(32) THEN
                    userinput = 1
                END IF
                IF userinput = 1 THEN
                    loops = loops + 1
                END IF
                IF userinput = 1 AND loops = 1 THEN
                    PLAY "a30"
                ELSE
                    PLAY "d30"
                END IF
                RANDOMIZE TIMER
                wordchoice = INT(RND * 15 + 1)
                SELECT CASE wordchoice
                    CASE 1
                        word$ = "anti-"
                        definition$ = "against"
                    CASE 2
                        word$ = "bene-"
                        definition$ = "good"
                    CASE 3
                        word$ = "com-"
                        definition$ = "with, together"
                    CASE 4
                        word$ = "de-"
                        definition$ = "down, away"
                    CASE 5
                        word$ = "ex-"
                        definition$ = "out of, from"
                    CASE 6
                        word$ = "hyper-"
                        definition$ = "over"
                    CASE 7
                        word$ = "hypo-"
                        definition$ = "under"
                    CASE 8
                        word$ = "inter-"
                        definition$ = "between"
                    CASE 9
                        word$ = "intra-"
                        definition$ = "within"
                    CASE 10
                        word$ = "mal-, male-"
                        definition$ = "bad, evil"
                    CASE 11
                        word$ = "neo-"
                        definition$ = "new"
                    CASE 12
                        word$ = "phil-, philo-"
                        definition$ = "lover of"
                    CASE 13
                        word$ = "pseudo-"
                        definition$ = "false"
                    CASE 14
                        word$ = "super-"
                        definition$ = "over, above"
                    CASE 15
                        word$ = "syn-, sym-, syl-, sys-"
                        definition$ = "with, together"
                END SELECT
                IF loops = 1 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 12
                END IF
                IF loops > 1 AND loops <= 5 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 10
                END IF
                IF loops > 5 AND loops <= 7 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine4$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 8
                END IF
                IF loops > 7 AND loops <= 10 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 6
                END IF
                IF loops > 10 AND loops <= 12 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 4
                END IF
                IF loops > 12 AND loops <= 15 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 2
                END IF
                IF loops > 15 AND loops <= 18 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    stopped = 1
                END IF
                IF doneyet = 0 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                END IF
                LOCATE 7, 25
                PRINT word$
                LOCATE 1, 70
                PRINT score
                IF stopped = 1 THEN
                    section = 2
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR12:
                    distractor1$ = distractor$
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR22:
                    distractor2$ = distractor$
                    RANDOMIZE TIMER
                    printplace = INT(RND * 6 + 1)
                    SELECT CASE printplace
                        CASE 1
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 2
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 3
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 4
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                        CASE 5
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 6
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                    END SELECT
                    DO
                        SLEEP
                        keypress$ = INKEY$
                        IF keypress$ = CHR$(27) THEN
                            esc = 1
                            EXIT DO
                        END IF
                        IF keypress$ = CHR$(97) THEN
                            IF printplace = 1 OR printplace = 2 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(98) THEN
                            IF printplace = 3 OR printplace = 4 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(99) THEN
                            IF printplace = 5 OR printplace = 6 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                    LOOP UNTIL leave = 1
                    IF right = 1 THEN
                        LOCATE 6, 17
                        COLOR 10, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    IF wrong = 1 THEN
                        LOCATE 6, 17
                        COLOR 12, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    _DELAY 2
                    EXIT DO
                END IF
            LOOP
        LOOP
    END IF
    IF keypress$ = CHR$(51) THEN
        DO
            leave = 0
            userinput = 0
            loops = 0
            stopped = 0
            doneyet = 0
            right = 0
            wrong = 0
            lps = 20
            IF esc = 1 THEN
                EXIT DO
            END IF
            DO
                IF leave = 1 THEN
                    EXIT DO
                END IF
                IF esc = 1 THEN
                    EXIT DO
                END IF
                _LIMIT lps
                keypress$ = INKEY$
                IF keypress$ = CHR$(27) THEN
                    esc = 1
                    EXIT DO
                END IF
                IF keypress$ = CHR$(32) THEN
                    userinput = 1
                END IF
                IF userinput = 1 THEN
                    loops = loops + 1
                END IF
                IF userinput = 1 AND loops = 1 THEN
                    PLAY "a30"
                ELSE
                    PLAY "d30"
                END IF
                RANDOMIZE TIMER
                wordchoice = INT(RND * 10 + 1)
                SELECT CASE wordchoice
                    CASE 1
                        word$ = "-cide"
                        definition$ = "kill"
                    CASE 2
                        word$ = "-ia, -y"
                        definition$ = "act, state"
                    CASE 3
                        word$ = "-ic, -tic, -ical, -ac"
                        definition$ = "haveing to do with"
                    CASE 4
                        word$ = "-ism"
                        definition$ = "the belief in"
                    CASE 5
                        word$ = "-ist"
                        definition$ = "one who believes in"
                    CASE 6
                        word$ = "-ite"
                        definition$ = "one connected to"
                    CASE 7
                        word$ = "-logy"
                        definition$ = "study of"
                    CASE 8
                        word$ = "-or, -er"
                        definition$ = "one who takes part in"
                    CASE 9
                        word$ = "-phobia"
                        definition$ = "exaggerated fear of"
                    CASE 10
                        word$ = "-sis"
                        definition$ = "act, state, condition of"
                END SELECT
                IF loops = 1 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 12
                END IF
                IF loops > 1 AND loops <= 5 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 10
                END IF
                IF loops > 5 AND loops <= 7 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine4$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 8
                END IF
                IF loops > 7 AND loops <= 10 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine3$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 6
                END IF
                IF loops > 10 AND loops <= 12 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine2$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 4
                END IF
                IF loops > 12 AND loops <= 15 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    doneyet = 1
                    lps = 2
                END IF
                IF loops > 15 AND loops <= 18 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                    stopped = 1
                END IF
                IF doneyet = 0 THEN
                    slotmachinerow = 1
                    CLS
                    LOCATE 1, 1
                    FOR slotmachinerow = 1 TO slotmachinerow + 21
                        PRINT slotmachine1$(slotmachinerow)
                    NEXT
                END IF
                LOCATE 7, 25
                PRINT word$
                LOCATE 1, 70
                PRINT score
                IF stopped = 1 THEN
                    section = 3
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR13:
                    distractor1$ = distractor$
                    GOTO FINDDISTRACTOR
                    FINDDISTRACTOR23:
                    distractor2$ = distractor$
                    RANDOMIZE TIMER
                    printplace = INT(RND * 6 + 1)
                    SELECT CASE printplace
                        CASE 1
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 2
                            LOCATE 11, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 3
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 19, 21
                            PRINT distractor2$
                        CASE 4
                            LOCATE 15, 21
                            PRINT definition$
                            LOCATE 19, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                        CASE 5
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 11, 21
                            PRINT distractor1$
                            LOCATE 15, 21
                            PRINT distractor2$
                        CASE 6
                            LOCATE 19, 21
                            PRINT definition$
                            LOCATE 15, 21
                            PRINT distractor1$
                            LOCATE 11, 21
                            PRINT distractor2$
                    END SELECT
                    DO
                        SLEEP
                        keypress$ = INKEY$
                        IF keypress$ = CHR$(27) THEN
                            esc = 1
                            EXIT DO
                        END IF
                        IF keypress$ = CHR$(97) THEN
                            IF printplace = 1 OR printplace = 2 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(98) THEN
                            IF printplace = 3 OR printplace = 4 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                        IF keypress$ = CHR$(99) THEN
                            IF printplace = 5 OR printplace = 6 THEN
                                score = score + 5
                                right = 1
                            ELSE
                                score = score - 2
                                wrong = 1
                            END IF
                            OPEN "root prefix suffix buddy\score.txt" FOR OUTPUT AS #1
                            WRITE #1, score
                            CLOSE #1
                            leave = 1
                        END IF
                    LOOP UNTIL leave = 1
                    IF right = 1 THEN
                        LOCATE 6, 17
                        COLOR 10, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    IF wrong = 1 THEN
                        LOCATE 6, 17
                        COLOR 12, 0
                        PRINT CHR$(219)
                        COLOR 15, 0
                    END IF
                    _DELAY 2
                    EXIT DO
                END IF
            LOOP
        LOOP
    END IF
    IF keypress$ = CHR$(105) THEN
        DO
            CLS
            PRINT "Select a category to practice from the main menu. Then you will see a slot machine looking machine thing. When you press Space, the belt will slow down and stop on a prefix, root, or suffix, depending on what you picked to practice. You will recieve 5 points for a correct response, and -2 points for an incorrect response (This score will be saved even after you exit the application, and will be accessable from any practice category). You can return to the Main Menu at any[most] time[s] by pressing Esc. Have fun!"
            PRINT
            PRINT " -Press Space to return to the Main Menu-"
            SLEEP
            keypress$ = INKEY$
            IF keypress$ = CHR$(27) THEN
                EXIT DO
            END IF
            IF keypress$ = CHR$(32) THEN
                EXIT DO
            END IF
        LOOP
    END IF
    IF keypress$ = CHR$(99) THEN
        DO
            CLS
            PRINT "Coded By: Zachary Gill"
            PRINT
            PRINT "Using: QB64 BASIC"
            PRINT
            PRINT "For: Mr. Shoenberger's 6th Period"
            PRINT
            PRINT "Group: Zachary Gill"
            PRINT "       Connor Martin"
            PRINT "       Tenisson Watts?"
            PRINT
            PRINT "Music: Golden Sun"
            PRINT
            PRINT " -Press Space to return to Main Menu-"
            SLEEP
            keypress$ = INKEY$
            IF keypress$ = CHR$(27) THEN
                EXIT DO
            END IF
            IF keypress$ = CHR$(32) THEN
                EXIT DO
            END IF
        LOOP
    END IF
LOOP
        FINDDISTRACTOR:
DO
    DO
        RANDOMIZE TIMER
        distractorchoice = INT(RND * 50 + 1)
        SELECT CASE distractorchoice
            CASE 1
                distractor$ = "other"
            CASE 2
                distractor$ = "year"
            CASE 3
                distractor$ = "human, man"
            CASE 4
                distractor$ = "leader"
            CASE 5
                distractor$ = "sound"
            CASE 6
                distractor$ = "war"
            CASE 7
                distractor$ = "book"
            CASE 8
                distractor$ = "believe"
            CASE 9
                distractor$ = "hidden"
            CASE 10
                distractor$ = "people"
            CASE 11
                distractor$ = "skin"
            CASE 12
                distractor$ = "speak, say"
            CASE 13
                distractor$ = "lead"
            CASE 14
                distractor$ = "power"
            CASE 15
                distractor$ = "self"
            CASE 16
                distractor$ = "step"
            CASE 17
                distractor$ = "throw"
            CASE 18
                distractor$ = "send"
            CASE 19
                distractor$ = "feeling, suffering"
            CASE 20
                distractor$ = "write"
            CASE 21
                distractor$ = "sun"
            CASE 22
                distractor$ = "touch"
            CASE 23
                distractor$ = "time"
            CASE 24
                distractor$ = "turn"
            CASE 25
                distractor$ = "call"
            CASE 26
                distractor$ = "against"
            CASE 27
                distractor$ = "good"
            CASE 28
                distractor$ = "with, together"
            CASE 29
                distractor$ = "down, away"
            CASE 30
                distractor$ = "out of, from"
            CASE 31
                distractor$ = "over"
            CASE 32
                distractor$ = "under"
            CASE 33
                distractor$ = "between"
            CASE 34
                distractor$ = "within"
            CASE 35
                distractor$ = "bad, evil"
            CASE 36
                distractor$ = "-new"
            CASE 37
                distractor$ = "like, lover of"
            CASE 38
                distractor$ = "false"
            CASE 39
                distractor$ = "over, above"
            CASE 40
                distractor$ = "with, together"
            CASE 41
                distractor$ = "kill"
            CASE 42
                distractor$ = "act, state "
            CASE 43
                distractor$ = "having to do with"
            CASE 44
                distractor$ = "the belief in"
            CASE 45
                distractor$ = "one who believes in"
            CASE 46
                distractor$ = "one connected with"
            CASE 47
                distractor$ = "study of"
            CASE 48
                distractor$ = "one who takes part in"
            CASE 49
                distractor$ = "exaggerated fear of"
            CASE 50
                distractor$ = "act, state, condition of"
        END SELECT
        IF definition$ = distractor$ THEN
            EXIT DO
        END IF
        IF section = 1 AND distractor1$ = "" THEN
            GOTO FINDDISTRACTOR11
        END IF
        IF section = 1 AND distractor1$ <> "" THEN
            GOTO FINDDISTRACTOR21
        END IF
        IF section = 2 AND distractor1$ = "" THEN
            GOTO FINDDISTRACTOR12
        END IF
        IF section = 2 AND distractor1$ <> "" THEN
            GOTO FINDDISTRACTOR22
        END IF
        IF section = 3 AND distractor1$ = "" THEN
            GOTO FINDDISTRACTOR13
        END IF
        IF section = 3 AND distractor1$ <> "" THEN
            GOTO FINDDISTRACTOR23
        END IF
    LOOP
LOOP