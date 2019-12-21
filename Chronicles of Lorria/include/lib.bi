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
    SUB GetCursorPos (BYVAL lpPoint AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms648390(v=vs.85).aspx
    SUB GetLastInputInfo (BYVAL plii AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646302(v=vs.85).aspx
    FUNCTION EnumDisplaySettingsA& (BYVAL lpszDeviceName AS _UNSIGNED _OFFSET, BYVAL iModeNum AS _UNSIGNED LONG, BYVAL lpDevMode AS _UNSIGNED _OFFSET)
    FUNCTION GetDesktopWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633504(v=vs.85).aspx
    FUNCTION GetForegroundWindow%& () 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633505(v=vs.85).aspx
    FUNCTION GetKeyState% (BYVAL nVirtKey AS LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646301(v=vs.85).aspx
    FUNCTION GetSystemMetrics (BYVAL nIndex AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724385(v=vs.85).aspx
    FUNCTION OpenInputDesktop%& (BYVAL dwFlags AS _OFFSET, BYVAL fInherit AS _OFFSET, BYVAL dwDesiredAccess AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms684309(v=vs.85).aspx
    FUNCTION SetThreadDesktop%& (BYVAL hDesktop AS _OFFSET) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms686250(v=vs.85).aspx
    FUNCTION SystemParametersInfoW& (BYVAL uiAction AS _UNSIGNED LONG, BYVAL uiParam AS _UNSIGNED LONG, BYVAL pvParam AS _OFFSET, BYVAL fWinlni AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms724947(v=vs.85).aspx
END DECLARE
DECLARE LIBRARY
    FUNCTION GetAsyncKeyState (BYVAL vkey AS _UNSIGNED LONG) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms646293(v=vs.85).aspx
END DECLARE
DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName AS STRING) 'http://msdn.microsoft.com/en-us/library/windows/desktop/ms633499(v=vs.85).aspx
END DECLARE