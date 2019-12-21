_SCREENHIDE
_TITLE "Box Maker"
SCREEN 12
_SCREENSHOW

DO
    _LIMIT 64
    CLS
    IF p THEN
        PSET (px, py), 15
        DRAW "D" + LTRIM$(RTRIM$(STR$((_MOUSEY - py)))) + "R" + LTRIM$(RTRIM$(STR$((_MOUSEX - px)))) + "U" + LTRIM$(RTRIM$(STR$((_MOUSEY - py)))) + "L" + LTRIM$(RTRIM$(STR$((_MOUSEX - px))))
    END IF
    DO WHILE _MOUSEINPUT
        IF _MOUSEBUTTON(1) THEN
            IF q = 0 THEN
                p = 1
                px = _MOUSEX
                py = _MOUSEY
                q = 1
            END IF
        ELSE
            p = 0
            q = 0
        END IF
    LOOP
    _DISPLAY
LOOP UNTIL INKEY$ <> ""
SYSTEM