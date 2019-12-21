'loads cursor images
SUB getcursor
DIM cursorsheetloc AS STRING
DIM cursorcellstart AS LONG
IF Cursorsheet THEN
    SPRITEFREE Cursorstand
    SPRITEFREE Cursorhover
    SPRITEFREE Cursoraction
    SPRITEFREE Cursorhit
    SHEETFREE Cursorsheet
END IF
cursorsheetloc = "resource\image\cursor\" + cursors(setting.cursor) + ".png"
IF NOT _FILEEXISTS(cursorsheetloc) THEN
    setting.cursor = 1
    cursorsheetloc = "resource\image\cursor\" + cursors(setting.cursor) + ".png"
END IF
Cursorsheet = SPRITESHEETLOAD(cursorsheetloc, cursordata(setting.cursor, 1), cursordata(setting.cursor, 2), SPRITE_NOTRANSPARENCY)
IF Cursorsheet THEN
    IF setting.cursorcolor > cursordata(setting.cursor, 3) OR setting.cursorcolor < 1 THEN setting.cursorcolor = 1
    cursorcellstart = ((setting.cursorcolor - 1) * 4)
    Cursorstand = SPRITENEW(Cursorsheet, cursorcellstart + 1, SPRITE_DONTSAVE)
    Cursorhover = SPRITENEW(Cursorsheet, cursorcellstart + 2, SPRITE_DONTSAVE)
    Cursoraction = SPRITENEW(Cursorsheet, cursorcellstart + 3, SPRITE_DONTSAVE)
    Cursorhit = SPRITENEW(Cursorsheet, cursorcellstart + 4, SPRITE_DONTSAVE)
END IF
END SUB