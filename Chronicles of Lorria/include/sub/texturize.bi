'puts a texture over an area of the screen
'parameter: the filename of a seamless tile image
'parameter: the desired width of the tile in pixels, 0 for actual size
'parameter: the desired height of the tile in pixels, 0 for actual size
'parameter: the area of the screen to be texturized
SUB texturize (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG, destleft AS LONG, desttop AS LONG, destright AS LONG, destbottom AS LONG)
DIM putextratexturex AS _UNSIGNED _BYTE
DIM putextratexturey AS _UNSIGNED _BYTE
DIM puttexturex AS _UNSIGNED _BYTE
DIM puttexturey AS _UNSIGNED _BYTE
DIM destheight AS LONG
DIM destwidth AS LONG
DIM texture AS LONG
DIM textureheight AS LONG
DIM texturewidth AS LONG
DIM xextraspace AS SINGLE
DIM xextratexture AS SINGLE
DIM yextraspace AS SINGLE
DIM yextratexture AS SINGLE
SHARED textures() AS STRING
texture = _LOADIMAGE("resource\image\texture\" + textures(texturechoice))
destright = destright + 1
destbottom = destbottom + 1
IF texture THEN
    destheight = destbottom - desttop
    destwidth = destright - destleft
    IF width THEN
        texturewidth = width
    ELSE
        texturewidth = _WIDTH(texture)
    END IF
    IF height THEN
        textureheight = height
    ELSE
        textureheight = _HEIGHT(texture)
    END IF
    FOR puttexturex = 1 TO INT(destwidth / texturewidth)
        FOR puttexturey = 1 TO INT(destheight / textureheight)
            _PUTIMAGE (destleft + (puttexturex - 1) * texturewidth, desttop + (puttexturey - 1) * textureheight)-(destleft + puttexturex * texturewidth, desttop + puttexturey * textureheight), texture, dest
    NEXT puttexturey, puttexturex
    xextraspace = destwidth MOD texturewidth
    xextratexture = xextraspace * (_WIDTH(texture) / texturewidth)
    IF xextraspace THEN
        FOR putextratexturey = 1 TO INT(destheight / textureheight)
            MAPRECT texture, 0, 0, xextratexture, _HEIGHT(texture), dest, destright - xextraspace, desttop + (putextratexturey - 1) * textureheight, destright, desttop + putextratexturey * textureheight
        NEXT putextratexturey
    END IF
    yextraspace = destheight MOD textureheight
    yextratexture = yextraspace * (_HEIGHT(texture) / textureheight)
    IF yextraspace THEN
        FOR putextratexturex = 1 TO INT(destwidth / texturewidth)
            MAPRECT texture, 0, 0, _WIDTH(texture), yextratexture, dest, destleft + (putextratexturex - 1) * texturewidth, destbottom - yextraspace, destleft + putextratexturex * texturewidth, destbottom
        NEXT putextratexturex
    END IF
    IF xextraspace * yextraspace THEN
        MAPRECT texture, 0, 0, xextratexture, yextratexture, dest, destright - xextraspace, destbottom - yextraspace, destright, destbottom
    END IF
    _FREEIMAGE texture
END IF
END SUB