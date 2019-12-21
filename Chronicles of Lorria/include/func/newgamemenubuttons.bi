'creates buttons for the new game menu
'parameter: the number of the window sending the request
'parameter: the completion value of the last window
'parameter: the completion value of the next window
'return: the status of the button system
FUNCTION newgamemenubuttons%% (slide AS _BYTE, lastslide AS _BYTE, nextslide AS _BYTE)
DIM lastslidename AS STRING
DIM nextslidename AS STRING
SHARED newgamemenuslides() AS STRING
IF slide > 1 THEN lastslidename = newgamemenuslides(slide - 1)
IF slide < 8 THEN nextslidename = newgamemenuslides(slide + 1)
IF slide = 8 THEN lastslidename = "REVISE"
SELECT CASE lastslide
    CASE 0
        LINE (2, 22)-STEP(84, 20), ctorgb(8), B
        COLOR ctorgb(8)
        _PRINTSTRING (2 + ((84 - (LEN(lastslidename) * 8)) / 2), 25), lastslidename
    CASE 1
        IF isonbox(MInput.x, MInput.y, 2, 22, 86, 42) THEN
            LINE (2, 22)-STEP(84, 20), ctorgb(7), BF
            LINE (2, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(0)
            _PRINTSTRING (2 + ((84 - (LEN(lastslidename$) * 8)) / 2), 25), lastslidename
        ELSE
            LINE (2, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(15)
            _PRINTSTRING (2 + ((84 - (LEN(lastslidename) * 8)) / 2), 25), lastslidename
        END IF
        IF CLICK AND (NOT Newgamemenuoldclick) THEN
            IF isonbox(MInput.x, MInput.y, 2, 22, 86, 42) THEN Newgamemenulast = -1
        END IF
        IF CLICK AND Newgamemenuoldclick THEN
            IF NOT isonbox(MInput.x, MInput.y, 2, 22, 86, 42) THEN Newgamemenulast = 0
        END IF
        IF (NOT CLICK) AND Newgamemenuoldclick THEN
            IF Newgamemenulast THEN
                newgamemenubuttons = -1
                Newgamemenulast = 0
                COLOR ctorgb(15)
                EXIT FUNCTION
            END IF
        END IF
END SELECT
SELECT CASE nextslide
    CASE 0
        LINE (554, 22)-STEP(84, 20), ctorgb(8), B
        COLOR ctorgb(8)
        _PRINTSTRING (554 + ((84 - (LEN(nextslidename) * 8)) / 2), 25), nextslidename
    CASE 1
        IF isonbox(MInput.x, MInput.y, 554, 22, 638, 42) THEN
            LINE (554, 22)-STEP(84, 20), ctorgb(7), BF
            LINE (554, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(0)
            _PRINTSTRING (554 + ((84 - (LEN(nextslidename) * 8)) / 2), 25), nextslidename
        ELSE
            LINE (554, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(15)
            _PRINTSTRING (554 + ((84 - (LEN(nextslidename) * 8)) / 2), 25), nextslidename
        END IF
        IF CLICK AND (NOT Newgamemenuoldclick) THEN
            IF isonbox(MInput.x, MInput.y, 554, 22, 638, 42) THEN Newgamemenunext = -1
        END IF
        IF CLICK AND Newgamemenuoldclick THEN
            IF NOT isonbox(MInput.x, MInput.y, 554, 22, 638, 42) THEN Newgamemenunext = 0
        END IF
        IF (NOT CLICK) AND Newgamemenuoldclick THEN
            IF Newgamemenunext THEN
                newgamemenubuttons = 1
                Newgamemenunext = 0
                COLOR ctorgb(15)
                EXIT FUNCTION
            END IF
        END IF
END SELECT
Newgamemenuoldclick = CLICK
COLOR ctorgb(15)
END FUNCTION