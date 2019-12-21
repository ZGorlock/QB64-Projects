'_SCREENHIDE

DIM checkcall AS _BIT
DIM client AS LONG

DO
    _LIMIT .1
    client = _OPENCLIENT("TCP/IP:8080:192.168.1.9")
    IF client THEN
        PRINT "connected"
        DO
            _LIMIT 8
            INPUT #client, checkcall
            IF checkcall = -1 THEN PRINT "hit"
            IF checkcall = -1 THEN BEEP
        LOOP
    END IF
LOOP