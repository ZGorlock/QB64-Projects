'shared variable dimensioning
DIM SHARED Hovering AS _BIT
DIM SHARED Loading AS _BIT
DIM SHARED Newgamemenulast AS _BIT '                                   newgamemenu
DIM SHARED Newgamemenuoldclick AS _BIT '                               newgamemenu
DIM SHARED Newgamemenunext AS _BIT '                                   newgamemenu
DIM SHARED Updatecursor AS _BIT
DIM SHARED Numoftitlebutton AS _BYTE
DIM SHARED Framespeed AS _UNSIGNED INTEGER
DIM SHARED Numofcursor AS _UNSIGNED INTEGER
DIM SHARED Numoferrormessage AS _UNSIGNED INTEGER
DIM SHARED Numofinstruction AS _UNSIGNED INTEGER
DIM SHARED Refreshrate AS LONG
DIM SHARED Tcpip AS LONG
DIM SHARED Displaytimer AS _FLOAT '                                    updatescreen
DIM SHARED oldDisplaytimer AS _FLOAT '                                 updatescreen
DIM SHARED initTimstamp AS STRING
DIM SHARED Module AS STRING
DIM SHARED lpDevMode AS DEVMODE
DIM SHARED setting AS metrics
DIM SHARED profile AS character

'variable dimensioning
DIM saveclick AS _BIT
DIM errortext AS _UNSIGNED _BYTE
DIM instructiontext AS _UNSIGNED _BYTE
DIM newtext AS _UNSIGNED _BYTE
DIM errorflag AS INTEGER
DIM savemousex AS SINGLE
DIM savemousey AS SINGLE

'variable initiations
Module$ = "Initiation"
Tcpip = 0
Frameloc$ = "resource\image\gui\frame"
Buttonloc$ = "resource\image\button"