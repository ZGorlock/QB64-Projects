_TITLE "Chronicles of Ardendore"
_SCREENMOVE _MIDDLE
DIM azerbaijani(65536) AS STRING
DIM basque(65536) AS STRING
DIM catalan(65536) AS STRING
DIM croatian(65536) AS STRING
DIM czech(65536) AS STRING
DIM danish(65536) AS STRING
DIM dutch(65536) AS STRING
DIM english(65536) AS STRING
DIM estonian(65536) AS STRING
DIM filipino(65536) AS STRING
DIM finnish(65536) AS STRING
DIM french(65536) AS STRING
DIM galacian(65536) AS STRING
DIM german(65536) AS STRING
DIM hatiancreole(65536) AS STRING
DIM hungarian(65536) AS STRING
DIM indonesian(65536) AS STRING
DIM irish(65536) AS STRING
DIM italian(65536) AS STRING
DIM lang(64) AS INTEGER
DIM langset(256) AS STRING
DIM language(65536) AS STRING
DIM latin(65536) AS STRING
DIM lavian(65536) AS STRING
DIM lithuanian(65536) AS STRING
DIM loading(65536) AS STRING
DIM malay(65536) AS STRING
DIM maltese(65536) AS STRING
DIM norwegian(65536) AS STRING
DIM persian(65536) AS STRING
DIM polish(65536) AS STRING
DIM portuguese(65536) AS STRING
DIM slovenian(65536) AS STRING
DIM spanish(65536) AS STRING
DIM swahili(65536) AS STRING
DIM swedish(65536) AS STRING
DIM turkish(65536) AS STRING
DIM vietnamese(65536) AS STRING
DIM welsh(65536) AS STRING
SCREEN 13
GOSUB load
SCREEN _NEWIMAGE(640, 480, 256)
prestart:
_SNDLOOP mainbgm
_SNDVOL mainbgm, volume
start:
DO
    _LIMIT 64
    CLS
    GOSUB bg
    PSET (47, 350), 7
    DRAW mainmenubox$
    PAINT (76, 366), 7
    PAINT (261, 366), 7
    PAINT (481, 366), 7
    PSET (47, 350), 0
    DRAW mainmenubox$
    _PUTIMAGE (20, 20), title
    _PUTIMAGE (75, 365), startbutton
    _PUTIMAGE (260, 365), optionsbutton
    _PUTIMAGE (480, 365), exitbutton
    GOSUB control
    IF lclick = 1 THEN
        IF (x > 47 AND x < 197) AND (y > 350 AND y < 425) THEN
            DO
                GOSUB mouse
            LOOP UNTIL lclick = 0

            bspl = 19
            strength = 1
            dexterity = 1
            luck = 1
            intelligence = 1
            wisdom = 1
            charisma = 1
            totalbasestats = 6
            DO
                DO
                    _LIMIT 64
                    CLS
                    GOSUB bg
                    PSET (15, 15), 7
                    DRAW textboxg1$
                    PAINT (16, 16), 7
                    PSET (15, 15), 0
                    DRAW textboxg1$
                    PSET (31, 31), 0
                    DRAW textboxg2$
                    PSET (28, 28), 0
                    DRAW textboxg6$
                    PSET (32, 90), 15
                    DRAW textboxg3$
                    PAINT (33, 91), 15
                    PSET (32, 90), 0
                    DRAW textboxg3$
                    PSET (332, 90), 0
                    DRAW textboxg4$
                    PSET (334, 94), 0
                    DRAW textboxg5$
                    PSET (182, 370), 0
                    DRAW basestatspread$
                    PSET (182, 370), 7
                    DRAW basestatspreadline1$
                    PSET (295, 174), 7
                    DRAW basestatspreadline2$
                    PSET (295, 306), 7
                    DRAW basestatspreadline3$
                    PSET (182, 110), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    PSET (295, 174), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    PSET (295, 306), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    PSET (182, 370), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    PSET (69, 306), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    PSET (69, 174), 8
                    FOR basestatspreadcircle = 1 TO 17
                        CIRCLE STEP(0, 0), basestatspreadcircle, 8
                    NEXT basestatspreadcircle
                    CIRCLE STEP(0, 0), 18, 0
                    strx = 182
                    stry = (240 - ((strength / totalbasestats) * 130))
                    dexrat = (dexterity / totalbasestats)
                    dexx = (182 - (dexrat * 112))
                    dexy = (240 - (dexrat * 66))
                    lukrat = (luck / totalbasestats)
                    lukx = (182 + (lukrat * 112))
                    luky = (240 - (lukrat * 66))
                    intrat = (intelligence / totalbasestats)
                    intx = (182 - (intrat * 112))
                    inty = (240 + (intrat * 66))
                    wisrat = (wisdom / totalbasestats)
                    wisx = (182 + (wisrat * 112))
                    wisy = (240 + (wisrat * 66))
                    chrx = 182
                    chry = (240 + ((charisma / totalbasestats) * 130))
                    PSET (strx, stry), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    PSET (dexx, dexy), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    PSET (lukx, luky), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    PSET (intx, inty), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    PSET (wisx, wisy), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    PSET (chrx, chry), 8
                    FOR statdot = 1 TO 2
                        CIRCLE STEP(0, 0), statdot, 8
                    NEXT statdot
                    CIRCLE STEP(0, 0), 3, 0
                    strtodexangle = ATN(((stry - dexy) / (strx - dexx)))
                    strtodexangle = strtodexangle * (180 / 3.1415926535)
                    strtodexangle = strtodexangle - 180
                    strtodexangle$ = STR$(strtodexangle)
                    strtodexangle$ = LTRIM$(strtodexangle$)
                    strtodexdis = SQR((((stry - dexy) ^ 2) + ((strx - dexx) ^ 2)))
                    strtodexdis$ = STR$(strtodexdis)
                    strtodexdis$ = LTRIM$(strtodexdis$)




                    PSET (strx, stry), 8
                    DRAW "TA" + strtodexangle$ + " U" + strtodexdis$ + "TA360"


                    COLOR 15, 7
                    LOCATE 3, 6
                    PRINT language$(58)
                    LOCATE 3, 48
                    PRINT language$(59); bspl; language$(60)
                    LOCATE 7, 44
                    PRINT statname$
                    IF overstrdot < 20 THEN COLOR 7, 15
                    LOCATE 9, 43
                    PRINT language$(68); strength
                    COLOR 15, 7
                    IF overdexdot < 20 THEN COLOR 7, 15
                    LOCATE 10, 43
                    PRINT language$(69); dexterity
                    COLOR 15, 7
                    IF overlukdot < 20 THEN COLOR 7, 15
                    LOCATE 11, 43
                    PRINT language$(70); luck
                    COLOR 15, 7
                    IF overintdot < 20 THEN COLOR 7, 15
                    LOCATE 12, 43
                    PRINT language$(71); intelligence
                    COLOR 15, 7
                    IF overwisdot < 20 THEN COLOR 7, 15
                    LOCATE 13, 43
                    PRINT language$(72); wisdom
                    COLOR 15, 7
                    IF overchrdot < 20 THEN COLOR 7, 15
                    LOCATE 14, 43
                    PRINT language$(73); charisma
                    COLOR 15, 7
                    LOCATE 23, 43
                    PRINT "Left Click (+)            c-reset"
                    LOCATE 24, 43
                    PRINT "Right Click (-)      Enter-accept"
                    GOSUB control
                    statname$ = language$(67)
                    overstrdot = SQR((((x - 182) ^ 2) + ((y - 110) ^ 2)))
                    overdexdot = SQR((((x - 69) ^ 2) + ((y - 174) ^ 2)))
                    overlukdot = SQR((((x - 295) ^ 2) + ((y - 174) ^ 2)))
                    overintdot = SQR((((x - 69) ^ 2) + ((y - 306) ^ 2)))
                    overwisdot = SQR((((x - 295) ^ 2) + ((y - 306) ^ 2)))
                    overchrdot = SQR((((x - 182) ^ 2) + ((y - 370) ^ 2)))
                    IF overstrdot < 20 THEN
                        statname$ = language$(61)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            strength = strength + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND strength > 1 THEN
                            bspl = bspl + 1
                            strength = strength - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF overdexdot < 20 THEN
                        statname$ = language$(62)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            dexterity = dexterity + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND dexterity > 1 THEN
                            bspl = bspl + 1
                            dexterity = dexterity - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF overlukdot < 20 THEN
                        statname$ = language$(63)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            luck = luck + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND luck > 1 THEN
                            bspl = bspl + 1
                            luck = luck - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF overintdot < 20 THEN
                        statname$ = language$(64)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            intelligence = intelligence + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND intelligence > 1 THEN
                            bspl = bspl + 1
                            intelligence = intelligence - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF overwisdot < 20 THEN
                        statname$ = language$(65)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            wisdom = wisdom + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND wisdom > 1 THEN
                            bspl = bspl + 1
                            wisdom = wisdom - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF overchrdot < 20 THEN
                        statname$ = language$(66)
                        IF lclick = 1 AND bspl > 0 THEN
                            bspl = bspl - 1
                            charisma = charisma + 1
                            totalbasestats = totalbasestats + 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL lclick = 0
                        END IF
                        IF rclick = 1 AND charisma > 1 THEN
                            bspl = bspl + 1
                            charisma = charisma - 1
                            totalbasestats = totalbasestats - 1
                            DO
                                GOSUB mouse
                            LOOP UNTIL rclick = 0
                        END IF
                    END IF
                    IF k$ = CHR$(99) OR k$ = CHR$(67) THEN
                        bspl = 19
                        totalbasestats = 6
                        strength = 1
                        dexterity = 1
                        luck = 1
                        intelligence = 1
                        wisdom = 1
                        charisma = 1
                    END IF
                    _DISPLAY
                LOOP UNTIL k$ = CHR$(13)
                DO
                    k$ = INKEY$
                LOOP UNTIL k$ = ""
                DO
                    _LIMIT 64
                    CLS
                    GOSUB bg
                    PSET (15, 15), 7
                    DRAW textboxg7$
                    PAINT (16, 16), 7
                    PSET (15, 15), 0
                    DRAW textboxg7$
                    PSET (25, 210), 0
                    DRAW textboxg8$
                    COLOR 15, 7
                    LOCATE 2, 4
                    PRINT language$(74)
                    LOCATE 3, 9
                    PRINT language$(75)
                    LOCATE 4, 9
                    PRINT language$(76)
                    LOCATE 6, 5
                    PRINT language$(77); strength
                    LOCATE 7, 5
                    PRINT language$(78); dexterity
                    LOCATE 8, 5
                    PRINT language$(79); luck
                    LOCATE 9, 5
                    PRINT language$(80); intelligence
                    LOCATE 10, 5
                    PRINT language$(81); wisdom
                    LOCATE 11, 5
                    PRINT language$(82); charisma
                    LOCATE 13, 4
                    PRINT language$(83)
                    GOSUB control
                    IF k$ = CHR$(121) OR k$ = CHR$(89) THEN
                        exitloop = 1
                        EXIT DO
                    END IF
                    IF k$ = CHR$(110) OR k$ = CHR$(78) THEN EXIT DO
                    _DISPLAY
                LOOP
                IF exitloop = 1 THEN EXIT DO
            LOOP
            exitloop = 0

        END IF
        IF (x > 244 AND x < 394) AND (y > 350 AND y < 425) THEN
            DO
                GOSUB mouse
            LOOP UNTIL lclick = 0
            DO
                _LIMIT 64
                CLS
                GOSUB bg
                PSET (15, 15), 7
                DRAW textboxo1$
                PAINT (16, 16), 7
                PSET (15, 15), 0
                DRAW textboxo1$
                COLOR 15, 7
                LOCATE 2, 4
                PRINT language$(1)
                LOCATE 3, 9
                PRINT language$(2)
                LOCATE 4, 9
                PRINT language$(3)
                LOCATE 5, 9
                PRINT language$(4)
                LOCATE 6, 9
                PRINT language$(5)
                LOCATE 7, 9
                PRINT language$(6)
                LOCATE 8, 9
                PRINT language$(20)
                LOCATE 9, 9
                PRINT language$(7)
                GOSUB control
                IF k$ = CHR$(49) OR ((x > 64 AND x < 208) AND (y > 32 AND y < 48) AND lclick = 1) THEN
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo3$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo3$
                        hours&& = INT(totime&& / 3600)
                        mins = INT((((totime&& / 3600) - hours&&) * 3600) / 60)
                        secs = INT((((((totime&& / 3600) - hours&&) * 3600) / 60) - mins) * 60)
                        hours$ = STR$(hours&&)
                        hours$ = RTRIM$(hours$)
                        mins$ = STR$(mins)
                        mins$ = RTRIM$(mins$)
                        secs$ = STR$(secs)
                        secs$ = RTRIM$(secs$)
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(11); uses&&; language$(12)
                        LOCATE 3, 4
                        PRINT language$(13); hours$; language$(14); mins$; language$(15); secs$; language$(16)
                        LOCATE 4, 4
                        PRINT language$(17); language$
                        LOCATE 5, 4
                        PRINT language$(18); volume
                        GOSUB control
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                END IF
                IF k$ = CHR$(50) OR ((x > 64 AND x < 200) AND (y > 48 AND y < 64) AND lclick = 1) THEN
                    row = 2
                    selected = 2
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo4$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo4$
                        PSET (15, 15), 0
                        DRAW textboxo5$
                        PSET (18, 47), 0
                        DRAW textboxo6$
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(19)
                        IF row + 24 < langs AND selected > row + 12 THEN
                            row = row + 1
                        END IF
                        IF row <> 2 AND selected < row + 12 THEN
                            row = row - 1
                        END IF
                        locset = 3
                        FOR langset = row TO (row + 24)
                            locset = locset + 1
                            LOCATE locset, 5
                            IF langset = selected THEN
                                COLOR 7, 15
                            ELSE
                                COLOR 15, 7
                            END IF
                            PRINT langset$(langset)
                        NEXT langset
                        nomouse = 1
                        GOSUB control
                        IF k$ = (CHR$(0) + CHR$(72)) AND selected <> 2 THEN selected = selected - 1
                        IF k$ = (CHR$(0) + CHR$(80)) AND selected <> langs THEN selected = selected + 1
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(13)
                    language$ = langset$(selected)
                    OPEN "user\main\language.txt" FOR OUTPUT AS #1
                    PRINT #1, language$
                    CLOSE #1
                    GOSUB language
                    GOSUB stopmouse
                    GOTO start
                END IF
                IF k$ = CHR$(51) OR ((x > 64 AND x < 184) AND (y > 64 AND y < 80) AND lclick = 1) THEN
                    swipex = INT(((volume * 200) + 220))
                    swipey = 80
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo2$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo2$
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(8); volume
                        LOCATE 3, 4
                        PRINT language$(9)
                        LOCATE 4, 4
                        PRINT language$(10)
                        PSET (220, swipey), 8
                        DRAW volumeswipeline$
                        FOR drawingswiper = 1 TO 10
                            CIRCLE (swipex, swipey), drawingswiper, 8
                        NEXT drawingswiper
                        GOSUB control
                        dis = SQR(((x - swipex) ^ 2) + ((y - 64) ^ 2))
                        IF lclick = 1 AND dis < 20 THEN
                            volume$ = ""
                            movingvolumeswipe = 1
                        END IF
                        IF lclick = 0 AND movingvolumeswipe = 1 THEN
                            movingvolumeswipe = 0
                            volume = ((swipex - 220) / 200)
                        END IF
                        IF x <> oldx AND (x >= 220 AND x <= 420) AND movingvolumeswipe = 1 THEN
                            swipex = x
                        END IF
                        IF movingvolumeswipe = 0 THEN
                            IF (k$ >= CHR$(48) AND k$ <= CHR$(57)) OR k$ = CHR$(46) THEN
                                volume$ = volume$ + k$
                                checkvolume = VAL(volume$)
                                IF checkvolume >= 0 AND checkvolume <= 1 THEN
                                    volume = checkvolume
                                ELSE
                                    volume$ = ""
                                END IF
                            END IF
                            IF k$ = CHR$(8) AND LEN(volume$) THEN
                                volume$ = MID$(volume$, 1, (LEN(volume$) - 1))
                                checkvolume = VAL(volume$)
                                IF checkvolume >= 0 AND checkvolume <= 1 THEN
                                    volume = checkvolume
                                ELSE
                                    volume$ = ""
                                END IF
                                justbackspace = 1
                            END IF
                            IF LEN(volume$) > 8 THEN volume$ = MID$(volume$, 1, 8)
                            IF justbackspace = 1 AND volume$ = CHR$(46) THEN volume$ = ""
                            swipex = INT(((volume * 200) + 220))
                        END IF
                        IF volume <> oldvolume THEN
                            OPEN "user\main\volume.txt" FOR OUTPUT AS #1
                            PRINT #1, volume
                            CLOSE #1
                            _SNDVOL mainbgm, volume
                        END IF
                        oldx = x
                        oldvolume = volume
                        justbackspace = 0
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(13)
                END IF
                IF k$ = CHR$(52) OR ((x > 64 AND x < 248) AND (y > 80 AND y < 96) AND lclick = 1) THEN
                    newname$ = ""
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo7$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo7$
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(21); name$
                        LOCATE 3, 4
                        PRINT language$(22)
                        LOCATE 4, 4
                        PRINT language$(23); newname$
                        GOSUB control
                        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN newname$ = newname$ + k$
                        IF k$ = CHR$(8) AND LEN(newname$) <> 0 THEN newname$ = MID$(newname$, 1, (LEN(newname$) - 1))
                        IF LEN(newname$) > 16 THEN newname$ = MID$(newname$, 1, 16)
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(13)
                    name$ = newname$
                    OPEN "user\char\name.txt" FOR OUTPUT AS #1
                    PRINT #1, name$
                    CLOSE #1
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo8$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo8$
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(24); name$
                        LOCATE 3, 4
                        PRINT language$(25)
                        GOSUB control
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(32)
                END IF
                IF k$ = CHR$(53) OR ((x > 64 AND x < 248) AND (y > 96 AND y < 112) AND lclick = 1) THEN
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo9$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo9$
                        COLOR 15, 7
                        LOCATE 2, 4
                        PRINT language$(26)
                        LOCATE 3, 9
                        PRINT language$(27)
                        LOCATE 4, 9
                        PRINT language$(28)
                        GOSUB control
                        IF k$ = CHR$(121) OR k$ = CHR$(89) THEN
                            DO
                                _LIMIT 64
                                CLS
                                GOSUB bg
                                PSET (15, 15), 7
                                DRAW textboxo10$
                                PAINT (16, 16), 7
                                PSET (15, 15), 0
                                DRAW textboxo10$
                                COLOR 15, 7
                                LOCATE 2, 4
                                PRINT language$(29)
                                LOCATE 3, 4
                                PRINT language$(30)
                                GOSUB control
                                IF k$ = CHR$(113) OR k$ = CHR$(81) THEN
                                    KILL "user\a"
                                    DO
                                        _LIMIT 64
                                        CLS
                                        GOSUB bg
                                        PSET (15, 15), 7
                                        DRAW textboxo11$
                                        PAINT (16, 16), 7
                                        PSET (15, 15), 0
                                        DRAW textboxo11$
                                        COLOR 15, 7
                                        LOCATE 2, 4
                                        PRINT language$(31)
                                        LOCATE 3, 4
                                        PRINT language$(32)
                                        LOCATE 4, 4
                                        PRINT language$(33)
                                        GOSUB control
                                        _DISPLAY
                                    LOOP UNTIL k$ = CHR$(32)
                                    CLEAR
                                    SYSTEM
                                END IF
                                IF k$ = CHR$(119) OR k$ = CHR$(87) THEN GOTO start
                                _DISPLAY
                            LOOP
                        END IF
                        IF k$ = CHR$(110) OR k$ = CHR$(78) THEN GOTO start
                        _DISPLAY
                    LOOP
                END IF
                IF k$ = CHR$(54) OR ((x > 64 AND x < 136) AND (y > 112 AND y < 128) AND lclick = 1) THEN
                    DO
                        _LIMIT 64
                        CLS
                        GOSUB bg
                        PSET (15, 15), 7
                        DRAW textboxo12$
                        PAINT (16, 16), 7
                        PSET (15, 15), 0
                        DRAW textboxo12$
                        COLOR 15, 7
                        centerfindstr$ = language$(34)
                        GOSUB findcenter
                        LOCATE 2, centerpos
                        PRINT language$(34)
                        LOCATE 4, 10
                        PRINT language$(35)
                        LOCATE 5, 30
                        PRINT language$(36)
                        LOCATE 7, 10
                        PRINT language$(37)
                        LOCATE 8, 30
                        PRINT language$(38)
                        LOCATE 9, 30
                        PRINT language$(39)
                        LOCATE 10, 30
                        PRINT language$(40)
                        LOCATE 12, 10
                        PRINT language$(44)
                        LOCATE 13, 20
                        PRINT language$(45)
                        LOCATE 14, 20
                        PRINT language$(46)
                        LOCATE 15, 20
                        PRINT language$(47)
                        LOCATE 16, 20
                        PRINT language$(48)
                        LOCATE 13, 50
                        PRINT language$(49)
                        LOCATE 14, 50
                        PRINT language$(50)
                        LOCATE 15, 50
                        PRINT language$(51)
                        LOCATE 18, 10
                        PRINT language$(52)
                        LOCATE 19, 30
                        PRINT language$(53)
                        LOCATE 24, 10
                        PRINT language$(41)
                        LOCATE 25, 10
                        PRINT language$(42)
                        LOCATE 26, 10
                        PRINT language$(43)
                        centerfindstr$ = language$(54)
                        GOSUB findcenter
                        LOCATE 28, centerpos
                        PRINT language$(54)
                        GOSUB control
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 1
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 1
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 2
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 3
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 4
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 5
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 6
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 7
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 8
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 9
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = 10
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = -1
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = -2
                            GOSUB bios
                        END IF
                        IF (x > x AND x < x) AND (y > y AND y < y) AND lclick = 1 THEN
                            bionum = -3
                            GOSUB bios
                        END IF
                        _DISPLAY
                    LOOP UNTIL k$ = CHR$(32)
                END IF
                IF k$ = CHR$(55) OR ((x > 64 AND x < 128) AND (y > 128 AND y < 144) AND lclick = 1) THEN
                    EXIT DO
                END IF
                _DISPLAY
            LOOP
        END IF
        IF (x > 441 AND x < 591) AND (y > 350 AND y < 425) THEN
            DO
                GOSUB mouse
            LOOP UNTIL lclick = 0
            CLEAR
            SYSTEM
        END IF
    END IF
    _DISPLAY
LOOP

bg:
IF helping = 0 THEN
    _PUTIMAGE (0, 0), mainbg
ELSE
    _PUTIMAGE (0, 0), helpbg
END IF
RETURN

bios:
SELECT CASE bionum
    CASE 1
    CASE 2
    CASE 3
    CASE 4
    CASE 5
    CASE 6
    CASE 7
    CASE 8
    CASE 9
    CASE 10
    CASE -1
        _CLIPBOARD$ = language$(55)
        DO
            _LIMIT 64
            CLS
            PRINT language$(55)
            GOSUB control
            _DISPLAY
        LOOP UNTIL k$ = CHR$(32)
    CASE -2
        _CLIPBOARD$ = language$(56)
        DO
            _LIMIT 64
            CLS
            PRINT language$(56)
            GOSUB control
            _DISPLAY
        LOOP UNTIL k$ = CHR$(32)
    CASE -3
        _CLIPBOARD$ = language$(57)
        DO
            _LIMIT 64
            CLS
            PRINT language$(57)
            GOSUB control
            _DISPLAY
        LOOP UNTIL k$ = CHR$(32)
END SELECT
DO
    _LIMIT 64
    GOSUB control
LOOP UNTIL k$ = ""
bionum = 0
RETURN

control:
k$ = INKEY$
IF k$ = CHR$(27) THEN
    GOSUB stopmusic
    GOSUB stopmouse
    VIEW PRINT
    GOTO prestart
END IF
IF k$ = (CHR$(0) + CHR$(59)) THEN
    mousehelping = 1
    GOSUB help
END IF
IF k$ = (CHR$(0) + CHR$(62)) THEN
    CLEAR
    SYSTEM
END IF
IF k$ = (CHR$(0) + CHR$(133)) THEN
    IF full = 1 THEN
        _FULLSCREEN _OFF
        full = 0
    ELSE
        _FULLSCREEN
        full = 1
    END IF
END IF
IF nomouse = 0 THEN GOSUB mouse
nomouse = 0
GOSUB usetime
ON ERROR GOTO errorhandler
RETURN

drawings:
mainmenubox$ = "R150 D75 L150 U75 R150 BR47 R150 D75 L150 U75 R150 BR47 R150 D75 L150 U75"
textboxg1$ = "R608 D390 L608 U390"
textboxg2$ = "R577 D18 L577 U18"
textboxg3$ = "R300 D300 L300 U300"
textboxg4$ = "R276 D300 L276 U300"
textboxg5$ = "R272 D18 L272 U18"
textboxg6$ = "R583 D366 L583 U366"
textboxg7$ = "R608 D448 L608 U448"
textboxg8$ = "R590 D245 L590 U245"
textboxo1$ = "R608 D131 L608 U131"
textboxo2$ = "R608 D93 L608 U93"
textboxo3$ = "R608 D65 L608 U65"
textboxo4$ = "R608 D448 L608 U448"
textboxo5$ = "R608 D17 L608 U17"
textboxo6$ = "R602 D413 L602 U413"
textboxo7$ = "R608 D49 L608 U49"
textboxo8$ = "R608 D33 L608 U33"
textboxo9$ = "R608 D49 L608 U49"
textboxo10$ = "R608 D33 L608 U33"
textboxo11$ = "R608 D49 L608 U49"
textboxo12$ = "R608 D448 L608 U448"
textboxh1$ = "R608 D448 L608 U448"
basestatspread$ = "TA300 U130 TA360 U130 TA420 U130 TA480 U130 TA540 U130 TA600 U130 TA360"
basestatspreadline1$ = "U260"
basestatspreadline2$ = "TA120 U260 TA360"
basestatspreadline3$ = "TA60 U260 TA360"
volumeswipeline$ = "R200"
RETURN

errorhandler:
_AUTODISPLAY
CLS
PRINT "The program has encountered an error an needs to close!"
PRINT "We are sorry for the inconvinience."
PRINT
PRINT "3..."
_DELAY 1
PRINT "2..."
_DELAY 1
PRINT "1..."
_DELAY 1
SYSTEM
RETURN

findcenter:
centerpos = ((80 - (LEN(centerfindstr$))) / 2)
RETURN

help:
GOSUB pausemusic
_SNDLOOP helpbgm
_SNDVOL helpbgm, volume
DO
    CLS
    helping = 1
    GOSUB bg
    PSET (15, 15), 11
    DRAW textboxh1$
    PAINT (16, 16), 11
    PSET (15, 15), 8
    DRAW textboxh1$
    COLOR 0, 11
    LOCATE 2, 4
    PRINT "<insert help menu>"
    helping = 0
    nomouse = 1
    GOSUB control
    _DISPLAY
LOOP UNTIL k$ = CHR$(32)
_SNDSTOP helpbgm
GOSUB playmusic
GOSUB stopmouse
RETURN

language:
SELECT CASE language$
    CASE "English"
        FOR langswitch = 1 TO lang(1)
            language$(langswitch) = english$(langswitch)
        NEXT langswitch
    CASE "Spanish"
        FOR langswitch = 1 TO lang(2)
            language$(langswitch) = spanish$(langswitch)
        NEXT langswitch
    CASE "French"
    CASE "German"
    CASE "Azerbaijani"
    CASE "Basque"
    CASE "Catalan"
    CASE "Croatian"
    CASE "Czech"
    CASE "Danish"
    CASE "Dutch"
    CASE "Estonian"
    CASE "Filipino"
    CASE "Finnish"
    CASE "Galacian"
    CASE "Haitian Creole"
    CASE "Hungarian"
    CASE "Indonesian"
    CASE "Irish"
    CASE "Italian"
    CASE "Latin"
    CASE "Latvian"
    CASE "Lithuanian"
    CASE "Malay"
    CASE "Maltese"
    CASE "Norwegian"
    CASE "Persian"
    CASE "Polish"
    CASE "Portuguese"
    CASE "Slovenian"
    CASE "Swahili"
    CASE "Swedish"
    CASE "Turkish"
    CASE "Vietnamese"
    CASE "Welsh"
    CASE ELSE
        FOR langswitch = 1 TO lang(1)
            language$(langswitch) = english$(langswitch)
        NEXT langswitch
END SELECT
RETURN

load:
GOSUB drawings
OPEN "data\main\loading.txt" FOR INPUT AS #1
loading = 1
DO UNTIL EOF(1)
    ON ERROR GOTO endofloading
    LINE INPUT #1, loading$(loading)
    loading = loading + 1
LOOP
endofloading:
loaded = 1
CLOSE #1
mainbgm = _SNDOPEN(loading$(loaded), "PAUSE, VOL, SYNC, LEN")
GOSUB loadbar
helpbgm = _SNDOPEN(loading$(loaded), "PAUSE, VOL, SYNC, LEN")
GOSUB loadbar
keypress = _SNDOPEN(loading$(loaded), "PAUSE, VOL, SYNC, LEN")
GOSUB loadbar
mainbg = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
helpbg = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
title = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
startbutton = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
optionsbutton = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
exitbutton = _LOADIMAGE(loading$(loaded))
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
langs = 1
DO UNTIL EOF(1)
    langs = langs + 1
    ON ERROR GOTO endoflangset
    LINE INPUT #1, langset$(langs)
LOOP
endoflangset:
CLOSE #1
GOSUB loadbar
FOR languageload = 1 TO 35
    OPEN loading$(loaded) FOR INPUT AS #1
    langload = 1
    DO UNTIL EOF(1)
        ON ERROR GOTO endoflangload
        SELECT CASE languageload
            CASE 1
                LINE INPUT #1, english$(langload)
            CASE 2
                LINE INPUT #1, spanish$(langload)
            CASE 3
                LINE INPUT #1, french$(langload)
            CASE 4
                LINE INPUT #1, german$(langload)
            CASE 5
                LINE INPUT #1, azerbaijani$(langload)
            CASE 6
                LINE INPUT #1, basque$(langload)
            CASE 7
                LINE INPUT #1, catalan$(langload)
            CASE 8
                LINE INPUT #1, croatian$(langload)
            CASE 9
                LINE INPUT #1, czech$(langload)
            CASE 10
                LINE INPUT #1, danish$(langload)
            CASE 11
                LINE INPUT #1, dutch$(langload)
            CASE 12
                LINE INPUT #1, estonian$(langload)
            CASE 13
                LINE INPUT #1, filipino$(langload)
            CASE 14
                LINE INPUT #1, finnish$(langload)
            CASE 15
                LINE INPUT #1, galacian$(langload)
            CASE 16
                LINE INPUT #1, hatiancreole$(langload)
            CASE 17
                LINE INPUT #1, hungarian$(langload)
            CASE 18
                LINE INPUT #1, indonesian$(langload)
            CASE 19
                LINE INPUT #1, irish$(langload)
            CASE 20
                LINE INPUT #1, italian$(langload)
            CASE 21
                LINE INPUT #1, latin$(langload)
            CASE 22
                LINE INPUT #1, latvian$(langload)
            CASE 23
                LINE INPUT #1, lithuanian$(langload)
            CASE 24
                LINE INPUT #1, malay$(langload)
            CASE 25
                LINE INPUT #1, maltese$(langload)
            CASE 26
                LINE INPUT #1, norwegian$(langload)
            CASE 27
                LINE INPUT #1, persian$(langload)
            CASE 28
                LINE INPUT #1, polish$(langload)
            CASE 29
                LINE INPUT #1, portuguese$(langload)
            CASE 30
                LINE INPUT #1, slovenian$(langload)
            CASE 31
                LINE INPUT #1, swahili$(langload)
            CASE 32
                LINE INPUT #1, swedish$(langload)
            CASE 33
                LINE INPUT #1, turkish$(langload)
            CASE 34
                LINE INPUT #1, vietnamese$(langload)
            CASE 35
                LINE INPUT #1, welsh$(langload)
        END SELECT
        langload = langload + 1
    LOOP
    endoflangload:
    lang(languageload) = langload
    CLOSE #1
    GOSUB loadbar
NEXT languageload
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, uses&&
CLOSE #1
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, totime&&
CLOSE #1
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, language$
CLOSE #1
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, volume
CLOSE #1
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, firsttime
CLOSE #1
GOSUB loadbar
OPEN loading$(loaded) FOR INPUT AS #1
INPUT #1, name$
CLOSE #1
GOSUB loadbar
GOSUB usecounter
GOSUB language
oldtime = TIMER
RETURN

loadbar:
loaded = loaded + 1
loadingprint$ = ">LOADING..." + CHR$(13) + ">"
loadingprint2$ = ""
IF loaded < 17 THEN
    FOR loadingprintcheck = 1 TO loaded
        loadingprint$ = loadingprint$ + CHR$(13) + ">" + loading$(loadingprintcheck)
    NEXT loadingprintcheck
ELSE
    FOR loadingprintcheck = (loaded - 16) TO loaded
        loadingprint$ = loadingprint$ + CHR$(13) + ">" + loading$(loadingprintcheck)
    NEXT loadingprintcheck
END IF
loadingbar = loaded / loading
lastloadingbar = INT(((loadingbar * 39) + 1))
FOR addloadingbar = 1 TO lastloadingbar
    loadingprint2$ = loadingprint2$ + CHR$(254)
NEXT addloadingbar
CLS
PRINT loadingprint$
LOCATE 20, 1
PRINT loadingprint2$
_DISPLAY
RETURN

mouse:
IF _MOUSEINPUT OR mousehelping = 1 THEN
    x = _MOUSEX
    y = _MOUSEY
    lclick = 0
    rclick = 0
    IF _MOUSEBUTTON(1) = -1 THEN lclick = 1
    IF _MOUSEBUTTON(2) = -1 THEN rclick = 1
END IF
IF x < 6 THEN
    x = 6
END IF
IF x > 634 THEN
    x = 634
END IF
IF y < 6 THEN
    y = 6
END IF
IF y > 474 THEN
    y = 474
END IF
GOSUB stopmouse
CIRCLE (x, y), 5, 0
RETURN

pausemusic:
mainbgmplaying = _SNDPLAYING(mainbgm)
IF mainbgmplaying = -1 THEN pausedmusic = mainbgm
_SNDPAUSE mainbgm
helpbgmplaying = _SNDPLAYING(helpbgm)
IF helpbgmplaying = -1 THEN pausedmusic = helpbgm
_SNDPAUSE helpbgm
RETURN

playmusic:
_SNDPLAY pausedmusic
RETURN

stopmouse:
DO WHILE _MOUSEINPUT
LOOP
RETURN

stopmusic:
mainbgmplaying = _SNDPLAYING(mainbgm)
IF mainbgmplaying = -1 THEN _SNDSTOP mainbgm
helpbgmplaying = _SNDPLAYING(helpbgm)
IF helpbgmplaying = -1 THEN _SNDSTOP helpbgm
RETURN

usecounter:
uses&& = uses&& + 1
OPEN "user\main\uses.txt" FOR OUTPUT AS #1
PRINT #1, uses&&
CLOSE #1
RETURN

usetime:
newtime = TIMER
addtime = newtime - oldtime
IF addtime >= 1 THEN
    IF addtime < 0 THEN addtime = 0
    totime&& = totime&& + addtime
    OPEN "user\main\time.txt" FOR OUTPUT AS #1
    PRINT #1, totime&&
    CLOSE #1
    oldtime = newtime
END IF
RETURN