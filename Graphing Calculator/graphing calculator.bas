_TITLE "Grpahing Caclulator"
SCREEN 12
DO
CLEAR
DEFDBL A-Z
DO
_LIMIT 64
CLS
k$ = INKEY$
PRINT "Enter your equation: ";equation$
PRINT "ex\ '4X3+3X2-X+6'"
PRINT "The number after the X is the power, use X not x"
IF (k$ >= CHR$(48) AND k$ <=CHR$(57)) OR k$ = CHR$(88) OR k$ = CHR$(45) OR k$ = CHR$(46) THEN equation$ = equation$ + k$
IF k$ = CHR$(8) AND LEN(equation$) <> 0 THEN equation$ = MID$(equation$, 1, (LEN(equation$) - 1))
IF k$ = (CHR$(0)+CHR$(83)) THEN equation$ = ""
IF k$ = CHR$(27) THEN SYSTEM
_DISPLAY
LOOP UNTIL k$ = CHR$(13)



LOOP