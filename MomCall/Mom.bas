'_SCREENHIDE

DECLARE LIBRARY
    FUNCTION GetAsyncKeyState (BYVAL vkey AS _UNSIGNED LONG)
END DECLARE

DIM client AS LONG
DIM host AS LONG
DIM myclient AS LONG
DIM newclient AS LONG
DIM count AS _UNSIGNED LONG

DO
    _LIMIT .1
    host = _OPENHOST("TCP/IP:8080")
    IF host THEN
        PRINT "host"
        client = _OPENCLIENT("TCP/IP:8080:localhost")
        IF client THEN
            PRINT "client"
            DO
                _LIMIT 1
                myclient = _OPENCONNECTION(host)
                IF myclient THEN
                    DO
                        _LIMIT .5
                        newclient = _OPENCONNECTION(host)
                        IF newclient THEN
                            PRINT "youre connected"
                            DO
                                _LIMIT 8
                                count = count + 1
                                IF GetAsyncKeyState(18) AND GetAsyncKeyState(90) THEN PRINT "hit": PRINT #newclient, -1
                                IF count MOD 8 = 0 THEN
                                    IF NOT _CONNECTED(newclient) THEN EXIT DO
                                END IF
                            LOOP
                        END IF
                    LOOP
                END IF
            LOOP
        END IF
        CLOSE host
    END IF
LOOP