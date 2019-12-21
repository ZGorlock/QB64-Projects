'$INCLUDE:'GL_consts.bas'
DEFLNG A-Z

REDIM SHARED LoadTexture_Buffer(1) AS LONG 'used by the FUNCTION LoadTexture
REDIM SHARED LoadTexture_Buffer2(1) AS LONG

SCREEN _NEWIMAGE(800, 600, 32)

gl_X = 640: gl_Y = 480
GL_Setup gl_X, gl_Y

glEnable GL_DEPTH_TEST
glDepthMask GL_TRUE
glClearDepth 1
glMatrixMode GL_PROJECTION
glLoadIdentity
gluPerspective 90, 1, 1, 500
glEnable GL_TEXTURE_2D
glColor4f 1, 1, 1, 1

up = LoadTexture("up.jpg")
aster = LoadTexture("aster.jpg")

DO
    DO WHILE _MOUSEINPUT
        rz = rz + _MOUSEWHEEL
    LOOP
    k$ = INKEY$

    glClear GL_DEPTH_BUFFER_BIT + GL_COLOR_BUFFER_BIT
    glMatrixMode GL_MODELVIEW
    glLoadIdentity
    glTranslatef 0, 0, -200

    glRotatef _MOUSEX, 0, 1, 0
    glRotatef _MOUSEY, 1, 0, 0
    glRotatef rz * 20, 0, 0, 1

    SelectTexture aster: glBegin GL_QUADS

    'a cube
    glTexCoord2f 0, 0: glVertex3f -50, -50, -50
    glTexCoord2f 0, 1: glVertex3f -50, 50, -50
    glTexCoord2f 1, 1: glVertex3f 50, 50, -50
    glTexCoord2f 1, 0: glVertex3f 50, -50, -50

    glTexCoord2f 0, 0: glVertex3f -50, -50, 50
    glTexCoord2f 0, 1: glVertex3f -50, 50, 50
    glTexCoord2f 1, 1: glVertex3f 50, 50, 50
    glTexCoord2f 1, 0: glVertex3f 50, -50, 50

    glTexCoord2f 0, 0: glVertex3f -50, -50, -50
    glTexCoord2f 0, 1: glVertex3f -50, 50, -50
    glTexCoord2f 1, 1: glVertex3f -50, 50, 50
    glTexCoord2f 1, 0: glVertex3f -50, -50, 50

    glTexCoord2f 0, 0: glVertex3f 50, -50, -50
    glTexCoord2f 0, 1: glVertex3f 50, 50, -50
    glTexCoord2f 1, 1: glVertex3f 50, 50, 50
    glTexCoord2f 1, 0: glVertex3f 50, -50, 50

    glTexCoord2f 0, 1: glVertex3f -50, -50, 50
    glTexCoord2f 0, 0: glVertex3f -50, -50, -50
    glTexCoord2f 1, 0: glVertex3f 50, -50, -50
    glTexCoord2f 1, 1: glVertex3f 50, -50, 50

    glTexCoord2f 0, 1: glVertex3f -50, 50, 50
    glTexCoord2f 0, 0: glVertex3f -50, 50, -50
    glTexCoord2f 1, 0: glVertex3f 50, 50, -50
    glTexCoord2f 1, 1: glVertex3f 50, 50, 50

    glEnd

    SelectTexture up: glBegin GL_QUADS

    'the "sky" box

    glTexCoord2f 0, 0: glVertex3f -200, -200, -200
    glTexCoord2f 0, 1: glVertex3f -200, 200, -200
    glTexCoord2f 1, 1: glVertex3f 200, 200, -200
    glTexCoord2f 1, 0: glVertex3f 200, -200, -200

    glTexCoord2f 0, 0: glVertex3f -200, -200, 200
    glTexCoord2f 0, 1: glVertex3f -200, 200, 200
    glTexCoord2f 1, 1: glVertex3f 200, 200, 200
    glTexCoord2f 1, 0: glVertex3f 200, -200, 200

    glTexCoord2f 0, 0: glVertex3f -200, -200, -200
    glTexCoord2f 0, 1: glVertex3f -200, 200, -200
    glTexCoord2f 1, 1: glVertex3f -200, 200, 200
    glTexCoord2f 1, 0: glVertex3f -200, -200, 200

    glTexCoord2f 0, 0: glVertex3f 200, -200, -200
    glTexCoord2f 0, 1: glVertex3f 200, 200, -200
    glTexCoord2f 1, 1: glVertex3f 200, 200, 200
    glTexCoord2f 1, 0: glVertex3f 200, -200, 200

    glTexCoord2f 0, 1: glVertex3f -200, -200, 200
    glTexCoord2f 0, 0: glVertex3f -200, -200, -200
    glTexCoord2f 1, 0: glVertex3f 200, -200, -200
    glTexCoord2f 1, 1: glVertex3f 200, -200, 200

    glTexCoord2f 0, 1: glVertex3f -200, 200, 200
    glTexCoord2f 0, 0: glVertex3f -200, 200, -200
    glTexCoord2f 1, 0: glVertex3f 200, 200, -200
    glTexCoord2f 1, 1: glVertex3f 200, 200, 200

    'a crude, bouncing box made up of random quads
    IF xd = 0 THEN xd = 1
    xo = xo + xd * 5
    IF xo > 200 THEN xd = -1
    IF xo < 50 THEN xd = 1
    FOR n = 1 TO 1000
        FOR i = 1 TO 4
            IF i = 1 THEN glTexCoord2f 0, 1
            IF i = 2 THEN glTexCoord2f 0, 0
            IF i = 3 THEN glTexCoord2f 1, 0
            IF i = 4 THEN glTexCoord2f 1, 1
            x = RND * 20 - 10 + xo
            y = RND * 20 - 10
            z = RND * 20 - 10
            glVertex3f x, y, z
        NEXT
    NEXT

    glEnd

    'integrate image from 3D window back into QB64 and 'PUT' it on screen
    sx = gl_X
    sy = gl_Y
    IF oldsx < sx OR oldsy < sy THEN
        REDIM pixels(sx * sy) AS LONG
        REDIM pixels2(sx * sy) AS LONG
        oldsx = sx: oldsy = sy
    END IF
    glReadPixels 0, 0, sx, sy, GL_RGBA, GL_UNSIGNED_BYTE, pixels(1)
    'flip & convert RGB to BGR
    p1 = 0 'source
    p2 = sx * (sy - 1) 'dest
    FOR y = 0 TO sy - 1
        FOR x = p1 TO p1 + sx - 1
            c = pixels(x)
            pixels2(p2) = ((c \ 65536) AND 255) + (c AND &HFF00&) + ((c AND 255&) * 65536)
            p2 = p2 + 1
        NEXT
        p1 = p1 + sx
        p2 = p2 - sx - sx
    NEXT
    'create the PUT header in the first index
    pixels2(0) = sx + sy * 65536
    PUT (16, 16), pixels2(0), PSET

    LOCATE 1, 1
    PRINT "Frames:"; f
    f = f + 1

    _DISPLAY

LOOP



SUB GL_Setup (Window_X AS LONG, Window_Y AS LONG)
DECLARE LIBRARY "GL\libopengl32", "GL\libglu32", "SFML\libsfml-graphics", "SFML\libsfml-window", "GL_helper"
    SUB gl_helper_init (BYVAL x AS LONG, BYVAL y AS LONG)
    'OpenGL calls:
    SUB glEnable (BYVAL eg__GL_DEPTH_TEST&)
    SUB glDepthMask (BYVAL eg__GL_TRUE&)
    SUB glClearDepth (BYVAL eg_1!)
    SUB glMatrixMode (BYVAL eg__GL_PROJECTION&) 'GL_MODELVIEW
    SUB glLoadIdentity
    SUB gluPerspective (BYVAL fovy!, BYVAL aspect!, BYVAL zNear!, BYVAL zFar!)
    'fovy    The field of view angle, in degrees, in the y-direction.
    'aspect  The aspect ratio that determines the field of view in the x-direction. The aspect ratio is the ratio of x (width) to y (height).
    'zNear   The distance from the viewer to the near clipping plane (always positive).
    'zFar    The distance from the viewer to the far clipping plane (always positive).
    SUB glColor4f (BYVAL v1!, BYVAL v2!, BYVAL v3!, BYVAL v4!)
    SUB glClear (BYVAL what&)
    SUB glTranslatef (BYVAL x!, BYVAL y!, BYVAL z!)
    SUB glRotatef (BYVAL amount!, BYVAL x!, BYVAL y!, BYVAL z!)
    SUB glBegin (BYVAL what&)
    SUB glTexCoord2f (BYVAL x!, BYVAL y!)
    SUB glVertex3f (BYVAL x!, BYVAL y!, BYVAL z!)
    SUB glEnd
    SUB glReadPixels (BYVAL x&, BYVAL y&, BYVAL sx&, BYVAL sy&, BYVAL gl__rgba&, BYVAL gl__unsigned_byte&, offset&)
    SUB glGenTextures (BYVAL num_to_generate&, offset AS _UNSIGNED LONG)
    SUB glBindTexture (BYVAL eg__GL_TEXTURE_2D&, BYVAL texture&)
    SUB gluBuild2DMipmaps (BYVAL eg__GL_TEXTURE_2D&, BYVAL eg__GL_RGBA&, BYVAL sx&, BYVAL sy&, BYVAL eg__GL_RGBA&, BYVAL eg__GL_UNSIGNED_BYTE&, offset&)
    SUB glTexParameteri (BYVAL eg__GL_TEXTURE_2D&, BYVAL eg__GL_TEXTURE_MAG_FILTER&, BYVAL eg__GL_LINEAR&) 'GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR
END DECLARE
gl_helper_init Window_X, Window_Y
END SUB

FUNCTION LoadTexture (filename$)
i = _LOADIMAGE(filename$, 32)
IF i = -1 THEN EXIT FUNCTION
sx = _WIDTH(i)
sy = _HEIGHT(i)
IF sx * sy > UBOUND(LoadTexture_Buffer) THEN
    REDIM LoadTexture_Buffer(sx * sy) AS LONG
    REDIM LoadTexture_Buffer2(sx * sy) AS LONG
END IF
oldsrc = _SOURCE
_SOURCE i
GET (0, 0)-(sx - 1, sy - 1), LoadTexture_Buffer(0)
_SOURCE oldsrc
_FREEIMAGE i
'flip & convert BGR->RGB
p1 = 0 'source
p2 = sx * (sy - 1) 'dest
FOR y = 0 TO sy - 1
    FOR x = p1 TO p1 + sx - 1
        c = LoadTexture_Buffer(x)
        LoadTexture_Buffer2(p2) = ((c \ 65536) AND 255) + (c AND &HFF00&) + ((c AND 255&) * 65536)
        p2 = p2 + 1
    NEXT
    p1 = p1 + sx
    p2 = p2 - sx - sx
NEXT
DIM h AS _UNSIGNED LONG
glGenTextures 1, h
glBindTexture GL_TEXTURE_2D, h
gluBuild2DMipmaps GL_TEXTURE_2D, GL_RGBA, sx, sy, GL_RGBA, GL_UNSIGNED_BYTE, LoadTexture_Buffer2(1)
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR
LoadTexture = h
END FUNCTION

SUB SelectTexture (h AS LONG)
glBindTexture GL_TEXTURE_2D, h
END SUB
