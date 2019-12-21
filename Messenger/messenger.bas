client = _OPENCLIENT("TCP/IP:7319:192.168.2.4")
IF client THEN
    _TITLE "Client - Messenger"
    INPUT "Enter your name: ", myname$
    PRINT #client, myname$ + " connected!"
    LOCATE 24, 1
    PRINT myname$; ":";
    DO
        GetMessage client
        SendMessage myname$, mymessage$, client
        _DELAY 0.01
    LOOP
ELSE
    host = _OPENHOST("TCP/IP:7319")
    IF host THEN
        _TITLE "Host - Messenger"
        DIM Users(1 TO 10000000)
        numclients = 0
        client = _OPENCLIENT("TCP/IP:7319:localhost")
        INPUT "Enter your name: ", myname$
        PRINT #client, myname$ + " connected!"
        LOCATE 24, 1
        PRINT myname$; ":";
        DO
            _LIMIT 1000
            newclient = _OPENCONNECTION(host)
            IF newclient THEN
                numclients = numclients + 1
                Users(numclients) = newclient
                PRINT #Users(numclients), "Welcome!"
            END IF
            FOR i = 1 TO numclients
                IF Users(i) THEN
                    INPUT #Users(i), message$
                    IF message$ <> "" THEN
                        FOR p = 1 TO numclients
                            IF Users(p) THEN PRINT #Users(p), message$
                        NEXT p
                    END IF
                    IF _CONNECTED(Users(i)) THEN
                        n = n + 1
                        Users(n) = Users(i)
                    ELSE
                        CLOSE #(User(i))
                        Users(i) = 0
                    END IF
                END IF
            NEXT i
            numclients = n
            n = 0
            GetMessage client
            SendMessage myname$, mymessage$, client
        LOOP
    END IF
END IF
SLEEP
SYSTEM

SUB GetMessage (client)
INPUT #client, newmessage$
IF newmessage$ <> "" THEN
    VIEW PRINT 1 TO 23
    LOCATE 23, 1
    PRINT newmessage$
    VIEW PRINT 1 TO 24
END IF
END SUB

SUB SendMessage (myname$, mymessage$, client)
k$ = INKEY$
IF LEN(k$) THEN
    IF k$ = CHR$(8) AND LEN(mymessage$) <> 0 THEN
        mymessage$ = LEFT$(mymessage$, LEN(mymessage$) - 1)
    ELSE
        IF LEN(k$) = 1 AND ASC(k$) >= 32 THEN
            mymessage$ = mymessage$ + k$
        END IF
    END IF
    LOCATE 24, 1
    PRINT SPACE$(80);
    LOCATE 24, 1
    PRINT myname$ + ": "; mymessage$;
    IF k$ = CHR$(13) THEN
        IF LEN(mymessage$) > 0 THEN
            PRINT #client, myname$ + ": " + mymessage$
            mymessage$ = ""
            LOCATE 24, 1
            PRINT SPACE$(80);
            LOCATE 24, 1
            PRINT myname$ + ": ";
        END IF
    END IF
END IF
END SUB