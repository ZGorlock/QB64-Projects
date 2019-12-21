SUB LAYER_BLUR (handle AS INTEGER, intensity AS _BYTE)
DIM l AS INTEGER
DIM n AS INTEGER
DIM h AS LONG
DIM o AS LONG
DIM w AS LONG
DIM m AS _MEM
DIM p AS PIXEL
DIM q AS PIXEL

IF NOT VALIDLAYER(handle) THEN EXIT SUB
m = _MEMIMAGE(LAYER(handle))


'$CHECKING:OFF
w = _WIDTH(LAYER(handle))
h = _HEIGHT(LAYER(handle))


FOR x = 0 TO w - 1
    FOR y = 0 TO h - 1
        FOR x = x TO x + intensity - 1
            IF x > w - 1 THEN EXIT FOR
            FOR y = y TO y + intensity - 1
                IF y > h - 1 THEN EXIT FOR
                n = n + 1
                _MEMGET m, m.OFFSET + (y * w * 4) + (x * 4), q
                p.a = p.a + q.a
                p.r = p.r + q.r
                p.g = p.g + q.g
                p.b = p.b + q.b
            NEXT y
        NEXT x
        p.a = p.a \ n
        p.r = p.r \ n
        p.g = p.g \ n
        p.b = p.b \ n
        FOR x = x - (n MOD intensity) TO x + intensity - 1
            IF x > w - 1 THEN EXIT FOR
            FOR y = y - (n MOD intensity) TO y + intensity - 1
                IF y > h - 1 THEN EXIT FOR
                _MEMPUT m, m.OFFSET + (y * w * 4) + (x * 4), p
            NEXT y
        NEXT x
        x = x - 1
        y = y - 1
        n = 0
        p.a = 0
        p.r = 0
        p.g = 0
        p.b = 0
NEXT y, x


'$CHECKING:ON

_MEMFREE m


END SUB









SUB LAYER_INVERT (handle AS INTEGER)
DIM o AS LONG
DIM m AS _MEM
DIM p AS PIXEL
IF NOT VALIDLAYER(handle) THEN EXIT SUB
m = _MEMIMAGE(LAYER(handle))
$CHECKING:OFF
DO
    cavg = 0
    _MEMGET m, m.OFFSET + o, p
    p.r = 255 - p.r
    p.g = 255 - p.g
    p.b = 255 - p.b
    _MEMPUT m, m.OFFSET + o, p
    o = o + 4
LOOP UNTIL o > m.SIZE - 4
$CHECKING:ON
_MEMFREE m
END SUB

SUB LAYER_TINT (handle AS INTEGER, tint AS _UNSIGNED LONG)
DIM l AS INTEGER
DIM o AS LONG
DIM m AS _MEM
DIM p AS PIXEL
IF NOT VALIDLAYER(handle) THEN EXIT SUB
l = NEWLAYER(_WIDTH(LAYER(handle)), _HEIGHT(LAYER(handle)), "", 0, LAYER_HIDE)
m = _MEMIMAGE(LAYER(l))
p.a = _ALPHA32(tint)
p.r = _RED32(tint)
p.g = _GREEN32(tint)
p.b = _BLUE32(tint)
$CHECKING:OFF
DO
    _MEMPUT m, m.OFFSET + o, p
    o = o + 4
LOOP UNTIL o > m.SIZE - 4
$CHECKING:ON
_MEMFREE m
_PUTIMAGE , LAYER(l), LAYER(handle)
LAYERFREE l
END SUB

SUB LAYER_GRAYSCALE (handle AS INTEGER)
DIM cavg AS INTEGER
DIM o AS LONG
DIM cgray AS _UNSIGNED LONG
DIM m AS _MEM
DIM p AS PIXEL
IF NOT VALIDLAYER(handle) THEN EXIT SUB
m = _MEMIMAGE(LAYER(handle))
$CHECKING:OFF
DO
    cavg = 0
    _MEMGET m, m.OFFSET + o, p
    cavg = (p.r + p.g + p.b) \ 3
    cgray = _RGBA32(cavg, cavg, cavg, p.a)
    _MEMPUT m, m.OFFSET + o, cgray
    o = o + 4
LOOP UNTIL o > m.SIZE - 4
$CHECKING:ON
_MEMFREE m
END SUB

SUB LAYER_LUMINOSITY (handle AS INTEGER)
DIM cavg AS INTEGER
DIM o AS LONG
DIM cgray AS _UNSIGNED LONG
DIM m AS _MEM
DIM p AS RGBA
IF NOT VALIDLAYER(handle) THEN EXIT SUB
m = _MEMIMAGE(LAYER(handle))
$CHECKING:OFF
DO
    cavg = 0
    _MEMGET m, m.OFFSET + o, p
    cavg = INT((.21 * p.r) + (.71 * p.g) + (.07 * p.b))
    cgray = _RGBA32(cavg, cavg, cavg, p.a)
    _MEMPUT m, m.OFFSET + o, cgray
    o = o + 4
LOOP UNTIL o > m.SIZE - 4
$CHECKING:ON
_MEMFREE m
END SUB

















SUB RGBAtoRGB (rgba AS RGBA, rgb AS RGB)
rgb.b = rgba.b
rgb.g = rgba.g
rgb.r = rgba.r
END SUB

SUB RGBtoRGBA (rgb AS RGB, rgba AS RGBA)
rgba.b = rgb.b
rgba.g = rgb.g
rgba.r = rgb.r
rgba.a = 255
END SUB

SUB RGBtoHSL (rgb AS RGB, hsl AS HSL)
DIM b AS _FLOAT
DIM g AS _FLOAT
DIM h AS _FLOAT
DIM l AS _FLOAT
DIM max AS _FLOAT
DIM min AS _FLOAT
DIM r AS _FLOAT
DIM s AS _FLOAT
r = rgb.r / 256
g = rgb.g / 256
b = rgb.b / 256
max = r
IF g > max THEN max = g
IF b > max THEN max = b
min = r
IF g < min THEN min = g
IF b < min THEN min = b
IF max = min THEN
    h = 0
    s = 0
    l = r
ELSE
    l = (min + max) / 2
    IF l < .5 THEN
        s = (max - min) / (max + min)
    ELSE
        s = (max - min) / (2 - max - min)
    END IF
    IF r = max THEN
        h = (g - b) / (max - min)
    ELSE IF g = max THEN
            h = 2 + (b - r) / (max - min)
        ELSE
            h = 4 + (r - g) / (max - min)
        END IF
    END IF
    h = h / 6
    IF h < 0 THEN h = h + 1
END IF
hsl.h = INT(h * 255)
hsl.s = INT(s * 255)
hsl.l = INT(l * 255)
END SUB

SUB RGBtoHSV (rgb AS RGB, hsv AS HSV)
DIM b AS _FLOAT
DIM g AS _FLOAT
DIM h AS _FLOAT
DIM max AS _FLOAT
DIM min AS _FLOAT
DIM r AS _FLOAT
DIM s AS _FLOAT
DIM v AS _FLOAT
r = rgb.r / 256
g = rgb.g / 256
b = rgb.b / 256
max = r
IF g > max THEN max = g
IF b > max THEN max = b
min = r
IF g < min THEN min = g
IF b < min THEN min = b
v = max
IF max = 0 THEN
    s = 0
ELSE
    s = (max - min) / max
END IF
IF s = 0 THEN
    h = 0
ELSE
    IF r = max THEN
        h = (g - b) / (max - min)
    ELSE IF g = max THEN
            h = 2 + (b - r) / (max - min)
        ELSE
            h = 4 + (r - g) / (max - min)
        END IF
    END IF
    h = h / 6
    IF h < 0 THEN h = h + 1
END IF
hsv.h = INT(h * 255)
hsv.s = INT(s * 255)
hsv.v = INT(v * 255)
END SUB

SUB HSLtoRGB (hsl AS HSL, rgb AS RGB)
DIM b AS _FLOAT
DIM g AS _FLOAT
DIM h AS _FLOAT
DIM l AS _FLOAT
DIM r AS _FLOAT
DIM s AS _FLOAT
DIM temp1 AS _FLOAT
DIM temp2 AS _FLOAT
DIM tempr AS _FLOAT
DIM tempg AS _FLOAT
DIM tempb AS _FLOAT
h = hsl.h / 256
s = hsl.s / 256
l = hsl.l / 256
IF s = 0 THEN
    r = l
    g = l
    b = l
ELSE
    IF l < .5 THEN
        temp2 = l * (1 + s)
    ELSE
        temp2 = (l + s) - (l * s)
    END IF
    temp1 = 2 * l - temp2
    tempr = h + 1 / 3
    IF tempr > l THEN tempr = tempr - 1
    tempg = h
    tempb = h - 1 / 3
    IF tempb < 0 THEN tempb = tempb + 1
    IF tempr < 1 / 6 THEN
        r = temp1 + (temp2 - temp1) * 6 * tempr
    ELSE IF tempr < .5 THEN
            r = temp2
        ELSE IF tempr < 2 / 3 THEN
                r = temp1 + (temp2 - temp1) * ((2 / 3) - tempr) * 6
            ELSE
                r = temp1
            END IF
        END IF
    END IF
    IF tempg < 1 / 6 THEN
        g = temp1 + (temp2 - temp1) * 6 * tempg
    ELSE IF tempg < .5 THEN
            g = temp2
        ELSE IF tempg < 2 / 3 THEN
                g = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - tempg) * 6.0
            ELSE
                g = temp1
            END IF
        END IF
    END IF
    IF tempb < 1.0 / 6.0 THEN
        b = temp1 + (temp2 - temp1) * 6.0 * tempb
    ELSE IF tempb < 0.5 THEN
            b = temp2
        ELSE IF tempb < 2.0 / 3.0 THEN
                b = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - tempb) * 6.0
            ELSE
                b = temp1
            END IF
        END IF
    END IF
    rgb.r = r
    rgb.g = g
    rgb.b = b
END IF
END SUB

SUB HSVtoRGB (hsv AS HSV, rgb AS RGB)
DIM i AS INTEGER
DIM b AS _FLOAT
DIM f AS _FLOAT
DIM g AS _FLOAT
DIM h AS _FLOAT
DIM p AS _FLOAT
DIM q AS _FLOAT
DIM r AS _FLOAT
DIM s AS _FLOAT
DIM t AS _FLOAT
DIM v AS _FLOAT
h = hsv.h / 256
s = hsv.s / 256
v = hsv.v / 256
IF s = 0 THEN
    r = v
    g = v
    b = v
ELSE
    h = h * 6
    i = INT(h)
    f = h - i
    p = v * (1 - s)
    q = v * (1 - (s * f))
    t = v * (1 - (s * (1 - f)))
    SELECT CASE i
        CASE 0
            r = v
            g = t
            b = p
        CASE 1
            r = q
            g = v
            b = p
        CASE 2
            r = p
            g = v
            b = t
        CASE 3
            r = p
            g = q
            b = v
        CASE 4
            r = t
            g = p
            b = v
        CASE 5
            r = v
            g = p
            b = q
    END SELECT
END IF
rgb.r = INT(r * 255)
rgb.g = INT(g * 255)
rgb.b = INT(b * 255)
END SUB
