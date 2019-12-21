_TITLE "Studded"
SCREEN _NEWIMAGE(640, 480, 32)
CLS
PAINT (1, 1), _RGBA(255, 255, 255, 255)
FOR xcube = 0 TO 639 STEP 16
    FOR ycube = 0 TO 479 STEP 16
        drawcube = cubedraw(xcube, ycube)
    NEXT ycube
NEXT xcube
_DISPLAY
SLEEP
SYSTEM

FUNCTION cubedraw (x, y)
PSET (x, y), _RGBA(1, 1, 1, 255)
DRAW "R15 D15 L15 U15"
LINE (x, y)-(x + 15, y + 15), _RGBA(1, 1, 1, 255)
LINE (x + 15, y)-(x, y + 15), _RGBA(1, 1, 1, 255)
PAINT (x + 7, y + 4), _RGBA(1, 1, 1, 64), _RGBA(1, 1, 1, 255)
PAINT (x + 12, y + 7), _RGBA(1, 1, 1, 128), _RGBA(1, 1, 1, 255)
PAINT (x + 4, y + 7), _RGBA(1, 1, 1, 128), _RGBA(1, 1, 1, 255)
PAINT (x + 7, y + 12), _RGBA(1, 1, 1, 255)
END FUNCTION
