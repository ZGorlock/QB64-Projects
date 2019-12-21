'load database indexes
DIM indexcount AS _UNSIGNED LONG
indexcount = 0
OPEN "resource\db\index\map.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_map(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_map(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1
indexcount = 0
OPEN "resource\db\index\monster.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_monster(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_monster(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1
indexcount = 0
OPEN "resource\db\index\item.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_item(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_item(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1
indexcount = 0
OPEN "resource\db\index\npc.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_npc(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_npc(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1
indexcount = 0
OPEN "resource\db\index\spell.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_spell(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_spell(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1
indexcount = 0
OPEN "resource\db\index\quest.idx" FOR INPUT AS #1
IF LOF(1) THEN
    REDIM index_quest(INT(LOF(1) / 12))
    DO
        indexcount = indexcount + 1
        INPUT #1, index_quest(indexcount)
    LOOP UNTIL EOF(1)
END IF
CLOSE #1