_TITLE "Dungeon Dojo"
SCREEN 12
BEGIN:
DO
    CLS
    PRINT "Welcome to Dungeon Dojo!"
    PRINT "Would you like to join a friend or become a host?"
    PRINT "     1-Join Friend"
    PRINT "     2-Become Host"
    SLEEP
    keypress$ = INKEY$
    IF keypress$ = CHR$(49) THEN
        exitloop = 0
        OPEN "friend1.txt" FOR INPUT AS #1
        INPUT #1, friend1$
        INPUT #1, friend1ip$
        CLOSE #1
        OPEN "friend2.txt" FOR INPUT AS #1
        INPUT #1, friend2$
        INPUT #1, friend2ip$
        CLOSE #1
        OPEN "friend3.txt" FOR INPUT AS #1
        INPUT #1, friend3$
        INPUT #1, friend3ip$
        CLOSE #1
        OPEN "friend4.txt" FOR INPUT AS #1
        INPUT #1, friend4$
        INPUT #1, friend4ip$
        CLOSE #1
        OPEN "friend5.txt" FOR INPUT AS #1
        INPUT #1, friend5$
        INPUT #1, friend5ip$
        CLOSE #1
        DO
            DO
                DO
                    CLS
                    PRINT "Enter your friend's IP Address or enter the number of a friend"
                    PRINT "Use the form '000.000.0.0'"
                    PRINT "- "; ip$;
                    LOCATE 60.5, 1
                    PRINT "-FRIENDS-"
                    LOCATE 50, 2
                    PRINT "1-"; friend1$; " - "; friend1ip$;
                    LOCATE 50, 3
                    PRINT "2-"; friend2$; " - "; friend2ip$;
                    LOCATE 50, 4
                    PRINT "3-"; friend3$; " - "; friend3ip$;
                    LOCATE 50, 5
                    PRINT "4-"; friend4$; " - "; friend4ip$;
                    LOCATE 50, 6
                    PRINT "5-"; friend5$; " - "; friend5ip$;
                    SLEEP
                    keypress$ = INKEY$
                    IF keypress$ = CHR$(27) THEN
                        GOTO BEGIN
                    END IF
                    IF keypress$ = CHR$(46) THEN
                        IF decimal1 = 0 THEN
                            decimal1 = 1
                            ip$ = ip$ + keypress$
                            inputlength = LEN(ip$)
                            decimalloc1 = LEN(ip$)
                        END IF
                        IF decimal2 = 0 THEN
                            decimal2 = 1
                            ip$ = ip$ + keypress$
                            inputlength = LEN(ip$)
                            decimalloc2 = LEN(ip$)
                        END IF
                        IF decimal3 = 0 THEN
                            decimal3 = 1
                            ip$ = ip$ + keypress$
                            inputlength = LEN(ip$)
                            decimalloc3 = LEN(ip$)
                        END IF
                    END IF
                    IF keypress$ >= CHR$(48) AND keypress$ <= CHR$(58) THEN
                        ip$ = ip$ + keypress$
                        inputlength = LEN(ip$)
                    END IF
                    IF keypress$ = CHR$(8) AND inputlength > 0 THEN
                        ip$ = MID$(ip$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                    IF inputlength < decimalloc3 THEN
                        decimal3 = 0
                    ELSE
                        IF inputlength < decimalloc2 THEN
                            decimal2 = 0
                        ELSE
                            IF inputlength < decimalloc1 THEN
                                decimal1 = 0
                            END IF
                        END IF
                    END IF
                LOOP UNTIL keypress$ = CHR$(13)
                IF decimalloc1 <> 4 OR decimalloc2 <> 8 OR decimalloc3 <> 10 THEN
                    ip$ = ""
                    inputlength = 0
                    EXIT DO
                END IF
                IF ip$ = "1" THEN
                    hostip$ = friend1ip$
                END IF
                IF ip$ = "2" THEN
                    hostip$ = friend2ip$
                END IF
                IF ip$ = "3" THEN
                    hostip$ = friend3ip$
                END IF
                IF ip$ = "4" THEN
                    hostip$ = friend4ip$
                END IF
                IF ip$ = "5" THEN
                    hostip$ = friend5ip$
                END IF
hostip$ = ip$
                exitloop = 1
                EXIT DO
            LOOP
            IF exitloop = 1 THEN EXIT DO
        LOOP
        host$ = "TCP/IP:7319:" + hostip$
        client = _OPENCLIENT(host$)
        IF client THEN
            DO
                CLS
                PRINT "You are connected"
                PRINT "Enter the name of your friend"
                PRINT ": "; friend$
                SLEEP
                keypress$ = INKEY$
                IF keypress$ = CHR$(27) THEN
                    GOTO BEGIN
                END IF
                IF keypress$ >= CHR$(48) AND keypress$ <= CHR$(58) THEN
                    friend$ = friend$ + keypress$
                    inputlength = LEN(friend$)
                END IF
                IF keypress$ = CHR$(8) AND inputlength > 0 THEN
                    friend$ = MID$(friend$, 1, (inputlength - 1))
                    inputlength = (inputlength - 1)
                END IF
                IF inputlength > 14 THEN
                    friend$ = MID$(friend$, 1, 14)
                    inputlength = 14
                END IF
            LOOP UNTIL keypress$ = CHR$(13)
            IF ip$ = "1" THEN
                friend1ip$ = hostip$
friend1$ = friend$
                OPEN "friend1.txt" FOR INPUT AS #1
                INPUT #1, friend1$
                INPUT #1, friend1ip$
                CLOSE #1
                OPEN "friend1.txt" FOR OUTPUT AS #1
                WRITE #1, name$
                WRITE #1, ip$
                CLOSE #1
            END IF
            IF ip$ = "2" THEN
                friend2ip$ = hostip$
            END IF
            IF ip$ = "3" THEN
                friend2ip$ = hostip$
            END IF
            IF ip$ = "4" THEN
                friend2ip$ = hostip$
            END IF
            IF ip$ = "5" THEN
                friend2ip$ = hostip$
            END IF
ELSE
CLS
PRINT "There is no connection"
PRINT "Either your friend isn't on or your internet isn't working"
PRINT "You can create your own server in the 'Become Host' section"
        END IF
    END IF
    IF keypress$ = CHR$(50) THEN
    END IF
LOOP
























