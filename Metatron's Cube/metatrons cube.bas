_TITLE "Metatron's Cube"
SCREEN 12

DIM points(13, 2) AS SINGLE

COLOR 0
PSET (320, 240)
GOSUB addpoints
FOR fruit = 0 TO 5
    PSET (320, 240)
    DRAW "TA" + STR$(60 * fruit)
    DRAW "BU90"
    GOSUB addpoints
    DRAW "BU90"
    GOSUB addpoints
NEXT fruit
COLOR 7
FOR body = 1 TO 13
    CIRCLE (points(body, 1), points(body, 2)), 45
NEXT body
COLOR 15
FOR connecta = 1 TO 13
    FOR connectb = 1 TO 13
        LINE (points(connecta, 1), points(connecta, 2))-(points(connectb, 1), points(connectb, 2))
NEXT connectb, connecta
SLEEP
SYSTEM

addpoints:
points = points + 1
points(points, 1) = POINT(2)
points(points, 2) = POINT(1)
RETURN