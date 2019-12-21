DECLARE SUB LAYER_TINT (handle AS INTEGER, tint AS _UNSIGNED LONG)
DECLARE SUB LAYER_INVERT (handle AS INTEGER)
DECLARE SUB LAYER_GRAYSCALE (handle AS INTEGER)
DECLARE SUB LAYER_LUMINOSITY (handle AS INTEGER)
DECLARE SUB RGBAtoRGB (rgba AS RGBA, rgb AS RGB)
DECLARE SUB RGBtoRGBA (rgb AS RGB, rgba AS RGBA)
DECLARE SUB RGBtoHSL (rgb AS RGB, hsl AS HSL)
DECLARE SUB RGBtoHSV (rgb AS RGB, hsv AS HSV)
DECLARE SUB HSLtoRGB (hsl AS HSL, rgb AS RGB)
DECLARE SUB HSVtoRGB (hsv AS HSV, rgb AS RGB)

TYPE PIXEL
    b AS _UNSIGNED _BYTE
    g AS _UNSIGNED _BYTE
    r AS _UNSIGNED _BYTE
    a AS _UNSIGNED _BYTE
END TYPE
TYPE RGBA
    a AS _UNSIGNED _BYTE
    r AS _UNSIGNED _BYTE
    g AS _UNSIGNED _BYTE
    b AS _UNSIGNED _BYTE
END TYPE
TYPE RGB
    r AS _UNSIGNED _BYTE
    g AS _UNSIGNED _BYTE
    b AS _UNSIGNED _BYTE
END TYPE
TYPE HSV
    h AS INTEGER
    s AS _UNSIGNED _BYTE
    v AS _UNSIGNED _BYTE
END TYPE
TYPE HSL
    h AS INTEGER
    s AS _UNSIGNED _BYTE
    l AS _UNSIGNED _BYTE
END TYPE