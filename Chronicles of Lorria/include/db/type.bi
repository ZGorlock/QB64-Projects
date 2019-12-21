'database type declarations
TYPE monster
    id AS _UNSIGNED LONG
    name AS STRING * 32
    lv AS RANGE
    description AS STRING * 2048
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
    pad AS STRING * 1973
END TYPE