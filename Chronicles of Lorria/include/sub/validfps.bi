'calculates all valid fps options
'precondition: setting must be set
SUB validfps (fpsoption() AS LONG)
DIM fpsoptions AS _UNSIGNED _BYTE
DIM findmultiple AS INTEGER
DIM getfactors AS INTEGER
REDIM fpsoption(255) AS LONG
FOR getfactors = 10 TO Refreshrate / 2
    IF Refreshrate MOD getfactors = 0 THEN
        fpsoptions = fpsoptions + 1
        fpsoption(fpsoptions) = getfactors
    END IF
NEXT getfactors
IF Refreshrate <= setting.lps THEN
    fpsoptions = fpsoptions + 1
    fpsoption(fpsoptions) = Refreshrate
    findmultiple = Refreshrate
    DO
        findmultiple = findmultiple * 2
        IF findmultiple <= setting.lps THEN
            fpsoptions = fpsoptions + 1
            fpsoption(fpsoptions) = findmultiple
        ELSE
            EXIT DO
        END IF
    LOOP
END IF
REDIM _PRESERVE fpsoption(fpsoptions) AS LONG
END SUB