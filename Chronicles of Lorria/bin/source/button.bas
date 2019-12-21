'$INCLUDE:'bin\backup\library\spritetop.bi'


TYPE RECT
    left AS LONG
    top AS LONG
    right AS LONG
    bottom AS LONG
END TYPE

TYPE buttonimage
    true AS INTEGER
    false AS INTEGER
END TYPE

TYPE button
    inuse AS _BYTE
    show AS _BYTE
    value AS _BYTE
    status AS _BYTE
    click AS _BYTE
    hit AS _BYTE
    spritesheet AS INTEGER
    width AS LONG
    height AS LONG
    buffer AS INTEGER
    stand AS buttonimage
    hover AS buttonimage
    active AS buttonimage
    locked AS buttonimage
    area AS RECT
    activearea AS RECT
    time AS SINGLE
    timer AS LONG
    oldTIMER AS SINGLE
END TYPE

CONST FALSE = 0
CONST TRUE = NOT FALSE


CONST BUTTON_ALLBUTTONS = TRUE
CONST BUTTON_AUTOUPDATE_OFF = FALSE
CONST BUTTON_AUTOUPDATE_ON = TRUE
CONST BUTTON_ACTION = 4
CONST BUTTON_CREATED = 1
CONST BUTTON_HIDE = FALSE
CONST BUTTON_HOVER = 3
CONST BUTTON_LCLICK = 1
CONST BUTTON_LMCLICK = 5
CONST BUTTON_LOCKED = 5
CONST BUTTON_LRCLICK = 4
CONST BUTTON_LRMCLICK = 7
CONST BUTTON_MCLICK = 3
CONST BUTTON_NOCLICK = FALSE
CONST BUTTON_OFF = 0
CONST BUTTON_ON = -1
CONST BUTTON_RCLICK = 2
CONST BUTTON_RMCLICK = 6
CONST BUTTON_SHOW = TRUE
CONST BUTTON_STAND = 2
CONST BUTTON_UNCREATED = FALSE

OPTION BASE 1

REDIM buttons(0) AS button






SCREEN _NEWIMAGE(640, 480, 32)

OPEN "a.txt" FOR INPUT AS #1
DIM a(10) AS INTEGER
FOR x = 1 TO 10
    LINE INPUT #1, a$
    a(x) = NEWBUTTON(a$, 50 + 40 * x, 60, 0, 0, 0, 0, BUTTON_OFF, 0, BUTTON_SHOW, BUTTON_AUTOUPDATE_OFF)
NEXT
CLOSE #1

DO
    _LIMIT 60
    CLS
    UPDATEBUTTON BUTTON_ALLBUTTONS
LOOP UNTIL INKEY$ > ""

BUTTONFREE BUTTON_ALLBUTTONS

END





SUB BUTTONFREE (handle AS INTEGER)
SHARED buttons() AS button
SELECT CASE handle
    CASE BUTTON_ALLBUTTONS
        FOR handle = 1 TO UBOUND(buttons)
            IF VALIDBUTTON(handle) THEN
                SHEETFREE buttons(handle).spritesheet
                IF buttons(handle).timer THEN TIMER(buttons(handle).timer) FREE
                IF handle = UBOUND(buttons) THEN
                    REDIM _PRESERVE buttons(UBOUND(buttons) - 1) AS button
                ELSE
                    buttons(handle).inuse = 0
                END IF
            END IF
        NEXT handle
    CASE ELSE
        IF NOT VALIDBUTTON(handle) THEN EXIT SUB
        SHEETFREE buttons(handle).spritesheet
        IF buttons(handle).timer THEN TIMER(buttons(handle).timer) FREE
        IF handle = UBOUND(buttons) THEN
            REDIM _PRESERVE buttons(UBOUND(buttons) - 1) AS button
        ELSE
            buttons(handle).inuse = 0
        END IF
END SELECT
END SUB

SUB HIDEBUTTON (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
buttons(handle).show = BUTTON_HIDE
buttons(handle).status = BUTTON_CREATED
END SUB

SUB LOCKBUTTON (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
buttons(handle).status = BUTTON_LOCKED
END SUB

SUB LOCKBUTTONTOGGLE (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
buttons(handle).status = buttons(handle).status XOR 2 ^ 0
END SUB

SUB PRINTBUTTON (handle AS INTEGER)
DIM locx AS LONG
DIM locy AS LONG
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
IF buttons(handle).show = BUTTON_HIDE THEN EXIT SUB
IF buttons(handle).status < BUTTON_STAND THEN EXIT SUB
locx = buttons(handle).area.left + (buttons(handle).width / 2)
locy = buttons(handle).area.top + (buttons(handle).height / 2)
SELECT CASE buttons(handle).status
    CASE BUTTON_STAND
        SELECT CASE BUTTONVALUE(handle)
            CASE BUTTON_OFF
                SPRITESTAMP locx, locy, buttons(handle).stand.false
            CASE BUTTON_ON
                SPRITESTAMP locx, locy, buttons(handle).stand.true
        END SELECT
    CASE BUTTON_HOVER
        SELECT CASE BUTTONVALUE(handle)
            CASE BUTTON_OFF
                SPRITESTAMP locx, locy, buttons(handle).hover.false
            CASE BUTTON_ON
                SPRITESTAMP locx, locy, buttons(handle).hover.true
        END SELECT
    CASE BUTTON_ACTION
        SELECT CASE BUTTONVALUE(handle)
            CASE BUTTON_OFF
                SPRITESTAMP locx, locy, buttons(handle).active.false
            CASE BUTTON_ON
                SPRITESTAMP locx, locy, buttons(handle).active.true
        END SELECT
    CASE BUTTON_LOCKED
        SELECT CASE BUTTONVALUE(handle)
            CASE BUTTON_OFF
                SPRITESTAMP locx, locy, buttons(handle).locked.false
            CASE BUTTON_ON
                SPRITESTAMP locx, locy, buttons(handle).locked.true
        END SELECT
END SELECT
END SUB

SUB SHOWBUTTON (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
buttons(handle).show = BUTTON_SHOW
buttons(handle).status = BUTTON_STAND
END SUB

SUB UNLOCKBUTTON (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT SUB
buttons(handle).status = BUTTON_STAND
END SUB

SUB UPDATEBUTTON (handle AS INTEGER)
DIM lclick AS _BIT
DIM mclick AS _BIT
DIM onbutton AS _BIT
DIM rclick AS _BIT
DIM saveclick AS _BYTE
DIM savestatus AS _BYTE
DIM x AS LONG
DIM y AS LONG
SHARED buttons() AS button
SELECT CASE handle
    CASE BUTTON_ALLBUTTONS
        FOR handle = 1 TO UBOUND(buttons)
            IF VALIDBUTTON(handle) THEN
                IF buttons(handle).show = BUTTON_SHOW THEN
                    DO
                        x = _MOUSEX
                        y = _MOUSEY
                        lclick = _MOUSEBUTTON(1)
                        rclick = _MOUSEBUTTON(2)
                        mclick = _MOUSEBUTTON(3)
                    LOOP WHILE _MOUSEINPUT
                    saveclick = buttons(handle).click
                    buttons(handle).click = 0
                    IF lclick THEN buttons(handle).click = BUTTON_LCLICK
                    IF rclick THEN buttons(handle).click = BUTTON_RCLICK
                    IF mclick THEN buttons(handle).click = BUTTON_MCLICK
                    IF lclick AND rclick THEN buttons(handle).click = BUTTON_LRCLICK
                    IF lclick AND mclick THEN buttons(handle).click = BUTTON_LMCLICK
                    IF rclick AND mclick THEN buttons(handle).click = BUTTON_RMCLICK
                    IF lclick AND rclick AND mclick THEN buttons(handle).click = BUTTON_LRMCLICK
                    IF buttons(handle).status <> BUTTON_LOCKED THEN
                        savestatus = buttons(handle).status
                        onbutton = -1
                        IF x < buttons(handle).activearea.left OR x > buttons(handle).activearea.right THEN onbutton = 0
                        IF y < buttons(handle).activearea.top OR y > buttons(handle).activearea.bottom THEN onbutton = 0
                        IF onbutton THEN
                            IF lclick OR rclick OR mclick THEN
                                buttons(handle).status = BUTTON_ACTION
                            ELSE
                                buttons(handle).status = BUTTON_HOVER
                            END IF
                        ELSE
                            buttons(handle).status = BUTTON_STAND
                        END IF
                        IF buttons(handle).status <> savestatus THEN buttons(handle).time = TIMER(.001)
                        buttons(handle).hit = 0
                        IF saveclick = BUTTON_LCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 1
                        IF saveclick = BUTTON_RCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 2
                        IF saveclick = BUTTON_MCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 3
                        IF saveclick = BUTTON_LRCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 4
                        IF saveclick = BUTTON_LMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 5
                        IF saveclick = BUTTON_RMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 6
                        IF saveclick = BUTTON_LRMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 7
                        IF buttons(handle).hit THEN buttons(handle).value = buttons(handle).value XOR 2 ^ 0
                    END IF
                    PRINTBUTTON handle
                END IF
            END IF
        NEXT handle
    CASE ELSE
        IF NOT VALIDBUTTON(handle) THEN EXIT SUB
        IF buttons(handle).show = BUTTON_HIDE THEN EXIT SUB
        DO
            x = _MOUSEX
            y = _MOUSEY
            lclick = _MOUSEBUTTON(1)
            rclick = _MOUSEBUTTON(2)
            mclick = _MOUSEBUTTON(3)
        LOOP WHILE _MOUSEINPUT
        saveclick = buttons(handle).click
        buttons(handle).click = 0
        IF lclick THEN buttons(handle).click = BUTTON_LCLICK
        IF rclick THEN buttons(handle).click = BUTTON_RCLICK
        IF mclick THEN buttons(handle).click = BUTTON_MCLICK
        IF lclick AND rclick THEN buttons(handle).click = BUTTON_LRCLICK
        IF lclick AND mclick THEN buttons(handle).click = BUTTON_LMCLICK
        IF rclick AND mclick THEN buttons(handle).click = BUTTON_RMCLICK
        IF lclick AND rclick AND mclick THEN buttons(handle).click = BUTTON_LRMCLICK
        IF buttons(handle).status <> BUTTON_LOCKED THEN
            savestatus = buttons(handle).status
            onbutton = -1
            IF x < buttons(handle).activearea.left OR x > buttons(handle).activearea.right THEN onbutton = 0
            IF y < buttons(handle).activearea.top OR y > buttons(handle).activearea.bottom THEN onbutton = 0
            IF onbutton THEN
                IF lclick OR rclick OR mclick THEN
                    buttons(handle).status = BUTTON_ACTION
                ELSE
                    buttons(handle).status = BUTTON_HOVER
                END IF
            ELSE
                buttons(handle).status = BUTTON_STAND
            END IF
            IF buttons(handle).status <> savestatus THEN buttons(handle).time = TIMER(.001)
            buttons(handle).hit = 0
            IF saveclick = BUTTON_LCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 1
            IF saveclick = BUTTON_RCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 2
            IF saveclick = BUTTON_MCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 3
            IF saveclick = BUTTON_LRCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 4
            IF saveclick = BUTTON_LMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 5
            IF saveclick = BUTTON_RMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 6
            IF saveclick = BUTTON_LRMCLICK AND buttons(handle).click = BUTTON_NOCLICK AND onbutton THEN buttons(handle).hit = 7
            IF buttons(handle).hit THEN buttons(handle).value = buttons(handle).value XOR 2 ^ 0
        END IF
        PRINTBUTTON handle
END SELECT
END SUB

FUNCTION BUTTONCLICK%% (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT FUNCTION
BUTTONCLICK = buttons(handle).click
END FUNCTION

FUNCTION BUTTONHIT%% (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT FUNCTION
BUTTONHIT = buttons(handle).hit
END FUNCTION

FUNCTION BUTTONSTATUS%% (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT FUNCTION
BUTTONSTATUS = buttons(handle).status
END FUNCTION

FUNCTION BUTTONTIME! (handle AS INTEGER)
DIM currenttime AS SINGLE
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT FUNCTION
currenttime = TIMER(.001)
IF currenttime < buttons(handle).time THEN
    BUTTONTIME = currenttime + buttons(handle).time - 86400
ELSE
    BUTTONTIME = currenttime - buttons(handle).time
END IF
END FUNCTION

FUNCTION BUTTONVALUE` (handle AS INTEGER)
SHARED buttons() AS button
IF NOT VALIDBUTTON(handle) THEN EXIT FUNCTION
BUTTONVALUE = buttons(handle).value
END FUNCTION

FUNCTION NEWBUTTON% (spritesheet AS STRING, left AS LONG, top AS LONG, leftactive AS LONG, topactive AS LONG, rightactive AS LONG, bottomactive AS LONG, value AS _BYTE, status AS _BYTE, show AS _BYTE, auto AS _BYTE)
DIM findfreebutton AS INTEGER
DIM spriteheight AS LONG
DIM spritesheetpeek AS LONG
DIM spritewidth AS LONG
SHARED buttons() AS button
IF NOT _FILEEXISTS(spritesheet) THEN EXIT FUNCTION
spritesheetpeek = _LOADIMAGE(spritesheet)
spritewidth = INT(_WIDTH(spritesheetpeek) / 4)
spriteheight = INT(_HEIGHT(spritesheetpeek) / 2)
_FREEIMAGE spritesheetpeek
IF spritesheetpeek = 0 THEN EXIT FUNCTION
IF value < BUTTON_ON THEN value = BUTTON_ON
IF value > BUTTON_OFF THEN value = BUTTON_OFF
IF status > BUTTON_LOCKED THEN status = BUTTON_LOCKED
IF status < BUTTON_UNCREATED THEN status = BUTTON_UNCREATED
IF show < BUTTON_SHOW THEN show = BUTTON_SHOW
IF show > BUTTON_HIDE THEN show = BUTTON_HIDE
IF auto < BUTTON_AUTOUPDATE_ON THEN auto = BUTTON_AUTOUPDATE_ON
IF auto > BUTTON_AUTOUPDATE_OFF THEN auto = BUTTON_AUTOUPDATE_OFF
FOR findfreebutton = 1 TO UBOUND(buttons)
    IF buttons(findfreebutton).inuse = 0 THEN
        NEWBUTTON = findfreebutton
        EXIT FOR
    END IF
NEXT findfreebutton
IF NEWBUTTON = 0 THEN
    REDIM _PRESERVE buttons(UBOUND(buttons) + 1) AS button
    NEWBUTTON = UBOUND(buttons)
END IF
buttons(NEWBUTTON).inuse = -1
buttons(NEWBUTTON).show = show
buttons(NEWBUTTON).value = value
IF status THEN
    buttons(NEWBUTTON).status = status
ELSE
    buttons(NEWBUTTON).status = 1
END IF
buttons(NEWBUTTON).click = 0
buttons(NEWBUTTON).hit = 0
buttons(NEWBUTTON).spritesheet = SPRITESHEETLOAD(spritesheet, spritewidth, spriteheight, SPRITE_NOTRANSPARENCY)
buttons(NEWBUTTON).width = spritewidth
buttons(NEWBUTTON).height = spriteheight
buttons(NEWBUTTON).stand.false = SPRITENEW(buttons(NEWBUTTON).spritesheet, 1, SPRITE_DONTSAVE)
buttons(NEWBUTTON).stand.true = SPRITENEW(buttons(NEWBUTTON).spritesheet, 5, SPRITE_DONTSAVE)
buttons(NEWBUTTON).hover.false = SPRITENEW(buttons(NEWBUTTON).spritesheet, 2, SPRITE_DONTSAVE)
buttons(NEWBUTTON).hover.true = SPRITENEW(buttons(NEWBUTTON).spritesheet, 6, SPRITE_DONTSAVE)
buttons(NEWBUTTON).active.false = SPRITENEW(buttons(NEWBUTTON).spritesheet, 3, SPRITE_DONTSAVE)
buttons(NEWBUTTON).active.true = SPRITENEW(buttons(NEWBUTTON).spritesheet, 7, SPRITE_DONTSAVE)
buttons(NEWBUTTON).locked.false = SPRITENEW(buttons(NEWBUTTON).spritesheet, 4, SPRITE_DONTSAVE)
buttons(NEWBUTTON).locked.true = SPRITENEW(buttons(NEWBUTTON).spritesheet, 8, SPRITE_DONTSAVE)
buttons(NEWBUTTON).area.left = left
buttons(NEWBUTTON).area.top = top
IF rightactive > buttons(NEWBUTTON).area.left + spritewidth THEN rightactive = 0
IF bottomactive > buttons(NEWBUTTON).area.top + spriteheight THEN bottomactive = 0
IF leftactive > 0 THEN
    buttons(NEWBUTTON).activearea.left = leftactive
ELSE
    buttons(NEWBUTTON).activearea.left = left
END IF
IF topactive > 0 THEN
    buttons(NEWBUTTON).activearea.top = topactive
ELSE
    buttons(NEWBUTTON).activearea.top = top
END IF
IF rightactive > buttons(NEWBUTTON).activearea.left THEN
    buttons(NEWBUTTON).activearea.right = rightactive
ELSE
    buttons(NEWBUTTON).activearea.right = left + spritewidth
END IF
IF bottomactive > buttons(NEWBUTTON).activearea.top THEN
    buttons(NEWBUTTON).activearea.bottom = bottomactive
ELSE
    buttons(NEWBUTTON).activearea.bottom = top + spriteheight
END IF
buttons(NEWBUTTON).time = 0
IF auto = BUTTON_AUTOUPDATE_ON THEN
    buttons(NEWBUTTON).timer = _FREETIMER
    ON TIMER(buttons(NEWBUTTON).timer, .025) UPDATEBUTTON NEWBUTTON
    TIMER(buttons(NEWBUTTON).timer) ON
    UPDATEBUTTON NEWBUTTON
ELSE
    buttons(NEWBUTTON).timer = 0
END IF
END FUNCTION

FUNCTION VALIDBUTTON` (handle AS INTEGER)
SHARED buttons() AS button
IF handle > UBOUND(buttons) OR handle = 0 THEN EXIT FUNCTION
IF buttons(handle).inuse = 0 THEN EXIT FUNCTION
VALIDBUTTON = -1
END FUNCTION

'$INCLUDE:'lib\sprite.bi'