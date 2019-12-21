SCREEN 0
SCREEN 12
_TITLE "Magic 4"
DO
    CLEAR
    DO
        DO
            DO
                CLS
                PRINT "Enter a number: "; startnum$
                DO
                    k$ = INKEY$
                LOOP UNTIL LEN(k$)
                IF k$ >= CHR$(47) AND k$ <= CHR$(58) THEN
                    startnum$ = startnum$ + k$
                    inputlength = LEN(startnum$)
                END IF
                IF k$ = CHR$(8) AND inputlength > 0 THEN
                    startnum$ = MID$(startnum$, 1, (inputlength - 1))
                    inputlength = (inputlength - 1)
                END IF
                IF inputlength > 6 THEN
                    startnum$ = MID$(startnum$, 1, 6)
                    inputlength = 6
                END IF
                IF k$ = CHR$(13) THEN
                    EXIT DO
                END IF
            LOOP
            REDIM digit$(6)
            FOR digit = 1 TO (LEN(startnum$))
                digit$(digit) = MID$(startnum$, (LEN(startnum$) - (digit - 1)), 1)
                IF digit$(digit) = "0" THEN
                    digit$(digit) = "zero"
                END IF
                IF digit$(digit) = "1" THEN
                    digit$(digit) = "one"
                END IF
                IF digit$(digit) = "2" THEN
                    digit$(digit) = "two"
                END IF
                IF digit$(digit) = "3" THEN
                    digit$(digit) = "three"
                END IF
                IF digit$(digit) = "4" THEN
                    digit$(digit) = "four"
                END IF
                IF digit$(digit) = "5" THEN
                    digit$(digit) = "five"
                END IF
                IF digit$(digit) = "6" THEN
                    digit$(digit) = "six"
                END IF
                IF digit$(digit) = "7" THEN
                    digit$(digit) = "seven"
                END IF
                IF digit$(digit) = "8" THEN
                    digit$(digit) = "eight"
                END IF
                IF digit$(digit) = "9" THEN
                    digit$(digit) = "nine"
                END IF
            NEXT digit
            IF LEN(startnum$) = 6 THEN
                IF digit$(6) = "zero" THEN
                    thousands$ = thousands$
                ELSE
                    thousands$ = digit$(6) + " hundred"
                    IF digit$(5) = "zero" AND digit$(4) = "zero" THEN
                        thousands$ = thousands$ + " thousand"
                    ELSE
                        IF digit$(5) = "zero" THEN
                            IF digit$(4) <> "zero" THEN
                                thousands$ = thousands$
                            END IF
                        ELSE
                            IF digit$(5) = "one" THEN
                                digit$(5) = "ten"
                                IF digit$(4) = "one" THEN
                                    digit$(5) = ""
                                    digit$(4) = "eleven"
                                END IF
                                IF digit$(4) = "two" THEN
                                    digit$(5) = ""
                                    digit$(4) = "twelve"
                                END IF
                                IF digit$(4) = "three" THEN
                                    digit$(5) = ""
                                    digit$(4) = "thirteen"
                                END IF
                                IF digit$(4) = "four" THEN
                                    digit$(5) = ""
                                    digit$(4) = "fourteen"
                                END IF
                                IF digit$(4) = "five" THEN
                                    digit$(5) = ""
                                    digit$(4) = "fifteen"
                                END IF
                                IF digit$(4) = "six" THEN
                                    digit$(5) = ""
                                    digit$(4) = "sixteen"
                                END IF
                                IF digit$(4) = "seven" THEN
                                    digit$(5) = ""
                                    digit$(4) = "seventeen"
                                END IF
                                IF digit$(4) = "eight" THEN
                                    digit$(5) = ""
                                    digit$(4) = "eighteen"
                                END IF
                                IF digit$(4) = "nine" THEN
                                    digit$(5) = ""
                                    digit$(4) = "nineteen"
                                END IF
                            END IF
                            IF digit$(5) = "two" THEN
                                digit$(5) = "twenty"
                            END IF
                            IF digit$(5) = "three" THEN
                                digit$(5) = "thirty"
                            END IF
                            IF digit$(5) = "four" THEN
                                digit$(5) = "fourty"
                            END IF
                            IF digit$(5) = "five" THEN
                                digit$(5) = "fifty"
                            END IF
                            IF digit$(5) = "six" THEN
                                digit$(5) = "sixty"
                            END IF
                            IF digit$(5) = "seven" THEN
                                digit$(5) = "seventy"
                            END IF
                            IF digit$(5) = "eight" THEN
                                digit$(5) = "eighty"
                            END IF
                            IF digit$(5) = "nine" THEN
                                digit$(5) = "ninty"
                            END IF
                            thousands$ = thousands$ + " " + digit$(5)
                        END IF
                        IF digit$(4) = "zero" THEN
                            thousands$ = thousands$
                        ELSE
                            thousands$ = thousands$ + "-" + digit$(4)
                        END IF
                        thousands$ = thousands$ + " thousand "
                    END IF
                END IF
                IF digit$(3) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = digit$(3) + " hundred"
                    IF digit$(2) = "zero" AND digit$(1) = "zero" THEN
                        hundreds$ = hundreds$ + " hundred"
                    ELSE
                        IF digit$(2) = "zero" THEN
                            IF digit$(1) <> "zero" THEN
                                hundreds$ = hundreds$
                            END IF
                        ELSE
                            IF digit$(2) = "one" THEN
                                digit$(2) = "ten"
                                IF digit$(1) = "one" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eleven"
                                END IF
                                IF digit$(1) = "two" THEN
                                    digit$(2) = ""
                                    digit$(1) = "twelve"
                                END IF
                                IF digit$(1) = "three" THEN
                                    digit$(2) = ""
                                    digit$(1) = "thirteen"
                                END IF
                                IF digit$(1) = "four" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fourteen"
                                END IF
                                IF digit$(1) = "five" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fifteen"
                                END IF
                                IF digit$(1) = "six" THEN
                                    digit$(2) = ""
                                    digit$(1) = "sixteen"
                                END IF
                                IF digit$(1) = "seven" THEN
                                    digit$(2) = ""
                                    digit$(1) = "seventeen"
                                END IF
                                IF digit$(1) = "eight" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eighteen"
                                END IF
                                IF digit$(1) = "nine" THEN
                                    digit$(2) = ""
                                    digit$(1) = "nineteen"
                                END IF
                            END IF
                            IF digit$(2) = "two" THEN
                                digit$(2) = "twenty"
                            END IF
                            IF digit$(2) = "three" THEN
                                digit$(2) = "thirty"
                            END IF
                            IF digit$(2) = "four" THEN
                                digit$(2) = "fourty"
                            END IF
                            IF digit$(2) = "five" THEN
                                digit$(2) = "fifty"
                            END IF
                            IF digit$(2) = "six" THEN
                                digit$(2) = "sixty"
                            END IF
                            IF digit$(2) = "seven" THEN
                                digit$(2) = "seventy"
                            END IF
                            IF digit$(2) = "eight" THEN
                                digit$(2) = "eighty"
                            END IF
                            IF digit$(2) = "nine" THEN
                                digit$(2) = "ninty"
                            END IF
                            hundreds$ = hundreds$ + " " + digit$(2)
                        END IF
                        IF digit$(1) = "zero" THEN
                            hundreds$ = hundreds$
                        ELSE
                            hundreds$ = hundreds$ + "-" + digit$(1)
                        END IF
                    END IF
                END IF
            END IF
            IF LEN(startnum$) = 5 THEN
                IF digit$(5) = "zero" AND digit$(4) = "zero" THEN
                    thousands$ = thousands$ + " thousand"
                ELSE
                    IF digit$(5) = "zero" THEN
                        IF digit$(4) <> "zero" THEN
                            thousands$ = thousands$
                        END IF
                    ELSE
                        IF digit$(5) = "one" THEN
                            digit$(5) = "ten"
                            IF digit$(4) = "one" THEN
                                digit$(5) = ""
                                digit$(4) = "eleven"
                            END IF
                            IF digit$(4) = "two" THEN
                                digit$(5) = ""
                                digit$(4) = "twelve"
                            END IF
                            IF digit$(4) = "three" THEN
                                digit$(5) = ""
                                digit$(4) = "thirteen"
                            END IF
                            IF digit$(4) = "four" THEN
                                digit$(5) = ""
                                digit$(4) = "fourteen"
                            END IF
                            IF digit$(4) = "five" THEN
                                digit$(5) = ""
                                digit$(4) = "fifteen"
                            END IF
                            IF digit$(4) = "six" THEN
                                digit$(5) = ""
                                digit$(4) = "sixteen"
                            END IF
                            IF digit$(4) = "seven" THEN
                                digit$(5) = ""
                                digit$(4) = "seventeen"
                            END IF
                            IF digit$(4) = "eight" THEN
                                digit$(5) = ""
                                digit$(4) = "eighteen"
                            END IF
                            IF digit$(4) = "nine" THEN
                                digit$(5) = ""
                                digit$(4) = "nineteen"
                            END IF
                        END IF
                        IF digit$(5) = "two" THEN
                            digit$(5) = "twenty"
                        END IF
                        IF digit$(5) = "three" THEN
                            digit$(5) = "thirty"
                        END IF
                        IF digit$(5) = "four" THEN
                            digit$(5) = "fourty"
                        END IF
                        IF digit$(5) = "five" THEN
                            digit$(5) = "fifty"
                        END IF
                        IF digit$(5) = "six" THEN
                            digit$(5) = "sixty"
                        END IF
                        IF digit$(5) = "seven" THEN
                            digit$(5) = "seventy"
                        END IF
                        IF digit$(5) = "eight" THEN
                            digit$(5) = "eighty"
                        END IF
                        IF digit$(5) = "nine" THEN
                            digit$(5) = "ninty"
                        END IF
                        thousands$ = thousands$ + " " + digit$(5)
                    END IF
                    IF digit$(4) = "zero" THEN
                        thousands$ = thousands$
                    ELSE
                        thousands$ = thousands$ + "-" + digit$(4)
                    END IF
                    thousands$ = thousands$ + " thousand "
                END IF
                IF digit$(3) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = digit$(3) + " hundred"
                    IF digit$(2) = "zero" AND digit$(1) = "zero" THEN
                        hundreds$ = hundreds$ + " hundred"
                    ELSE
                        IF digit$(2) = "zero" THEN
                            IF digit$(1) <> "zero" THEN
                                hundreds$ = hundreds$
                            END IF
                        ELSE
                            IF digit$(2) = "one" THEN
                                digit$(2) = "ten"
                                IF digit$(1) = "one" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eleven"
                                END IF
                                IF digit$(1) = "two" THEN
                                    digit$(2) = ""
                                    digit$(1) = "twelve"
                                END IF
                                IF digit$(1) = "three" THEN
                                    digit$(2) = ""
                                    digit$(1) = "thirteen"
                                END IF
                                IF digit$(1) = "four" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fourteen"
                                END IF
                                IF digit$(1) = "five" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fifteen"
                                END IF
                                IF digit$(1) = "six" THEN
                                    digit$(2) = ""
                                    digit$(1) = "sixteen"
                                END IF
                                IF digit$(1) = "seven" THEN
                                    digit$(2) = ""
                                    digit$(1) = "seventeen"
                                END IF
                                IF digit$(1) = "eight" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eighteen"
                                END IF
                                IF digit$(1) = "nine" THEN
                                    digit$(2) = ""
                                    digit$(1) = "nineteen"
                                END IF
                            END IF
                            IF digit$(2) = "two" THEN
                                digit$(2) = "twenty"
                            END IF
                            IF digit$(2) = "three" THEN
                                digit$(2) = "thirty"
                            END IF
                            IF digit$(2) = "four" THEN
                                digit$(2) = "fourty"
                            END IF
                            IF digit$(2) = "five" THEN
                                digit$(2) = "fifty"
                            END IF
                            IF digit$(2) = "six" THEN
                                digit$(2) = "sixty"
                            END IF
                            IF digit$(2) = "seven" THEN
                                digit$(2) = "seventy"
                            END IF
                            IF digit$(2) = "eight" THEN
                                digit$(2) = "eighty"
                            END IF
                            IF digit$(2) = "nine" THEN
                                digit$(2) = "ninty"
                            END IF
                            hundreds$ = hundreds$ + " " + digit$(2)
                        END IF
                        IF digit$(1) = "zero" THEN
                            hundreds$ = hundreds$
                        ELSE
                            hundreds$ = hundreds$ + "-" + digit$(1)
                        END IF
                    END IF
                END IF
            END IF
            IF LEN(startnum$) = 4 THEN
                IF digit$(4) = "zero" THEN
                    thousands$ = thousands$
                ELSE
                    thousands$ = thousands$ + digit$(4)
                END IF
                thousands$ = thousands$ + " thousand "
                IF digit$(3) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = digit$(3) + " hundred"
                    IF digit$(2) = "zero" AND digit$(1) = "zero" THEN
                        hundreds$ = hundreds$ + " hundred"
                    ELSE
                        IF digit$(2) = "zero" THEN
                            IF digit$(1) <> "zero" THEN
                                hundreds$ = hundreds$
                            END IF
                        ELSE
                            IF digit$(2) = "one" THEN
                                digit$(2) = "ten"
                                IF digit$(1) = "one" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eleven"
                                END IF
                                IF digit$(1) = "two" THEN
                                    digit$(2) = ""
                                    digit$(1) = "twelve"
                                END IF
                                IF digit$(1) = "three" THEN
                                    digit$(2) = ""
                                    digit$(1) = "thirteen"
                                END IF
                                IF digit$(1) = "four" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fourteen"
                                END IF
                                IF digit$(1) = "five" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fifteen"
                                END IF
                                IF digit$(1) = "six" THEN
                                    digit$(2) = ""
                                    digit$(1) = "sixteen"
                                END IF
                                IF digit$(1) = "seven" THEN
                                    digit$(2) = ""
                                    digit$(1) = "seventeen"
                                END IF
                                IF digit$(1) = "eight" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eighteen"
                                END IF
                                IF digit$(1) = "nine" THEN
                                    digit$(2) = ""
                                    digit$(1) = "nineteen"
                                END IF
                            END IF
                            IF digit$(2) = "two" THEN
                                digit$(2) = "twenty"
                            END IF
                            IF digit$(2) = "three" THEN
                                digit$(2) = "thirty"
                            END IF
                            IF digit$(2) = "four" THEN
                                digit$(2) = "fourty"
                            END IF
                            IF digit$(2) = "five" THEN
                                digit$(2) = "fifty"
                            END IF
                            IF digit$(2) = "six" THEN
                                digit$(2) = "sixty"
                            END IF
                            IF digit$(2) = "seven" THEN
                                digit$(2) = "seventy"
                            END IF
                            IF digit$(2) = "eight" THEN
                                digit$(2) = "eighty"
                            END IF
                            IF digit$(2) = "nine" THEN
                                digit$(2) = "ninty"
                            END IF
                            hundreds$ = hundreds$ + " " + digit$(2)
                        END IF
                        IF digit$(1) = "zero" THEN
                            hundreds$ = hundreds$
                        ELSE
                            hundreds$ = hundreds$ + "-" + digit$(1)
                        END IF
                    END IF
                END IF
            END IF
            IF LEN(startnum$) = 3 THEN
                IF digit$(3) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = digit$(3) + " hundred"
                    IF digit$(2) = "zero" AND digit$(1) = "zero" THEN
                        hundreds$ = hundreds$ + " hundred"
                    ELSE
                        IF digit$(2) = "zero" THEN
                            IF digit$(1) <> "zero" THEN
                                hundreds$ = hundreds$
                            END IF
                        ELSE
                            IF digit$(2) = "one" THEN
                                digit$(2) = "ten"
                                IF digit$(1) = "one" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eleven"
                                END IF
                                IF digit$(1) = "two" THEN
                                    digit$(2) = ""
                                    digit$(1) = "twelve"
                                END IF
                                IF digit$(1) = "three" THEN
                                    digit$(2) = ""
                                    digit$(1) = "thirteen"
                                END IF
                                IF digit$(1) = "four" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fourteen"
                                END IF
                                IF digit$(1) = "five" THEN
                                    digit$(2) = ""
                                    digit$(1) = "fifteen"
                                END IF
                                IF digit$(1) = "six" THEN
                                    digit$(2) = ""
                                    digit$(1) = "sixteen"
                                END IF
                                IF digit$(1) = "seven" THEN
                                    digit$(2) = ""
                                    digit$(1) = "seventeen"
                                END IF
                                IF digit$(1) = "eight" THEN
                                    digit$(2) = ""
                                    digit$(1) = "eighteen"
                                END IF
                                IF digit$(1) = "nine" THEN
                                    digit$(2) = ""
                                    digit$(1) = "nineteen"
                                END IF
                            END IF
                            IF digit$(2) = "two" THEN
                                digit$(2) = "twenty"
                            END IF
                            IF digit$(2) = "three" THEN
                                digit$(2) = "thirty"
                            END IF
                            IF digit$(2) = "four" THEN
                                digit$(2) = "fourty"
                            END IF
                            IF digit$(2) = "five" THEN
                                digit$(2) = "fifty"
                            END IF
                            IF digit$(2) = "six" THEN
                                digit$(2) = "sixty"
                            END IF
                            IF digit$(2) = "seven" THEN
                                digit$(2) = "seventy"
                            END IF
                            IF digit$(2) = "eight" THEN
                                digit$(2) = "eighty"
                            END IF
                            IF digit$(2) = "nine" THEN
                                digit$(2) = "ninty"
                            END IF
                            hundreds$ = hundreds$ + " " + digit$(2)
                        END IF
                        IF digit$(1) = "zero" THEN
                            hundreds$ = hundreds$
                        ELSE
                            hundreds$ = hundreds$ + "-" + digit$(1)
                        END IF
                    END IF
                END IF
            END IF
            IF LEN(startnum$) = 2 THEN
                IF digit$(2) = "zero" THEN
                    IF digit$(1) <> "zero" THEN
                        hundreds$ = hundreds$
                    END IF
                ELSE
                    IF digit$(2) = "one" THEN
                        digit$(2) = "ten"
                        IF digit$(1) = "one" THEN
                            digit$(2) = ""
                            digit$(1) = "eleven"
                        END IF
                        IF digit$(1) = "two" THEN
                            digit$(2) = ""
                            digit$(1) = "twelve"
                        END IF
                        IF digit$(1) = "three" THEN
                            digit$(2) = ""
                            digit$(1) = "thirteen"
                        END IF
                        IF digit$(1) = "four" THEN
                            digit$(2) = ""
                            digit$(1) = "fourteen"
                        END IF
                        IF digit$(1) = "five" THEN
                            digit$(2) = ""
                            digit$(1) = "fifteen"
                        END IF
                        IF digit$(1) = "six" THEN
                            digit$(2) = ""
                            digit$(1) = "sixteen"
                        END IF
                        IF digit$(1) = "seven" THEN
                            digit$(2) = ""
                            digit$(1) = "seventeen"
                        END IF
                        IF digit$(1) = "eight" THEN
                            digit$(2) = ""
                            digit$(1) = "eighteen"
                        END IF
                        IF digit$(1) = "nine" THEN
                            digit$(2) = ""
                            digit$(1) = "nineteen"
                        END IF
                    END IF
                    IF digit$(2) = "two" THEN
                        digit$(2) = "twenty"
                    END IF
                    IF digit$(2) = "three" THEN
                        digit$(2) = "thirty"
                    END IF
                    IF digit$(2) = "four" THEN
                        digit$(2) = "fourty"
                    END IF
                    IF digit$(2) = "five" THEN
                        digit$(2) = "fifty"
                    END IF
                    IF digit$(2) = "six" THEN
                        digit$(2) = "sixty"
                    END IF
                    IF digit$(2) = "seven" THEN
                        digit$(2) = "seventy"
                    END IF
                    IF digit$(2) = "eight" THEN
                        digit$(2) = "eighty"
                    END IF
                    IF digit$(2) = "nine" THEN
                        digit$(2) = "ninty"
                    END IF
                    hundreds$ = hundreds$ + " " + digit$(2)
                END IF
                IF digit$(1) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = hundreds$ + "-" + digit$(1)
                END IF
            END IF
            IF LEN(startnum$) = 1 THEN
                IF digit$(1) = "zero" THEN
                    hundreds$ = "zero"
                ELSE
                    hundreds$ = hundreds$ + digit$(1)
                END IF
            END IF
            startnumletter$ = thousands$ + hundreds$
            EXIT DO
        LOOP
        REDIM times$(100)
        REDIM timesletter$(100)
        CLS
        PRINT ">"; startnum$; " = "; startnumletter$
        times = LEN(startnumletter$)
        times$(0) = STR$(times)
        times$(0) = LTRIM$(times$(0))
        PRINT ">LEN("; startnumletter$; ") = "; times$(0)
        DO
            FOR times = 1 TO 100
                IF times$((times - 1)) = "1" THEN
                    timesletter$(times - 1) = "one"
                END IF
                IF times$((times - 1)) = "2" THEN
                    timesletter$(times - 1) = "two"
                END IF
                IF times$((times - 1)) = "3" THEN
                    timesletter$(times - 1) = "three"
                END IF
                IF times$((times - 1)) = "4" THEN
                    timesletter$(times - 1) = "four"
                END IF
                IF times$((times - 1)) = "5" THEN
                    timesletter$(times - 1) = "five"
                END IF
                IF times$((times - 1)) = "6" THEN
                    timesletter$(times - 1) = "six"
                END IF
                IF times$((times - 1)) = "7" THEN
                    timesletter$(times - 1) = "seven"
                END IF
                IF times$((times - 1)) = "8" THEN
                    timesletter$(times - 1) = "eight"
                END IF
                IF times$((times - 1)) = "9" THEN
                    timesletter$(times - 1) = "nine"
                END IF
                IF times$((times - 1)) = "10" THEN
                    timesletter$(times - 1) = "ten"
                END IF
                IF times$((times - 1)) = "11" THEN
                    timesletter$(times - 1) = "eleven"
                END IF
                IF times$((times - 1)) = "12" THEN
                    timesletter$(times - 1) = "twelve"
                END IF
                IF times$((times - 1)) = "13" THEN
                    timesletter$(times - 1) = "thirteen"
                END IF
                IF times$((times - 1)) = "14" THEN
                    timesletter$(times - 1) = "fourteen"
                END IF
                IF times$((times - 1)) = "15" THEN
                    timesletter$(times - 1) = "fifteen"
                END IF
                IF times$((times - 1)) = "16" THEN
                    timesletter$(times - 1) = "sixteen"
                END IF
                IF times$((times - 1)) = "17" THEN
                    timesletter$(times - 1) = "seventeen"
                END IF
                IF times$((times - 1)) = "18" THEN
                    timesletter$(times - 1) = "eighteen"
                END IF
                IF times$((times - 1)) = "19" THEN
                    timesletter$(times - 1) = "nineteen"
                END IF
                IF times$((times - 1)) = "20" THEN
                    timesletter$(times - 1) = "twenty"
                END IF
                IF times$((times - 1)) = "21" THEN
                    timesletter$(times - 1) = "twenty-one"
                END IF
                IF times$((times - 1)) = "22" THEN
                    timesletter$(times - 1) = "twenty-two"
                END IF
                IF times$((times - 1)) = "23" THEN
                    timesletter$(times - 1) = "twenty-three"
                END IF
                IF times$((times - 1)) = "24" THEN
                    timesletter$(times - 1) = "twenty-four"
                END IF
                IF times$((times - 1)) = "25" THEN
                    timesletter$(times - 1) = "twenty-five"
                END IF
                IF times$((times - 1)) = "26" THEN
                    timesletter$(times - 1) = "twenty-six"
                END IF
                IF times$((times - 1)) = "27" THEN
                    timesletter$(times - 1) = "twenty-seven"
                END IF
                IF times$((times - 1)) = "28" THEN
                    timesletter$(times - 1) = "twenty-eight"
                END IF
                IF times$((times - 1)) = "29" THEN
                    timesletter$(times - 1) = "twenty-nine"
                END IF
                IF times$((times - 1)) = "30" THEN
                    timesletter$(times - 1) = "thirty"
                END IF
                IF times$((times - 1)) = "31" THEN
                    timesletter$(times - 1) = "thirty-one"
                END IF
                IF times$((times - 1)) = "32" THEN
                    timesletter$(times - 1) = "thirty-two"
                END IF
                IF times$((times - 1)) = "33" THEN
                    timesletter$(times - 1) = "thirty-three"
                END IF
                IF times$((times - 1)) = "34" THEN
                    timesletter$(times - 1) = "thirty-four"
                END IF
                IF times$((times - 1)) = "35" THEN
                    timesletter$(times - 1) = "thirty-five"
                END IF
                IF times$((times - 1)) = "36" THEN
                    timesletter$(times - 1) = "thirty-six"
                END IF
                IF times$((times - 1)) = "37" THEN
                    timesletter$(times - 1) = "thirty-seven"
                END IF
                IF times$((times - 1)) = "38" THEN
                    timesletter$(times - 1) = "thirty-eight"
                END IF
                IF times$((times - 1)) = "39" THEN
                    timesletter$(times - 1) = "thirty-nine"
                END IF
                IF times$((times - 1)) = "40" THEN
                    timesletter$(times - 1) = "fourty"
                END IF
                IF times$((times - 1)) = "41" THEN
                    timesletter$(times - 1) = "fourty-one"
                END IF
                IF times$((times - 1)) = "42" THEN
                    timesletter$(times - 1) = "fourty-two"
                END IF
                IF times$((times - 1)) = "43" THEN
                    timesletter$(times - 1) = "fourty-three"
                END IF
                IF times$((times - 1)) = "44" THEN
                    timesletter$(times - 1) = "fourty-four"
                END IF
                IF times$((times - 1)) = "45" THEN
                    timesletter$(times - 1) = "fourty-five"
                END IF
                IF times$((times - 1)) = "46" THEN
                    timesletter$(times - 1) = "fourty-six"
                END IF
                IF times$((times - 1)) = "47" THEN
                    timesletter$(times - 1) = "fourty-seven"
                END IF
                IF times$((times - 1)) = "48" THEN
                    timesletter$(times - 1) = "fourty-eight"
                END IF
                IF times$((times - 1)) = "49" THEN
                    timesletter$(times - 1) = "fourty-nine"
                END IF
                IF times$((times - 1)) = "50" THEN
                    timesletter$(times - 1) = "fifty"
                END IF
                IF times$((times - 1)) = "51" THEN
                    timesletter$(times - 1) = "fifty-one"
                END IF
                IF times$((times - 1)) = "52" THEN
                    timesletter$(times - 1) = "fifty-two"
                END IF
                IF times$((times - 1)) = "53" THEN
                    timesletter$(times - 1) = "fifty-three"
                END IF
                IF times$((times - 1)) = "54" THEN
                    timesletter$(times - 1) = "fifty-four"
                END IF
                IF times$((times - 1)) = "55" THEN
                    timesletter$(times - 1) = "fifty-five"
                END IF
                IF times$((times - 1)) = "56" THEN
                    timesletter$(times - 1) = "fifty-six"
                END IF
                IF times$((times - 1)) = "57" THEN
                    timesletter$(times - 1) = "fifty-seven"
                END IF
                IF times$((times - 1)) = "58" THEN
                    timesletter$(times - 1) = "fifty-eight"
                END IF
                IF times$((times - 1)) = "59" THEN
                    timesletter$(times - 1) = "fifty-nine"
                END IF
                IF times$((times - 1)) = "60" THEN
                    timesletter$(times - 1) = "sixty"
                END IF
                IF times$((times - 1)) = "61" THEN
                    timesletter$(times - 1) = "sixty-one"
                END IF
                IF times$((times - 1)) = "62" THEN
                    timesletter$(times - 1) = "sixty-two"
                END IF
                times$(times) = STR$(LEN(timesletter$((times - 1))))
                times$(times) = LTRIM$(times$(times))
                PRINT ">"; times$((times - 1)); " = "; timesletter$((times - 1))
                PRINT ">LEN("; timesletter$((times - 1)); ") = "; times$(times)
                IF times$(times) = "4" THEN
                    EXIT DO
                END IF
            NEXT times
        LOOP
        PRINT ">4 = 4"
        DO
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
        LOOP UNTIL k$ = CHR$(32)
        EXIT DO
    LOOP
LOOP