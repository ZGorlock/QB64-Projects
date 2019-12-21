SCREEN 12
_TITLE "Picture Maker"
DO
    CLS
    PRINT "Draw Freestyle with F"
    PRINT "    Use Up, Down, Left, and Right to make whatever"
    PRINT "Make a Line with L"
    PRINT "    Use Up and Down OR Left and Right to make a line"
    PRINT "    Whatever direction you start going first will be the axis the line is on"
    PRINT "    You can then use the other two keys to rotate the line"
    PRINT "Make Boxes with B"
    PRINT "    Use Up, Down, Left, and Right to shape dimensions"
    PRINT "Make Circles with C"
    PRINT "    Use Up and Down to enlarge or shink the circle"
    PRINT "Make Triangle with T"
    PRINT "    Use Up and Down to enlarge or shink the triangle"
    PRINT "    Use Left and Right to change the shape of the triangle"
    PRINT "Make Hexagon with H"
    PRINT "    Use Up and Down to enlarge or shink the hexagon"
    PRINT "Make Octagon with O"
    PRINT "    Use Up and Down to enlarge or shink the octagon"
    PRINT "Make a Dot with D"
    PRINT "    You can't change that, it really just makes a dot"
    PRINT "Press Enter to Save, and Esc to Stop that shape, Z to Ctrl-Z, Space to Clear"
    PRINT "Click Left to Paint"
    PRINT "    You must have a closed boundry drawn in the same color as the paint"
    PRINT "Change Color with 1"
    PRINT "Change Paint Color with 2"
    PRINT "Take Screen Shot with 3 *workin on it"
    PRINT "Press Space to Draw!"
    _DISPLAY
    DO
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
LOOP UNTIL k$ = CHR$(32)
CLS
DIM drawing(307200)
DIM drawingx(307200)
DIM drawingy(307200)
DIM drawingradius(307200)
DIM drawingcolor(307200)
DIM drawing$(307200)
dr = 0
dcolor = 15
pcolor = 15
DO
    _LIMIT 64
    CLS
    DO WHILE _MOUSEINPUT
        IF _MOUSEBUTTON(1) = -1 THEN painter = 1
        paintx = _MOUSEX
        painty = _MOUSEY
        fsx = _MOUSEX
        fsy = _MOUSEY
        fsoldx = _MOUSEX + 1
        fsoldy = _MOUSEY + 1
        linesetx = _MOUSEX
        linesety = _MOUSEY
        boxx = _MOUSEX
        boxy = _MOUSEY
        boxsetx = _MOUSEX
        boxsety = _MOUSEY
        circlesetx = _MOUSEX
        circlesety = _MOUSEY
        trianglesetx = _MOUSEX
        tiranglesety = _MOUSEY
        dotx = _MOUSEX
        doty = _MOUSEY
    LOOP
    FOR d = 1 TO dr
        IF drawing(d) = 0 THEN
            PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
        END IF
        IF drawing(d) = 1 OR drawing(d) = 8 THEN
            PSET (drawingx(d), drawingy(d)), drawingcolor(d)
        END IF
        IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
            PSET (drawingx(d), drawingy(d))
            DRAW drawing$(d)
        END IF
        IF drawing(d) = 4 THEN
            CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
        END IF
    NEXT d
    _DISPLAY
    k$ = INKEY$
    IF k$ = CHR$(102) THEN
        freestyle = 1
    END IF
    IF k$ = CHR$(108) THEN
        liner = 1
    END IF
    IF k$ = CHR$(98) THEN
        box = 1
    END IF
    IF k$ = CHR$(99) THEN
        circler = 1
    END IF
    IF k$ = CHR$(116) THEN
        triangle = 1
    END IF
    IF k$ = CHR$(104) THEN
        hexagon = 1
    END IF
    IF k$ = CHR$(111) THEN
        octagon = 1
    END IF
    IF k$ = CHR$(100) THEN
        dot = 1
    END IF
    IF k$ = CHR$(32) THEN
        dr = 0
    END IF
    IF k$ = CHR$(122) THEN dr = dr - 1
    IF k$ = CHR$(49) THEN
        DO
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        color$ = ""
        inputlength = 0
        DO
            CLS
            PRINT "Enter the color of the line you want (1-15)"
            PRINT "Current Color:"; dcolor
            PRINT ": "; color$
            FOR drawing = 0 TO 40
                CIRCLE ((280 + drawing), 240), 20, dcolor
            NEXT drawing
            _DISPLAY
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                color$ = color$ + k$
                inputlength = LEN(color$)
            END IF
            IF k$ = CHR$(8) AND inputlength > 0 THEN
                color$ = MID$(color$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            dcolor = VAL(color$)
        LOOP UNTIL k$ = CHR$(13)
    END IF
    IF k$ = CHR$(50) THEN
        DO
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        color$ = ""
        inputlength = 0
        DO
            CLS
            PRINT "Enter the color of the paint you want (1-15)"
            PRINT "Current Color:"; pcolor
            PRINT ": "; color$
            FOR drawing = 0 TO 40
                CIRCLE ((280 + drawing), 240), 20, pcolor
            NEXT drawing
            _DISPLAY
            DO
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                color$ = color$ + k$
                inputlength = LEN(color$)
            END IF
            IF k$ = CHR$(8) AND inputlength > 0 THEN
                color$ = MID$(color$, 1, (inputlength - 1))
                inputlength = (inputlength - 1)
            END IF
            pcolor = VAL(color$)
        LOOP UNTIL k$ = CHR$(13)
    END IF
    IF k$ = CHR$(51) THEN
    END IF
    IF painter = 1 THEN
        dr = dr + 1
        drawing(dr) = 0
        drawingx(dr) = paintx
        drawingy(dr) = painty
        drawingcolor(dr) = pcolor
        drawingradius(dr) = 0
        drawing$(dr) = ""
        painter = 0
    END IF
    IF freestyle = 1 THEN
        DO
            _LIMIT 64
            k$ = INKEY$
            u = _KEYDOWN(CVI(CHR$(0) + CHR$(72)))
            d = _KEYDOWN(CVI(CHR$(0) + CHR$(80)))
            l = _KEYDOWN(CVI(CHR$(0) + CHR$(75)))
            r = _KEYDOWN(CVI(CHR$(0) + CHR$(77)))
            IF u = -1 THEN
                fsy = fsy - 1
            END IF
            IF d = -1 THEN
                fsy = fsy + 1
            END IF
            IF l = -1 THEN
                fsx = fsx - 1
            END IF
            IF r = -1 THEN
                fsx = fsx + 1
            END IF
            CLS
            FOR d = 1 TO dr
                IF drawing(d) = 0 THEN
                    PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
                END IF
                IF drawing(d) = 1 OR drawing(d) = 8 THEN
                    PSET (drawingx(d), drawingy(d)), drawingcolor(d)
                END IF
                IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
                    PSET (drawingx(d), drawingy(d))
                    DRAW drawing$(d)
                END IF
                IF drawing(d) = 4 THEN
                    CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
                END IF
            NEXT d
            _DISPLAY
            IF k$ = CHR$(27) OR k$ = CHR$(32) THEN EXIT DO
            IF fsx <> fsoldx OR fsy <> fsoldy THEN
                dr = dr + 1
                drawing(dr) = 3
                drawingx(dr) = fsx
                drawingy(dr) = fsy
                drawingcolor(dr) = dcolor
                drawingradius(dr) = 0
                drawing$(dr) = ""
                fsoldx = fsx
                fsoldy = fsy
            END IF
        LOOP UNTIL k$ = CHR$(13)
        freestyle = 0
    END IF
    IF liner = 1 THEN
        length = 0
        angle = 0
        liner$ = ""
        DO
            DO
                _LIMIT 64
                k$ = INKEY$
                u = _KEYDOWN(CVI(CHR$(0) + CHR$(72)))
                d = _KEYDOWN(CVI(CHR$(0) + CHR$(80)))
                l = _KEYDOWN(CVI(CHR$(0) + CHR$(75)))
                r = _KEYDOWN(CVI(CHR$(0) + CHR$(77)))
                IF chosen = 1 THEN
                    IF way = 1 THEN
                        IF way2 = 1 THEN
                            IF u = -1 THEN
                                length = length + 1
                            END IF
                            IF d = -1 THEN
                                length = length - 1
                            END IF
                        END IF
                        IF way2 = 2 THEN
                            IF u = -1 THEN
                                length = length - 1
                            END IF
                            IF d = -1 THEN
                                length = length + 1
                            END IF
                        END IF
                        IF l = -1 THEN
                            angle = angle - 1
                        END IF
                        IF r = -1 THEN
                            angle = angle + 1
                        END IF
                    END IF
                    IF way = 2 THEN
                        IF u = -1 THEN
                            angle = angle - 1
                        END IF
                        IF d = -1 THEN
                            angle = angle + 1
                        END IF
                        IF way2 = 1 THEN
                            IF l = -1 THEN
                                length = length + 1
                            END IF
                            IF r = -1 THEN
                                length = length - 1
                            END IF
                        END IF
                        IF way2 = 2 THEN
                            IF l = -1 THEN
                                length = length - 1
                            END IF
                            IF r = -1 THEN
                                length = length + 1
                            END IF
                        END IF
                    END IF
                ELSE
                    IF u = -1 THEN
                        length = length + 1
                        angle = 360
                        way = 1
                        way2 = 1
                        chosen = 1
                    END IF
                    IF d = -1 THEN
                        length = length + 1
                        angle = 180
                        way = 1
                        way2 = 2
                        chosen = 1
                    END IF
                    IF l = -1 THEN
                        length = length + 1
                        angle = 90
                        way = 2
                        way2 = 1
                        chosen = 1
                    END IF
                    IF r = -1 THEN
                        length = length + 1
                        angle = 270
                        way = 2
                        way2 = 2
                        chosen = 1
                    END IF
                END IF
                CLS
                FOR d = 1 TO dr
                    IF drawing(d) = 0 THEN
                        PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 1 OR drawing(d) = 8 THEN
                        PSET (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
                        PSET (drawingx(d), drawingy(d))
                        DRAW drawing$(d)
                    END IF
                    IF drawing(d) = 4 THEN
                        CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
                    END IF
                NEXT d
                length$ = STR$(length)
                length$ = LTRIM$(length$)
                angle$ = STR$(angle)
                angle$ = LTRIM$(angle$)
                dcolor$ = STR$(dcolor)
                dcolor$ = LTRIM$(dcolor$)
                PSET (linesetx, linesety)
                liner$ = "C" + dcolor$ + " TA" + angle$ + " U" + length$ + "TA360"
                DRAW liner$
                _DISPLAY
                IF k$ = CHR$(27) THEN
                    exitloop = 1
                    EXIT DO
                END IF
            LOOP UNTIL k$ = CHR$(13)
            IF exitloop = 1 THEN EXIT DO
            dr = dr + 1
            drawing(dr) = 2
            drawingx(dr) = linesetx
            drawingy(dr) = linesety
            drawingcolor(dr) = dcolor
            drawingradius(dr) = 0
            drawing$(dr) = liner$
            EXIT DO
        LOOP
        exitloop = 0
        chosen = 0
        liner = 0
    END IF
    IF box = 1 THEN
        box$ = ""
        DO
            DO
                _LIMIT 64
                k$ = INKEY$
                u = _KEYDOWN(CVI(CHR$(0) + CHR$(72)))
                d = _KEYDOWN(CVI(CHR$(0) + CHR$(80)))
                l = _KEYDOWN(CVI(CHR$(0) + CHR$(75)))
                r = _KEYDOWN(CVI(CHR$(0) + CHR$(77)))
                IF u = -1 THEN
                    boxy = boxy - 1
                END IF
                IF d = -1 THEN
                    boxy = boxy + 1
                END IF
                IF l = -1 THEN
                    boxx = boxx - 1
                END IF
                IF r = -1 THEN
                    boxx = boxx + 1
                END IF
                CLS
                FOR d = 1 TO dr
                    IF drawing(d) = 0 THEN
                        PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 1 OR drawing(d) = 8 THEN
                        PSET (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
                        PSET (drawingx(d), drawingy(d))
                        DRAW drawing$(d)
                    END IF
                    IF drawing(d) = 4 THEN
                        CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
                    END IF
                NEXT d
                cx = boxsetx - boxx
                cy = boxsety - boxy
                cx$ = STR$(cx)
                cx$ = LTRIM$(cx$)
                cy$ = STR$(cy)
                cy$ = LTRIM$(cy$)
                dcolor$ = STR$(dcolor)
                dcolor$ = LTRIM$(dcolor$)
                PSET (boxsetx, boxsety), drawingcolor(d)
                box$ = "C" + dcolor$ + " L" + cx$ + " U" + cy$ + " R" + cx$ + " D" + cy$
                DRAW box$
                _DISPLAY
                IF k$ = CHR$(27) THEN
                    exitloop = 1
                    EXIT DO
                END IF
            LOOP UNTIL k$ = CHR$(13)
            IF exitloop = 1 THEN EXIT DO
            dr = dr + 1
            drawing(dr) = 3
            drawingx(dr) = boxsetx
            drawingy(dr) = boxsety
            drawingcolor(dr) = dcolor
            drawingradius(dr) = 0
            drawing$(dr) = box$
            EXIT DO
        LOOP
        exitloop = 0
        box = 0
    END IF
    IF circler = 1 THEN
        DO
            y = 0
            DO
                _LIMIT 64
                k$ = INKEY$
                u = _KEYDOWN(CVI(CHR$(0) + CHR$(72)))
                d = _KEYDOWN(CVI(CHR$(0) + CHR$(80)))
                IF u = -1 THEN
                    y = y - 1
                END IF
                IF d = -1 THEN
                    y = y + 1
                END IF
                CLS
                FOR d = 1 TO dr
                    IF drawing(d) = 0 THEN
                        PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 1 OR drawing(d) = 8 THEN
                        PSET (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
                        PSET (drawingx(d), drawingy(d))
                        DRAW drawing$(d)
                    END IF
                    IF drawing(d) = 4 THEN
                        CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
                    END IF
                NEXT d
                CIRCLE (circlesetx, circlesety), y, dcolor
                _DISPLAY
                IF k$ = CHR$(27) THEN
                    exitloop = 1
                    EXIT DO
                END IF
            LOOP UNTIL k$ = CHR$(13)
            IF exitloop = 1 THEN EXIT DO
            dr = dr + 1
            drawing(dr) = 4
            drawingx(dr) = circlesetx
            drawingy(dr) = circlesety
            drawingcolor(dr) = dcolor
            drawingradius(dr) = y
            drawing$(dr) = ""
            EXIT DO
        LOOP
        exitloop = 0
        circler = 0
    END IF
    IF triangle = 1 THEN
        xup = 0
        touch = 0
        DO
            DO
                _LIMIT 64
                k$ = INKEY$
                u = _KEYDOWN(CVI(CHR$(0) + CHR$(72)))
                d = _KEYDOWN(CVI(CHR$(0) + CHR$(80)))
                l = _KEYDOWN(CVI(CHR$(0) + CHR$(75)))
                r = _KEYDOWN(CVI(CHR$(0) + CHR$(77)))
                IF u = -1 THEN
                    length = length + 1
                    xup = xup + 1
                    distance = distance + 2
                END IF
                IF d = -1 THEN
                    length = length - 1
                    distance = distance - 2
                    xup = xup + 1
                END IF
                IF l = -1 THEN
                    angle = angle + 1
                    touch = 1
                END IF
                IF r = -1 THEN
                    angle = angle - 1
                    touch = 1
                END IF
                IF touch = 0 THEN
                    angle = 60
                END IF
                CLS
                FOR d = 1 TO dr
                    IF drawing(d) = 0 THEN
                        PAINT (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 1 OR drawing(d) = 8 THEN
                        PSET (drawingx(d), drawingy(d)), drawingcolor(d)
                    END IF
                    IF drawing(d) = 2 OR drawing(d) = 3 OR drawing(d) = 5 OR drawing(d) = 6 OR drawing(d) = 7 THEN
                        PSET (drawingx(d), drawingy(d))
                        DRAW drawing$(d)
                    END IF
                    IF drawing(d) = 4 THEN
                        CIRCLE (drawingx(d), drawingy(d)), drawingradius(d), drawingcolor(d)
                    END IF
                NEXT d
                de = distance ^ 2
                dr = de - (xup ^ 2)
                bottom = (SQR(de) * 2)
                bottom$ = STR$(bottom)
                bottom$ = LTRIM$(bottom$)
                dis$ = STR$(distance)
                dis$ = LTRIM$(dis$)
                tangle = (angle / 2)
                tangle$ = STR$(tangle)
                tangle$ = LTRIM$(tangle$)
                btangle = (360 - tangle)
                btangle$ = STR$(tangle)
                btangle$ = LTRIM$(btangle$)
                triangle$ = "TA" + tangle$ + " U" + dis$ + " BU-" + dis$ + " TA360 TA" + btangle$ + " U" + dis$ + " TA360 TA90 U" + bottom$
                DRAW triangle$
                _DISPLAY
                IF k$ = CHR$(27) THEN
                    exitloop = 1
                    EXIT DO
                END IF
            LOOP UNTIL k$ = CHR$(13)
            IF exitloop = 1 THEN EXIT DO
            dr = dr + 1
            drawing(dr) = 5
            drawingx(dr) = trianglesetx
            drawingy(dr) = trianglesety
            drawingcolor(dr) = dcolor
            drawingradius(dr) = 0
            drawing$(dr) = triangle$
            EXIT DO
        LOOP
        exitloop = 0
        triangle = 0
    END IF
    IF hexagon = 1 THEN
    END IF
    IF octagon = 1 THEN
    END IF
    IF dot = 1 THEN
        dr = dr + 1
        drawing(dr) = 8
        drawingx(dr) = dotx
        drawingy(dr) = doty
        drawingcolor(dr) = dcolor
        drawingradius(dr) = 0
        drawing$(dr) = ""
        dot = 0
    END IF
LOOP