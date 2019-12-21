_TITLE "Chronicles of Ardendore"

SCREEN 13

REDIM graphics&(32768)
REDIM graphics$(32768)
REDIM sounds&(32768)
REDIM sounds$(32768)

OPEN "resources\data\loadaudio.txt" FOR INPUT AS #1
DO
    loadaudio = loadaudio + 1
    LINE INPUT #1, loadaudio$
    PRINT ">" + loadaudio$
    sounds$(loadaudio) = loadaudio$
    sounds&(loadaudio) = _SNDOPEN(loadaudio$, "VOL, SYNC, LEN, PAUSE, SETPOS")
LOOP UNTIL EOF(1) = -1
CLOSE #1
REDIM _PRESERVE sounds&(loadaudio)
REDIM _PRESERVE sounds$(loadaudio)

OPEN "resources\data\loaddata.txt" FOR INPUT AS #1
DO
    loaddata = loaddata + 1
    LINE INPUT #1, loaddata$
    PRINT ">" + loaddata$
    dataload = 0
    OPEN loaddata$ FOR INPUT AS #2
    DO
        LINE INPUT #1, dataload$
        dataload = dataload + 1
        SELECT CASE loaddata

        END SELECT
    LOOP UNTIL EOF(1) = -1
    CLOSE #2
LOOP UNTIL EOF(1) = -1
CLOSE #1

OPEN "resources\data\loadgraphic.txt" FOR INPUT AS #1
DO
    loadgraphic = loadgraphic + 1
    LINE INPUT #1, loadgraphic$
    PRINT ">" + loadgraphic$
    graphics$(loadgraphic) = loadgraphic$
    graphics&(loadgraphic) = _LOADIMAGE(loadgraphic$)
LOOP UNTIL EOF(1) = -1
CLOSE #1
REDIM _PRESERVE graphics&(loadgraphic)
REDIM _PRESERVE graphics$(loadgraphic)

SCREEN _NEWIMAGE(640, 480, 32)

_ICON 