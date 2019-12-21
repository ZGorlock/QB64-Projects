'finds the index of a data stucture in a database
'parameter: the id to search for
'parameter: the array of sequencial ids of the particular database
'parameter: the code of the database to look in
'return: the location in the database where the structure with the id begins
FUNCTION dbindex& (id AS _UNSIGNED LONG, index() AS _UNSIGNED LONG, db AS _BYTE)
DIM blocklength AS LONG
FOR dbindex = 1 TO UBOUND(index)
    IF id = index(dbindex) THEN
        SELECT CASE db
            CASE 1
                blocklength = DB_MAP_SIZE
            CASE 2
                blocklength = DB_MONSTER_SIZE
            CASE 3
                blocklength = DB_ITEM_SIZE
            CASE 4
                blocklength = DB_NPC_SIZE
            CASE 5
                blocklength = DB_SPELL_SIZE
            CASE 6
                blocklength = DB_QUEST_SIZE
        END SELECT
        dbindex = (dbindex - 1) * blocklength - (dbindex - 2)
        EXIT FUNCTION
    END IF
NEXT dbindex
dbindex = -1
END FUNCTION