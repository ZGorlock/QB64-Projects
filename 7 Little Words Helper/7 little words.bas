SCREEN 12
_TITLE "7 Little Words Helper"

CLS
PRINT "loading dictionary..."
_DISPLAY

DIM SHARED lex
lex = 118618

DIM SHARED lexicon$(lex)
OPEN "lexicon.txt" FOR INPUT AS #1
FOR lexicon = 1 TO lex
    LINE INPUT #1, lexicon$(lexicon)
NEXT lexicon
CLOSE #1

DIM SHARED size

start:
fragments = 0
REDIM fragments$(20)

DO
    _LIMIT 32
    CLS
    PRINT "This utility can help you find words for the game '7 Little Words'."
    PRINT "Enter all of the word fragments. Press End when you are done."
    PRINT ": "; fragment$
    PRINT
    FOR fragment = 1 TO 20
        PRINT UCASE$(fragments$(fragment))
    NEXT fragment
    k$ = INKEY$
    IF k$ = CHR$(27) THEN SYSTEM
    IF k$ = CHR$(13) AND LEN(fragment$) THEN
        fragments = fragments + 1
        fragments$(fragments) = LCASE$(fragment$)
        fragment$ = ""
    END IF
    IF k$ = CHR$(8) AND LEN(fragment$) THEN fragment$ = LEFT$(fragment$, LEN(fragment$) - 1)
    IF (k$ >= CHR$(65) AND k$ <= CHR$(90)) OR (k$ >= CHR$(97) AND k$ <= CHR$(122)) THEN fragment$ = fragment$ + k$
    IF k$ = (CHR$(0) + CHR$(79)) AND fragments THEN EXIT DO
    _DISPLAY
LOOP
CLS
PRINT "working..."
_DISPLAY

FOR sget = 1 TO fragments
    s = s + permutation(fragments, sget)
NEXT sget
REDIM possibilities$(s)

IF fragments > 1 THEN
    fragments = fragments - 1
    REDIM sn(fragments) AS _MEM
    FOR t = 0 TO fragments
        sn(t) = _MEMNEW(((fragments - t) + 1) * 2)
    NEXT t
    DIM m AS _UNSIGNED INTEGER
    FOR n = 0 TO fragments
        m = n
        _MEMPUT sn(0), sn(0).OFFSET + (n * 2), m
    NEXT n
    REDIM tl(fragments)
    q = 1
    DO
        FOR t = 0 TO cpos
            _MEMGET sn(t), sn(t).OFFSET + (tl(t) * 2), m
            possibilities$(q) = possibilities$(q) + RTRIM$(fragments$(m + 1))
        NEXT t
        IF cpos < fragments THEN
            cpos = cpos + 1
            ar = 0
            FOR r = 0 TO fragments - cpos + 1
                _MEMGET sn(cpos - 1), sn(cpos - 1).OFFSET + (r * 2), m
                IF r <> tl(cpos - 1) THEN
                    _MEMPUT sn(cpos), sn(cpos).OFFSET + (ar * 2), m
                    ar = ar + 1
                END IF
            NEXT r
        ELSE
            tl(fragments) = tl(fragments) + 1
            ar = 0
            FOR t = fragments TO 1 STEP -1
                IF tl(t) > ar THEN
                    tl(t) = 0
                    tl(t - 1) = tl(t - 1) + 1
                    cpos = cpos - 1
                END IF
                ar = ar + 1
            NEXT t
        END IF
        q = q + 1
        IF tl(0) > fragments THEN EXIT DO
    LOOP UNTIL q = UBOUND(possibilities$)
ELSE
    q = 1
    possibilities$(q) = fragments$(1)
END IF

words = 0
REDIM words$(32, s)
FOR check = 1 TO q
    CLS
    percent = INT((check / q) * 1000) / 10
    IF percent < 1 THEN
        percent$ = "00"
    ELSE IF percent < 10 THEN
            percent$ = "0"
        ELSE
            percent$ = ""
        END IF
    END IF
    PRINT "working: " + percent$ + LTRIM$(RTRIM$(STR$(percent)))
    LOCATE 1, 15
    PRINT "%"
    _DISPLAY
    IF possibilities$(check) > "" AND isword(possibilities$(check)) THEN 'isword(possibilities$(check), 1, lex) THEN
        words = words + 1
        words$(0, words) = possibilities$(check)
    END IF
NEXT check

IF words = 0 THEN
    DO
        CLS
        PRINT "No words were found. Press any key to retry. Press Escape to quit."
        k$ = INKEY$
        IF k$ = CHR$(27) THEN SYSTEM
        _DISPLAY
    LOOP UNTIL k$ > ""
    GOTO start
END IF

REDIM words(32)
FOR numsort = 1 TO words
    length = LEN(words$(0, numsort))
    words(length) = words(length) + 1
    words$(length, words(length)) = words$(0, numsort)
NEXT numsort
FOR lengths = 1 TO 32
    FOR alpsortx = 1 TO words(lengths)
        FOR alpsorty = 1 TO words(lengths)
            IF words$(lengths, alpsorty) > words$(lengths, alpsortx) THEN SWAP words$(lengths, alpsortx), words$(lengths, alpsorty)
NEXT alpsorty, alpsortx, lengths

printstream = 0
REDIM printstream$(words + 64)
FOR lengths = 1 TO 32
    IF words(lengths) THEN
        printstream = printstream + 1
        printstream$(printstream) = "-" + LTRIM$(RTRIM$(STR$(lengths))) + " Letters-"
        FOR wordsin = 1 TO words(lengths)
            printstream = printstream + 1
            printstream$(printstream) = UCASE$(words$(lengths, wordsin))
        NEXT wordsin
        printstream = printstream + 1
    END IF
NEXT lengths

row = 1
DO
    _LIMIT 32
    CLS
    PRINT "I found " + LTRIM$(RTRIM$(STR$(words))) + " words that exist in my dictionary."
    PRINT
    IF printstream < 25 THEN
        FOR printing = 1 TO printstream
            PRINT printstream$(printing)
        NEXT printing
    ELSE
        FOR printing = row TO row + 24
            PRINT printstream$(printing)
        NEXT printing
        LINE (635, 20)-STEP(0, 440), 8
        height = 25 / (printstream - 25)
        location = (20 + (row / (printstream - 25)) * 420) - (height / 2)
        LINE (632, location)-STEP(6, height), 15, BF
    END IF
    k$ = INKEY$
    IF k$ = CHR$(27) THEN SYSTEM
    DO
        row = row + _MOUSEWHEEL
    LOOP WHILE _MOUSEINPUT
    IF row < 1 THEN row = 1
    IF row > printstream - 25 THEN row = printstream - 25
    _DISPLAY
LOOP UNTIL k$ > ""
GOTO start

FUNCTION combination (m, n)
combination = factorial(m) / (factorial(n) * factorial(m - n))
END FUNCTION

FUNCTION factorial (n)
factorial = 1
FOR a = n TO 2 STEP -1
    factorial = factorial * a
NEXT a
END FUNCTION

FUNCTION isword (word$)
isword = 0
word$ = LCASE$(word$)
FOR lexicon = 1 TO lex
    IF lexicon$(lexicon) = word$ THEN
        isword = -1
        EXIT FUNCTION
    END IF
NEXT lexicon
END FUNCTION

'FUNCTION isword (word$, min, max)
'isword = 0
'IF max < min THEN
'    EXIT FUNCTION
'ELSE
'    mid = INT(((max - min + 1) / 2) + min)
'    IF lexicon$(mid) > word$ THEN
'        isword = isword(word$, min, mid - 1)
'    ELSE IF lexicon$(mid) < word$ THEN
'            isword = isword(word$, mid + 1, max)
'        ELSE
'            isword = -1
'        END IF
'    END IF
'END IF
'END FUNCTION

FUNCTION permutation (m, n)
permutation = factorial(m) / factorial(m - n)
END FUNCTION