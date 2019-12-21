'updates the settings file with the current metrics
SUB updatesettings
OPEN "data\settings.inf" FOR OUTPUT AS #1
CLOSE #1
'OPEN "data\settings.inf" FOR BINARY AS #1
'PUT #1, , setting
'CLOSE #1
OPEN "data\settings.inf" FOR OUTPUT AS #1
PRINT #1, setting.sound
PRINT #1, setting.fx
PRINT #1, setting.lps
PRINT #1, setting.fps
PRINT #1, setting.ssloc
PRINT #1, setting.cursor
PRINT #1, setting.cursorcolor
PRINT #1, setting.hidecursor
PRINT #1, setting.races
PRINT #1, setting.scrollmultiplier
CLOSE #1
END SUB