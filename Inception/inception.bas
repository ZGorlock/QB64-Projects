_TITLE "Inception"
SCREEN _NEWIMAGE(640, 480, 32)
DO
    _LIMIT 4
    SHELL _HIDE "nircmd.exe savescreenshot a.jpg"
    a = _LOADIMAGE("a.jpg")
    _PUTIMAGE (0, 0)-(639, 479), a
LOOP UNTIL INKEY$ > ""
SYSTEM