'converts the location of the prime stat on the base prime stat hexagon to the location of it in the array
'parameter: the number of the stat on the hexagon (by angle)
'return: the location of the same stat in primestat()
FUNCTION primestathextoloc~%% (hex AS _BYTE)
SELECT CASE hex
    CASE 1
        primestathextoloc = 6
    CASE 2
        primestathextoloc = 3
    CASE 3
        primestathextoloc = 2
    CASE 4
        primestathextoloc = 1
    CASE 5
        primestathextoloc = 5
    CASE 6
        primestathextoloc = 4
END SELECT
END FUNCTION