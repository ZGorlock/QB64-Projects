''''''''''''''''''''''''''''INITIATION''''''''''''''''''''''''''''

_SCREENHIDE

'library declarations
'$INCLUDE:'include\lib.bi'

'declare sub/func
'$INCLUDE:'include\subfunc.bi'

'common library initiation
'$INCLUDE:'include\lib\common_init.bi'

'console commands
SCREEN _NEWIMAGE(SCRX, SCRY, SCRZ)
Programname = "Chronicles of Lorria"
_TITLE Programname
Version = 0.01

'type declarations
'$INCLUDE:'include\type.bi'

'custom library initiations
'$INCLUDE:'include\lib\animation_init.bi'
'$INCLUDE:'include\lib\button_init.bi'
'$INCLUDE:'include\lib\download_init.bi'
'$INCLUDE:'include\lib\frame_init.bi'
'$INCLUDE:'include\lib\input_init.bi'
'$INCLUDE:'include\lib\layer_init.bi'
'$INCLUDE:'include\lib\math_init.bi'
'$INCLUDE:'include\lib\sprite_init.bi'
'$INCLUDE:'include\lib\textbox_init.bi'
'$INCLUDE:'include\lib\time_init.bi'

'constant definitions
'$INCLUDE:'include\const.bi'

'SMcNeill's Color Constants
'$INCLUDE:'include\lib\Color32.BI'

'variable dimensioning
'$INCLUDE:'include\var.bi'

'array dimensioning
'$INCLUDE:'include\array.bi'

'shared structure size definitions
lpDevMode.dmSize = LEN(lpDevMode) '156 bytes
lpDevMode.dmDriverExtra = 64

'load settings
'$INCLUDE:'include\setting.bi'

'load database indexes
'$INCLUDE:'include\db\index.bi'

'load data files
'$INCLUDE:'include\data.bi'

'load cursor
'$INCLUDE:'include\cursor.bi'

'load gui
'$INCLUDE:'include\gui.bi'

'load fonts
'$INCLUDE:'include\font.bi'

'tcp/ip connections
'$INCLUDE:'include\tcpip.bi'

'preparation
RANDOMIZE TIMER
PLAY "MF"
SHELL _HIDE "exit"
_MOUSEHIDE
getrefreshrate = getdefaultfps
_CONTROLCHR OFF
GETINPUT
initTimestamp$ = TIMESTAMP
PRINT #4, initTimestamp$; " - "; TRIMnum$(Winos)
oldDisplaytimer = TIMER(.001)
Module$ = "Main Program"
CLS

_SCREENSHOW
_DISPLAY

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''MAIN PROGRAM''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'startup
IF titlelogo THEN _FREEIMAGE titlelogo

titlescreen:
DIM activemenubutton AS _BYTE
DIM drawtitlebutton AS _BYTE
DIM freetitleanimations AS INTEGER
DIM freetitlelayers AS INTEGER
DIM titlebuttony1 AS LONG
DIM titlebuttony2 AS LONG
Loading = TRUE
REDIM titlebuttons(16) AS STRING
OPEN "resource\data\titlebuttons.txt" FOR INPUT AS #1
DO
    Numoftitlebutton = Numoftitlebutton + 1
    LINE INPUT #1, titlebuttons$(Numoftitlebutton)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE titlebuttons(Numoftitlebutton) AS STRING


REDIM screenlayer(2) AS LONG
screenlayer(1) = NEWLAYER(0, 0, 0, LAYER_SHOW)
CALL texturizebg(1, 640, 480, LAYER(screenlayer(1)))
screenlayer(2) = NEWLAYER(0, 0, 0, LAYER_SHOW)
CALL texturize(120, 300, 300, LAYER(screenlayer(2)), (SCRX - 540) / 2, 20, ((SCRX - 540) / 2) + 540, 235)
_DEST LAYER(screenlayer(2))
COLOR ctorgb(0)
_PRINTMODE _KEEPBACKGROUND
_FONT fonts(12)
_PRINTSTRING ((_WIDTH(source) - _PRINTWIDTH("CHRONICLES")) / 2, 37), "CHRONICLES"
_PRINTSTRING ((_WIDTH(source) - _PRINTWIDTH("LORRIA")) / 2, 37 + _FONTHEIGHT(fonts(12)) + 20 + _FONTHEIGHT(fonts(11))), "LORRIA"
_FONT fonts(11)
_PRINTSTRING ((_WIDTH(source) - _PRINTWIDTH("OF")) / 2, 37 + _FONTHEIGHT(fonts(12)) + 10), "OF"
_FONT 16
_DEST 0
COLOR ctorgb(Textcolor)
_FONT fonts(FONT_DEFAULT)
FRAME TRIMnum$((SCRX - 540) / 2) + " 20 C2 R540 C1 D215 C4 L540 C3", FRAME_DOUBLE, LAYER(screenlayer(2))


REDIM animationsequence(1) AS INTEGER
animationsequence(1) = NEWANIMATION(0, -235, 640, 0, 3, "", ANIMATION_BASIC, ANIMATION_AUTOUPDATE_OFF, ANIMATION_AUTOTERMINATE_OFF)
STARTANIMATION animationsequence(1)
Loading = FALSE

DO
    _LIMIT setting.lps
    UPDATEANIMATION animationsequence(1)
    IF updatescreen THEN
        GOSUB resetscreen
        LAYERPUT 0, ANIMATIONY(animationsequence(1)), 0, screenlayer(2)
        PRINTLAYER screenlayer(2)
        _FONT fonts(8)
        FOR drawtitlebutton = Numoftitlebutton TO 1 STEP -1
            titlebuttony1 = SCRY - 30 - (30 * (Numoftitlebutton - drawtitlebutton))
            titlebuttony2 = titlebuttony1 + 25
            IF activebutton = drawtitlebutton THEN
                _PUTIMAGE (((SCRX - 200) / 2), titlebuttony1)-(((SCRX - 200) / 2) + 200, titlebuttony2), GUI_box_special
            ELSE
                _PUTIMAGE (((SCRX - 200) / 2), titlebuttony1)-(((SCRX - 200) / 2) + 200, titlebuttony2), GUI_box
            END IF
            _PRINTSTRING (((SCRX - 200) / 2) + (((200 - _PRINTWIDTH(titlebuttons$(drawtitlebutton))) / 2)), (titlebuttony1 + ((titlebuttony2 - titlebuttony1 - _FONTHEIGHT) / 2))), titlebuttons$(drawtitlebutton)
        NEXT drawtitlebutton
        CALL versionstamp(4)
        GOSUB cursor
        _DISPLAY
    END IF
    GETINPUT
    IF ESC THEN GOSUB cleanup
    IF MInput.lclick = TRUE AND Isfg THEN
        IF activemenubutton THEN
            FOR freetitleanimations = 1 TO 1
                ANIMATIONFREE animationsequence(freetitleanimations)
            NEXT freetitleanimations
            FOR freetitlelayers = 1 TO 2
                LAYERFREE screenlayer(freetitlelayers)
            NEXT freetitlelayers
            REDIM animationsequence(0) AS INTEGER
            REDIM screenlayer(0) AS LONG
            REDIM titlebuttons(0) AS STRING
        END IF
        SELECT CASE activemenubutton
            CASE 1
                GOSUB newgame
                EXIT DO
            CASE 2
                GOSUB loadgame
                EXIT DO
            CASE 3
                GOSUB settings
                GOTO titlescreen
            CASE 4
                GOSUB help
                GOTO titlescreen
            CASE 5
                GOSUB credits
                GOTO titlescreen
            CASE 6
                GOSUB cleanup
        END SELECT
    END IF
LOOP
DO
    _LIMIT setting.lps

    IF updatescreen THEN
        _DISPLAY
        GOSUB resetscreen
        PRINT "gameplay"
        GOSUB cursor
        _DISPLAY
        _AUTODISPLAY
    END IF
    GETINPUT
    IF ESC THEN GOTO titlescreen
LOOP

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'''''''''''''''''''''''''''''GOSUBS'''''''''''''''''''''''''''''
'
'$INCLUDE:'include\gosub\checkhotkeys.bi'
'$INCLUDE:'include\gosub\cleanup.bi'
'$INCLUDE:'include\gosub\credits.bi'
'$INCLUDE:'include\gosub\cursor.bi'
'$INCLUDE:'include\gosub\emptynewgamearrays.bi'
'$INCLUDE:'include\gosub\help.bi'
'$INCLUDE:'include\gosub\loadgame.bi'
'$INCLUDE:'include\gosub\newgame.bi'
'$INCLUDE:'include\gosub\refreshrandom.bi'
'$INCLUDE:'include\gosub\resetscreen.bi'
'$INCLUDE:'include\gosub\settings.bi'
'$INCLUDE:'include\gosub\sierr.bi'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''ERRORHANDLER''''''''''''''''''''''''''
'
'$INCLUDE:'include\gosub\errorhandler.bi'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''''SUBS''''''''''''''''''''''''''''''
'
'$INCLUDE:'include\sub\getcursor.bi'
'$INCLUDE:'include\sub\getminprimebasestats.bi'
'$INCLUDE:'include\sub\hexagon.bi'
'$INCLUDE:'include\sub\resetsettings.bi'
'$INCLUDE:'include\sub\saveprofile.bi'
'$INCLUDE:'include\sub\sort_insertion_str.bi'
'$INCLUDE:'include\sub\texturize.bi'
'$INCLUDE:'include\sub\texturizebg.bi'
'$INCLUDE:'include\sub\updatesettings.bi'
'$INCLUDE:'include\sub\validfps.bi'
'$INCLUDE:'include\sub\versionstamp.bi'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''FUNCTION''''''''''''''''''''''''''''
'
'$INCLUDE:'include\func\arrayloc_int.bi'
'$INCLUDE:'include\func\closestelement.bi'
'$INCLUDE:'include\func\dbindex.bi'
'$INCLUDE:'include\func\getdefaultfps.bi'
'$INCLUDE:'include\func\minprimebasestat.bi'
'$INCLUDE:'include\func\monsterzoom.bi'
'$INCLUDE:'include\func\newgamemenubuttons.bi'
'$INCLUDE:'include\func\primestathextoloc.bi'
'$INCLUDE:'include\func\raceloc.bi'
'$INCLUDE:'include\func\summinprimebasestats.bi'
'$INCLUDE:'include\func\sumprimebasestats.bi'
'$INCLUDE:'include\func\updatescreen.bi'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''LIBRARIES'''''''''''''''''''''''''''
'
'QB64 Animation Library by Gorlock
'$INCLUDE:'include\lib\animation.bi'
'
'QB64 Button Library by Gorlock
'$INCLUDE:'include\lib\button.bi'
'
'QB64 Common Library by Gorlock
'$INCLUDE:'include\lib\common.bi'
'
'QB64 Download Library by Gorlock
'$INCLUDE:'include\lib\download.bi'
'
'QB64 Frame Library by Gorlock
'$INCLUDE:'include\lib\frame.bi'
'
'QB64 Input Library by Gorlock
'$INCLUDE:'include\lib\input.bi'
'
'QB64 Layer Library by Gorlock
'$INCLUDE:'include\lib\layer.bi'
'
'Math Evaluator Library by SMcNeill
'$INCLUDE:'include\lib\math.bi'
'
'QB64 Sprite Library by Terry Ritchie
'$INCLUDE:'include\lib\sprite.bi'
'
'QB64 Textbox Library by Gorlock
'$INCLUDE:'include\lib\textbox.bi'
'
'QB64 Time Library by Gorlock
'$INCLUDE:'include\lib\time.bi'
'
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''