SCREEN 0
SCREEN 12
_TITLE "Mouseball"
DIM BGArray(5000) AS INTEGER
DO
    IF _MOUSEINPUT THEN
        currentx = _MOUSEX
        currenty = _MOUSEY
        IF currentx < 6 THEN
            currentx = 6
        END IF
        IF currentx > 634 THEN
            currentx = 634
        END IF
        IF currenty < 6 THEN
            currenty = 6
        END IF
        IF currenty > 474 THEN
            currenty = 474
        END IF
        IF oldx <> currentx OR oldy <> currenty THEN
            IF oldx THEN
                PUT (oldx - 5, oldy - 5), BGArray(), PSET
            END IF
            GET (currentx - 5, currenty - 5)-(currentx + 5, currenty + 5), BGArray()
            CIRCLE (currentx, currenty), 5, 15
        END IF
        oldx = currentx
        oldy = currenty
    ELSE
        IF _MOUSEX = 0 AND _MOUSEY = 0 AND oldx THEN
            PUT (oldx - 5, oldy - 5), BGArray(), PSET
            GET (currentx - 5, currenty - 5)-(currentx + 5, currenty + 5), BGArray()
        END IF
    END IF
LOOP
SYSTEM