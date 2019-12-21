_TITLE "The Count"
SCREEN 0
SCREEN 12
OPEN "the count\save.txt" FOR INPUT AS #1
INPUT #1, A~&&
CLOSE #1
DO
    A~&& = A~&& + 1
    PRINT ": "; A~&&
    IF INKEY$ = "s" OR INKEY$ = "S" THEN
        OPEN "save.txt" FOR OUTPUT AS #1
        WRITE #1, A~&&
        CLOSE #1
    END IF
    IF INKEY$ = "c" OR INKEY$ = "C" THEN
        A~&& = 0
        OPEN "save.txt" FOR OUTPUT AS #1
        WRITE #1, A~&&
        CLOSE #1
    END IF
LOOP