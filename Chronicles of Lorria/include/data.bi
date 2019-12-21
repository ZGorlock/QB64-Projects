'load cursors
REDIM SHARED cursordata(16, 3) AS INTEGER
REDIM SHARED cursors(16) AS STRING
Numofcursor = 0
OPEN "resource\data\cursors.txt" FOR INPUT AS #1
DO
    Numofcursor = Numofcursor + 1
    LINE INPUT #1, cursors(Numofcursor)
    INPUT #1, cursordata(Numofcursor, 1)
    INPUT #1, cursordata(Numofcursor, 2)
    INPUT #1, cursordata(Numofcursor, 3)
LOOP UNTIL EOF(1)
CLOSE #1

'load errormessages
REDIM errormessage(1024) AS STRING
Numoferrormessage = 0
OPEN "resource\data\errormessage.txt" FOR INPUT AS #1
DO
    Numoferrormessage = Numoferrormessage + 1
    LINE INPUT #1, errormessage$(Numoferrormessage)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE errormessage(Numoferrormessage) AS STRING

'load instructions
REDIM instruction(1024) AS STRING
Numofinstruction = 0
OPEN "resource\data\instruction.txt" FOR INPUT AS #1
DO
    Numofinstruction = Numofinstruction + 1
    LINE INPUT #1, instruction$(Numofinstruction)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE instruction(Numofinstruction) AS STRING

'load prime stat descriptions
DIM getprimestatdescription AS _BYTE
REDIM primestatdescription(PRIMESTATS_NUM) AS STRING
OPEN "resource\data\primestatdescription.txt" FOR INPUT AS #1
FOR getprimestatdescription = 1 TO PRIMESTATS_NUM
    LINE INPUT #1, primestatdescription$(getprimestatdescription)
NEXT getprimestatdescription
CLOSE #1

'load prime stat names
DIM getprimestatname AS _BYTE
REDIM primestatname(PRIMESTATS_NUM) AS STRING
OPEN "resource\data\primestatname.txt" FOR INPUT AS #1
FOR getprimestatname = 1 TO PRIMESTATS_NUM
    LINE INPUT #1, primestatname$(getprimestatname)
NEXT getprimestatname
CLOSE #1

'load race descriptions
DIM getracedescription AS _BYTE
REDIM racedescription(RACES_NUM) AS STRING
OPEN "resource\data\racedescription.txt" FOR INPUT AS #1
FOR getracedescription = 1 TO RACES_NUM
    LINE INPUT #1, racedescription$(getracedescription)
NEXT getracedescription
CLOSE #1

'load races
DIM getraces AS _BYTE
REDIM races(RACES_NUM) AS STRING
OPEN "resource\data\races.txt" FOR INPUT AS #1
FOR getraces = 1 TO RACES_NUM
    LINE INPUT #1, races$(getraces)
NEXT getraces
CLOSE #1

'load textures
DIM gettextures AS _UNSIGNED _BYTE
REDIM textures(255) AS STRING
OPEN "resource\data\textures.txt" FOR INPUT AS #1
FOR gettextures = 1 TO 255
    LINE INPUT #1, textures$(gettextures)
NEXT gettextures
CLOSE #1