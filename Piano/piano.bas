_TITLE "Piano"
CLS
PRINT "     3-C+  4-D+        6-F+  7-G+  8-A+"
PRINT "   w-C   e-D   r-E    t-F   y-G   u-A"
PRINT
PRINT "      v- <-Octave      n- ->Octave"
octave = 3
DO
_LIMIT 100
key$ = INKEY$
play$ = ""
IF key$ <> CHR$(99) THEN
octavedown = 0
END IF
IF key$ = CHR$(99) AND octavedown = 0 THEN
octave = octave - 1
IF octave < 1 THEN
octave = 1
END IF
octavenum$ = STR$(octave)
octavenum$ = LTRIM$(octave$)
octave$ = "O" + octavenum$
octavedown = 1
END IF
IF key$ <> CHR$(110) THEN
octaveup = 0
END IF
IF key$ = CHR$(110) AND octaveup = 0 THEN
octave = octave - 1
IF octave < 1 THEN
octave = 1
END IF
octaveup = 1
END IF
IF key$ = CHR$(119) THEN
play$ = play$ + "C"
END IF




octavenum$ = STR$(octave)
octavenum$ = LTRIM$(octave$)
octave$ = "O" + octavenum$
play$ = octave$ + 
PLAY play$
LOOP