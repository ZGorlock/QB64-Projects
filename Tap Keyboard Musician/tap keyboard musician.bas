SCREEN 0
SCREEN 12
_TITLE "Tap Musician"
accuracybarrank$ = "R10"
accuracybarline$ = "D80"
flowline$ = "D230"
bound$ = "R360"
combocountbox$ = "D250 R10 U250 L10"
crosshairs$ = "U35 D35 L35 R70 L35 D35"
crosshairs2$ = "U35 D70 U35 L35 R70"
progressionbox$ = "D12 R400 U12 L400"
tapstrip(1) = 12
tapstrip(2) = 10
tapstrip(3) = 9
tapstrip(4) = 14
tapstrip2(1) = 4
tapstrip2(2) = 2
tapstrip2(3) = 1
tapstrip2(4) = 6
BEGIN:
DO
    k$ = INKEY$
LOOP UNTIL k$ = ""
DO
    CLS
    PRINT "Welcome to Tap Musician!"
    PRINT "     1-Play"
    PRINT "     2-Record"
    PRINT "     3-Scores"
    _DISPLAY
    DO
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
    GOSUB controls
    IF k$ = CHR$(49) THEN
        selected = 1
        OPEN "tap musician\songs\nos.txt" FOR INPUT AS #1
        INPUT #1, nos
        CLOSE #1
        inputcount = 0
        REDIM songlist$(32768)
        OPEN "tap musician\songs\list.txt" FOR INPUT AS #1
        DO UNTIL EOF(1)
            inputcount = inputcount + 1
            LINE INPUT #1, songlist$(inputcount)
            IF inputcount = nos THEN EXIT DO
        LOOP
        CLOSE #1
        row = 1
        DO
            CLS
            PRINT "Select the song you wish to play"
            VIEW PRINT 3 TO 27
            IF nos > 27 THEN
                DO
                    k$ = INKEY$
                    DO WHILE _MOUSEINPUT
                        row = row + (_MOUSEWHEEL * 3)
                        IF prevrow <> row THEN
                            IF row < 1 THEN
                                row = 1
                            END IF
                            IF row > (nos - 24) THEN
                                row = (nos - 24)
                            END IF
                            CLS 2
                            FOR n = row TO row + 24
                                IF n = selected THEN
                                    COLOR 0, 15
                                ELSE
                                    COLOR 15, 0
                                END IF
                                PRINT songlist$(n)
                            NEXT
                            _DISPLAY
                        END IF
                        prevrow = row
                    LOOP
                LOOP UNTIL LEN(k$)
            ELSE
                DO
                    k$ = INKEY$
                    row = 1
                    CLS 2
                    FOR n = row TO nos
                        IF n = selected THEN
                            COLOR 0, 15
                        ELSE
                            COLOR 15, 0
                        END IF
                        PRINT songlist$(n)
                    NEXT
                    _DISPLAY
                    GOSUB controls
                    xx1 = 1
                LOOP UNTIL LEN(k$)
            END IF
            VIEW PRINT
            IF k$ = CHR$(0) + CHR$(72) THEN selected = selected - 1
            IF k$ = CHR$(0) + CHR$(80) THEN selected = selected + 1
            IF selected < 1 THEN selected = 1
            IF selected > nos THEN selected = nos
        LOOP UNTIL k$ = CHR$(13)
        song$ = songlist$(selected)
        PRINT song$
        songfile$ = "tap musician\songs\data\" + song$ + ".txt"
        OPEN songfile$ FOR INPUT AS #1
        INPUT #1, blah$
        INPUT #1, endit
        CLOSE #1
        IF songaudio = -1 THEN
            _SNDCLOSE songaudio
        END IF
        songaudio = _SNDOPEN(blah$, "PAUSE, LEN, SYNC")
        inputcount = 0
        DIM songinfo$(32768)
        OPEN songfile$ FOR INPUT AS #1
        DO UNTIL EOF(1)
            inputcount = inputcount + 1
            LINE INPUT #1, songinfo$(inputcount)
            IF inputcount = endit THEN EXIT DO
        LOOP
        CLOSE #1
        DIM noteinfo$(32768)
        DIM rednote$(32768)
        DIM greennote$(32768)
        DIM bluenote$(32768)
        DIM yellownote$(32768)
        DIM rn(32768)
        DIM gn(32768)
        DIM bn(32768)
        DIM yn(32768)
        FOR noteinfo = 3 TO inputcount
            noteinfo$((noteinfo - 2)) = songinfo$(noteinfo)
        NEXT noteinfo
        FOR notes = 1 TO endit
            rednote$(notes) = MID$(noteinfo$(notes), 1, 1)
            IF rednote$(notes) = "" THEN rednote$(notes) = "0"
            greennote$(notes) = MID$(noteinfo$(notes), 2, 1)
            IF greennote$(notes) = "" THEN greennote$(notes) = "0"
            bluenote$(notes) = MID$(noteinfo$(notes), 3, 1)
            IF bluenote$(notes) = "" THEN bluenote$(notes) = "0"
            yellownote$(notes) = MID$(noteinfo$(notes), 4, 1)
            IF yellownote$(notes) = "" THEN yellownote$(notes) = "0"
            rn(notes) = VAL(rednote$(notes))
            gn(notes) = VAL(greennote$(notes))
            bn(notes) = VAL(bluenote$(notes))
            yn(notes) = VAL(yellownote$(notes))
        NEXT notes
        paused = 0
        combo = 0
        multipliar = 1
        combocount = 0
        loopcount = 0
        started = 0
        timetocheck = 0
        songstart = 0
        accuracyball = 0
        tapcolor(1) = 15
        tapcolor(2) = 15
        tapcolor(3) = 15
        tapcolor(4) = 15
        tapcolor2(1) = 7
        tapcolor2(2) = 7
        tapcolor2(3) = 7
        tapcolor2(4) = 7
        combocount(1) = -1
        combocount(2) = -1
        combocount(3) = -1
        combocount(4) = -1
        combocount(5) = -1
        combocount(6) = -1
        combocount(7) = -1
        combocount(8) = -1
        combocount(9) = -1
        combocount(10) = -1
        redfirst = 1
        greenfirst = 1
        bluefirst = 1
        yellowfirst = 1
        perfect = 0
        great = 0
        good = 0
        poor = 0
        miss = 0
        score&& = 0
        DIM redsleepnote(32768)
        DIM greensleepnote(32768)
        DIM bluesleepnote(32768)
        DIM yellowsleepnote(32768)
        DIM denotaion$(4)
        denotation$(1) = ""
        denotation$(2) = ""
        denotation$(3) = ""
        denotation$(4) = ""
        DO
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        _SNDPLAY songaudio
        songplaying = _SNDPLAYING(songaudio)
        totalsonglength = _SNDLEN(songaudio)
        length = _SNDLEN(songaudio)
        minutes = INT((length / 60))
        minutes$ = STR$(minutes)
        minutes$ = LTRIM$(minutes$)
        seconds = INT((length - (minutes * 60)))
        seconds$ = STR$(seconds)
        seconds$ = LTRIM$(seconds$)
        digitseconds = LEN(seconds$)
        IF digitseconds = 1 THEN
            seconds$ = "0" + seconds$
        END IF
        totaltime$ = minutes$ + ":" + seconds$
        DO
            _LIMIT 64
            songpause = _KEYDOWN(32)
            red = _KEYDOWN(118)
            green = _KEYDOWN(98)
            blue = _KEYDOWN(110)
            yellow = _KEYDOWN(109)
            IF songpause = -1 THEN
                paused = 1
            END IF
            IF red = -1 THEN
                reddown = 1
                press(1) = 1
            ELSE
                redpress = 1
                press(1) = 0
            END IF
            IF green = -1 THEN
                greendown = 1
                press(2) = 1
            ELSE
                greenpress = 1
                press(2) = 0
            END IF
            IF blue = -1 THEN
                bluedown = 1
                press(3) = 1
            ELSE
                bluepress = 1
                press(3) = 0
            END IF
            IF yellow = -1 THEN
                yellowdown = 1
                press(4) = 1
            ELSE
                yellowpress = 1
                press(4) = 0
            END IF
            IF combo < 50 THEN
                tap(1) = 12
                tap(2) = 10
                tap(3) = 9
                tap(4) = 14
                tap2(1) = 4
                tap2(2) = 2
                tap2(3) = 1
                tap2(4) = 6
            END IF
            IF combo >= 50 AND combo < 100 THEN
                tap(1) = 12
                tap(2) = 12
                tap(3) = 12
                tap(4) = 12
                tap2(1) = 4
                tap2(2) = 4
                tap2(3) = 4
                tap2(4) = 4
            END IF
            IF combo >= 100 AND combo < 200 THEN
                tap(1) = 10
                tap(2) = 10
                tap(3) = 10
                tap(4) = 10
                tap2(1) = 2
                tap2(2) = 2
                tap2(3) = 2
                tap2(4) = 2
            END IF
            IF combo >= 201 AND combo < 500 THEN
                tap(1) = 9
                tap(2) = 9
                tap(3) = 9
                tap(4) = 9
                tap2(1) = 1
                tap2(2) = 1
                tap2(3) = 1
                tap2(4) = 1
            END IF
            IF combo >= 500 AND combo < 1000 THEN
                tap(1) = 14
                tap(2) = 14
                tap(3) = 14
                tap(4) = 14
                tap2(1) = 6
                tap2(2) = 6
                tap2(3) = 6
                tap2(4) = 6
            END IF
            IF combo >= 1000 THEN
                tap(1) = 15
                tap(2) = 15
                tap(3) = 15
                tap(4) = 15
                tap2(1) = 7
                tap2(2) = 7
                tap2(3) = 7
                tap2(4) = 7
            END IF
            IF combo < 20 THEN
                multipliar = 1
                space = 20
            END IF
            IF combo >= 20 AND combo < 30 THEN
                multipliar = 2
                space = 30
            END IF
            IF combo >= 30 AND combo < 40 THEN
                multipliar = 3
                space = 40
            END IF
            IF combo >= 40 AND combo < 50 THEN
                multipliar = 4
                space = 50
            END IF
            IF combo >= 50 AND combo < 100 THEN
                multipliar = 5
                space = 100
            END IF
            IF combo >= 100 AND combo < 200 THEN
                multipliar = 10
                space = 200
            END IF
            IF combo >= 200 AND combo < 500 THEN
                multipliar = 20
                space = 500
            END IF
            IF combo >= 500 AND combo < 1000 THEN
                multipliar = 50
                space = 1000
            END IF
            IF combo >= 1000 AND combo < 2500 THEN
                multipliar = 100
                space = 2500
            END IF
            IF combo >= 2500 AND combo < 5000 THEN
                multipliar = 250
                space = 5000
            END IF
            IF combo >= 5000 AND combo < 10000 THEN
                multipliar = 500
                space = 10000
            END IF
            IF combo >= 10000 THEN
                multipliar = 1000
                space = combo
            END IF
            CLS
            length = LEN(score&&)
            LOCATE 1, ((80 - length) / 2)
            PRINT score&&
            LOCATE 2, 2
            PRINT combo
            multiplier$ = STR$(multipliar) + "X"
            LOCATE 1, 2
            PRINT multiplier$
            PSET (120, 32)
            DRAW progressionbox$
            songposition = _SNDGETPOS(songaudio)
            position = _SNDGETPOS(songaudio)
            playingminutes = INT((position / 60))
            playingminutes$ = STR$(playingminutes)
            playingminutes$ = LTRIM$(playingminutes$)
            playingseconds = INT((position - (playingminutes * 60)))
            playingseconds$ = STR$(playingseconds)
            playingseconds$ = LTRIM$(playingseconds$)
            playingdigitseconds = LEN(playingseconds$)
            IF playingdigitseconds = 1 THEN
                playingseconds$ = "0" + playingseconds$
            END IF
            timedisplay$ = " " + playingminutes$ + ":" + playingseconds$
            LOCATE 4, 15
            PRINT timedisplay$
            LOCATE 4, ((80 - (LEN(song$))) / 2)
            PRINT song$
            LOCATE 4, 62
            PRINT totaltime$
            LOCATE 28, 21
            PRINT denotation$(1)
            LOCATE 28, 33
            PRINT denotation$(2)
            LOCATE 28, 44
            PRINT denotation$(3)
            LOCATE 28, 56
            PRINT denotation$(4)
            FOR flow = 1 TO 5
                flowx = 45 + (flow * 90)
                PSET (flowx, 100)
                DRAW flowline$
                IF flow <> 5 THEN
                    IF press(flow) = 1 THEN
                        flowx = flowx + 45
                        CIRCLE (flowx, 371), 32, tapstrip2(flow)
                        PSET STEP(0, 0), tapstrip2(flow)
                        DRAW crosshairs$
                        CIRCLE (flowx, 371), 33, tapstrip2(flow)
                        FOR rimcolor = 1 TO 5
                            rim = 33 + rimcolor
                            CIRCLE (flowx, 371), rim, tapcolor2(flow)
                        NEXT rimcolor
                    ELSE
                        flowx = flowx + 45
                        CIRCLE (flowx, 371), 32, tapstrip(flow)
                        PSET STEP(0, 0), tapstrip(flow)
                        DRAW crosshairs$
                        CIRCLE (flowx, 371), 33, tapstrip(flow)
                        FOR rimcolor = 1 TO 5
                            rim = 33 + rimcolor
                            CIRCLE (flowx, 371), rim, tapcolor(flow)
                        NEXT rimcolor
                    END IF
                END IF
            NEXT flow
            PSET (135, 330)
            DRAW bound$
            FOR guidehole = 1 TO 4
                hop = 90 + (guidehole * 90)
                CIRCLE (hop, 275), 16, 7
            NEXT guidehole
            position = _ROUND((121 + ((songposition / totalsonglength) * 399)))
            PSET (position, 37)
            PSET (position, 38)
            PSET (position, 39)
            PSET ((position - 1), 37)
            PSET ((position - 1), 38)
            PSET ((position - 1), 39)
            PSET ((position + 1), 37)
            PSET ((position + 1), 38)
            PSET ((position + 1), 39)
            PSET (600, 40)
            DRAW accuracybarline$
            PSET (580, 40)
            DRAW accuracybarline$
            FOR accuracyballs = 1 TO 5
                CIRCLE (590, (accuracyballs * 20) + 20), 10, 15
                IF accuracyball = accuracyballs THEN
                    FOR fillinball = 1 TO 9
                        CIRCLE (590, (accuracyballs * 20) + 20), fillinball, ballcolor
                    NEXT fillinball
                END IF
            NEXT accuracyballs
            PSET (15, 35)
            DRAW combocountbox$
            highofbox = _ROUND(((combo / space) * 250))
            FOR height = 1 TO highofbox
                PSET (15, (285 - height))
                DRAW accuracybarrank$
            NEXT height
            IF combo >= 10000 THEN
                FOR ranks = 1 TO 250
                    PSET (15, (285 - height))
                    DRAW accuracybarrank$
                NEXT ranks
            END IF
            FOR drawnote = loopcount TO (loopcount + 128)
                depth = drawnote - loopcount
                tapy = _ROUND((116 + (depth * 1.2421875)))
                tapy = ((275 - tapy) + 116)
                IF rn(drawnote) = 1 THEN
                    flowing = 1
                    tapx = 180
                    FOR tapfill = 1 TO 12
                        CIRCLE (tapx, tapy), tapfill, tap(flowing)
                    NEXT tapfill
                    FOR tapshade = 1 TO 3
                        CIRCLE (tapx, tapy), (tapshade + 13), tap2(flowing)
                    NEXT tapshade
                    CIRCLE (tapx, tapy), (15), 15
                END IF
                IF gn(drawnote) = 1 THEN
                    flowing = 2
                    tapx = 270
                    FOR tapfill = 1 TO 12
                        CIRCLE (tapx, tapy), tapfill, tap(flowing)
                    NEXT tapfill
                    FOR tapshade = 1 TO 3
                        CIRCLE (tapx, tapy), (tapshade + 13), tap2(flowing)
                    NEXT tapshade
                    CIRCLE (tapx, tapy), (15), 15
                END IF
                IF bn(drawnote) = 1 THEN
                    flowing = 3
                    tapx = 360
                    FOR tapfill = 1 TO 12
                        CIRCLE (tapx, tapy), tapfill, tap(flowing)
                    NEXT tapfill
                    FOR tapshade = 1 TO 3
                        CIRCLE (tapx, tapy), (tapshade + 13), tap2(flowing)
                    NEXT tapshade
                    CIRCLE (tapx, tapy), (15), 15
                END IF
                IF yn(drawnote) = 1 THEN
                    flowing = 4
                    tapx = 450
                    FOR tapfill = 1 TO 12
                        CIRCLE (tapx, tapy), tapfill, tap(flowing)
                    NEXT tapfill
                    FOR tapshade = 1 TO 3
                        CIRCLE (tapx, tapy), (tapshade + 13), tap2(flowing)
                    NEXT tapshade
                    CIRCLE (tapx, tapy), (15), 15
                END IF
                IF tapy = 159 THEN
                    IF rn(drawnote) = 1 THEN redsleepnote(loopcount) = 1
                    IF gn(drawnote) = 1 THEN greensleepnote(loopcount) = 1
                    IF bn(drawnote) = 1 THEN bluesleepnote(loopcount) = 1
                    IF yn(drawnote) = 1 THEN yellowsleepnote(loopcount) = 1
                END IF
            NEXT drawnote
            DO
                DO
                    IF red = -1 AND redpress = 1 THEN
                        IF rn(loopcount) = 1 THEN
                            rn(loopcount) = 0
                            scoreadd& = scoreadd& + 10000
                            combo = combo + 1
                            perfect = perfect + 1
                            tapcolor(1) = 13
                            tapcolor2(1) = 5
                            accuracyball = 1
                            ballcolor = 13
                            denotation$(1) = "PERFECT"
                            redpress = 0
                            EXIT DO
                        END IF
                        FOR redcheck = -3 TO 3 STEP 1
                            IF rn(loopcount + redcheck) = 1 THEN
                                rn(loopcount + redcheck) = 0
                                scoreadd& = scoreadd& + 1000
                                combo = combo + 1
                                great = great + 1
                                tapcolor(1) = 9
                                tapcolor2(1) = 1
                                accuracyball = 2
                                ballcolor = 9
                                denotation$(1) = "GREAT"
                                redpress = 0
                                EXIT DO
                            END IF
                        NEXT redcheck
                        FOR redcheck = -8 TO 8 STEP 1
                            IF rn(loopcount + redcheck) = 1 THEN
                                rn(loopcount + redcheck) = 0
                                scoreadd& = scoreadd& + 500
                                combo = combo + 1
                                good = good + 1
                                tapcolor(1) = 10
                                tapcolor2(1) = 2
                                accuracyball = 3
                                ballcolor = 10
                                denotation$(1) = "GOOD"
                                redpress = 0
                                EXIT DO
                            END IF
                        NEXT redcheck
                        FOR redcheck = -16 TO 16 STEP 1
                            IF rn(loopcount + redcheck) = 1 THEN
                                rn(loopcount + redcheck) = 0
                                scoreadd& = scoreadd& + 100
                                combo = combo + 1
                                poor = poor + 1
                                tapcolor(1) = 14
                                tapcolor2(1) = 6
                                accuracyball = 4
                                ballcolor = 14
                                denotation$(1) = "POOR"
                                redpress = 0
                                EXIT DO
                            END IF
                        NEXT redcheck
                        combo = 0
                        miss = miss + 1
                        tapcolor(1) = 12
                        tapcolor2(1) = 4
                        accuracyball = 5
                        ballcolor = 12
                        denotation$(1) = "MISS"
                        redpress = 0
                    END IF
                    EXIT DO
                LOOP
                DO
                    IF green = -1 AND greenpress = 1 THEN
                        IF gn(loopcount) = 1 THEN
                            gn(loopcount) = 0
                            scoreadd& = scoreadd& + 10000
                            combo = combo + 1
                            perfect = perfect + 1
                            tapcolor(2) = 13
                            tapcolor2(2) = 5
                            accuracyball = 1
                            ballcolor = 13
                            denotation$(2) = "PERFECT"
                            greenpress = 0
                            EXIT DO
                        END IF
                        FOR greencheck = -3 TO 3 STEP 1
                            IF gn(loopcount + greencheck) = 1 THEN
                                gn(loopcount + greencheck) = 0
                                scoreadd& = scoreadd& + 1000
                                combo = combo + 1
                                great = great + 1
                                tapcolor(2) = 9
                                tapcolor2(2) = 1
                                accuracyball = 2
                                ballcolor = 9
                                denotation$(2) = "GREAT"
                                greenpress = 0
                                EXIT DO
                            END IF
                        NEXT greencheck
                        FOR greencheck = -8 TO 8 STEP 1
                            IF gn(loopcount + greencheck) = 1 THEN
                                gn(loopcount + greencheck) = 0
                                scoreadd& = scoreadd& + 500
                                combo = combo + 1
                                good = good + 1
                                tapcolor(2) = 10
                                tapcolor2(2) = 2
                                accuracyball = 3
                                ballcolor = 10
                                denotation$(2) = "GOOD"
                                greenpress = 0
                                EXIT DO
                            END IF
                        NEXT greencheck
                        FOR greencheck = -16 TO 16 STEP 1
                            IF gn(loopcount + greencheck) = 1 THEN
                                gn(loopcount + greencheck) = 0
                                scoreadd& = scoreadd& + 100
                                combo = combo + 1
                                poor = poor + 1
                                tapcolor(2) = 14
                                tapcolor2(2) = 6
                                accuracyball = 4
                                ballcolor = 14
                                denotation$(2) = "POOR"
                                greenpress = 0
                                EXIT DO
                            END IF
                        NEXT greencheck
                        combo = 0
                        miss = miss + 1
                        tapcolor(2) = 12
                        tapcolor2(2) = 4
                        accuracyball = 5
                        ballcolor = 12
                        denotation$(2) = "MISS"
                        greenpress = 0
                    END IF
                    EXIT DO
                LOOP
                DO
                    IF blue = -1 AND bluepress = 1 THEN
                        IF bn(loopcount) = 1 THEN
                            bn(loopcount) = 0
                            scoreadd& = scoreadd& + 10000
                            combo = combo + 1
                            perfect = perfect + 1
                            tapcolor(3) = 13
                            tapcolor2(3) = 5
                            accuracyball = 1
                            ballcolor = 13
                            denotation$(3) = "PERFECT"
                            bluepress = 0
                            EXIT DO
                        END IF
                        FOR bluecheck = -3 TO 3 STEP 1
                            IF bn(loopcount + bluecheck) = 1 THEN
                                bn(loopcount + bluecheck) = 0
                                scoreadd& = scoreadd& + 1000
                                combo = combo + 1
                                great = great + 1
                                tapcolor(3) = 9
                                tapcolor2(3) = 1
                                accuracyball = 2
                                ballcolor = 9
                                denotation$(3) = "GREAT"
                                bluepress = 0
                                EXIT DO
                            END IF
                        NEXT bluecheck
                        FOR bluecheck = -8 TO 8 STEP 1
                            IF bn(loopcount + bluecheck) = 1 THEN
                                bn(loopcount + bluecheck) = 0
                                scoreadd& = scoreadd& + 500
                                combo = combo + 1
                                good = good + 1
                                tapcolor(3) = 10
                                tapcolor2(3) = 2
                                accuracyball = 3
                                ballcolor = 10
                                denotation$(3) = "GOOD"
                                bluepress = 0
                                EXIT DO
                            END IF
                        NEXT bluecheck
                        FOR bluecheck = -16 TO 16 STEP 1
                            IF bn(loopcount + bluecheck) = 1 THEN
                                bn(loopcount + bluecheck) = 0
                                scoreadd& = scoreadd& + 100
                                combo = combo + 1
                                poor = poor + 1
                                tapcolor(3) = 14
                                tapcolor2(3) = 6
                                accuracyball = 4
                                ballcolor = 14
                                denotation$(3) = "POOR"
                                bluepress = 0
                                EXIT DO
                            END IF
                        NEXT bluecheck
                        combo = 0
                        miss = miss + 1
                        tapcolor(3) = 12
                        tapcolor2(3) = 4
                        accuracyball = 5
                        ballcolor = 12
                        denotation$(3) = "MISS"
                        bluepress = 0
                    END IF
                    EXIT DO
                LOOP
                DO
                    IF yellow = -1 AND yellowpress = 1 THEN
                        IF yn(loopcount) = 1 THEN
                            yn(loopcount) = 0
                            scoreadd& = scoreadd& + 10000
                            combo = combo + 1
                            perfect = perfect + 1
                            tapcolor(4) = 13
                            tapcolor2(4) = 5
                            accuracyball = 1
                            ballcolor = 13
                            denotation$(4) = "PERFECT"
                            yellowpress = 0
                            EXIT DO
                        END IF
                        FOR yellowcheck = -3 TO 3 STEP 1
                            IF yn(loopcount + yellowcheck) = 1 THEN
                                yn(loopcount + yellowcheck) = 0
                                scoreadd& = scoreadd& + 1000
                                combo = combo + 1
                                great = great + 1
                                tapcolor(4) = 9
                                tapcolor2(4) = 1
                                accuracyball = 2
                                ballcolor = 9
                                denotation$(4) = "GREAT"
                                yellowpress = 0
                                EXIT DO
                            END IF
                        NEXT yellowcheck
                        FOR yellowcheck = -8 TO 8 STEP 1
                            IF yn(loopcount + yellowcheck) = 1 THEN
                                yn(loopcount + yellowcheck) = 0
                                scoreadd& = scoreadd& + 500
                                combo = combo + 1
                                good = good + 1
                                tapcolor(4) = 10
                                tapcolor2(4) = 2
                                accuracyball = 3
                                ballcolor = 10
                                denotation$(4) = "GOOD"
                                yellowpress = 0
                                EXIT DO
                            END IF
                        NEXT yellowcheck
                        FOR yellowcheck = -16 TO 16 STEP 1
                            IF yn(loopcount + yellowcheck) = 1 THEN
                                yn(loopcount + yellowcheck) = 0
                                scoreadd& = scoreadd& + 100
                                combo = combo + 1
                                poor = poor + 1
                                tapcolor(4) = 14
                                tapcolor2(4) = 6
                                accuracyball = 4
                                ballcolor = 14
                                denotation$(4) = "POOR"
                                yellowpress = 0
                                EXIT DO
                            END IF
                        NEXT yellowcheck
                        combo = 0
                        miss = miss + 1
                        tapcolor(4) = 12
                        tapcolor2(4) = 4
                        accuracyball = 5
                        ballcolor = 12
                        denotation$(4) = "MISS"
                        yellowpress = 0
                    END IF
                    EXIT DO
                LOOP
                score&& = score&& + (scoreadd& * multipliar)
                scoreadd& = 0
                EXIT DO
            LOOP
            IF paused = 1 THEN
                _AUTODISPLAY
                _SNDPAUSE songaudio
                DO
                    CLS
                    LOCATE 1, 36
                    PRINT "PAUSED"
                    PRINT "Select an Option"
                    PRINT "     1-Continue"
                    PRINT "     2-Return to Main Menu"
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    xx2 = 0
                    GOSUB controls
                    IF k$ = CHR$(49) THEN
                        CLS
                        PRINT "Get ready"
                        _DELAY .5
                        PRINT "3"
                        _DELAY 1
                        PRINT "2"
                        _DELAY 1
                        PRINT "1"
                        _DELAY 1
                        PRINT "GO"
                        _DELAY .1
                        _SNDPLAY songaudio
                        EXIT DO
                    END IF
                    IF k$ = CHR$(50) THEN
                        _SNDSTOP songaudio
                        GOTO BEGIN
                    END IF
                LOOP
                paused = 0
                _DISPLAY
            END IF
            loopcount = loopcount + 1
            _DISPLAY
        LOOP UNTIL loopcount = (endit + 128)
        DIM oldsongscore$(12)
        inputcount = 0
        songscore$ = "tap musician\songs\scores\" + song$ + ".txt"
        OPEN songscore$ FOR INPUT AS #1
        FOR getting = 1 TO 11
            LINE INPUT #1, oldsongscore$(getting)
        NEXT getting
        CLOSE #1
        aa = VAL(MID$(oldsongscore$(5), 7, LEN(oldsongscore$(5))))
        playtimes$ = MID$(oldsongscore$(2), 8, (LEN(oldsongscore$(2)) - 12))
        playtimes = VAL(playtimes$)
        playtimes = playtimes + 1
        oldsongscore$(2) = "Played" + STR$(playtimes) + " times"
        oldscoredata$(3) = "Last Played on " + DATE$ + " at " + TIME$
        oldsongscore$(12) = ""
        OPEN songscore$ FOR OUTPUT AS #1
        FOR writting = 1 TO 12
            PRINT #1, oldsongscore$(writting)
        NEXT writting
        CLOSE #1
        DIM scoredata$(12)
        IF score&& > aa THEN writescore = 1
        scoredata$(1) = song$
        scoredata$(2) = "Played" + STR$(playtimes) + " times"
        scoredata$(3) = "Last Played on " + DATE$ + " at " + TIME$
        scoredata$(4) = ""
        scoredata$(5) = "Score:" + STR$(score&&)
        noteshit = perfect + great + good + poor
        scoredata$(6) = "Notes Hit: " + STR$(noteshit)
        scoredata$(7) = "     Perfect:" + STR$(perfect)
        scoredata$(8) = "     Great:" + STR$(great)
        scoredata$(9) = "     Good:" + STR$(good)
        scoredata$(10) = "     Poor:" + STR$(poor)
        scoredata$(11) = "     Miss:" + STR$(miss)
        scoredata$(12) = ""
        IF writescore = 1 THEN
            OPEN songscore$ FOR OUTPUT AS #1
            FOR writingscore = 1 TO 12
                PRINT #1, scoredata$(writingscore)
            NEXT writingscore
            CLOSE #1
        END IF
        DO
            CLS
            FOR printscore = 1 TO 11
                PRINT scoredata$(printscore)
            NEXT printscore
            _DISPLAY
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
        LOOP UNTIL k$ = CHR$(32)
        GOTO BEGIN
    END IF
    IF k$ = CHR$(50) THEN
        _AUTODISPLAY
        sname$ = ""
        DO
            CLS
            PRINT "What would you like to name this song?"
            PRINT ": "; sname$
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            GOSUB controls
            IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                sname$ = sname$ + k$
                inputlength = LEN(sname$)
            END IF
            IF k$ = CHR$(8) AND inputlength > 0 THEN
                sname$ = MID$(sname$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
        LOOP UNTIL k$ = CHR$(13)
        snameogg$ = sname$ + ".ogg"
        DO
            DO
                songname$ = "tap musician\songs\data\" + sname$ + ".txt"
                OPEN songname$ FOR OUTPUT AS #1
                SHELL "CD > loc.tmp"
                OPEN "loc.tmp" FOR INPUT AS #2
                INPUT #2, folderloc$
                CLOSE #2
                scorefile$ = "tap musician\songs\scores\" + sname$ + ".txt"
                nul$ = ""
                OPEN scorefile$ FOR OUTPUT AS #3
                FOR fill = 1 TO 12
                    PRINT #3, nul$
                NEXT fill
                CLOSE #3
                folderloc$ = folderloc$ + "\songs\songs\"
                KILL "loc.tmp"
                DO
                    CLS
                    PRINT "Make a copy of the audio you want for your song at this location"
                    PRINT "At this time all audio files must be in ogg format"
                    PRINT "A good, free converter is 'Format Factory'"
                    PRINT "'"; folderloc$; "'"
                    PRINT "Once you have done this press Space"
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    GOSUB controls
                LOOP UNTIL k$ = CHR$(32)
                audioname$ = ""
                DO
                    CLS
                    PRINT "Enter the name of the audio you want to use for this song"
                    PRINT "At this time all audio files must be in ogg format"
                    PRINT "A good, free converter is 'Format Factory'"
                    PRINT "Enter '*' to name it '"; snameogg$; "'"
                    PRINT "Example: 'song.ogg' or 'audio.ogg'"
                    PRINT ": "; audioname$
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    GOSUB controls
                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                        audioname$ = audioname$ + k$
                        inputlength = LEN(audioname$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        audioname$ = MID$(audioname$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                LOOP UNTIL k$ = CHR$(13)
                IF audioname$ = "*" THEN
                    audioname$ = snameogg$
                END IF
                folderloc$ = "tap musician\songs\songs\" + audioname$
                PRINT #1, folderloc$
                IF music = -1 THEN
                    _SNDCLOSE music
                END IF
                music = _SNDOPEN(folderloc$, "PAUSE, LEN, SYNC")
                los = _SNDLEN(music)
                los = _ROUND(los)
                los = los * 64
                PRINT #1, los
                IF music = 0 THEN
                    DO
                        CLS
                        PRINT "You have either entered an invalid song name or you never moved the song"
                        PRINT "Press Space to retry"
                        DO
                            _LIMIT 128
                            k$ = INKEY$
                        LOOP UNTIL LEN(k$)
                    LOOP UNTIL k$ = CHR$(32)
                    EXIT DO
                END IF
                exitloop = 1
                EXIT DO
            LOOP
            IF exitloop = 1 THEN EXIT DO
        LOOP
        exitloop = 0
        paused = 0
        notes = 0
        redpress = 0
        greenpress = 0
        bluepress = 0
        yellowpress = 0
        tapcolor(1) = 15
        tapcolor(2) = 15
        tapcolor(3) = 15
        tapcolor(4) = 15
        _SNDPLAY music
        songplaying = _SNDPLAYING(music)
        totalsonglength = _SNDLEN(music)
        length = _SNDLEN(music)
        minutes = INT((length / 60))
        minutes$ = STR$(minutes)
        minutes$ = LTRIM$(minutes$)
        seconds = INT((length - (minutes * 60)))
        seconds$ = STR$(seconds)
        seconds$ = LTRIM$(seconds$)
        digitseconds = LEN(seconds$)
        IF digitseconds = 1 THEN
            seconds$ = "0" + seconds$
        END IF
        totaltime$ = minutes$ + ":" + seconds$
        DO
            _LIMIT 64
            songpause = _KEYDOWN(32)
            red = _KEYDOWN(118)
            green = _KEYDOWN(98)
            blue = _KEYDOWN(110)
            yellow = _KEYDOWN(109)
            IF songpause = -1 THEN
                paused = 1
            END IF
            IF red = -1 THEN
                IF rpress = 1 THEN
                    redpress = 1
                END IF
                reddown = 1
                press(1) = 1
            ELSE
                redhold = 0
                rpress = 1
                redpress = 0
                reddown = 0
                press(1) = 0
            END IF
            greenpress = 1
            IF green = -1 THEN
                IF gpress = 1 THEN
                    greenpress = 1
                END IF
                greendown = 1
                press(2) = 1
            ELSE
                greenhold = 0
                gpress = 1
                greenpress = 0
                greendown = 0
                press(2) = 0
            END IF
            IF blue = -1 THEN
                IF bpress = 1 THEN
                    bluepress = 1
                END IF
                bluedown = 1
                press(3) = 1
            ELSE
                bluehold = 0
                bpress = 1
                bluepress = 0
                bluedown = 0
                press(3) = 0
            END IF
            yellowpress = 1
            IF yellow = -1 THEN
                IF ypress = 1 THEN
                    yellowpress = 1
                END IF
                yellowdown = 1
                press(4) = 1
            ELSE
                yellowhold = 0
                ypress = 1
                yellowpress = 0
                yellowdown = 0
                press(4) = 0
            END IF
            CLS
            PSET (120, 140)
            DRAW progressionbox$
            songposition = _SNDGETPOS(music)
            position = _SNDGETPOS(music)
            playingminutes = INT((position / 60))
            playingminutes$ = STR$(playingminutes)
            playingminutes$ = LTRIM$(playingminutes$)
            playingseconds = INT((position - (playingminutes * 60)))
            playingseconds$ = STR$(playingseconds)
            playingseconds$ = LTRIM$(playingseconds$)
            playingdigitseconds = LEN(playingseconds$)
            IF playingdigitseconds = 1 THEN
                playingseconds$ = "0" + playingseconds$
            END IF
            timedisplay$ = " " + playingminutes$ + ":" + playingseconds$
            LOCATE 12, 15
            PRINT timedisplay$
            LOCATE 12, ((80 - (LEN(sname$))) / 2)
            PRINT sname$
            LOCATE 12, 62
            PRINT totaltime$
            position = _ROUND((121 + ((songposition / totalsonglength) * 399)))
            PSET (position, 145)
            PSET (position, 146)
            PSET (position, 147)
            PSET ((position - 1), 145)
            PSET ((position - 1), 146)
            PSET ((position - 1), 147)
            PSET ((position + 1), 145)
            PSET ((position + 1), 146)
            PSET ((position + 1), 147)
            FOR recordcircle = 1 TO 4
                IF press(recordcircle) = 1 THEN
                    CIRCLE ((60 + (recordcircle * 100)), 240), 35, tapstrip(recordcircle)
                    PSET ((60 + (recordcircle * 100)), 240), tapstrip(recordcircle)
                    DRAW crosshairs2$
                    FOR colorloops = 1 TO 10
                        CIRCLE ((60 + (recordcircle * 100)), 240), (35 + colorloops), tapcolor(recordcircle)
                    NEXT colorloops
                ELSE
                    CIRCLE ((60 + (recordcircle * 100)), 240), 35, tapstrip2(recordcircle)
                    PSET ((60 + (recordcircle * 100)), 240), tapstrip2(recordcircle)
                    DRAW crosshairs2$
                    FOR colorloops = 1 TO 10
                        CIRCLE ((60 + (recordcircle * 100)), 240), (35 + colorloops), 0
                    NEXT colorloops
                END IF
            NEXT recordcircle
            IF paused = 1 THEN
                _SNDPAUSE music
                _AUTODISPLAY
                DO
                    CLS
                    LOCATE 1, 36
                    PRINT "PAUSED"
                    PRINT "Select an Option"
                    PRINT "     1-Continue"
                    PRINT "     2-Return to Main Menu"
                    DO
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    xx3 = 1
                    GOSUB controls
                    IF k$ = CHR$(49) THEN
                        CLS
                        PRINT "Get ready"
                        _DELAY .5
                        PRINT "3"
                        _DELAY 1
                        PRINT "2"
                        _DELAY 1
                        PRINT "1"
                        _DELAY 1
                        PRINT "GO"
                        _DELAY .1
                        _SNDPLAY music
                        EXIT DO
                    END IF
                    IF k$ = CHR$(50) THEN
                        CLOSE #1
                        _SNDSTOP music
                        GOTO BEGIN
                    END IF
                LOOP
                paused = 0
                _DISPLAY
            END IF
            IF reddown = 0 THEN
                keyinfo$ = keyinfo$ + "0"
            END IF
            IF reddown = 1 AND redhold = 0 THEN
                IF redpress = 1 THEN
                    keyinfo$ = keyinfo$ + "1"
                    notes = notes + 1
                    redhold = 1
                END IF
                rpress = 0
            END IF
            IF greendown = 0 THEN
                keyinfo$ = keyinfo$ + "0"
            END IF
            IF greendown = 1 AND greenhold = 0 THEN
                IF greenpress = 1 THEN
                    keyinfo$ = keyinfo$ + "1"
                    notes = notes + 1
                    greenhold = 1
                END IF
                gpress = 0
            END IF
            IF bluedown = 0 THEN
                keyinfo$ = keyinfo$ + "0"
            END IF
            IF bluedown = 1 AND bluehold = 0 THEN
                IF bluepress = 1 THEN
                    keyinfo$ = keyinfo$ + "1"
                    notes = notes + 1
                    bluehold = 1
                END IF
                bpress = 0
            END IF
            IF yellowdown = 0 THEN
                keyinfo$ = keyinfo$ + "0"
            END IF
            IF yellowdown = 1 AND yellowhold = 0 THEN
                IF yellowpress = 1 THEN
                    keyinfo$ = keyinfo$ + "1"
                    notes = notes + 1
                    yellowhold = 1
                END IF
                ypress = 0
            END IF
            PRINT #1, keyinfo$
            keyinfo$ = ""
            IF timetocheck = 64 THEN
                songplaying = _SNDPLAYING(music)
                timetocheck = 0
            END IF
            timetocheck = timetocheck + 1
            _DISPLAY
        LOOP UNTIL songplaying = 0
        _DELAY 1
        CLOSE #1
        inputcount = 0
        OPEN "tap musician\songs\nos.txt" FOR INPUT AS #6
        INPUT #6, nos
        CLOSE #6
        DIM oldlist$(32768)
        OPEN "tap musician\songs\list.txt" FOR INPUT AS #3
        DO UNTIL EOF(3)
            inputcount = inputcount + 1
            LINE INPUT #3, oldlist$(inputcount)
            IF inputcount = nos THEN EXIT DO
        LOOP
        CLOSE #3
        OPEN "tap musician\songs\list.txt" FOR OUTPUT AS #5
        PRINT #5, sname$
        FOR writer = 1 TO inputcount
            IF oldlist$(writer) <> sname$ THEN
                PRINT #5, oldlist$(writer)
                IF dontadd = 0 THEN
                    nos = nos + 1
                    dontadd = 1
                END IF
            END IF
        NEXT writer
        CLOSE #5
        OPEN "tap musician\songs\nos.txt" FOR OUTPUT AS #6
        WRITE #6, nos
        CLOSE #6
        DO
            CLS
            PRINT "Recording Finished"
            PRINT "This recording has"; notes; "notes"
            PRINT "Press Space to return to main screen"
            _DISPLAY
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            GOSUB controls
        LOOP UNTIL k$ = CHR$(32)
        GOTO BEGIN
    END IF
    IF k$ = CHR$(51) THEN
        OPEN "tap musician\songs\nos.txt" FOR INPUT AS #1
        INPUT #1, nos
        CLOSE #1
        inputcount = 0
        DIM songlistscore$(32768)
        OPEN "tap musician\songs\nos.txt" FOR INPUT AS #1
        INPUT #1, nos
        CLOSE #1
        inputcount = 0
        REDIM songlist$(32768)
        OPEN "tap musician\songs\list.txt" FOR INPUT AS #1
        DO UNTIL EOF(1)
            inputcount = inputcount + 1
            LINE INPUT #1, songlist$(inputcount)
            IF inputcount = nos THEN EXIT DO
        LOOP
        CLOSE #1
        row = 1
        DO
            CLS
            PRINT "Select the score you wish to see"
            VIEW PRINT 3 TO 27
            IF nos > 27 THEN
                DO
                    k$ = INKEY$
                    DO WHILE _MOUSEINPUT
                        row = row + (_MOUSEWHEEL * 3)
                        IF prevrow <> row THEN
                            IF row < 1 THEN
                                row = 1
                            END IF
                            IF row > (nos - 24) THEN
                                row = (nos - 24)
                            END IF
                            CLS 2
                            FOR n = row TO row + 24
                                IF n = selected THEN
                                    COLOR 0, 15
                                ELSE
                                    COLOR 15, 0
                                END IF
                                PRINT songlist$(n)
                            NEXT
                            _DISPLAY
                        END IF
                        prevrow = row
                    LOOP
                LOOP UNTIL LEN(k$)
            ELSE
                DO
                    k$ = INKEY$
                    row = 1
                    CLS 2
                    FOR n = row TO nos
                        IF n = selected THEN
                            COLOR 0, 15
                        ELSE
                            COLOR 15, 0
                        END IF
                        PRINT songlist$(n)
                    NEXT
                    _DISPLAY
                    GOSUB controls
                    xx1 = 1
                LOOP UNTIL LEN(k$)
            END IF
            VIEW PRINT
            IF k$ = CHR$(0) + CHR$(72) THEN selected = selected - 1
            IF k$ = CHR$(0) + CHR$(80) THEN selected = selected + 1
            IF selected < 1 THEN selected = 1
            IF selected > nos THEN selected = nos
        LOOP UNTIL k$ = CHR$(13)
        songscore$ = songlist$(selected)
        scorefile$ = "tap musician\songs\scores\" + songscore$ + ".txt"
        OPEN scorefile$ FOR INPUT AS #1
        FOR scoreget = 1 TO 11
            LINE INPUT #1, scoredata$(scoreget)
        NEXT scoreget
        CLOSE #1
        IF scoredata$(1) = "" THEN
            DO
                CLS
                PRINT "You have not played this song yet"
                PRINT "Press Space to return to the Main Menu"
                DO
                    k$ = INKEY$
                LOOP UNTIL LEN(k$)
                GOSUB controls
            LOOP UNTIL k$ = CHR$(32)
            GOTO BEGIN
        ELSE
            scorebgm$ = "tap musician\songs\songs\" + scoredata$(1) + ".ogg"
            scorebgm = _SNDOPEN(scorebgm$, "PAUSE,SYNC,VOL,LEN")
            _SNDLOOP scorebgm
            DO
                CLS
                FOR scoreprint = 1 TO 11
                    PRINT scoredata$(scoreprint)
                NEXT scoreprint
                _DISPLAY
                DO
                    k$ = INKEY$
                LOOP UNTIL LEN(k$)
                xx4 = 1
                GOSUB controls
            LOOP UNTIL k$ = CHR$(32)
            _SNDSTOP scorebgm
            _SNDCLOSE scorebgm
            GOTO BEGIN
        END IF
    END IF
LOOP

controls:
IF k$ = CHR$(27) THEN
    IF xx1 = 1 THEN VIEW PRINT
    IF xx2 = 1 THEN
        _SNDSTOP songaudio
        _SNDCLOSE songaudio
    END IF
    IF xx3 = 1 THEN
        _SNDSTOP music
        _SNDCLOSE music
    END IF
    IF xx4 = 1 THEN
        _SNDSTOP scorebgm
        _SNDCLOSE scorebgm
    END IF
    xx1 = 0
    xx2 = 0
    xx3 = 0
    xx4 = 0
    GOTO BEGIN
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
RETURN