_TITLE "MS Collector Tool"
SCREEN 12

CONST CSIDL_PERSONAL = &H5

DECLARE DYNAMIC LIBRARY "shell32"
    FUNCTION SHGetFolderPathA& (BYVAL hwndOwner%&, BYVAL nFolder&, BYVAL hToken%&, BYVAL dwFlags~&, BYVAL pszPath%&)
END DECLARE

REDIM eqpvac$(32768)
REDIM etcvac$(32768)
REDIM info$(1024)
REDIM infotransfer$(1024)
REDIM lines$(4)
REDIM namelist$(131072)
REDIM note$(1028)
REDIM notecopy$(1028)
REDIM printlist$(131072)
REDIM statprefix$(32)
REDIM statslist$(32)
REDIM statvalue$(32)
REDIM stpvac$(32768)
REDIM usevac$(32768)

start:
GOSUB prepare
poststart:
DO
    CLS
    COLOR 15, 0
    PRINT "What would you like to do?"
    PRINT "   0-Search an Item"
    PRINT "   1-Find Vacancies"
    PRINT "   2-Notes"
    DO
        _LIMIT 128
        k$ = INKEY$
    LOOP UNTIL LEN(k$)
    IF k$ = CHR$(48) THEN
        search:
        bts = 0
        DO
            _LIMIT 128
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        DO
            DO
                FOR ni = 1 TO inputcount
                    printlist$(ni) = namelist$(ni)
                NEXT ni
                item$ = ""
                selected = 1
                row = 1
                listnum = inputcount
                DO
                    CLS
                    COLOR 15, 0
                    PRINT ": "; item$
                    PRINT
                    IF selected < 1 THEN selected = 1
                    IF selected > listnum THEN selected = listnum
                    IF row + 25 < listnum AND selected > row + 11 THEN
                        row = row + 1
                    END IF
                    IF row <> 1 AND selected < row + 11 THEN
                        row = row - 1
                    END IF
                    IF row = 1 AND selected < row + 11 THEN
                        row = row
                    END IF
                    IF row + 12 = listnum AND selected > row + 11 THEN
                        row = row
                    END IF
                    FOR searchlist = row TO row + 25
                        IF searchlist = selected THEN
                            COLOR 0, 15
                        ELSE
                            COLOR 15, 0
                        END IF
                        PRINT printlist$(searchlist)
                    NEXT searchlist
                    COLOR 15, 0
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                        DO WHILE _MOUSEINPUT
                            selected = selected + _MOUSEWHEEL
                            k$ = CHR$(255)
                        LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                        item$ = item$ + k$
                        inputlength = LEN(item$)
                    END IF
                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                        item$ = MID$(item$, 1, (inputlength - 1))
                        inputlength = (inputlength - 1)
                    END IF
                    IF k$ = (CHR$(0) + CHR$(72)) THEN selected = selected - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN selected = selected + 1
                    IF k$ = CHR$(27) THEN
                        GOSUB start
                    END IF
                    GOSUB searchlist
                LOOP UNTIL k$ = CHR$(13)

                item$ = printlist$(selected)
                filename$ = fileloc$ + item$ + ".txt"
                tmpfile$ = fileloc$ + item$ + ".tmp"
                REDIM info$(32768)
                infos$(2) = "Enter you command-"
                infos$(3) = "     1-Search another item"
                infos$(4) = "     2-Add/Delete"
                OPEN filename$ FOR INPUT AS #1
                LINE INPUT #1, infos$(1)
                cont = 0
                IF infos$(1) = "" THEN
                    infos$(1) = "We do not currently have this item"
                    cont = 0
                ELSE
                    infos$(1) = "We currently have this item"
                    cont = 1
                END IF
                CLOSE #1
                IF cont = 1 THEN
                    REDIM infoget$(1024, 64)
                    OPEN filename$ FOR INPUT AS #1
infogets = 0
                    DO
                        infogets = infogets + 1
                        infogetter$(infogets, 1) = "Location:"
                        infogetter$(infogets, 4) = "Stats:"
                        infogetter = 2
                        LINE INPUT #1, infoget$(infogets, infogetter)
                            infogetter = 4
                        DO
infogetter = infogetter + 1
                            LINE INPUT #1, infoget$(infogets, infogetter)
                            IF infoget$(infogets, infogetter) = "" THEN EXIT DO
                        LOOP UNTIL EOF(1) = -1
                    LOOP UNTIL EOF(1) = -1
                    CLOSE #1

PRINT infogets
FOR a = 1 TO infogets
PRINT infoget$(a)
NEXT a
SLEEP

                    FOR sortgets = 1 TO infogets
                        FOR getssort = 1 TO infogets
                            IF infoget$(sortgets, 2) < infoget$(getssort, 2) AND getssort <> sortgets THEN
FOR mover = 1 TO 64
SWAP infoget$(getssort, mover), infoget$(sortgets, mover)
NEXT mover
                            END IF
                        NEXT getssort
                    NEXT sortgets
                    infoput = 0
                    FOR printget = 1 TO infogets
                        DO
k = 0
                            FOR printgetter = 1 TO 64
                                infoput = infoput + 1
                                info$(infoput) = infoget$(printget, printgetter)
                                IF info$(infoput) = "" THEN k = k + 1
IF k= 2 THEN EXIT DO
                            NEXT printgetter
                        LOOP
                                infoput = infoput + 2
                    NEXT printget
                                infoput = infoput - 2
                END IF

PRINT infoput
FOR a = 1 TO infoput
PRINT info$(a)
NEXT a
SLEEP


bar$ = ""
FOR makebar = 1 TO 80
bar$ = bar$ + CHR$(205)
NEXT makebar
row = 1
                DO
                    CLS
                    PRINT "-" + UCASE$(item$) + "-"
                    PRINT infos$(1)
                    PRINT infos$(2)
                    PRINT infos$(3)
                    PRINT infos$(4)
                    PRINT
PRINT bar$
                    IF infoput <= 18 THEN
                        FOR row = 1 TO infoput
                            PRINT info$(row)
                        NEXT row
                    ELSE
                        FOR viewrow = row TO (row + 17)
                            PRINT info$(viewrow)
                        NEXT viewrow
                    END IF
PRINT bar$
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                    DO WHILE _MOUSEINPUT
                        row = row + _MOUSEWHEEL
k$ = CHR$(255)
                    LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ = (CHR$(0) + CHR$(72)) THEN row = row - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN row = row + 1
                    IF row < 1 THEN row = 1
                    IF row > infoput - 17 THEN row = listnum - 17
                    IF k$ = CHR$(49) THEN
                        bts = 1
                        GOSUB prepare
                    END IF
                    IF k$ = CHR$(50) THEN
                        OPEN filename$ FOR INPUT AS #1
                        LINE INPUT #1, existcheck$
                        IF existcheck$ <> "" THEN LINE INPUT #1, valuecount$
                        CLOSE #1
                        IF MID$(existcheck$, 10, 1) <> "" THEN
                            IF VAL(MID$(existcheck$, 10, 1)) = 1 THEN
                                DO
                                    CLS
                                    PRINT "What would you like to do?"
                                    PRINT "1-Update with a better version of the equip"
                                    PRINT "2-Delete an item"
                                    PRINT "3-Add an item"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(49) THEN
                                        location$ = existcheck$
                                        location3$ = MID$(existcheck$, 10, 1)
                                        dotype = 1
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(50) THEN
                                        dotype = 2
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(51) THEN
                                        dotype = 3
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(27) THEN GOSUB start
                                LOOP
                            ELSE
                                DO
                                    CLS
                                    PRINT "What would you like to do?"
                                    PRINT "1-Update existing quantity"
                                    PRINT "2-Fill form as usual"
PRINT "3-Delete Stack"
PRINT "4-Add Stack"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(49) THEN
                                        DO
                                            CLS
                                            PRINT "Enter the new amount of the item"
                                            PRINT "Quantity: "; quantity$
                                            DO
                                                _LIMIT 128
                                                k$ = INKEY$
                                            LOOP UNTIL LEN(k$)
                                            IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                                                quantity$ = quantity$ + k$
                                            END IF
                                            IF k$ = CHR$(8) AND LEN(quantity$) <> 0 THEN
                                                quantity$ = MID$(quantity$, 1, ((LEN(quantity$)) - 1))
                                            END IF
                                            IF k$ = CHR$(27) THEN GOSUB start
                                        LOOP UNTIL k$ = CHR$(13) AND LEN(quantity$) <> 0
                                        quantity$ = "Quantity: " + quantity$
                                        DO
                                            CLS
                                            PRINT "Entry Complete"
                                            DO
                                                _LIMIT 128
                                                k$ = INKEY$
                                            LOOP UNTIL LEN(k$)
                                        LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                                        OPEN filename$ FOR OUTPUT AS #1
                                        PRINT #1, existcheck$
                                        PRINT #1, quantity$
                                        CLOSE #1
                                        SELECT CASE VAL(location3$)
                                            CASE 1
                                                OPEN fileloc$ + "[0eqp.txt" FOR OUTPUT AS #1
                                                FOR remvac = 1 TO eqpvac
                                                    IF eqpvac$(remvac) <> location$ THEN PRINT #1, eqpvac$(remvac)
                                                NEXT remvac
                                                CLOSE #1
                                            CASE 2
                                                OPEN fileloc$ + "[0use.txt" FOR OUTPUT AS #1
                                                FOR remvac = 1 TO usevac
                                                    IF usevac$(remvac) <> location$ THEN PRINT #1, usevac$(remvac)
                                                NEXT remvac
                                                CLOSE #1
                                            CASE 3
                                                OPEN fileloc$ + "[0etc.txt" FOR OUTPUT AS #1
                                                FOR remvac = 1 TO etcvac
                                                    IF etcvac$(remvac) <> location$ THEN PRINT #1, etcvac$(remvac)
                                                NEXT remvac
                                                CLOSE #1
                                            CASE 4
                                                OPEN fileloc$ + "[0stp.txt" FOR OUTPUT AS #1
                                                FOR remvac = 1 TO stpvac
                                                    IF stpvac$(remvac) <> location$ THEN PRINT #1, stpvac$(remvac)
                                                NEXT remvac
                                                CLOSE #1
                                        END SELECT
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(50) THEN EXIT DO
                                    IF k$ = CHR$(27) THEN GOSUB start
                                LOOP
                            END IF
                            IF exitloop = 1 THEN EXIT DO
                        END IF
                        IF dotype <> 3 THEN
                            DO
                                _LIMIT 64
                                CLS
                                PRINT "Select the item"
                                PRINT
                                IF infogets > 25 THEN
                                    FOR locprint = printgets TO printgets + 24
                                        IF locprint = selected THEN
                                            COLOR 0, 15
                                        ELSE
                                            COLOR 15, 0
                                        END IF
                                        PRINT infoget$(locprint, 2)
                                        COLOR 15, 0
                                    NEXT locprint
                                ELSE
                                    FOR locprint = 1 TO infogets
                                        IF locprint = selected THEN
                                            COLOR 0, 15
                                        ELSE
                                            COLOR 15, 0
                                        END IF
                                        PRINT infoget$(locprint, 2)
                                        COLOR 15, 0
                                    NEXT locprint
                                    VIEW PRINT
                                    k$ = INKEY$
                                END IF
                            LOOP UNTIL k$ = CHR$(13)
                            selectglob = selected
                        END IF
                        OPEN tmpfile$ FOR OUTPUT AS #1
                        IF location$ <> "" THEN GOTO skiploc
                        location1$ = ""
                        el = 0
                        catcheckdone = 0
                        DO
                            IF before = 1 THEN
                                DO
                                    CLS
                                    PRINT "Are you on the same mule as before?"
                                    PRINT "     1-Yes (Same Tab)"
                                    PRINT "     2-Yes (Different Tab)"
                                    PRINT "     0-No"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(48) THEN
                                        location1$ = location1old$
                                        el = 0
                                        location1$ = ""
                                        location2$ = ""
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(49) THEN
                                        location1$ = location1old$
                                        location2$ = location2old$
                                        location3$ = location3old$
                                        el = 1
                                        catcheckdone = 1
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(50) THEN
                                        location1$ = location1old$
                                        location2$ = location2old$
                                        el = 1
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP
                                IF exitloop = 1 THEN EXIT DO
                                IF el = 1 THEN
                                    el = 0
                                    EXIT DO
                                END IF
                            END IF
                            DO
                                CLS
                                PRINT "What is the account code of the account this item is located?"
                                PRINT ": "; location1$
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                LOOP UNTIL LEN(k$)
                                IF (k$ >= CHR$(48) AND k$ <= CHR$(57)) OR (k$ >= CHR$(65) AND k$ <= CHR$(90)) THEN
                                    location1$ = location1$ + k$
                                    inputlength = LEN(location1$)
                                END IF
                                IF k$ = CHR$(8) AND inputlength > 0 THEN
                                    location1$ = MID$(location1$, 1, (inputlength - 1))
                                    inputlength = (inputlength - 1)
                                END IF
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP UNTIL k$ = CHR$(13) AND LEN(location1$) <> 0
                            IF exitloop = 1 THEN EXIT DO
                            location1old$ = location1$
                            location2$ = ""
                            DO
                                CLS
                                PRINT "What is the mule code of the mule this item is located?"
                                PRINT ": "; location2$
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                LOOP UNTIL LEN(k$)
                                IF (k$ >= CHR$(48) AND k$ <= CHR$(57)) OR (k$ >= CHR$(65) AND k$ <= CHR$(90)) THEN
                                    location2$ = location2$ + k$
                                    inputlength = LEN(location2$)
                                END IF
                                IF k$ = CHR$(8) AND inputlength > 0 THEN
                                    location2$ = MID$(location2$, 1, (inputlength - 1))
                                    inputlength = (inputlength - 1)
                                END IF
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP UNTIL k$ = CHR$(13) AND LEN(location2$) <> 0
                            IF exitloop = 1 THEN EXIT DO
                            location2old$ = location2$
                            before = 1
                            EXIT DO
                        LOOP
                        IF exitloop = 1 THEN EXIT DO
                        DO
                            IF catcheckdone = 1 THEN EXIT DO
                            category$ = ""
                            DO
                                CLS
                                PRINT "How would you best categorize this item?"
                                PRINT "     1-Equip"
                                PRINT "     2-Use"
                                PRINT "     3-Mastery Book"
                                PRINT "     4-Etc"
                                PRINT "     5-Familiar"
                                PRINT "     6-Set-Up"
                                PRINT "     7-Chair"
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                LOOP UNTIL LEN(k$)
                                IF k$ = CHR$(49) THEN
                                    location3$ = "1"
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(50) THEN
                                    location3$ = "2"
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(51) THEN
                                    location3$ = "2"
                                    noquant = 1
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(52) THEN
                                    location3$ = "3"
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(53) THEN
                                    location3$ = "3"
                                    noquant = 1
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(54) THEN
                                    location3$ = "4"
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(55) THEN
                                    location3$ = "4"
                                    noquant = 1
                                    EXIT DO
                                END IF
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP
                            EXIT DO
                        LOOP
                        IF exitloop = 1 THEN EXIT DO
                        location3old$ = location3$
                        location4$ = ""
                        DO
                            DO
                                CLS
                                PRINT "In what box number is this item located?"
                                PRINT "Enter '*' to see how to determine the box number"
                                PRINT ": "; location4$
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                LOOP UNTIL LEN(k$)
                                IF k$ = CHR$(42) OR (k$ >= CHR$(48) AND k$ <= CHR$(57)) THEN
                                    location4$ = location4$ + k$
                                    inputlength = LEN(location4$)
                                END IF
                                IF k$ = CHR$(8) AND inputlength > 0 THEN
                                    location4$ = MID$(location4$, 1, (inputlength - 1))
                                    inputlength = (inputlength - 1)
                                END IF
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP UNTIL k$ = CHR$(13) AND LEN(location4$) <> 0
                            IF exitloop = 1 THEN EXIT DO
                            exitloopa = 1
                            IF k$ = CHR$(42) THEN
                                DO
                                    CLS
                                    PRINT " 1     2     3     4"
                                    PRINT
                                    PRINT " 5     6     7     8"
                                    PRINT
                                    PRINT " 9    10    11    12"
                                    PRINT
                                    PRINT "13    14    15    16"
                                    PRINT
                                    PRINT "17    18    19    20"
                                    PRINT
                                    PRINT "21    22    23    24"
                                    PRINT
                                    PRINT "Press Space to return"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    location4$ = ""
                                LOOP UNTIL k$ = CHR$(32)
                                exitloopa = 0
                            END IF
                            IF exitloopa = 1 THEN EXIT DO
                        LOOP
                        IF exitloop = 1 THEN EXIT DO
                        location$ = location1$ + "." + location2$ + "." + location3$ + "." + location4$
                        skiploc:
                        FOR printgets = 1 TO infogets
                            IF printgets <> selectglob THEN
                                PRINT #1, infoget$(printgets, 2)
                                FOR erg = 5 TO 64
                                    IF infoget$(printgets, erg) <> "" THEN PRINT #1, infoget$(printgets, erg)
                                NEXT erg
                            END IF
                        NEXT printgets
                        WRITE #1, location$
                        IF location3$ = "1" THEN
                            DO
                                CLS
                                PRINT "Use the up and down keys to navigate the stats"
                                PRINT "If the stat doesn't exist leave that option blank"
                                PRINT "* means it is required"
                                PRINT "For Potential and Nebulite, if it exists enter '1'"
                                PRINT "Press Escape at any time to return to the main menu"
                                PRINT "Press Space to Begin"
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                LOOP UNTIL LEN(k$)
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP UNTIL k$ = CHR$(32)
                            IF exitloop = 1 THEN EXIT DO
                            REDIM statslist$(25)
                            REDIM statvalue$(25)
                            REDIM statprefix$(25)
                            statslist$(1) = "          STR"
                            statslist$(2) = "          DEX"
                            statslist$(3) = "          LUK"
                            statslist$(4) = "          INT"
                            statslist$(5) = "        MaxHP"
                            statslist$(6) = "        MaxMP"
                            statslist$(7) = "WEAPON ATTACK"
                            statslist$(8) = " MAGIC ATTACK"
                            statslist$(9) = "   WEAPON DEF"
                            statslist$(10) = "    MAGIC DEF"
                            statslist$(11) = "     ACCURACY"
                            statslist$(12) = " AVOIDABILITY"
                            statslist$(13) = "        SPEED"
                            statslist$(14) = "         JUMP"
                            statslist$(15) = "   KNOCK-BACK"
                            statslist$(16) = "*       Slots"
                            statslist$(17) = "*     Hammers"
                            statslist$(18) = " Enhancements"
                            statslist$(19) = "    Potential"
                            statslist$(23) = "     Nebulite"
                            statslist$(25) = "      Crafter"
                            statprefix$(1) = "STR"
                            statprefix$(2) = "DEX"
                            statprefix$(3) = "LUK"
                            statprefix$(4) = "INT"
                            statprefix$(5) = "MAXHP"
                            statprefix$(6) = "MAXMP"
                            statprefix$(7) = "ATK"
                            statprefix$(8) = "MATK"
                            statprefix$(9) = "DEF"
                            statprefix$(10) = "MDEF"
                            statprefix$(11) = "ACC"
                            statprefix$(12) = "AVOID"
                            statprefix$(13) = "SPD"
                            statprefix$(14) = "JMP"
                            statprefix$(15) = "KB"
                            statprefix$(16) = "SLOTS"
                            statprefix$(17) = "HAMMERS"
                            statprefix$(18) = "ENHANCEMENTS"
                            statprefix$(25) = "Crafted By"
                            selected = 1
                            DO
                                CLS
                                PRINT "Fill in the equip's stats:"
                                PRINT
                                FOR printstats = 1 TO 25
                                    IF statslist$(printstats) <> "" THEN
                                        IF printstats = selected THEN
                                            COLOR 0, 15
                                        ELSE
                                            COLOR 15, 0
                                        END IF
                                        PRINT statslist$(printstats);
                                        COLOR 15, 0
                                        PRINT ": "; statvalue$(printstats)
                                    END IF
                                NEXT printstats
                                DO
                                    _LIMIT 128
                                    k$ = INKEY$
                                    DO WHILE _MOUSEINPUT
                                        selected = selected + _MOUSEWHEEL
                                        k$ = CHR$(255)
                                    LOOP
                                LOOP UNTIL LEN(k$)
                                IF (k$ >= CHR$(48) AND k$ <= CHR$(57)) OR (k$ = CHR$(45) AND (selected = 16 OR selected = 17)) OR ((k$ >= CHR$(32) AND k$ <= CHR$(126)) AND selected = 25) THEN statvalue$(selected) = statvalue$(selected) + k$
                                IF k$ = CHR$(8) AND LEN(statvalue$(selected)) <> 0 THEN statvalue$(selected) = MID$(statvalue$(selected), 1, (LEN(statvalue$(selected)) - 1))
                                IF k$ = CHR$(13) THEN
                                    IF statvalue$(16) <> "" AND statvalue$(17) <> "" THEN
                                        EXIT DO
                                    ELSE
                                        IF statvalue$(17) = "" THEN selected = 17
                                        IF statvalue$(16) = "" THEN selected = 16
                                    END IF
                                END IF
                                IF k$ = (CHR$(0) + CHR$(72)) AND selected <> 1 THEN
                                    selected = selected - 1
                                    DO
                                        IF statslist$(selected) = "" THEN selected = selected - 1
                                    LOOP UNTIL statslist$(selected) <> ""
                                END IF
                                IF k$ = (CHR$(0) + CHR$(80)) AND selected <> 25 THEN
                                    selected = selected + 1
                                    DO
                                        IF statslist$(selected) = "" THEN selected = selected + 1
                                    LOOP UNTIL statslist$(selected) <> ""
                                END IF
                                IF k$ = CHR$(27) THEN
                                    exitloop = 1
                                    EXIT DO
                                END IF
                            LOOP
                            IF exitloop = 1 THEN EXIT DO
                            IF statvalue$(19) = "1" THEN
                                DO
                                    CLS
                                    PRINT "What tier of Potential does it have?"
                                    PRINT "     1-Rare"
                                    PRINT "     2-Epic"
                                    PRINT "     3-Unique"
                                    PRINT "     4-Legendary"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(49) THEN
                                        pot$ = "Rare"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(50) THEN
                                        pot$ = "Epic"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(51) THEN
                                        pot$ = "Unique"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(52) THEN
                                        pot$ = "Legendary"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP
                                IF exitloop = 1 THEN EXIT DO
                                DO
                                    CLS
                                    PRINT " How many lines does it have?"
                                    PRINT "     2-2 Lines"
                                    PRINT "     3-3 Lines"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(50) THEN
                                        potline$ = "2"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(51) THEN
                                        potline$ = "3"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP
                                IF exitloop = 1 THEN EXIT DO
                                potential$ = pot$ + " " + potline$ + " Lines: "
                                statvalue$(19) = potential$
                                FOR lines = 1 TO VAL(potline$)
                                    REDIM lines$(lines)
                                    DO
                                        CLS
                                        PRINT "Enter line"; lines; "of the potential exactly as it appears on the item"
                                        PRINT ": "; lines$(lines)
                                        DO
                                            _LIMIT 128
                                            k$ = INKEY$
                                        LOOP UNTIL LEN(k$)
                                        IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                                            lines$(lines) = lines$(lines) + k$
                                            inputlength = LEN(lines$(lines))
                                        END IF
                                        IF k$ = CHR$(8) AND inputlength > 0 THEN
                                            lines$(lines) = MID$(lines$(lines), 1, (inputlength - 1))
                                            inputlength = (inputlength - 1)
                                        END IF
                                        IF k$ = CHR$(27) THEN
                                            exitloop = 1
                                            EXIT DO
                                        END IF
                                    LOOP UNTIL k$ = CHR$(13) AND LEN(lines$(lines)) <> 0
                                    IF exitloop = 1 THEN EXIT DO
                                    lines$(lines) = "     -" + lines$(lines)
                                    statvalue$((19 + lines)) = lines$(lines)
                                NEXT lines
                            ELSE
                                statvalue$(19) = ""
                            END IF
                            IF statvalue$(23) = "1" THEN
                                DO
                                    CLS
                                    PRINT "What type of Nebulite does it have?"
                                    PRINT "     1-A"
                                    PRINT "     2-B"
                                    PRINT "     3-C"
                                    PRINT "     4-D"
                                    PRINT "     5-S"
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ = CHR$(49) THEN
                                        neb$ = "[A]"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(50) THEN
                                        neb$ = "[B]"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(51) THEN
                                        neb$ = "[C]"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(52) THEN
                                        neb$ = "[D]"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(53) THEN
                                        neb$ = "[S]"
                                        EXIT DO
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP
                                IF exitloop = 1 THEN EXIT DO
                                nebulite$ = neb$ + " Nebulite: "
                                statvalue$(23) = nebulite$
                                DO
                                    CLS
                                    PRINT "Enter the effect of the nebulite exactly as shown, without the nebulite rank"
                                    PRINT "Nebulite Effect: "; nebf$
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN
                                        nebf$ = nebf$ + k$
                                        inputlength = LEN(nebf$)
                                    END IF
                                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                                        nebf$ = MID$(nebf$, 1, (inputlength - 1))
                                        inputlength = (inputlength - 1)
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP UNTIL k$ = CHR$(13) AND LEN(nebf$) <> 0
                                IF exitloop = 1 THEN EXIT DO
                                nebf$ = "     -" + nebf$
                                statvalue$(24) = nebf$
                            ELSE
                                statvalue$(23) = ""
                            END IF
                            FOR fixstats = 1 TO 25
                                DO
                                    fixstatexit = 0
                                    IF LEFT$(statvalue$(fixstats), 1) = "0" AND (fixstats <> 16 AND fixstats <> 17) THEN
                                        statvalue$(fixstats) = MID$(statvalue$(fixstats), 2, (LEN(statvalue$(fixstats)) - 1))
                                        fixstatsexit = 1
                                    END IF
                                LOOP UNTIL fixstatsexit = 0
                            NEXT fixstats
                            FOR printstats = 1 TO 25
                                IF statvalue$(printstats) <> "" THEN
                                    IF statprefix$(printstats) <> "" THEN statvalue$(printstats) = statprefix$(printstats) + ": " + statvalue$(printstats)
                                    PRINT #1, statvalue$(printstats)
                                END IF
                            NEXT printstats
                            DO
                                CLS
                                PRINT "Entry complete"
                                k = 0
                                DO
                                    k = k + 1
                                    _LIMIT 128
                                    k$ = INKEY$
                                    IF k = 128 THEN
                                        exitec = 1
                                        EXIT DO
                                    END IF
                                LOOP UNTIL LEN(k$)
                                IF exitec = 1 THEN EXIT DO
                            LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                        ELSE
                            IF noquant = 0 THEN
                                exitloop = 0
                                quantity$ = ""
                                DO
                                    CLS
                                    PRINT "Enter how many of this item do we have total?"
                                    PRINT ": "; quantity$
                                    DO
                                        _LIMIT 128
                                        k$ = INKEY$
                                    LOOP UNTIL LEN(k$)
                                    IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN
                                        quantity$ = quantity$ + k$
                                        inputlength = LEN(quantity$)
                                    END IF
                                    IF k$ = CHR$(8) AND inputlength > 0 THEN
                                        quantity$ = MID$(quantity$, 1, (inputlength - 1))
                                        inputlength = (inputlength - 1)
                                    END IF
                                    IF k$ = CHR$(27) THEN
                                        exitloop = 1
                                        EXIT DO
                                    END IF
                                LOOP UNTIL k$ = CHR$(13)
                                IF exitloop = 1 THEN EXIT DO
                                quantity$ = "Quantity: " + quantity$
                                WRITE #1, quantity$
                                DO
                                    CLS
                                    PRINT "Entry complete"
                                    k = 0
                                    DO
                                        k = k + 1
                                        _LIMIT 128
                                        k$ = INKEY$
                                        IF k = 128 THEN
                                            exitec = 1
                                            EXIT DO
                                        END IF
                                    LOOP UNTIL LEN(k$)
                                    IF exitec = 1 THEN EXIT DO
                                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                            ELSE
                                quantity$ = "Quantity: " + "1"
                                WRITE #1, quantity$
                                DO
                                    CLS
                                    PRINT "Entry complete"
                                    k = 0
                                    DO
                                        k = k + 1
                                        _LIMIT 128
                                        k$ = INKEY$
                                        IF k = 128 THEN
                                            exitec = 1
                                            EXIT DO
                                        END IF
                                    LOOP UNTIL LEN(k$)
                                    IF exitec = 1 THEN EXIT DO
                                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                            END IF
                        END IF
                        before = 1
                        CLOSE #1
                        REDIM infotransfer$(1024)
                        inputcount = 0
                        OPEN tmpfile$ FOR INPUT AS #1
                        DO
                            inputcount = inputcount + 1
                            LINE INPUT #1, infotransfer$(inputcount)
                        LOOP UNTIL EOF(1) = -1
                        CLOSE #1
                        endlines = 0
                        FOR checker = 1 TO inputcount
                            endline$ = ""
                            FOR check = 1 TO LEN(infotransfer$(checker))
                                check$ = MID$(infotransfer$(checker), check, 1)
                                IF check$ <> CHR$(34) THEN endline$ = endline$ + check$
                            NEXT check
                            IF endline$ <> "" THEN
                                infotransfer$(checker) = endline$
                                endlines = endlines + 1
                            END IF
                        NEXT checker
                        OPEN filename$ FOR OUTPUT AS #1
                        FOR writer = 1 TO endlines
                            PRINT #1, infotransfer$(writer)
                        NEXT writer
                        CLOSE #1
                        KILL tmpfile$
                        SELECT CASE VAL(location3$)
                            CASE 1
                                OPEN fileloc$ + "[0eqp.txt" FOR OUTPUT AS #1
                                FOR remvac = 1 TO eqpvac
                                    IF eqpvac$(remvac) <> location$ THEN PRINT #1, eqpvac$(remvac)
                                NEXT remvac
                                CLOSE #1
                            CASE 2
                                OPEN fileloc$ + "[0use.txt" FOR OUTPUT AS #1
                                FOR remvac = 1 TO usevac
                                    IF usevac$(remvac) <> location$ THEN PRINT #1, usevac$(remvac)
                                NEXT remvac
                                CLOSE #1
                            CASE 3
                                OPEN fileloc$ + "[0etc.txt" FOR OUTPUT AS #1
                                FOR remvac = 1 TO etcvac
                                    IF etcvac$(remvac) <> location$ THEN PRINT #1, etcvac$(remvac)
                                NEXT remvac
                                CLOSE #1
                            CASE 4
                                OPEN fileloc$ + "[0stp.txt" FOR OUTPUT AS #1
                                FOR remvac = 1 TO stpvac
                                    IF stpvac$(remvac) <> location$ THEN PRINT #1, stpvac$(remvac)
                                NEXT remvac
                                CLOSE #1
                        END SELECT
                        exitloop = 1
                        EXIT DO
                    END IF
                    IF k$ = CHR$(27) THEN
                        exitloop = 1
                        EXIT DO
                    END IF
                LOOP
                IF exitloop = 1 THEN
                    exitloop = 0
                    CLOSE #1
                    KILL tmpfile$
                    GOSUB start
                END IF
            LOOP
        LOOP
    END IF
    IF k$ = CHR$(49) THEN
        vacancies:
        DO
            _LIMIT 128
            k$ = INKEY$
        LOOP UNTIL k$ = ""
        row = 1
        DO
            CLS
            PRINT "What type of item vacancy would you like to find?"
            PRINT "   1-Equip"
            PRINT "   2-Use"
            PRINT "   3-Etc"
            PRINT "   4-Set-up"
            DO
                _LIMIT 128
                k$ = INKEY$
            LOOP UNTIL LEN(k$)
            IF k$ = CHR$(49) THEN
                DO
                    CLS
                    PRINT "Press Space or Enter to exit"
                    PRINT
                    IF (row + 25) > eqpvac THEN row = (eqpvac - 25)
                    IF row < 1 THEN row = 1
                    VIEW PRINT 3 TO 28
                    IF eqpvac < 25 THEN
                        FOR eqpprinter = 1 TO eqpvac
                            PRINT eqpvac$(eqpprinter)
                        NEXT eqpprinter
                    ELSE
                        FOR eqpprinter = row TO (row + 25)
                            PRINT eqpvac$(eqpprinter)
                        NEXT eqpprinter
                    END IF
                    VIEW PRINT
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                        DO WHILE _MOUSEINPUT
                            row = row + (_MOUSEWHEEL * 3)
                            k$ = CHR$(255)
                        LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ = (CHR$(0) + CHR$(72)) THEN row = row - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN row = row + 1
                    IF k$ = (CHR$(0) + CHR$(75)) THEN row = 1
                    IF k$ = (CHR$(0) + CHR$(77)) THEN row = (eqpvac - 25)
                    IF k$ = CHR$(27) THEN GOSUB start
                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                GOSUB start
            END IF
            IF k$ = CHR$(50) THEN
                DO
                    CLS
                    PRINT "Press Space or Enter to exit"
                    PRINT
                    IF (row + 25) > usevac THEN row = (usevac - 25)
                    IF row < 1 THEN row = 1
                    VIEW PRINT 3 TO 28
                    IF usevac < 25 THEN
                        FOR useprinter = 1 TO usevac
                            PRINT usevac$(useprinter)
                        NEXT useprinter
                    ELSE
                        FOR useprinter = row TO (row + 25)
                            PRINT usevac$(useprinter)
                        NEXT useprinter
                    END IF
                    VIEW PRINT
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                        DO WHILE _MOUSEINPUT
                            row = row + (_MOUSEWHEEL * 3)
                            k$ = CHR$(255)
                        LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ = (CHR$(0) + CHR$(72)) THEN row = row - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN row = row + 1
                    IF k$ = (CHR$(0) + CHR$(75)) THEN row = 1
                    IF k$ = (CHR$(0) + CHR$(77)) THEN row = (usevac - 25)
                    IF k$ = CHR$(27) THEN GOSUB start
                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                GOSUB start
            END IF
            IF k$ = CHR$(51) THEN
                DO
                    CLS
                    PRINT "Press Space or Enter to exit"
                    PRINT
                    IF (row + 25) > etcvac THEN row = (etcvac - 25)
                    IF row < 1 THEN row = 1
                    VIEW PRINT 3 TO 28
                    IF etcvac < 25 THEN
                        FOR etcprinter = 1 TO etcvac
                            PRINT etcvac$(etcprinter)
                        NEXT etcprinter
                    ELSE
                        FOR etcprinter = row TO (row + 25)
                            PRINT etcvac$(etcprinter)
                        NEXT etcprinter
                    END IF
                    VIEW PRINT
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                        DO WHILE _MOUSEINPUT
                            row = row + (_MOUSEWHEEL * 3)
                            k$ = CHR$(255)
                        LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ = (CHR$(0) + CHR$(72)) THEN row = row - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN row = row + 1
                    IF k$ = (CHR$(0) + CHR$(75)) THEN row = 1
                    IF k$ = (CHR$(0) + CHR$(77)) THEN row = (etcvac - 25)
                    IF k$ = CHR$(27) THEN GOSUB start
                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                GOSUB start
            END IF
            IF k$ = CHR$(52) THEN
                DO
                    CLS
                    PRINT "Press Space or Enter to exit"
                    PRINT
                    IF (row + 25) > stpvac THEN row = (stpvac - 25)
                    IF row < 1 THEN row = 1
                    VIEW PRINT 3 TO 28
                    IF stpvac < 25 THEN
                        FOR stpprinter = 1 TO stpvac
                            PRINT stpvac$(stpprinter)
                        NEXT stpprinter
                    ELSE
                        FOR stpprinter = row TO (row + 25)
                            PRINT stpvac$(stpprinter)
                        NEXT stpprinter
                    END IF
                    VIEW PRINT
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                        DO WHILE _MOUSEINPUT
                            row = row + (_MOUSEWHEEL * 3)
                            k$ = CHR$(255)
                        LOOP
                    LOOP UNTIL LEN(k$)
                    IF k$ = (CHR$(0) + CHR$(72)) THEN row = row - 1
                    IF k$ = (CHR$(0) + CHR$(80)) THEN row = row + 1
                    IF k$ = (CHR$(0) + CHR$(75)) THEN row = 1
                    IF k$ = (CHR$(0) + CHR$(77)) THEN row = (stpvac - 25)
                    IF k$ = CHR$(27) THEN GOSUB start
                LOOP UNTIL k$ = CHR$(13) OR k$ = CHR$(32)
                GOSUB start
            END IF
            IF k$ = CHR$(27) THEN
                GOSUB start
            END IF
        LOOP
    END IF
    IF k$ = CHR$(50) THEN
        notes:
        IF _FILEEXISTS("mun.txt") = -1 THEN
            OPEN "mun.txt" FOR INPUT AS #1
            LINE INPUT #1, mun$
            CLOSE #1
        ELSE
            mun$ = ""
            DO
                CLS
                PRINT "Unable to find your Notes User Name"
                PRINT "Please enter your Notes User Name here:"
                PRINT ": "; mun$
                DO
                    _LIMIT 128
                    k$ = INKEY$
                LOOP UNTIL LEN(k$)
                IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN mun$ = mun$ + k$
                IF k$ = CHR$(8) AND LEN(mun$) <> 0 THEN mun$ = MID$(mun$, 1, (LEN(mun$) - 1))
                IF k$ = CHR$(27) THEN GOSUB start
            LOOP UNTIL k$ = CHR$(13)
            OPEN "mun.txt" FOR OUTPUT AS #1
            PRINT #1, mun$
            CLOSE #1
        END IF
        selected = 1
        row = 1
        DO
            CLS
            IF selected < 1 THEN selected = 1
            IF selected > notes THEN selected = notes
            IF row + 25 < notes AND selected > row + 11 THEN
                row = row + 1
            END IF
            IF row <> 1 AND selected < row + 11 THEN
                row = row - 1
            END IF
            IF row = 1 AND selected < row + 11 THEN
                row = row
            END IF
            IF row + 12 = notes AND selected > row + 11 THEN
                row = row
            END IF
            PRINT ": "; newnote$
            PRINT
            FOR noteprint = row TO row + 25
                IF noteprint = selected THEN
                    COLOR 0, 15
                ELSE
                    COLOR 15, 0
                END IF
                PRINT note$(noteprint)
            NEXT noteprint
            COLOR 15, 0
            DO
                _LIMIT 128
                k$ = INKEY$
                DO WHILE _MOUSEINPUT
                    selected = selected + _MOUSEWHEEL
                    k$ = CHR$(255)
                LOOP
            LOOP UNTIL LEN(k$)
            IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN newnote$ = newnote$ + k$
            IF k$ = CHR$(8) AND LEN(newnote$) <> 0 THEN newnote$ = MID$(newnote$, 1, (LEN(newnote$) - 1))
            IF (LEN(newnote$) + LEN(mun$) + 2) > 80 THEN newnote$ = MID$(newnote$, 1, (78 - LEN(mun$)))
            IF k$ = CHR$(13) AND newnote$ <> "" THEN
                FOR notemove = (notes + 1) TO 1 STEP -1
                    note$(notemove) = note$(notemove - 1)
                NEXT notemove
                note$(1) = mun$ + ": " + newnote$
                newnote$ = ""
                notes = notes + 1
                selected = 1
                row = 1
            END IF
            IF (k$ = CHR$(0) + CHR$(83)) THEN
                note$(selected) = ""
                REDIM notecopy$(1028)
                FOR notecopy = 1 TO notes
                    notecopy$(notecopy) = note$(notecopy)
                NEXT notecopy
                REDIM note$(1028)
                notesnow = 0
                FOR noterid = 1 TO notes
                    IF notecopy$(noterid) <> "" THEN
                        notesnow = notesnow + 1
                        note$(notesnow) = notecopy$(noterid)
                    END IF
                NEXT noterid
                notes = notesnow
            END IF
            IF k$ = (CHR$(0) + CHR$(72)) THEN selected = selected - 1
            IF k$ = (CHR$(0) + CHR$(80)) THEN selected = selected + 1
            IF k$ = CHR$(27) THEN EXIT DO
        LOOP
        OPEN fileloc$ + "[0notes.txt" FOR OUTPUT AS #1
        FOR savenotes = 1 TO notes
            PRINT #1, note$(savenotes)
        NEXT savenotes
        IF notes = 0 THEN PRINT #1, ""
        CLOSE #1
        GOSUB start
    END IF
LOOP UNTIL k$ = CHR$(27)
SYSTEM
RETURN

prepare:
OPEN "locold.tmp" FOR OUTPUT AS #1
PRINT #1, STR$(bts)
CLOSE #1
IF before = 1 THEN
    OPEN "locold.tmp" FOR APPEND AS #1
    PRINT #1, location1old$
    PRINT #1, location2old$
    PRINT #1, location3old$
    CLOSE #1
    CLEAR
    before = 1
    OPEN "locold.tmp" FOR INPUT AS #1
    LINE INPUT #1, bts$
    LINE INPUT #1, location1old$
    LINE INPUT #1, location2old$
    LINE INPUT #1, location3old$
    CLOSE #1
ELSE
    CLEAR
    OPEN "locold.tmp" FOR INPUT AS #1
    LINE INPUT #1, bts$
    CLOSE #1
END IF
KILL "locold.tmp"
path$ = STRING$(260, 0)
hr& = SHGetFolderPathA(0, CSIDL_PERSONAL, 0, 0, _OFFSET(path$))
n& = 1
DO WHILE ASC(path$, n&)
    n& = n& + 1
    IF n& > 260 THEN EXIT DO
LOOP
path$ = LEFT$(path$, n& - 1)
fileloc$ = path$
fileloc$ = fileloc$ + "Dropbox\MSCollector Items\"
IF _FILEEXISTS(fileloc$ + "[0list.txt") = 0 THEN
    fileloc$ = "C:" + ENVIRON$("HOMEPATH") + "\My Documents\Dropbox\MSCollector Items\"
    IF _FILEEXISTS(fileloc$ + "[0list.txt") = 0 THEN
        IF _FILEEXISTS("mscil.txt") = -1 THEN
            OPEN "mscil.txt" FOR INPUT AS #1
            LINE INPUT #1, fileloc$
            CLOSE #1
        ELSE
            DO
                fileloc$ = ""
                DO
                    CLS
                    PRINT "Unable to find your MSCollector Items folder"
                    PRINT "Please enter the full drive location here:"
                    PRINT ": "; fileloc$
                    DO
                        _LIMIT 128
                        k$ = INKEY$
                    LOOP UNTIL LEN(k$)
                    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN fileloc$ = fileloc$ + k$
                    IF k$ = CHR$(8) AND LEN(fileloc$) <> 0 THEN fileloc$ = MID$(fileloc$, 1, (LEN(fileloc$) - 1))
                    IF k$ = CHR$(27) THEN SYSTEM
                LOOP UNTIL k$ = CHR$(13)
            LOOP UNTIL _FILEEXISTS(fileloc$ + "[0list.txt") = -1
            OPEN "mscil.txt" FOR OUTPUT AS #1
            PRINT #1, fileloc$
            CLOSE #1
        END IF
    END IF
END IF
REDIM eqpvac$(32768)
REDIM etcvac$(32768)
REDIM info$(64)
REDIM infotransfer$(32)
REDIM lines$(4)
REDIM namelist$(131072)
REDIM note$(1028)
REDIM notecopy$(1028)
REDIM printlist$(131072)
REDIM statprefix$(32)
REDIM statslist$(32)
REDIM statvalue$(32)
REDIM stpvac$(32768)
REDIM usevac$(32768)
namelistloc$ = fileloc$ + "[0list.txt"
inputcount = 1
OPEN namelistloc$ FOR INPUT AS #1
DO UNTIL EOF(1)
    LINE INPUT #1, namelist$(inputcount)
    ON ERROR GOTO endoffile
    inputcount = inputcount + 1
LOOP
endoffile:
CLOSE #1
OPEN fileloc$ + "[0eqp.txt" FOR INPUT AS #1
DO
    eqpvac = eqpvac + 1
    LINE INPUT #1, eqpvac$(eqpvac)
LOOP UNTIL EOF(1) = -1
CLOSE #1
OPEN fileloc$ + "[0use.txt" FOR INPUT AS #1
DO
    usevac = usevac + 1
    LINE INPUT #1, usevac$(usevac)
LOOP UNTIL EOF(1) = -1
CLOSE #1
OPEN fileloc$ + "[0etc.txt" FOR INPUT AS #1
DO
    etcvac = etcvac + 1
    LINE INPUT #1, etcvac$(etcvac)
LOOP UNTIL EOF(1) = -1
CLOSE #1
OPEN fileloc$ + "[0stp.txt" FOR INPUT AS #1
DO
    stpvac = stpvac + 1
    LINE INPUT #1, stpvac$(stpvac)
LOOP UNTIL EOF(1) = -1
CLOSE #1
OPEN fileloc$ + "[0notes.txt" FOR INPUT AS #1
DO
    notes = notes + 1
    LINE INPUT #1, note$(notes)
LOOP UNTIL EOF(1) = -1
CLOSE #1
IF notes = 1 THEN notes = 0
ON ERROR GOTO start
SELECT CASE VAL(bts$)
    CASE 0
        GOTO poststart
    CASE 1
        GOTO search
END SELECT
RETURN

searchlist:
IF olditem$ <> item$ THEN
    REDIM printlist$(131072)
    listnum = 0
    FOR ni = 1 TO inputcount
        IF LEFT$(namelist$(ni), inputlength) = item$ THEN
            listnum = listnum + 1
            printlist$(listnum) = namelist$(ni)
        END IF
    NEXT ni
    row = 1
    selected = 1
    olditem$ = item$
END IF
RETURN