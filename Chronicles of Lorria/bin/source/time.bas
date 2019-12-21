DECLARE DYNAMIC LIBRARY "kernel32"
    SUB FileTimeToSystemTime (BYVAL lpFileTime AS _OFFSET, BYVAL lpSystemTime AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724280(v=vs.85).aspx
    SUB GetSystemTime (BYVAL lpSystemTime AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724390(v=vs.85).aspx
    SUB GetTimeZoneInformation (BYVAL pTimeZoneInformation AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724421(v=vs.85).aspx
    SUB SystemTimeToFileTime (BYVAL lpSystemTime AS _OFFSET, BYVAL lpFileTime AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724948(v=vs.85).aspx
    FUNCTION GetLastError~& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms679360(v=vs.85).aspx
    FUNCTION GetTickCount~& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724408(v=vs.85).aspx
    FUNCTION GetTimeZoneInformation~& (BYVAL pTimeZoneInformation AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724421(v=vs.85).aspx
    FUNCTION GetVersionExA& (BYVAL lpVersionInfo AS _UNSIGNED _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724451(v=vs.85).aspx
END DECLARE
DECLARE DYNAMIC LIBRARY "user32"
    FUNCTION GetDesktopWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633504(v=vs.85).aspx
    FUNCTION GetForegroundWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633505(v=vs.85).aspx
    FUNCTION OpenInputDesktop%& (BYVAL dwFlags AS _OFFSET, BYVAL fInherit AS _OFFSET, BYVAL dwDesiredAccess AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms684309(v=vs.85).aspx
    FUNCTION SetThreadDesktop%& (BYVAL hDesktop AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms686250(v=vs.85).aspx
    FUNCTION SystemParametersInfoW& (BYVAL uiAction AS _UNSIGNED LONG, BYVAL uiParam AS _UNSIGNED LONG, BYVAL pvParam AS _OFFSET, BYVAL fWinlni AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724947(v=vs.85).aspx
END DECLARE
DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName AS STRING) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633499(v=vs.85).aspx
END DECLARE


'$INCLUDE:'include\libinit\commoninit.bi'
'$INCLUDE:'include\libinit\timeinit.bi'

Programname = "untitled"
Version = 0
Ssloc = ""

SCREEN _NEWIMAGE(SCRX, SCRY, SCRZ)

DO
    _LIMIT 16
    CLS
    PRINT YEAR
    PRINT YEAR_SHORT
    PRINT
    PRINT MONTH
    PRINT MONTHNAME
    PRINT
    PRINT DAY
    PRINT DAYOFWEEK
    PRINT DAYNAME
    PRINT YEAR_CYCLE
    PRINT WEEK
    PRINT
    PRINT HOUR
    PRINT HOUR_12
    PRINT MINUTE
    PRINT SECOND
    PRINT MILLISECOND
    PRINT
    PRINT UNIXTIME
    PRINT UNIXTIME_LONG
    PRINT TICKCOUNT
    _DISPLAY
LOOP UNTIL INKEY$ > ""
DO
    _LIMIT 16
    CLS
    PRINT TIME$
    PRINT TIME_LONG
    PRINT TIME_SHORT
    PRINT TIME_12
    PRINT TIME_LONG_12
    PRINT TIME_SHORT_12
    PRINT AMPM
    PRINT TIMENAME
    PRINT
    PRINT TIMEZONE
    PRINT TIMEZONE_OFFSET
    PRINT TIMEZONE_DST
    PRINT
    PRINT HOLIDAY
    _DISPLAY
LOOP UNTIL INKEY$ > ""
DO
    _LIMIT 16
    CLS
    PRINT DATE$
    PRINT DATE_SHORT
    PRINT
    PRINT DATETIME
    PRINT DATETIME_LONG
    PRINT DATETIME_SHORT
    PRINT DATETIME_12
    PRINT DATETIME_LONG_12
    PRINT DATETIME_SHORT_12
    PRINT DATETIME_SHORTYEAR
    PRINT DATETIME_LONG_SHORTYEAR
    PRINT DATETIME_SHORT_SHORTYEAR
    PRINT DATETIME_12_SHORTYEAR
    PRINT DATETIME_LONG_12_SHORTYEAR
    PRINT DATETIME_SHORT_12_SHORTYEAR
    PRINT
    PRINT TIMESTAMP
    PRINT TIMESTAMP_LONG
    PRINT TIMESTAMP_SHORT
    PRINT TIMESTAMP_SHORTYEAR
    PRINT TIMESTAMP_LONG_SHORTYEAR
    PRINT TIMESTAMP_SHORT_SHORTYEAR
    _DISPLAY
LOOP UNTIL INKEY$ > ""
DIM a AS SYSTEMTIME, b AS SYSTEMTIME, c AS SYSTEMTIME, d AS SYSTEMTIME
LUNAR_LAST_NEW a
LUNAR_LAST_FULL b
LUNAR_NEXT_NEW c
LUNAR_NEXT_FULL d
DIM f AS LONG
f = LUNAR_DRAW(100)
DO
    _LIMIT 16
    CLS
    PRINT JULIANDAY
    PRINT JULIANDAY_LONG
    PRINT
    PRINT LUNAR_AGE
    PRINT LUNAR_AGE_LONG
    PRINT LUNAR_PHASE
    PRINT
    PRINT DATE_X(a)
    PRINT DATE_X(b)
    PRINT DATE_X(c)
    PRINT DATE_X(d)
    PRINT
    PRINT LUNAR_SYNODIC
    PRINT LUNAR_SYNODIC_RAD
    PRINT LUNAR_ANOMALISTIC
    PRINT LUNAR_ANOMALISTIC_RAD
    PRINT
    PRINT LUNAR_DISTANCE
    PRINT
    PRINT LUNAR_ECLIPTIC_LATITUDE
    PRINT LUNAR_ECLIPTIC_LONGITUDE
    _PUTIMAGE (200, 20), f
    _DISPLAY
LOOP UNTIL INKEY$ > ""
DO
    _LIMIT 16
    CLS
    PRINT ZODIAC
    PRINT BIRTHSTONE
    PRINT
    PRINT ASTROLOGICALAGE
    PRINT ASTROLOGICALAGE_START
    PRINT ASTROLOGICALAGE_END
    PRINT ASTROLOGICALAGE_CYCLE
    PRINT ASTROLOGICALAGE_LEFT
    PRINT
    PRINT PLATONICYEAR_START
    PRINT PLATONICYEAR_END
    PRINT PLATONICYEAR_CYCLE
    PRINT PLATONICYEAR_LEFT
    _DISPLAY
LOOP UNTIL INKEY$ > ""
DO
    _LIMIT 16
    CLS
    PRINT LONGCOUNT
    PRINT LONGCOUNT_DAYS
    PRINT
    PRINT LONGCOUNT_TZOLKIN
    PRINT LONGCOUNT_HAAB
    PRINT LONGCOUNT_LONG
    PRINT
    PRINT LONGCOUNT_KIN
    PRINT LONGCOUNT_WINAL
    PRINT LONGCOUNT_TUN
    PRINT LONGCOUNT_KATUN
    PRINT LONGCOUNT_BAKTUN
    _DISPLAY
LOOP UNTIL INKEY$ > ""
SYSTEM


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
IF Hotkeys.fullscreen = TRUE THEN
    IF TIMER < Hotkeys.fullscreen_clock THEN Hotkeys.fullscreen_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.fullscreen_clock THEN
        Hotkeys.close_clock = TIMER
        FULLSCREEN
    END IF
    Hotkeys.fullscreen = FALSE
END IF
IF Hotkeys.screenshot = TRUE THEN
    IF TIMER < Hotkeys.screenshot_clock THEN Hotkeys.screenshot_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.screenshot_clock THEN
        Hotkeys.close_clock = TIMER
        SCREENSHOT Ssloc, ""
    END IF
    Hotkeys.screenshot = FALSE
END IF
RETURN

cleanup:
CLOSE #3
CLOSE #4
CLOSE #7
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
    PRINT #4, TSTAMP; " - "; Module$; " - "; TRIMnum$(errornum); " ("; TRIMnum$(_ERRORLINE); ")"
    REDIM _PRESERVE errors(errorcount) AS errorhandle
    errors(errorcount).err = errornum
    errors(errorcount).line = _ERRORLINE
    errors(errorcount).count = 1
END IF
RESUME NEXT

'$INCLUDE:'lib\common.bi'
'$INCLUDE:'lib\time.bi'