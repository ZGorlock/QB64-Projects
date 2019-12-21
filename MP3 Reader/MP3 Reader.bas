SCREEN 12
_TITLE "MP3 Reader"

file$ = "Radioactive~1.mp3"

song = _SNDOPEN(file$)

song$ = readfile$(file$)
flag = 0
br = 0
freq = 0
pad = 0
firstloc = 0
CALL findfirstheader(song$, flag, br, freq, pad, frmhead$, firstfrmloc)
IF flag = 0 THEN
    frmlen = INT((144 * br / freq) + pad)
    REDIM frames$(INT((LEN(song$) / frmlen) * 1.25))
    frame = 0
    spos = firstfrmloc
    DO
        spaceleft = LEN(song$) - spos
        IF spaceleft < frmlen THEN EXIT DO
        estnext = spos + frmlen
        foundnext = 0
        FOR findnext = 0 TO frmlen
            IF estnext + findnext > LEN(song$) THEN EXIT DO
            IF isheader(MID$(song$, estnext + findnext, 4)) THEN
                lenoffrm = (estnext + findnext) - spos
                frame = frame + 1
                frames$(frame) = MID$(song$, spos, lenoffrm)
                spos = spos + lenoffrm
                EXIT FOR
            ELSE
                IF estnext - findnext > spos THEN
                    IF isheader(MID$(song$, estnext - findnext, 4)) THEN
                        lenoffrm = (estnext - findnext) - spos
                        frame = frame + 1
                        frames$(frame) = MID$(song$, spos + 4, lenoffrm - 4)
                        spos = spos + lenoffrm
                        EXIT FOR
                    END IF
                END IF
            END IF
        NEXT findnext
    LOOP
    REDIM _PRESERVE frames$(frame)
ELSE
    PRINT "cannot read mp3 file"
END IF

REDIM frames(frame)
min = 100000000000000
max = 0
FOR frameadd = 1 TO frame
    FOR frameloc = 1 TO LEN(frames$(frameadd))
        IF MID$(frames$(frameadd), frameloc, 1) > "" THEN frames(frameadd) = frames(frameadd) + ASC(frames$(frameadd))
    NEXT frameloc
    IF frames(frameadd) > max THEN max = frames(frameadd)
    IF frames(frameadd) < min THEN min = frames(frameadd)
NEXT frameadd


_SNDPLAY song
dif = max - min
divy = 440 / dif
divx = 600 / frame
DO
    _LIMIT 38.4615384615
    frameprint = frameprint + 1
    PSET (frameprint * divx + 20, frames(frameprint) * divy + 20), 15
LOOP UNTIL frameprint = frame

SLEEP
SYSTEM

SUB findfirstheader (song$, flag, br, freq, pad, header$, location)
FOR findheader = 1 TO LEN(song$)
    IF MID$(song$, findheader, 1) = CHR$(255) THEN
        DO
            REDIM header$(4)
            header$ = MID$(song$, findheader, 4)
            FOR headersplit = 1 TO 4
                header$(headersplit) = MID$(header$, headersplit, 1)
            NEXT headersplit
            flag = -1
            IF isheader(header$) THEN
                br = 0
                freq = 0
                pad = 0
                brget$ = STR$(bit(header$(3), 7)) + STR$(bit(header$(3), 6)) + STR$(bit(header$(3), 5)) + STR$(bit(header$(3), 4))
                SELECT CASE VAL(brget$)
                    CASE 0
                        EXIT DO
                    CASE 1
                        br = 32000
                    CASE 10
                        br = 40000
                    CASE 11
                        br = 48000
                    CASE 100
                        br = 56000
                    CASE 101
                        br = 64000
                    CASE 110
                        br = 80000
                    CASE 111
                        br = 96000
                    CASE 1000
                        br = 112000
                    CASE 1001
                        br = 128000
                    CASE 1010
                        br = 160000
                    CASE 1011
                        br = 192000
                    CASE 1100
                        br = 224000
                    CASE 1101
                        br = 256000
                    CASE 1110
                        br = 320000
                    CASE 1111
                        EXIT DO
                END SELECT
                freqget$ = STR$(bit(header$(3), 3)) + STR$(bit(header$(3), 2))
                SELECT CASE VAL(freqget$)
                    CASE 0
                        freq = 44100
                    CASE 1
                        freq = 48000
                    CASE 10
                        freq = 32000
                    CASE 11
                        EXIT DO
                END SELECT
                pad = bit(header$(3), 1)
                flag = 0
            END IF
            EXIT DO
        LOOP
        IF flag = 0 THEN
            location = findheader
            EXIT FOR
        END IF
    END IF
NEXT findheader
IF findheader = LEN(song$) THEN flag = -1
END SUB

FUNCTION isheader` (header$)
isheader` = 0
REDIM header$(4)
FOR headersplit = 1 TO 4
    header$(headersplit) = MID$(header$, headersplit, 1)
NEXT headersplit
IF (bit(header$(2), 4) AND bit(header$(2), 3)) AND (NOT bit(header$(2), 2) AND bit(header$(2), 1)) AND (bit(header$(2), 0)) THEN isheader` = -1
END FUNCTION

FUNCTION bit (byte$, twospace)
bit = 0
IF byte$ > "" THEN
    IF ASC(byte$) AND 2 ^ twospace THEN bit = 1
END IF
END FUNCTION

FUNCTION DeSync~& (value)
mask = &H7F
DO
    outv = value AND NOT mask
    outv = outv \ 2
    outv = outv OR (value AND mask)
    mask = ((mask + 1) * (2 ^ 8)) - 1
    value = outv
LOOP UNTIL mask = &H7FFFFFFF
DeSync = outv
END FUNCTION

FUNCTION readfile$ (file$)
TYPE Ext_Header
    size AS LONG
    flags AS _UNSIGNED _BYTE
    extflag AS _UNSIGNED _BYTE
END TYPE
TYPE Frame_Head
    id AS STRING * 4
    size AS _UNSIGNED LONG
    flags AS _UNSIGNED INTEGER
END TYPE
TYPE ID3_Header
    id AS STRING * 3
    ver AS _UNSIGNED _BYTE
    rev AS _UNSIGNED _BYTE
    flags AS _UNSIGNED _BYTE
    size AS LONG
END TYPE
DIM ext AS Ext_Header
DIM frm AS Frame_Head
DIM head AS ID3_Header
OPEN file$ FOR BINARY AS #1
GET #1, , head
IF head.id = "ID3" THEN
    head.size = switch_Byte~&(head.size)
    headsiz = DeSync~&(head.size)
    IF (head.flags AND &B1000000) = &B1000000 THEN
        GET #1, , ext
        SEEK #1, DeSync~&(ext.size) + 10
    END IF
    DO
        GET #1, , frm
        IF frm.id > "    " THEN
            framespace$ = SPACE$(switch_Byte~&(frm.size))
            GET #1, , framespace$
            c = c + 10 + VAL(STR$(switch_Byte~&(frm.size)))
        ELSE
            EXIT DO
        END IF
    LOOP UNTIL c >= headsiz
    SEEK #1, headsiz + 1
    readfile$ = SPACE$(LOF(1) - (headsiz + 1))
    GET #1, , readfile$
ELSE
    readfile$ = SPACE$(LOF(1))
    GET #1, , readfile$
END IF
CLOSE #1
END FUNCTION

FUNCTION switch_Byte~& (ln)
tb~& = (ln AND &HFF000000~&) \ (2 ^ 24)
mtb~& = (ln AND &H00FF0000~&) \ (2 ^ 8)
btb~& = (ln AND &H0000FF00~&) * (2 ^ 8)
bt~& = (ln AND &H000000FF~&) * (2 ^ 24)
switch_Byte~& = tb~& + mtb~& + btb~& + bt~&
END FUNCTION

FUNCTION TRIM$ (s$)
s$ = LTRIM$(RTRIM$(s$))
END FUNCTION