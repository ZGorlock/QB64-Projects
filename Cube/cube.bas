_SCREENHIDE

ON ERROR GOTO sierr
OPEN "si.tmp" FOR OUTPUT AS #3
LOCK #3
sierrpass:
ON ERROR GOTO 0

_TITLE "Unnamed Program about Cubes"
SCREEN 13
icon& = _LOADIMAGE("icon.png")
_ICON icon&
SCREEN 12

DIM SHARED cubes&
DIM SHARED deskwid&
DIM SHARED deskhei&
DIM SHARED factor&
DIM SHARED PSRT##(1 TO 4, 1 TO 4)
DIM SHARED xdir##
DIM SHARED ydir##
DIM SHARED zdir##

GOSUB setvar

REDIM SHARED cubedata(32)
REDIM SHARED cubedata$(32)
REDIM SHARED cubes$(32768)
REDIM SHARED sectordata(262144, 3, 3)
REDIM SHARED points(262144, 3, 8)

GOSUB loaddata

_SCREENSHOW

CALL camera

DO
    _LIMIT 64
    CLS
    GOSUB timetrack
    GOSUB cubes
    GOSUB getinput
    CALL camera
    _DISPLAY
LOOP

cubes:
FOR cube = 1 TO cubes&
    GOSUB points
    GOSUB lines
NEXT cube
RETURN

getinput:
IF _EXIT THEN GOSUB xcleanup
IF INKEY$ <> "" THEN
    IF _KEYDOWN(27) THEN GOSUB xcleanup
    IF _KEYDOWN(65) OR _KEYDOWN(97) THEN xdir## = xdir## + (factor& * (euler## / 100))
    IF _KEYDOWN(68) OR _KEYDOWN(100) THEN xdir## = xdir## - (factor& * (euler## / 100))
    IF _KEYDOWN(90) OR _KEYDOWN(122) THEN ydir## = ydir## + (factor& * (euler## / 100))
    IF _KEYDOWN(81) OR _KEYDOWN(113) THEN ydir## = ydir## - (factor& * (euler## / 100))
    IF _KEYDOWN(83) OR _KEYDOWN(115) THEN zdir## = zdir## + factor&
    IF _KEYDOWN(87) OR _KEYDOWN(119) THEN zdir## = zdir## - factor&
END IF
RETURN

loaddata:
OPEN "data.txt" FOR INPUT AS #1
LINE INPUT #1, world$
LINE INPUT #1, worldtype$
LINE INPUT #1, costume$
LINE INPUT #1, userposx$
LINE INPUT #1, userposy$
LINE INPUT #1, userposz$
LINE INPUT #1, totaltime$
CLOSE #1
GOSUB sector
worldtype = VAL(worldtype$)
costume = VAL(costume$)
userposx = VAL(userposx$)
userposy = VAL(userposy$)
userposz = VAL(userposz$)
totaltime&& = VAL(totaltime$)
RETURN

lines:
CALL linebetween(points(cube, 1, 1), points(cube, 2, 1), points(cube, 3, 1), points(cube, 1, 2), points(cube, 2, 2), points(cube, 3, 2), colour)
CALL linebetween(points(cube, 1, 3), points(cube, 2, 3), points(cube, 3, 3), points(cube, 1, 4), points(cube, 2, 4), points(cube, 3, 4), colour)
CALL linebetween(points(cube, 1, 1), points(cube, 2, 1), points(cube, 3, 1), points(cube, 1, 5), points(cube, 2, 5), points(cube, 3, 5), colour)
CALL linebetween(points(cube, 1, 2), points(cube, 2, 2), points(cube, 3, 2), points(cube, 1, 6), points(cube, 2, 6), points(cube, 3, 6), colour)
CALL linebetween(points(cube, 1, 7), points(cube, 2, 7), points(cube, 3, 7), points(cube, 1, 3), points(cube, 2, 3), points(cube, 3, 3), colour)
CALL linebetween(points(cube, 1, 7), points(cube, 2, 7), points(cube, 3, 7), points(cube, 1, 8), points(cube, 2, 8), points(cube, 3, 8), colour)
CALL linebetween(points(cube, 1, 8), points(cube, 2, 8), points(cube, 3, 8), points(cube, 1, 5), points(cube, 2, 5), points(cube, 3, 5), colour)
CALL linebetween(points(cube, 1, 2), points(cube, 2, 2), points(cube, 3, 2), points(cube, 1, 3), points(cube, 2, 3), points(cube, 3, 3), colour)
CALL linebetween(points(cube, 1, 1), points(cube, 2, 1), points(cube, 3, 1), points(cube, 1, 4), points(cube, 2, 4), points(cube, 3, 4), colour)
CALL linebetween(points(cube, 1, 6), points(cube, 2, 6), points(cube, 3, 6), points(cube, 1, 7), points(cube, 2, 7), points(cube, 3, 7), colour)
CALL linebetween(points(cube, 1, 8), points(cube, 2, 8), points(cube, 3, 8), points(cube, 1, 4), points(cube, 2, 4), points(cube, 3, 4), colour)
CALL linebetween(points(cube, 1, 6), points(cube, 2, 6), points(cube, 3, 6), points(cube, 1, 5), points(cube, 2, 5), points(cube, 3, 5), colour)
RETURN

points:
FOR printpoints = 1 TO 8
    CALL project(points(cube, 1, printpoints), points(cube, 2, printpoints), points(cube, 3, printpoints), scx##, scy##)
    PSET (scx##, scy##), colour
    '_PRINTSTRING (scx##, scy##), STR$(printpoints) + "~" + STR$(points(cube, 1, printpoints)) + STR$(points(cube, 2, printpoints)) + STR$(points(cube, 3, printpoints))
NEXT printpoints
RETURN

sector:
OPEN "sector1.txt" FOR BINARY AS #1
GET #1, , sectordata()
CLOSE #1
FOR parsesector = 1 TO 262144
    IF sectordata(parsesector, 0, 0) = 1 THEN
        cubes& = cubes& + 1
        points(cubes&, 0, 0) = 1
        points(cubes&, 0, 1) = sectordata(parsesector, 0, 1)
        points(cubes&, 0, 2) = sectordata(parsesector, 0, 2)
        points(cubes&, 1, 1) = sectordata(parsesector, 1, 1)
        points(cubes&, 2, 1) = sectordata(parsesector, 2, 1)
        points(cubes&, 3, 1) = sectordata(parsesector, 3, 1)
        CALL pointinfer(cubes&)
    END IF
NEXT parsesector
RETURN

setvar:
deskwid& = 640
deskhei& = 480
zdir## = 6
ydir## = 0
xdir## = 0
factor& = 1
pi## = 4 * ATN(4)
FOR finde = 1 TO 16
    edenom = 1
    FOR findenom = 1 TO finde
        edenom = edenom * findenom
    NEXT findenom
    euler## = euler## + (1 / edenom)
NEXT finde
euler## = euler## + 1
colour = 15
RETURN

sierr:
IF ERR = 70 THEN SYSTEM
GOTO sierrpass

timetrack:
IF INT(TIMER) <> oldtimer THEN totaltime&& = totaltime&& + 1
daytime = totaltime&& MOD 3600
oldtimer = INT(TIMER)
RETURN

updatedata:
OPEN "data.txt" FOR OUTPUT AS #1
PRINT #1, world$
PRINT #1, STR$(worldtype)
PRINT #1, STR$(costume)
PRINT #1, STR$(userposx)
PRINT #1, STR$(userposy)
PRINT #1, STR$(userposz)
PRINT #1, STR$(totaltime&&)
CLOSE #1
OPEN "sector1.txt" FOR BINARY AS #1
PUT #1, , sectordata()
CLOSE #1
RETURN

xcleanup:
GOSUB updatedata
CLEAR
CLOSE
KILL "si.tmp"
SYSTEM
RETURN

SUB camera
DIM V##(1 TO 3)
DIM Ni##(1 TO 3)
DIM Ro##(1 TO 3)
DIM Woo##(1 TO 3)
DIM UP##(1 TO 3)
near## = .1
far## = 1000
UP##(1) = 0
UP##(2) = 1
UP##(3) = 0
V##(1) = zdir## * COS(ydir##) * COS(xdir##)
V##(2) = zdir## * SIN(ydir##)
V##(3) = zdir## * SIN(xdir##) * COS(ydir##)
kapa## = near## / far##
Ni##(1) = V##(1) / (SQR(V##(1) ^ 2 + V##(2) ^ 2 + V##(3) ^ 2))
Ni##(2) = V##(2) / (SQR(V##(1) ^ 2 + V##(2) ^ 2 + V##(3) ^ 2))
Ni##(3) = V##(3) / (SQR(V##(1) ^ 2 + V##(2) ^ 2 + V##(3) ^ 2))
Ro##(1) = UP##(2) * Ni##(3) - UP##(3) * Ni##(2)
Ro##(2) = UP##(3) * Ni##(1) - UP##(1) * Ni##(3)
Ro##(3) = UP##(1) * Ni##(2) - UP##(2) * Ni##(1)
Modro = SQR((Ro##(1) ^ 2) + (Ro##(2) ^ 2) + (Ro##(3) ^ 2))
Ro##(1) = Ro##(1) / Modro
Ro##(2) = Ro##(2) / Modro
Ro##(3) = Ro##(3) / Modro
Woo##(1) = Ni##(2) * Ro##(3) - Ni##(3) * Ro##(2)
Woo##(2) = Ni##(3) * Ro##(1) - Ni##(1) * Ro##(3)
Woo##(3) = Ni##(1) * Ro##(2) - Ni##(2) * Ro##(1)
aspratio = deskhei& / deskwid&
PSRT##(1, 1) = -aspratio * ((Ro##(1)) / (far##))
PSRT##(1, 2) = aspratio * ((Ro##(2)) / (far##))
PSRT##(1, 3) = -aspratio * ((Ro##(3)) / (far##))
PSRT##(1, 4) = aspratio * ((-V##(1) * Ro##(1) - V##(2) * Ro##(2) - V##(3) * Ro##(3)) / (far##))
PSRT##(2, 1) = -Woo##(1) / far##
PSRT##(2, 2) = Woo##(2) / far##
PSRT##(2, 3) = -Woo##(3) / far##
PSRT##(2, 4) = (-V##(1) * Woo##(1) - V##(2) * Woo##(2) - V##(3) * Woo##(3)) / far##
PSRT##(3, 1) = -Ni##(1) / (far## * (kapa## - 1))
PSRT##(3, 2) = Ni##(2) / (far## * (kapa## - 1))
PSRT##(3, 3) = -Ni##(3) / (far## * (kapa## - 1))
PSRT##(3, 4) = ((-V##(1) * Ni##(1) - V##(2) * Ni##(2) - V##(3) * Ni##(3)) / (far## * (kapa## - 1))) + kapa## / (kapa## - 1)
PSRT##(4, 1) = -(-Ni##(1) / far##)
PSRT##(4, 2) = (-Ni##(2) / far##)
PSRT##(4, 3) = -(-Ni##(3) / far##)
PSRT##(4, 4) = (-V##(1) * Ni##(1) - V##(2) * Ni##(2) - V##(3) * Ni##(3)) / far##
END SUB

SUB linebetween (p1x, p1y, p1z, p2x, p2y, p2z, clchoi)
CALL project(p1x, p1y, p1z, a1x##, a1y##)
CALL project(p2x, p2y, p2z, a2x##, a2y##)
LINE (a1x##, a1y##)-(a2x##, a2y##), clchoi
END SUB

SUB mult4x1 (A##(), b##(), result##())
result##(1) = A##(1, 1) * b##(1) + A##(1, 2) * b##(2) + A##(1, 3) * b##(3) + A##(1, 4) * b##(4)
result##(2) = A##(2, 1) * b##(1) + A##(2, 2) * b##(2) + A##(2, 3) * b##(3) + A##(2, 4) * b##(4)
result##(3) = A##(3, 1) * b##(1) + A##(3, 2) * b##(2) + A##(3, 3) * b##(3) + A##(3, 4) * b##(4)
result##(4) = A##(4, 1) * b##(1) + A##(4, 2) * b##(2) + A##(4, 3) * b##(3) + A##(4, 4) * b##(4)
END SUB

SUB pointinfer (cube)
p1x = points(cube, 1, 1)
p1y = points(cube, 2, 1)
p1z = points(cube, 3, 1)
p1t = points(cube, 0, 1)
SELECT CASE p1t
    CASE 1
        points(cube, 0, 2) = 1
END SELECT
points(cube, 1, 2) = p1x
points(cube, 2, 2) = p1y
points(cube, 3, 2) = p1z + 1
points(cube, 1, 3) = p1x + 1
points(cube, 2, 3) = p1y
points(cube, 3, 3) = p1z + 1
points(cube, 1, 4) = p1x + 1
points(cube, 2, 4) = p1y
points(cube, 3, 4) = p1z
points(cube, 1, 5) = p1x
points(cube, 2, 5) = p1y - 1
points(cube, 3, 5) = p1z
points(cube, 1, 6) = p1x
points(cube, 2, 6) = p1y - 1
points(cube, 3, 6) = p1z + 1
points(cube, 1, 7) = p1x + 1
points(cube, 2, 7) = p1y - 1
points(cube, 3, 7) = p1z + 1
points(cube, 1, 8) = p1x + 1
points(cube, 2, 8) = p1y - 1
points(cube, 3, 8) = p1z
END SUB

SUB project (x##, y##, z##, scx##, scy##)
DIM vectorized##(1 TO 4)
DIM P##(1 TO 4)
vectorized##(1) = x##
vectorized##(2) = y##
vectorized##(3) = z##
vectorized##(4) = 1
CALL mult4x1(PSRT##(), vectorized##(), P##())
scx## = (deskwid& / 2) * (P##(1) / P##(4) + 1)
scy## = (deskhei& / 2) * (P##(2) / P##(4) + 1)
END SUB





FUNCTION dot## (a() AS _FLOAT, b() AS _FLOAT)
'dot product of a and b
dot## = a(0) * b(0) + a(1) * b(1) + a(2) * b(2)
END FUNCTION

SUB cross (a() AS _FLOAT, b() AS _FLOAT, c() AS _FLOAT)
'cross product of a and b, result stored in c
c(0) = a(1) * b(2) - a(2) * b(1)
c(1) = a(2) * b(0) - a(0) * b(2)
c(2) = a(0) * b(1) - a(1) * b(0)
END SUB

SUB subtract (a() AS _FLOAT, b() AS _FLOAT, ab() AS _FLOAT)
'subtract a from b, store result in ab
ab(0) = b(0) - a(0)
ab(1) = b(1) - a(1)
ab(2) = b(2) - a(2)
END SUB

FUNCTION cull% (V() AS _FLOAT, A() AS _FLOAT, B() AS _FLOAT, C() AS _FLOAT)
'given camera position V and polygon vertices A,B,C
'returns -1 if it should be drawn, 0 if not
DIM AB(3) AS _FLOAT
DIM AC(3) AS _FLOAT
DIM SN(3) AS _FLOAT 'surface normal
DIM VA(3) AS _FLOAT
subtract A(), B(), AB()
cross AB(), AC(), SN()
subtract V(), A(), VA()
IF dot##(SN(), VA()) < 0 THEN
    cull% = -1
ELSE
    cull% = 0
END IF
END FUNCTION