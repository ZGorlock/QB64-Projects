'draws a hexagon
'parameter: the center x coordinate
'parameter: the center y coordinate
'parameter: the side length
'parameter: the color
SUB HEXAGON (x AS SINGLE, y AS SINGLE, s AS LONG, c AS LONG)
DIM side AS _UNSIGNED _BYTE
PSET (x + ((s / 2) * SQR(3)), y + (s / 2)), c
FOR side = 0 TO 5
    DRAW "TA" + STR$(side * 60) + "U" + STR$(s)
NEXT side
DRAW "TA0"
END SUB