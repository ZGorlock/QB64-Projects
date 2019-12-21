DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetLastError~& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms679360(v=vs.85).aspx
    FUNCTION GetVersionExA& (BYVAL lpVersionInfo AS _UNSIGNED _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724451(v=vs.85).aspx
END DECLARE
DECLARE DYNAMIC LIBRARY "user32"
    FUNCTION GetDesktopWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633504(v=vs.85).aspx
    FUNCTION GetForegroundWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633505(v=vs.85).aspx
    FUNCTION OpenInputDesktop%& (BYVAL dwFlags AS _OFFSET, BYVAL fInherit AS _OFFSET, BYVAL dwDesiredAccess AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms684309(v=vs.85).aspx
    FUNCTION SetThreadDesktop%& (BYVAL hDesktop AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms686250(v=vs.85).aspx
    FUNCTION SystemParametersInfoW& (BYVAL uiAction AS _UNSIGNED LONG, BYVAL uiParam AS _UNSIGNED LONG, BYVAL pvParam AS _OFFSET, BYVAL fWinlni AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724947(v=vs.85).aspx
END DECLARE
DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName AS STRING) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633499(v=vs.85).aspx
END DECLARE

'$INCLUDE:'common_init.bi'
'$INCLUDE:'sprite_init.bi'

Programname = "untitled"
Version = 0.01
Ssloc = ""







REDIM sheetloc(2, 20) AS STRING
OPEN "male.txt" FOR INPUT AS #1
FOR a = 1 TO 20
    LINE INPUT #1, sheetloc(1, a)
NEXT a
CLOSE #1
OPEN "female.txt" FOR INPUT AS #1
FOR a = 1 TO 20
    LINE INPUT #1, sheetloc(2, a)
NEXT a
CLOSE #1

PRINT "loading sheets"
REDIM sheet(2, 20) AS INTEGER
FOR x = 1 TO 2
    FOR y = 1 TO 20
        sheet(x, y) = SPRITESHEETLOAD(sheetloc(x, y), 128, 128, SPRITE_NOTRANSPARENCY)
NEXT y, x

PRINT "loading sprites"
REDIM spr(2, 20, 8, 7) AS INTEGER
FOR gender = 1 TO 2
    FOR sheet = 1 TO 20
        FOR direction = 1 TO 8
            spr(gender, sheet, direction, 1) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 1, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 2) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 5, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 3) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 13, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 4) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 17, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 5) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 19, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 6) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 25, SPRITE_DONTSAVE)
            spr(gender, sheet, direction, 7) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 29, SPRITE_DONTSAVE)
            SPRITEANIMATESET spr(gender, sheet, direction, 1), (direction - 1) * 32 + 1, (direction - 1) * 32 + 4
            SPRITEANIMATESET spr(gender, sheet, direction, 2), (direction - 1) * 32 + 5, (direction - 1) * 32 + 12
            SPRITEANIMATESET spr(gender, sheet, direction, 3), (direction - 1) * 32 + 13, (direction - 1) * 32 + 16
            SPRITEANIMATESET spr(gender, sheet, direction, 4), (direction - 1) * 32 + 17, (direction - 1) * 32 + 18
            SPRITEANIMATESET spr(gender, sheet, direction, 5), (direction - 1) * 32 + 19, (direction - 1) * 32 + 24
            SPRITEANIMATESET spr(gender, sheet, direction, 6), (direction - 1) * 32 + 25, (direction - 1) * 32 + 28
            SPRITEANIMATESET spr(gender, sheet, direction, 7), (direction - 1) * 32 + 29, (direction - 1) * 32 + 32
            SPRITEANIMATION spr(gender, sheet, direction, 1), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 2), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 3), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 4), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 5), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 6), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION spr(gender, sheet, direction, 7), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            FOR d = 1 TO 7
                SPRITEZOOM spr(gender, sheet, direction, d), 200
            NEXT d
NEXT direction, sheet, gender
CLS
PAINT (1, 1), 4294769916
PCOPY 0, 1
direction = 8
stance = 1
head = 1
armour = 2
weapon = 1
sword = 1
bow = 1
staff = 1
shield = 1
DO
    _LIMIT 32
    counter = counter + 1

    IF counter MOD 4 = 0 THEN
        PCOPY 1, 0

        SELECT CASE head
            CASE 1
                SPRITEPLACE 200, 200, spr(1, 10, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 7, direction, stance)
            CASE 2
                SPRITEPLACE 200, 200, spr(1, 11, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 7, direction, stance)
            CASE 3
                SPRITEPLACE 200, 200, spr(1, 12, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 7, direction, stance)
        END SELECT
        SELECT CASE armour
            CASE 1
                SPRITEPLACE 200, 200, spr(1, 2, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 2, direction, stance)
            CASE 2
                SPRITEPLACE 200, 200, spr(1, 7, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 8, direction, stance)
            CASE 3
                SPRITEPLACE 200, 200, spr(1, 19, direction, stance)
                SPRITEPLACE 400, 200, spr(2, 17, direction, stance)
        END SELECT
        SELECT CASE weapon
            CASE 1
                SELECT CASE sword
                    CASE 1
                        SPRITEPLACE 200, 200, spr(1, 3, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 3, direction, stance)
                    CASE 2
                        SPRITEPLACE 200, 200, spr(1, 16, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 14, direction, stance)
                    CASE 3
                        SPRITEPLACE 200, 200, spr(1, 9, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 10, direction, stance)
                    CASE 4
                        SPRITEPLACE 200, 200, spr(1, 6, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 6, direction, stance)
                END SELECT
            CASE 2
                SELECT CASE bow
                    CASE 1
                        SPRITEPLACE 200, 200, spr(1, 15, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 13, direction, stance)
                    CASE 2
                        SPRITEPLACE 200, 200, spr(1, 8, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 9, direction, stance)
                    CASE 3
                        SPRITEPLACE 200, 200, spr(1, 4, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 4, direction, stance)
                    CASE 4
                        SPRITEPLACE 200, 200, spr(1, 17, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 15, direction, stance)
                END SELECT
            CASE 3
                SELECT CASE staff
                    CASE 1
                        SPRITEPLACE 200, 200, spr(1, 20, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 18, direction, stance)
                    CASE 2
                        SPRITEPLACE 200, 200, spr(1, 13, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 11, direction, stance)
                    CASE 3
                        SPRITEPLACE 200, 200, spr(1, 18, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 16, direction, stance)
                    CASE 4
                        SPRITEPLACE 200, 200, spr(1, 5, direction, stance)
                        SPRITEPLACE 400, 200, spr(2, 5, direction, stance)
                END SELECT
        END SELECT
        IF weapon <> 2 THEN
            SELECT CASE shield
                CASE 1
                    SPRITEPLACE 200, 200, spr(1, 1, direction, stance)
                    SPRITEPLACE 400, 200, spr(2, 1, direction, stance)
                CASE 2
                    SPRITEPLACE 200, 200, spr(1, 14, direction, stance)
                    SPRITEPLACE 400, 200, spr(2, 12, direction, stance)
            END SELECT
        END IF

        FOR align = 1 TO 20
            IF SPRITEANIMATIONCELL(spr(1, 9 + head, direction, stance)) <> SPRITEANIMATIONCELL(spr(1, align, direction, stance)) THEN SPRITEANIMATIONCELLSET spr(1, align, direction, stance), SPRITEANIMATIONCELL(spr(1, 9 + head, direction, stance))
            IF SPRITEANIMATIONCELL(spr(2, 7, direction, stance)) <> SPRITEANIMATIONCELL(spr(2, align, direction, stance)) THEN SPRITEANIMATIONCELLSET spr(2, align, direction, stance), SPRITEANIMATIONCELL(spr(2, 7, direction, stance))
        NEXT align

        IF stance > 2 THEN
            IF SPRITEANIMATIONCELL(spr(1, 9 + head, direction, stance)) = SPRITECELLS(spr(1, 1, direction, stance)) THEN stance = 1
        END IF

        _DISPLAY
    END IF

    k$ = INKEY$
    IF stance = 2 THEN stance = 1
    IF k$ > "" THEN
        SELECT CASE ASC(UCASE$(k$))
            CASE 49
                armour = armour + 1
                IF armour > 3 THEN armour = 1
            CASE 50
                shield = shield + 1
                IF shield > 2 THEN shield = 1
            CASE 51
                head = head + 1
                IF head > 3 THEN head = 1
            CASE 52
                sword = sword + 1
                IF sword > 4 THEN sword = 1
                weapon = 1
            CASE 53
                bow = bow + 1
                IF bow > 4 THEN bow = 1
                weapon = 2
            CASE 54
                staff = staff + 1
                IF staff > 4 THEN staff = 1
                weapon = 3
            CASE 65
                stance = 3
            CASE 66
                stance = 4
            CASE 68
                stance = 5
            CASE 83
                stance = 6
            CASE 86
                stance = 7
        END SELECT
        savestance = stance
        IF _KEYDOWN(18432) THEN direction = 3: stance = 2
        IF _KEYDOWN(19200) THEN direction = 1: stance = 2
        IF _KEYDOWN(19712) THEN direction = 5: stance = 2
        IF _KEYDOWN(20480) THEN direction = 7: stance = 2
        IF _KEYDOWN(18432) AND _KEYDOWN(19200) THEN direction = 2: stance = 2
        IF _KEYDOWN(20480) AND _KEYDOWN(19200) THEN direction = 8: stance = 2
        IF _KEYDOWN(20480) AND _KEYDOWN(19712) THEN direction = 6: stance = 2
        IF _KEYDOWN(18432) AND _KEYDOWN(19712) THEN direction = 4: stance = 2
        IF stance = 2 AND savestance > 1 THEN stance = savestance
    END IF

LOOP UNTIL k$ = CHR$(27)
FOR gender = 1 TO 2
    FOR sheet = 1 TO 20
        FOR direction = 1 TO 8
            FOR stance = 1 TO 7
                SPRITEFREE spr(gender, sheet, direction, stance)
NEXT stance, direction, sheet, gender
SYSTEM







cleanup:
CLOSE #32766
CLOSE #32767
CLOSE
CLEAR
SYSTEM
RETURN

help:
RETURN

sierr:
IF ERR = 70 THEN SYSTEM
GOTO sierrpass

errorhandler:
DIM printerror AS _BIT
DIM checkerror AS INTEGER
DIM errorcount AS INTEGER
DIM errornum AS INTEGER
errornum = ERR
printerror = TRUE
FOR checkerror = 1 TO UBOUND(errors)
    IF errors(checkerror).err = errornum AND errors(checkerror).line = _ERRORLINE THEN
        errors(checkerror).count = errors(checkerror).count + 1
        printerror = FALSE
        EXIT FOR
    END IF
NEXT checkerror
IF printerror THEN
    errorcount = UBOUND(errors) + 1
    PRINT #32766, TSTAMP; " - "; Module$; " - "; TRIMnum$(errornum); " ("; TRIMnum$(_ERRORLINE); ")"
    REDIM _PRESERVE errors(errorcount) AS errorhandle
    errors(errorcount).err = errornum
    errors(errorcount).line = _ERRORLINE
    errors(errorcount).count = 1
END IF
RESUME NEXT

'$INCLUDE:'common.bi'
'$INCLUDE:'sprite.bi'