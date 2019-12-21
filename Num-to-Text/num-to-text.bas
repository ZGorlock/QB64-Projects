SCREEN 0
SCREEN 12
_TITLE "Num To Text"
DO
    CLEAR
    DO
        DO
            DO
                CLS
                PRINT "Enter a number: "; num$
                SLEEP
                DO
                    key$ = INKEY$
                LOOP UNTIL LEN(key$)
                IF key$ >= CHR$(47) AND key$ <= CHR$(58) THEN
                    num$ = num$ + key$
                    inputlength = LEN(num$)
                END IF
                IF key$ = CHR$(8) AND inputlength > 0 THEN
                    num$ = MID$(num$, 1, (inputlength - 1))
                    inputlength = (inputlength - 1)
                END IF
                IF inputlength > 6 THEN
                    num$ = MID$(num$, 1, 6)
                    inputlength = 6
                END IF
                IF key$ = CHR$(13) THEN
                    EXIT DO
                END IF
            LOOP
            REDIM digit$(6)
            FOR digit = 1 TO (LEN(num$))
                digit$(digit) = MID$(num$, (LEN(num$) - (digit - 1)), 1)
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
            IF LEN(num$) = 6 THEN
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
            IF LEN(num$) = 5 THEN
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
                            hundreds$ = hundreds$ + digit$(2)
                        END IF
                        IF digit$(1) = "zero" THEN
                            hundreds$ = hundreds$
                        ELSE
                            hundreds$ = hundreds$ + "-" + digit$(1)
                        END IF
                    END IF
                END IF
            END IF
            IF LEN(num$) = 4 THEN
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
            IF LEN(num$) = 3 THEN
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
            IF LEN(num$) = 2 THEN
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
                    hundreds$ = hundreds$ + digit$(2)
                END IF
                IF digit$(1) = "zero" THEN
                    hundreds$ = hundreds$
                ELSE
                    hundreds$ = hundreds$ + "-" + digit$(1)
                END IF
            END IF
            IF LEN(num$) = 1 THEN
                IF digit$(1) = "zero" THEN
                    hundreds$ = "zero"
                ELSE
                    hundreds$ = hundreds$ + digit$(1)
                END IF
            END IF
            numletter$ = thousands$ + hundreds$
            EXIT DO
        LOOP
        DO
            CLS
            PRINT numletter$
            DO
                key$ = INKEY$
            LOOP UNTIL LEN(key$)
        LOOP UNTIL key$ = CHR$(32)
        EXIT DO
    LOOP
LOOP