'shared array dimensioning
REDIM SHARED cursordata(1 TO 0, 1 TO 0) AS INTEGER
REDIM SHARED screenlayer(1 TO 0) AS LONG
REDIM SHARED cursors(1 TO 0) AS STRING

'database array dimensioning
'$INCLUDE:'include\db\array.bi'

'array dimensioning
REDIM primestat(1 TO 0) AS _BYTE
REDIM monsters_sounds(1 TO 0, 1 TO 0) AS _BYTE
REDIM monsters_soundname(1 TO 0, 1 TO 0) AS _BYTE
REDIM monsters_sprites(1 TO 0, 1 TO 0) AS _BYTE
REDIM tempmonstersoundname(1 TO 0) AS _BYTE
REDIM tempmonstersounds(1 TO 0) AS _BYTE
REDIM tempmonstersprites(1 TO 0) AS _BYTE
REDIM newgamepass(1 TO 0) AS _UNSIGNED _BYTE
REDIM freedmonsterimage(1 TO 0) AS INTEGER
REDIM monsters_image(1 TO 0, 1 TO 0, 1 TO 0) AS INTEGER
REDIM racehave(1 TO 0) AS _UNSIGNED INTEGER
REDIM monsters_sound(1 TO 0, 1 TO 0) AS LONG
REDIM tempmonsterspell(1 TO 0) AS _UNSIGNED LONG
REDIM monsters_spell(1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM tempmonsterinteract(1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM tempmonsterloot(1 TO 0) AS _UNSIGNED LONG
REDIM monsters_interact(1 TO 0, 1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM monsters_loot(1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM tempmonsterarmour(1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM monsters_armour(1 TO 0, 1 TO 0, 1 TO 0) AS _UNSIGNED LONG
REDIM tempmonsterlootchance(1 TO 0) AS SINGLE
REDIM hexp(1 TO 0, 1 TO 0) AS SINGLE
REDIM monsters_lootchance(1 TO 0, 1 TO 0) AS SINGLE
REDIM setprimestatpoint(1 TO 0, 1 TO 0) AS SINGLE
REDIM tempmonsterarmourchance(1 TO 0, 1 TO 0) AS SINGLE
REDIM monsters_armourchance(1 TO 0, 1 TO 0, 1 TO 0) AS SINGLE
REDIM errormessage(1 TO 0) AS STRING
REDIM instruction(1 TO 0) AS STRING
REDIM newgamemenuslides(1 TO 0) AS STRING
REDIM primestatdescription(1 TO 0) AS STRING
REDIM primestatname(1 TO 0) AS STRING
REDIM racedescription(1 TO 0) AS STRING
REDIM races(1 TO 0) AS STRING
REDIM textures(1 TO 0) AS STRING
REDIM titlebuttons(1 TO 0) AS STRING
REDIM tempmonsterlootquantity(1 TO 0) AS RANGE
REDIM monsters_lootquantity(1 TO 0, 1 TO 0) AS RANGE
REDIM monsters(1 TO 0) AS monster