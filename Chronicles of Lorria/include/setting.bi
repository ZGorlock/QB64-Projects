'load settings
IF _FILEEXISTS("data\settings.inf") THEN
    'OPEN "data\settings.inf" FOR BINARY AS #1
    'IF LOF(1) = LEN(setting) THEN
    'GET #1, , setting
    'ELSE
    'CALL resetsettings
    'END IF
    'CLOSE #1
    OPEN "data\settings.inf" FOR INPUT AS #1
    INPUT #1, setting.sound
    INPUT #1, setting.fx
    INPUT #1, setting.lps
    INPUT #1, setting.fps
    LINE INPUT #1, setting.ssloc
    INPUT #1, setting.cursor
    INPUT #1, setting.cursorcolor
    INPUT #1, setting.hidecursor
    LINE INPUT #1, setting.races
    INPUT #1, setting.scrollmultiplier
    CLOSE #1
ELSE
    CALL resetsettings
END IF
IF setting.fps = 0 THEN setting.fps = getdefaultfps