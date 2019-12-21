_TITLE "Triangle Fractal"
SCREEN 12

pi = 4 * ATN(1)

REDIM ka(3, 2)
REDIM p(3, 2)
REDIM q(3, 2)

p(1, 1) = 160
p(1, 2) = 360
p(2, 1) = 480
p(2, 2) = 360
p(3, 1) = 320
p(3, 2) = 120

ka(1, 1) = 160
ka(1, 2) = 360
ka(2, 1) = 480
ka(2, 2) = 360
ka(3, 1) = 320
ka(3, 2) = 120

bcolor = 15
tcolor = 15

PSET (p(1, 1), p(1, 2)), bcolor
LINE STEP(0, 0)-(p(2, 1), p(2, 2)), bcolor
LINE STEP(0, 0)-(p(3, 1), p(3, 2)), tcolor
LINE STEP(0, 0)-(p(1, 1), p(1, 2)), tcolor

bcolor = 0

FOR ka = 1 TO 3
    p1x = ka(ka, 1)
    p1y = ka(ka, 2)
    kn = ((ka + 1) MOD 3)
    IF kn = 0 THEN kn = 3
    p2x = ka(kn, 1)
    p2y = ka(kn, 2)
    km = ((ka + 2) MOD 3)
    IF km = 0 THEN km = 3
    p3x = ka(km, 1)
    p3y = ka(km, 2)


    CALL midpoint(p1x, p1y, p2x, p2y, m1, m2)
    CALL midpoint(p1x, p1y, m1, m2, q1x, q1y)
    CALL midpoint(m1, m2, p2x, p2y, q2x, q2y)

    LINE (q1x, q1y)-(q2x, q2y), 0

    disab = distance(q1x, q1y, q2x, q2y)

    r1 = distance(p1x, p1y, p2x, p2y) * (SQR(3) / 2)
    r2 = disab * (SQR(3) / 2)
    r3 = r1 + r2
    rx = COS((pi / 6)) * r3
    ry = SIN((pi / 6)) * r3
    SELECT CASE km
        CASE 1
            q3x = p3x + rx
            q3y = p3y - ry
        CASE 2
            q3x = p3x + rx
            q3y = p3y + ry
        CASE 3
            q3x = p3x
            q3y = p3y + ry
    END SELECT

    LINE (q1x, q1y)-(q3x, q3y), tcolor
    LINE (q2x, q2y)-(q3x, q3y), tcolor

NEXT ka

SUB midpoint (x1, y1, x2, y2, m1, m2)
m1 = (x1 + x2) / 2
m2 = (y1 + y2) / 2
END SUB

FUNCTION distance (x1, y1, x2, y2)
distance = SQR(((x1 - x2) ^ 2) + ((y1 - y2) ^ 2))
END FUNCTION

FUNCTION slope (x1, y1, x2, y2)
slope = (y2 - y1) / (x2 - x1)
END FUNCTION

FUNCTION slopetoangle (m)
slopetoangle = ATN(m)
END FUNCTION