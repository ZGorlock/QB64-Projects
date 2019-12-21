TYPE RANGE
    min AS LONG
    max AS LONG
END TYPE

TYPE monster
    id AS _UNSIGNED LONG
    name AS STRING * 32
    lv AS RANGE
    description AS STRING * 4096
    alignment AS RANGE
    type AS STRING * 16
    attribute AS STRING * 16
    variation AS STRING * 40
    behaviour AS _BYTE
    action AS STRING * 1024
    interact AS STRING * 256 'interact(2, 32) AS _UNSIGNED LONG
    width AS LONG
    height AS LONG
    age AS RANGE
    health AS RANGE
    mana AS RANGE
    stamina AS RANGE
    attack AS RANGE
    defense AS RANGE
    speed AS RANGE
    intelligence AS RANGE
    armour AS STRING * 960 'armour(15, 16) AS _UNSIGNED LONG
    armourchance AS STRING * 960 'armourchance(15, 16) AS SINGLE
    exp AS RANGE
    gold AS RANGE
    loot AS STRING * 2048 'loot(512) AS _UNSIGNED LONG
    lootchance AS STRING * 2048 'lootchance(512) AS SINGLE
    lootquantity AS STRING * 4096 'lootquantity(512) AS RANGE
    traindif AS RANGE
    spell AS STRING * 512 'spell(128) AS _UNSIGNED LONG
    psionics AS RANGE
    sprites AS STRING * 10 'sprites(10) AS _BYTE
    sounds AS STRING * 12 'sounds(12) AS _BYTE
    soundname AS STRING * 96 'soundname(96) AS _BYTE
    pad AS STRING * 37
END TYPE

OPTION BASE 1

DIM newmonster AS monster

DIM m AS _MEM
DIM n AS _MEM

REDIM interact(2, 32) AS _UNSIGNED LONG
REDIM armour(15, 16) AS _UNSIGNED LONG
REDIM armourchance(15, 16) AS SINGLE
REDIM loot(512) AS _UNSIGNED LONG
REDIM lootchance(512) AS SINGLE
REDIM lootquantity(512) AS RANGE
REDIM spell(128) AS _UNSIGNED LONG
REDIM sprites(10) AS _BYTE
REDIM sounds(12) AS _BYTE
REDIM soundname(96) AS _BYTE



'DIM filename AS STRING

DO
    _LIMIT 32
    CLS
    PRINT "Enter the name of the txt file without the '.txt'"
    PRINT ": "; filename$
    k$ = INKEY$
    IF k$ > "" THEN
        IF k$ = CHR$(13) AND _FILEEXISTS(filename$ + ".txt") THEN EXIT DO
        IF k$ = CHR$(8) AND LEN(filename$) > 0 THEN
            filename$ = LEFT$(filename$, LEN(filename$) - 1)
        ELSE
            filename$ = filename$ + k$
        END IF
    END IF
LOOP
filename$ = filename$ + ".txt"




OPEN filename$ FOR INPUT AS #1
LINE INPUT #1, in$
newmonster.id = VAL("&H" + in$)
LINE INPUT #1, newmonster.name
INPUT #1, newmonster.lv.min
INPUT #1, newmonster.lv.max
LINE INPUT #1, newmonster.description
INPUT #1, newmonster.alignment.min
INPUT #1, newmonster.alignment.max
LINE INPUT #1, newmonster.type
LINE INPUT #1, newmonster.attribute
LINE INPUT #1, newmonster.variation
INPUT #1, newmonster.behaviour
LINE INPUT #1, newmonster.action
FOR x = 1 TO 2
    FOR y = 1 TO 32
        LINE INPUT #1, in$
        interact(x, y) = VAL("&H" + in$)
NEXT y, x
m = _MEM(interact())
n = _MEM(newmonster.interact)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
INPUT #1, newmonster.width
INPUT #1, newmonster.height
INPUT #1, newmonster.age.min
INPUT #1, newmonster.age.max
INPUT #1, newmonster.health.min
INPUT #1, newmonster.health.max
INPUT #1, newmonster.mana.min
INPUT #1, newmonster.mana.max
INPUT #1, newmonster.stamina.min
INPUT #1, newmonster.stamina.max
INPUT #1, newmonster.attack.min
INPUT #1, newmonster.attack.max
INPUT #1, newmonster.defense.min
INPUT #1, newmonster.defense.max
INPUT #1, newmonster.speed.min
INPUT #1, newmonster.speed.max
INPUT #1, newmonster.intelligence.min
INPUT #1, newmonster.intelligence.max
FOR x = 1 TO 15
    FOR y = 1 TO 16
        LINE INPUT #1, in$
        armour(x, y) = VAL("&H" + in$)
        INPUT #1, armourchance(x, y)
NEXT y, x
m = _MEM(armour())
n = _MEM(newmonster.armour)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
m = _MEM(armourchance())
n = _MEM(newmonster.armourchance)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
INPUT #1, newmonster.exp.min
INPUT #1, newmonster.exp.max
INPUT #1, newmonster.gold.min
INPUT #1, newmonster.gold.max
FOR x = 1 TO 512
    LINE INPUT #1, in$
    loot(x) = VAL("&H" + in$)
    INPUT #1, lootchance(x)
    INPUT #1, lootquantity(x).min
    INPUT #1, lootquantity(x).max
NEXT x
m = _MEM(loot())
n = _MEM(newmonster.loot)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
m = _MEM(lootchance())
n = _MEM(newmonster.lootchance)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
m = _MEM(lootquantity())
n = _MEM(newmonster.lootquantity)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
INPUT #1, newmonster.traindif.min
INPUT #1, newmonster.traindif.max
FOR x = 1 TO 128
    LINE INPUT #1, in$
    spell(x) = VAL("&H" + in$)
NEXT x
m = _MEM(spell())
n = _MEM(newmonster.spell)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
INPUT #1, newmonster.psionics.min
INPUT #1, newmonster.psionics.max
FOR x = 1 TO 10
    INPUT #1, sprites(x)
NEXT x
m = _MEM(sprites())
n = _MEM(newmonster.sprites)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
FOR x = 1 TO 12
    INPUT #1, sounds(x)
NEXT x
m = _MEM(sounds())
n = _MEM(newmonster.sounds)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
FOR x = 1 TO 96
    INPUT #1, soundname(x)
NEXT x
m = _MEM(soundname())
n = _MEM(newmonster.soundname)
_MEMCOPY m, m.OFFSET, m.SIZE TO n, n.OFFSET
_MEMFREE m
_MEMFREE n
CLOSE #1

OPEN "resource\db\monster.db" FOR BINARY AS #1
location = LOF(1)
IF location = 0 THEN location = 1
PUT #1, location, newmonster
CLOSE #1
DIM idnum AS STRING
idnum$ = LTRIM$(RTRIM$(STR$(newmonster.id)))
idnum$ = STRING$(10 - LEN(idnum$), 48) + idnum$
OPEN "resource\db\index\monster.idx" FOR APPEND AS #1
PRINT #1, idnum$
CLOSE #1

SYSTEM