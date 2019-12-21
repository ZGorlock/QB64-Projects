_TITLE "Name Caser
SCREEN 12
DO
    CLEAR
    DO
        CLS
        PRINT "Enter your name: "; name$
        DO
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        DO
            k$ = INKEY$
        LOOP UNTIL LEN(k$)
        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN name$ = name$ + k$
        IF k$ = CHR$(8) AND LEN(name$) <> 0 THEN name$ = MID$(name$, 1, (LEN(name$) - 1))
        IF LEN(name$) > 64 THEN name$ = MID$(name$, 1, (LEN(name$) - 1))
    LOOP UNTIL k$ = CHR$(13)
    namesave$ = name$
    FOR lowercase = 1 TO LEN(name$)
        character$ = MID$(name$, lowercase, 1)
        IF character$ >= CHR$(65) AND character$ <= CHR$(90) THEN character$ = CHR$((ASC(character$) + 32))
        IF character$ = CHR$(32) OR character$ = CHR$(39) OR character$ = CHR$(45) OR character$ = CHR$(46) OR (character$ >= CHR$(65) AND character$ <= CHR$(90)) OR (character$ >= CHR$(97) AND character$ <= CHR$(122)) OR (character$ >= CHR$(128) AND character$ <= CHR$(154)) OR (character$ >= CHR$(160) AND character$ <= CHR$(165)) THEN namex$ = namex$ + character$
    NEXT lowercase
    name$ = namex$
    DO
        nodisturb = 0
        IF INSTR(name$, "mr") AND MID$(name$, (INSTR(name$, "mr") + 2), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "mr") + 1)) + "." + MID$(name$, (INSTR(name$, "mr") + 2), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "dr") AND MID$(name$, (INSTR(name$, "dr") + 2), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "dr") + 1)) + "." + MID$(name$, (INSTR(name$, "dr") + 2), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "ms") AND MID$(name$, (INSTR(name$, "ms") + 2), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "ms") + 1)) + "." + MID$(name$, (INSTR(name$, "ms") + 2), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "mrs") AND MID$(name$, (INSTR(name$, "mrs") + 3), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "mrs") + 2)) + "." + MID$(name$, (INSTR(name$, "mrs") + 3), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "rev") AND MID$(name$, (INSTR(name$, "rev") + 3), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "rev") + 2)) + "." + MID$(name$, (INSTR(name$, "rev") + 3), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "phd") AND MID$(name$, (INSTR(name$, "phd") + 3), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "phd") + 2)) + "." + MID$(name$, (INSTR(name$, "phd") + 3), LEN(name$))
            nodisturb = 1
        END IF
        IF INSTR(name$, "prof") AND MID$(name$, (INSTR(name$, "prof") + 4), 1) <> CHR$(46) THEN
            name$ = MID$(name$, 1, (INSTR(name$, "prof") + 3)) + "." + MID$(name$, (INSTR(name$, "prof") + 4), LEN(name$))
            nodisturb = 1
        END IF
    LOOP UNTIL nodisturb = 0
    REDIM namesplit$(64)
    FOR namesplit = 1 TO LEN(name$)
        namesplit$(namesplit) = MID$(name$, namesplit, 1)
    NEXT namesplit
    REDIM spacecheck$(64)
    FOR spacecheck = 1 TO namesplit
        DO
            IF namesplit$(spacecheck) = CHR$(32) AND namesplit$(spacecheck + 1) = CHR$(32) THEN EXIT DO
            spacechecks = spacechecks + 1
            spacecheck$(spacechecks) = namesplit$(spacecheck)
            EXIT DO
        LOOP
    NEXT spacecheck
    FOR cap = 1 TO spacechecks
        IF cap = 1 THEN spacecheck$(cap) = uc$(spacecheck$(cap))
        IF spacecheck$(cap) = CHR$(32) THEN
            cap = cap + 1
            spacecheck$(cap) = uc$(spacecheck$(cap))
        END IF
        IF spacecheck$(cap) = CHR$(39) THEN
            cap = cap + 1
            spacecheck$(cap) = uc$(spacecheck$(cap))
        END IF
        IF cap > 3 THEN
            IF (spacecheck$(cap) = CHR$(99) AND spacecheck$(cap - 1) = CHR$(97) AND spacecheck$(cap - 2) = CHR$(77)) THEN
                cap = cap + 1
                spacecheck$(cap) = uc$(spacecheck$(cap))
            END IF
        END IF
        IF cap > 2 THEN
            IF (spacecheck$(cap) = CHR$(99) AND spacecheck$(cap - 1) = CHR$(77)) THEN
                cap = cap + 1
                spacecheck$(cap) = uc$(spacecheck$(cap))
            END IF
        END IF
    NEXT cap
    FOR sew = 1 TO spacechecks
        namere$ = namere$ + spacecheck$(sew)
    NEXT sew
    name$ = namere$
    REDIM chunks$(64)
    FOR chunker = 1 TO LEN(name$)
        chunk$ = MID$(name$, chunker, 1)
        IF chunk$ <> CHR$(32) THEN
            chunks = chunks + 1
            chunker = chunker - 1
            DO
                chunker = chunker + 1
                chunk$ = MID$(name$, chunker, 1)
                IF chunk$ = CHR$(32) THEN EXIT DO
                chunks$(chunks) = chunks$(chunks) + chunk$
            LOOP UNTIL chunker = LEN(name$)
        END IF
    NEXT chunker
    FOR chunkmod = 1 TO chunks
        SELECT CASE chunks$(chunkmod)
            CASE "Von"
                chunks$(chunkmod) = "von"
            CASE "De"
                chunks$(chunkmod) = "de"
            CASE "Ver"
                chunks$(chunkmod) = "ver"
            CASE "La"
                chunks$(chunkmod) = "la"
            CASE "Del"
                chunks$(chunkmod) = "del"
            CASE "Van"
                chunks$(chunkmod) = "van"
            CASE "Der"
                chunks$(chunkmod) = "der"
        END SELECT
    NEXT chunkmod
    FOR chunksew = 1 TO chunks
        nameer$ = nameer$ + chunks$(chunksew) + CHR$(32)
    NEXT chunksew
    name$ = nameer$
    name$ = MID$(name$, 1, (LEN(name$) - 1))
    CLS
    PRINT "Orignal Name: "; namesave$
    PRINT "Formatted Name: "; name$
    PRINT "Would you like to format another name? (y/n)"
    DO
        k$ = INKEY$
        IF k$ = CHR$(121) OR k$ = CHR$(89) OR k$ = CHR$(110) OR k$ = CHR$(78) THEN EXIT DO
    LOOP
LOOP UNTIL k$ = CHR$(110) OR k$ = CHR$(78)
SYSTEM

FUNCTION lc$ (ucc$)
SELECT CASE ASC(ucc$)
    CASE 65 TO 90
        lc$ = CHR$((ASC(ucc$) + 32))
    CASE 128
        lc$ = CHR$(135)
    CASE 142
        lc$ = CHR$(132)
    CASE 143
        lc$ = CHR$(134)
    CASE 144
        lc$ = CHR$(130)
    CASE 146
        lc$ = CHR$(145)
    CASE 153
        lc$ = CHR$(148)
    CASE 154
        lc$ = CHR$(129)
    CASE 165
        lc$ = CHR$(164)
    CASE ELSE
        lc$ = ucc$
END SELECT
END FUNCTION

FUNCTION uc$ (lcc$)
SELECT CASE ASC(lcc$)
    CASE 97 TO 122
        uc$ = CHR$((ASC(lcc$) - 32))
    CASE 135
        uc$ = CHR$(128)
    CASE 132
        uc$ = CHR$(142)
    CASE 134
        uc$ = CHR$(143)
    CASE 130
        uc$ = CHR$(144)
    CASE 145
        uc$ = CHR$(146)
    CASE 148
        uc$ = CHR$(153)
    CASE 129
        uc$ = CHR$(154)
    CASE 164
        uc$ = CHR$(165)
    CASE ELSE
        uc$ = lcc$
END SELECT
END FUNCTION