DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetLastError~& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms679360(v=vs.85).aspx
    FUNCTION GetVersionExA& (BYVAL lpVersionInfo AS _UNSIGNED _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724451(v=vs.85).aspx
END DECLARE
DECLARE DYNAMIC LIBRARY "user32"
    SUB GetCursorPos (BYVAL lpPoint AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms648390(v=vs.85).aspx
    SUB GetLastInputInfo (BYVAL plii AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646302(v=vs.85).aspx
    FUNCTION GetDesktopWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633504(v=vs.85).aspx
    FUNCTION GetForegroundWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633505(v=vs.85).aspx
    FUNCTION GetKeyState% (BYVAL nVirtKey AS LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646301(v=vs.85).aspx
    FUNCTION GetSystemMetrics (BYVAL nIndex AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724385(v=vs.85).aspx
    FUNCTION OpenInputDesktop%& (BYVAL dwFlags AS _OFFSET, BYVAL fInherit AS _OFFSET, BYVAL dwDesiredAccess AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms684309(v=vs.85).aspx
    FUNCTION SetThreadDesktop%& (BYVAL hDesktop AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms686250(v=vs.85).aspx
    FUNCTION SystemParametersInfoW& (BYVAL uiAction AS _UNSIGNED LONG, BYVAL uiParam AS _UNSIGNED LONG, BYVAL pvParam AS _OFFSET, BYVAL fWinlni AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724947(v=vs.85).aspx
END DECLARE
DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName AS STRING) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633499(v=vs.85).aspx
END DECLARE
DECLARE LIBRARY
    FUNCTION GetAsyncKeyState (BYVAL vkey AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646293(v=vs.85).aspx
END DECLARE

'$INCLUDE:'common_init.bi'
'$INCLUDE:'input_init.bi'
'$INCLUDE:'sprite_init.bi'
'$INCLUDE:'button_init.bi'

Programname = "untitled"
Version = 0













DIM f AS STRING
DIM a(4, 5, 2, 8) AS INTEGER

FOR x1 = 1 TO 4
    FOR x2 = 1 TO 4
        FOR x3 = 1 TO 2
            FOR x4 = 1 TO 8
                f = "resource\image\button\arrow_"
                SELECT CASE x1
                    CASE 1
                        f = f + "black"
                    CASE 2
                        f = f + "red"
                    CASE 3
                        f = f + "green"
                    CASE 4
                        f = f + "blue"
                END SELECT
                f = f + "_"
                SELECT CASE x2
                    CASE 1
                        f = f + "up"
                    CASE 2
                        f = f + "left"
                    CASE 3
                        f = f + "right"
                    CASE 4
                        f = f + "down"
                END SELECT
                IF x3 = 2 THEN
                    f = f + "_"
                    SELECT CASE x2
                        CASE 1
                            f = f + "plus"
                        CASE 2
                            f = f + "minus"
                        CASE 3
                            f = f + "plus"
                        CASE 4
                            f = f + "minus"
                    END SELECT
                END IF
                f = f + "_"
                SELECT CASE x4
                    CASE 1
                        f = f + "silver"
                    CASE 2
                        f = f + "gold"
                    CASE 3
                        f = f + "copper"
                    CASE 4
                        f = f + "bronze"
                    CASE 5
                        f = f + "lava"
                    CASE 6
                        f = f + "wood"
                    CASE 7
                        f = f + "mahogany"
                    CASE 8
                        f = f + "rust"
                END SELECT
                f = f + ".png"
                a(x1, x2, x3, x4) = NEWBUTTONTEMPLATE(f)
                b(x1, x2, x3, x4) = NEWBUTTON(a(x1, x2, x3, x4), BUTTON_OFF, 0, BUTTON_SHOW, BUTTON_AUTOUPDATE_OFF)
NEXT x4, x3, x2, x1
FOR x1 = 1 TO 4
    FOR x3 = 1 TO 2
        FOR x4 = 1 TO 8
            SELECT CASE x3
                CASE 1
                    f = "resource\image\button\tick_"
                CASE 2
                    f = "resource\image\button\checkbox_"
            END SELECT
            SELECT CASE x1
                CASE 1
                    f = f + "black"
                CASE 2
                    f = f + "red"
                CASE 3
                    f = f + "green"
                CASE 4
                    f = f + "blue"
            END SELECT
            f = f + "_"
            SELECT CASE x4
                CASE 1
                    f = f + "silver"
                CASE 2
                    f = f + "gold"
                CASE 3
                    f = f + "copper"
                CASE 4
                    f = f + "bronze"
                CASE 5
                    f = f + "lava"
                CASE 6
                    f = f + "wood"
                CASE 7
                    f = f + "mahogany"
                CASE 8
                    f = f + "rust"
            END SELECT
            f = f + ".png"
            a(x1, 5, x3, x4) = NEWBUTTONTEMPLATE(f)
            b(x1, 5, x3, x4) = NEWBUTTON(a(x1, 5, x3, x4), BUTTON_OFF, 0, BUTTON_SHOW, BUTTON_AUTOUPDATE_OFF)
NEXT x4, x3, x1

c = 1

DO
    HIDEBUTTON BUTTON_ALLBUTTONS
    FOR bc = 1 TO 4
        bcx = bc * 128
        FOR bs = 1 TO 2
            bsx = 96 - (144 * (bs = 2))
            PUTBUTTON bcx, bsx - 30, b(bc, 1, bs, c)
            PUTBUTTON bcx - 30, bsx, b(bc, 2, bs, c)
            PUTBUTTON bcx + 30, bsx, b(bc, 3, bs, c)
            PUTBUTTON bcx, bsx + 30, b(bc, 4, bs, c)
            PUTBUTTON bcx + 20, 384, b(bc, 5, 1, c)
            PUTBUTTON bcx - 20, 384, b(bc, 5, 2, c)
    NEXT bs, bc
    DO
        _LIMIT 60
        GETINPUT
        CLS
        UPDATEBUTTON BUTTON_ALLBUTTONS
        PRINTBUTTON BUTTON_ALLBUTTONS
        IF NUM >= BUTTON_THEME_SILVER AND NUM <= BUTTON_THEME_RUST THEN
            c = NUM
            EXIT DO
        END IF
        IF Keyd = 13 THEN LOCKBUTTONTOGGLE BUTTON_ALLBUTTONS
        _DISPLAY
    LOOP UNTIL ESC
LOOP UNTIL ESC

BUTTONFREE BUTTON_ALLBUTTONS
GOSUB cleanup























checkhotkeys:
IF Hotkeys.help = TRUE THEN
    IF TIMER < Hotkeys.help_clock THEN Hotkeys.help_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.help_clock THEN
        Hotkeys.help_clock = TIMER
        GOSUB help
    END IF
    Hotkeys.help = FALSE
END IF
IF Hotkeys.close = TRUE THEN
    IF TIMER < Hotkeys.close_clock THEN Hotkeys.close_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.close_clock THEN
        Hotkeys.close_clock = TIMER
        GOSUB cleanup
    END IF
    Hotkeys.close = FALSE
END IF
IF Hotkeys.screenshot = TRUE THEN
    IF TIMER < Hotkeys.screenshot_clock THEN Hotkeys.screenshot_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.screenshot_clock THEN
        Hotkeys.close_clock = TIMER
        SCREENSHOT SCREENSHOT_MONITOR, Ssloc, ""
    END IF
    Hotkeys.screenshot = FALSE
END IF
IF Hotkeys.windowshot = TRUE THEN
    IF TIMER < Hotkeys.windowshot_clock THEN Hotkeys.windowshot_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.windowshot_clock THEN
        Hotkeys.close_clock = TIMER
        SCREENSHOT SCREENSHOT_WINDOW, Ssloc, ""
    END IF
    Hotkeys.screenshot = FALSE
END IF
IF Hotkeys.fullscreen = TRUE THEN
    IF TIMER < Hotkeys.fullscreen_clock THEN Hotkeys.fullscreen_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.fullscreen_clock THEN
        Hotkeys.close_clock = TIMER
        FULLSCREEN
    END IF
    Hotkeys.fullscreen = FALSE
END IF
RETURN

cleanup:
CLOSE #32766
CLOSE #32767
CLOSE
CLEAR
SYSTEM
RETURN

help:
RETURN

sierr:
IF ERR = 70 THEN SYSTEM
GOTO sierrpass

errorhandler:
DIM printerror AS _BIT
DIM checkerror AS INTEGER
DIM errorcount AS INTEGER
DIM errornum AS INTEGER
errornum = ERR
printerror = TRUE
FOR checkerror = 1 TO UBOUND(errors)
    IF errors(checkerror).err = errornum AND errors(checkerror).line = _ERRORLINE THEN
        errors(checkerror).count = errors(checkerror).count + 1
        printerror = FALSE
        EXIT FOR
    END IF
NEXT checkerror
IF printerror THEN
    errorcount = UBOUND(errors) + 1
    PRINT #32766, TSTAMP; " - "; Module$; " - "; TRIMnum$(errornum); " ("; TRIMnum$(_ERRORLINE); ")"
    REDIM _PRESERVE errors(errorcount) AS errorhandle
    errors(errorcount).err = errornum
    errors(errorcount).line = _ERRORLINE
    errors(errorcount).count = 1
END IF
RESUME NEXT

'$INCLUDE:'common.bi'
'$INCLUDE:'input.bi'
'$INCLUDE:'sprite.bi'
'$INCLUDE:'button.bi'