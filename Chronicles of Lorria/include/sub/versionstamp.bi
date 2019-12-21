'prints the version number to the screen
'parameter: the corner to print the version to
SUB versionstamp (sector AS _BYTE)
DIM versionprint AS STRING
versionprint = "v" + STRING$(-1 * (Version < 1), 48) + TRIMnum$(Version)
COLOR ctorgb(8)
_FONT fonts(1)
SELECT CASE sector
    CASE 1
        _PRINTSTRING (SCRX - _PRINTWIDTH(versionprint), 0), versionprint
    CASE 2
        _PRINTSTRING (0, 0), versionprint
    CASE 3
        _PRINTSTRING (0, SCRY - _FONTHEIGHT), versionprint
    CASE 4
        _PRINTSTRING (SCRX - _PRINTWIDTH(versionprint), SCRY - _FONTHEIGHT), versionprint
END SELECT
COLOR Textcolor
_FONT fonts(FONT_DEFAULT)
END SUB