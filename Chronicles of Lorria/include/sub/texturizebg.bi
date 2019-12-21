'creates a background image
'parameter: the filename of a seamless tile image
'parameter: the desired width of the tile in pixels, 0 for actual size
'parameter: the desired height of the tile in pixels, 0 for actual size
SUB texturizebg (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG)
DIM putbgtexturex AS _UNSIGNED _BYTE
DIM putbgtexturey AS _UNSIGNED _BYTE
DIM bgtexture AS LONG
DIM textureheight AS LONG
DIM texturewidth AS LONG
SHARED textures() AS STRING
bgtexture = _LOADIMAGE("resource\image\texture\" + textures(texturechoice))
IF bgtexture THEN
    IF width * height THEN
        texturewidth = _WIDTH(bgtexture)
        textureheight = _HEIGHT(bgtexture)
        FOR putbgtexturex = 1 TO (INT(SCRX / texturewidth) + 1)
            FOR putbgtexturey = 1 TO (INT(SCRY / textureheight) + 1)
                _PUTIMAGE ((putbgtexturex - 1) * texturewidth, (putbgtexturey - 1) * textureheight)-(putbgtexturex * texturewidth, putbgtexturey * textureheight), bgtexture, dest
        NEXT putbgtexturey, putbgtexturex
    ELSE
        FOR putbgtexturex = 1 TO (INT(SCRX / width) + 1)
            FOR putbgtexturey = 1 TO (INT(SCRY / height) + 1)
                _PUTIMAGE ((putbgtexturex - 1) * width, (putbgtexturey - 1) * height)-(putbgtexturex * width, putbgtexturey * height), bgtexture, dest
        NEXT putbgtexturey, putbgtexturex
    END IF
    _FREEIMAGE bgtexture
END IF
END SUB