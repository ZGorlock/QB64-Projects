SCREEN 12

PI = 4 * ATN(1)

accuracy = 1800
sinestep = accuracy * 5 / 180

y = 0
FOR x = 0 TO 2 * PI STEP PI / accuracy
    y = y + PI / sinestep
    PSET (320 + ((100 + 2 * SIN(y)) * COS(x)), 240 + ((100 + 2 * SIN(y)) * SIN(x))), 15
NEXT x