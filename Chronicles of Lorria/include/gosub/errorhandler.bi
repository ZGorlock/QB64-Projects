'writes errors to the error log
errorhandler:
DIM printerror AS _BIT
DIM checkerror AS INTEGER
DIM errorcount AS INTEGER
DIM errornum AS INTEGER
errornum = ERR
printerror = TRUE
FOR checkerror = 1 TO UBOUND(errors)
    IF errors(checkerror).err = errornum AND errors(checkerror).line = _ERRORLINE THEN
        errors(checkerror).count = errors(checkerror).count + 1
        printerror = FALSE
        EXIT FOR
    END IF
NEXT checkerror
IF printerror THEN
    errorcount = UBOUND(errors) + 1
    PRINT #32766, TSTAMP; " - "; Module$; " - "; TRIMnum$(errornum); " ("; TRIMnum$(_ERRORLINE); ")"
    REDIM _PRESERVE errors(errorcount) AS errorhandle
    errors(errorcount).err = errornum
    errors(errorcount).line = _ERRORLINE
    errors(errorcount).count = 1
END IF
RESUME NEXT