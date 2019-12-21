'$include:'lib\spritetop.bi'

SCREEN _NEWIMAGE(640, 480, 32)

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
        sheet(x, y) = SPRITESHEETLOAD("..\..\..\" + sheetloc(x, y), 128, 128, SPRITE_NOTRANSPARENCY)
NEXT y, x

PRINT "loading sprites"
REDIM sprites(2, 20, 8, 7) AS INTEGER
FOR gender = 1 TO 2
    FOR sheet = 1 TO 20
        FOR direction = 1 TO 8
            sprites(gender, sheet, direction, 1) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 1, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 2) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 5, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 3) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 13, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 4) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 17, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 5) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 19, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 6) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 25, SPRITE_DONTSAVE)
            sprites(gender, sheet, direction, 7) = SPRITENEW(sheet(gender, sheet), (direction - 1) * 32 + 29, SPRITE_DONTSAVE)
            SPRITEANIMATESET sprites(gender, sheet, direction, 1), (direction - 1) * 32 + 1, (direction - 1) * 32 + 4
            SPRITEANIMATESET sprites(gender, sheet, direction, 2), (direction - 1) * 32 + 5, (direction - 1) * 32 + 12
            SPRITEANIMATESET sprites(gender, sheet, direction, 3), (direction - 1) * 32 + 13, (direction - 1) * 32 + 16
            SPRITEANIMATESET sprites(gender, sheet, direction, 4), (direction - 1) * 32 + 17, (direction - 1) * 32 + 18
            SPRITEANIMATESET sprites(gender, sheet, direction, 5), (direction - 1) * 32 + 19, (direction - 1) * 32 + 24
            SPRITEANIMATESET sprites(gender, sheet, direction, 6), (direction - 1) * 32 + 25, (direction - 1) * 32 + 28
            SPRITEANIMATESET sprites(gender, sheet, direction, 7), (direction - 1) * 32 + 29, (direction - 1) * 32 + 32
            SPRITEANIMATION sprites(gender, sheet, direction, 1), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 2), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 3), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 4), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 5), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 6), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            SPRITEANIMATION sprites(gender, sheet, direction, 7), SPRITE_ANIMATE, SPRITE_FORWARDLOOP
            FOR d = 1 TO 7
                SPRITEZOOM sprites(gender, sheet, direction, d), 300
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
                SPRITEPUT 200, 200, sprites(1, 10, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 7, direction, stance)
            CASE 2
                SPRITEPUT 200, 200, sprites(1, 11, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 7, direction, stance)
            CASE 3
                SPRITEPUT 200, 200, sprites(1, 12, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 7, direction, stance)
        END SELECT
        SELECT CASE armour
            CASE 1
                SPRITEPUT 200, 200, sprites(1, 2, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 2, direction, stance)
            CASE 2
                SPRITEPUT 200, 200, sprites(1, 7, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 8, direction, stance)
            CASE 3
                SPRITEPUT 200, 200, sprites(1, 19, direction, stance)
                SPRITEPUT 400, 200, sprites(2, 17, direction, stance)
        END SELECT
        SELECT CASE weapon
            CASE 1
                SELECT CASE sword
                    CASE 1
                        SPRITEPUT 200, 200, sprites(1, 3, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 3, direction, stance)
                    CASE 2
                        SPRITEPUT 200, 200, sprites(1, 16, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 14, direction, stance)
                    CASE 3
                        SPRITEPUT 200, 200, sprites(1, 9, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 10, direction, stance)
                    CASE 4
                        SPRITEPUT 200, 200, sprites(1, 6, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 6, direction, stance)
                END SELECT
            CASE 2
                SELECT CASE bow
                    CASE 1
                        SPRITEPUT 200, 200, sprites(1, 15, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 13, direction, stance)
                    CASE 2
                        SPRITEPUT 200, 200, sprites(1, 8, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 9, direction, stance)
                    CASE 3
                        SPRITEPUT 200, 200, sprites(1, 4, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 4, direction, stance)
                    CASE 4
                        SPRITEPUT 200, 200, sprites(1, 17, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 15, direction, stance)
                END SELECT
            CASE 3
                SELECT CASE staff
                    CASE 1
                        SPRITEPUT 200, 200, sprites(1, 20, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 18, direction, stance)
                    CASE 2
                        SPRITEPUT 200, 200, sprites(1, 13, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 11, direction, stance)
                    CASE 3
                        SPRITEPUT 200, 200, sprites(1, 18, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 16, direction, stance)
                    CASE 4
                        SPRITEPUT 200, 200, sprites(1, 5, direction, stance)
                        SPRITEPUT 400, 200, sprites(2, 5, direction, stance)
                END SELECT
        END SELECT
        IF weapon <> 2 THEN
            SELECT CASE shield
                CASE 1
                    SPRITEPUT 200, 200, sprites(1, 1, direction, stance)
                    SPRITEPUT 400, 200, sprites(2, 1, direction, stance)
                CASE 2
                    SPRITEPUT 200, 200, sprites(1, 14, direction, stance)
                    SPRITEPUT 400, 200, sprites(2, 12, direction, stance)
            END SELECT
        END IF

        FOR align = 1 TO 20
            IF SPRITEANIMATIONCELL(sprites(1, 9 + head, direction, stance)) <> SPRITEANIMATIONCELL(sprites(1, align, direction, stance)) THEN SPRITEANIMATIONCELLSET sprites(1, align, direction, stance), SPRITEANIMATIONCELL(sprites(1, 9 + head, direction, stance))
            IF SPRITEANIMATIONCELL(sprites(2, 7, direction, stance)) <> SPRITEANIMATIONCELL(sprites(2, align, direction, stance)) THEN SPRITEANIMATIONCELLSET sprites(2, align, direction, stance), SPRITEANIMATIONCELL(sprites(2, 7, direction, stance))
        NEXT align

        IF stance > 2 THEN
            IF SPRITEANIMATIONCELL(sprites(1, 9 + head, direction, stance)) = SPRITECELLS(sprites(1, 1, direction, stance)) THEN stance = 1
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
                SPRITEFREE sprites(gender, sheet, direction, stance)
NEXT stance, direction, sheet, gender
SYSTEM

'$include:'lib\sprite.bi'