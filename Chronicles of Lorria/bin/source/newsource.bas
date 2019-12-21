''''''''''''''''''''''''''''INITIATION''''''''''''''''''''''''''''

_SCREENHIDE

'single instance checking
ON ERROR GOTO sierr
OPEN "temp\si.tmp" FOR OUTPUT AS #3
LOCK #3
sierrpass:
ON ERROR GOTO 0

'console commands
SCREEN _NEWIMAGE(640, 480, 32)
_TITLE "Chronicles of Lorria"

'metacommands

'library declarations
DECLARE DYNAMIC LIBRARY "kernel32"
    FUNCTION GetVersionExA& (BYVAL lpVersionInfo AS _UNSIGNED _OFFSET)
    FUNCTION GetLastError~& ()
END DECLARE
DECLARE DYNAMIC LIBRARY "user32"
    FUNCTION DefWindowProcA& (BYVAL hwnd AS LONG, BYVAL wMsg AS LONG, BYVAL wParam AS LONG, BYVAL lParam AS LONG)
    FUNCTION EnumDisplaySettingsA& (BYVAL lpszDeviceName AS _UNSIGNED _OFFSET, BYVAL iModeNum AS _UNSIGNED LONG, BYVAL lpDevMode AS _UNSIGNED _OFFSET)
    FUNCTION GetCursorPos (BYVAL lpPoint AS _OFFSET)
    FUNCTION GetDesktopWindow%& ()
    FUNCTION GetForegroundWindow%& ()
    FUNCTION GetKeyState% (BYVAL nVirtKey AS LONG)
    FUNCTION GetSystemMetrics (BYVAL nIndex AS _UNSIGNED LONG)
    FUNCTION OpenInputDesktop%& (BYVAL dwFlags AS _OFFSET, BYVAL fInherit AS _OFFSET, BYVAL dwDesiredAccess AS _OFFSET)
    FUNCTION SendMessageA& (BYVAL hwnd AS LONG, BYVAL wMsg AS LONG, BYVAL wParam AS LONG, BYVAL lParam AS LONG)
    FUNCTION SetThreadDesktop%& (BYVAL hDesktop AS _OFFSET)
    FUNCTION SystemParametersInfoW& (BYVAL uiAction AS _UNSIGNED LONG, BYVAL uiParam AS _UNSIGNED LONG, BYVAL pvParam AS _OFFSET, BYVAL fWinlni AS _UNSIGNED LONG)
END DECLARE
DECLARE LIBRARY
    FUNCTION GetAsyncKeyState (BYVAL vkey AS _UNSIGNED LONG)
END DECLARE
DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName AS STRING)
END DECLARE

'sub declarations
DECLARE SUB cleartextbox (text() AS STRING, stream AS _UNSIGNED _BYTE)
DECLARE SUB errorhandler (errorcode AS INTEGER)
DECLARE SUB getinput ()
DECLARE SUB getminprimebasestats (race AS STRING, primestat() AS _BYTE)
DECLARE SUB HEXAGON (x AS SINGLE, y AS SINGLE, s AS LONG, c AS LONG)
DECLARE SUB keyboard (x AS SINGLE, y AS SINGLE, keybd() AS _UNSIGNED INTEGER)
DECLARE SUB MAPRECT (source AS LONG, sourceleft AS LONG, sourcetop AS LONG, sourceright AS LONG, sourcebottom AS LONG, dest AS LONG, destleft AS LONG, desttop AS LONG, destright AS LONG, destbottom AS LONG)
DECLARE SUB printtitle ()
DECLARE SUB resetfile (filename AS STRING)
DECLARE SUB resetkeyboard ()
DECLARE SUB resetscreenlayer (layers AS _UNSIGNED _BYTE, savelayers AS _UNSIGNED _BYTE)
DECLARE SUB resetsettings ()
DECLARE SUB saveprofile ()
DECLARE SUB sort_insertion_str (array() AS STRING)
'DECLARE
DECLARE SUB texturize (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG, destleft AS LONG, desttop AS LONG, destright AS LONG, destbottom AS LONG)
DECLARE SUB texturizebg (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG)
DECLARE SUB updatesettings ()
DECLARE SUB validfps (fpsoption() AS LONG)
DECLARE SUB versionstamp (sector AS _BYTE)

'function declarations
DECLARE FUNCTION addtotextbox% (text() AS STRING, stream AS _UNSIGNED _BYTE, add AS STRING, size AS _UNSIGNED INTEGER)
DECLARE FUNCTION arrayloc_int& (array() AS INTEGER, reference AS INTEGER)
DECLARE FUNCTION chance` (probability AS SINGLE)
DECLARE FUNCTION closestelement& (reference AS LONG, array() AS LONG)
DECLARE FUNCTION ctorgb& (c AS _BYTE)
DECLARE FUNCTION dbindex& (id AS _UNSIGNED LONG, index() AS _UNSIGNED LONG, db AS _BYTE)
DECLARE FUNCTION degtorad! (d AS SINGLE)
DECLARE FUNCTION dice& (sides AS LONG)
DECLARE FUNCTION distance## (x1 AS LONG, y1 AS LONG, x2 AS LONG, y2 AS LONG)
DECLARE FUNCTION filetitle$ (filename AS STRING)
DECLARE FUNCTION filetype$ (filename AS STRING)
DECLARE FUNCTION getdefaultfps%
DECLARE FUNCTION isonbox` (x AS LONG, y AS LONG, x1 AS LONG, y1 AS LONG, x2 AS LONG, y2 AS LONG)
DECLARE FUNCTION maxchars~% (width AS _UNSIGNED INTEGER)
DECLARE FUNCTION midpoint## (p1 AS LONG, p2 AS LONG)
DECLARE FUNCTION minprimebasestat%% (race AS STRING, stat AS _UNSIGNED _BYTE)
DECLARE FUNCTION monsterzoom! (agerange AS RANGE, age AS LONG)
DECLARE FUNCTION newgamemenubuttons%% (frame AS _BYTE, lastframe AS _BYTE, nextframe AS _BYTE, frames() AS STRING)
DECLARE FUNCTION pointoncirclex! (x AS SINGLE, y AS SINGLE, r AS LONG, a AS SINGLE)
DECLARE FUNCTION pointoncircley! (x AS SINGLE, y AS SINGLE, r AS LONG, a AS SINGLE)
DECLARE FUNCTION primestathextoloc~%% (hex AS _BYTE)
DECLARE FUNCTION raceloc%% (race AS STRING, races() AS STRING)
DECLARE FUNCTION radtodeg! (r AS SINGLE)
DECLARE FUNCTION rangepick& (set AS RANGE)
DECLARE FUNCTION remfilesuffix$ (filename AS STRING)
DECLARE FUNCTION summinprimebasestats~%% (race AS STRING)
DECLARE FUNCTION sumprimebasestats~%% (primestat() AS _BYTE, allocatestats AS _UNSIGNED _BYTE)
DECLARE FUNCTION TRIM$ (s AS STRING)
DECLARE FUNCTION trimdec## (num AS _FLOAT, dec AS _UNSIGNED _BYTE)
DECLARE FUNCTION TRIMnum$ (n AS SINGLE)
DECLARE FUNCTION updatescreen` ()

'Gorlock's QB64 Animation Library declarations
'DECLARE SUB ANIMATIONFREE (handle AS INTEGER)
'DECLARE SUB STARTANIMATION (handle AS INTEGER)
'DECLARE SUB STOPANIMATION (handle AS INTEGER)
'DECLARE SUB UPDATEANIMATION (handle AS INTEGER)
'DECLARE FUNCTION ANIMATIONSTATUS%% (handle AS INTEGER)
'DECLARE FUNCTION ANIMATIONTIME! (handle AS INTEGER)
'DECLARE FUNCTION ANIMATIONX! (handle AS INTEGER)
'DECLARE FUNCTION ANIMATIONY! (handle AS INTEGER)
'DECLARE FUNCTION NEWANIMATION% (x1 AS SINGLE, y1 AS SINGLE, x2 AS SINGLE, y2 AS SINGLE, time AS SINGLE, auto AS _BYTE)
'DECLARE FUNCTION VALIDANIMATION` (handle AS INTEGER)

'Gorlock's QB64 Button Library declarations
'DECLARE SUB BUTTONFREE (handle AS INTEGER)
'DECLARE SUB HIDEBUTTON (handle AS INTEGER)
'DECLARE SUB LOCKBUTTON (handle AS INTEGER)
'DECLARE SUB LOCKBUTTONTOGGLE (handle AS INTEGER)
'DECLARE SUB PRINTBUTTON (handle AS INTEGER)
'DECLARE SUB SHOWBUTTON (handle AS INTEGER)
'DECLARE SUB UNLOCKBUTTON (handle AS INTEGER)
'DECLARE SUB UPDATEBUTTON (handle AS INTEGER)
'DECLARE FUNCTION BUTTONCLICK%% (handle AS INTEGER)
'DECLARE FUNCTION BUTTONHIT%% (handle AS INTEGER)
'DECLARE FUNCTION BUTTONSTATUS%% (handle AS INTEGER)
'DECLARE FUNCTION BUTTONTIME! (handle AS INTEGER)
'DECLARE FUNCTION BUTTONVALUE` (handle AS INTEGER)
'DECLARE FUNCTION NEWBUTTON% (spritesheet AS STRING, left AS LONG, top AS LONG, right AS LONG, bottom AS LONG, leftactive AS LONG, topactive AS LONG, rightactive AS LONG, bottomactive AS LONG, value AS _BYTE, status AS _BYTE, show AS _BYTE, auto AS _BYTE)
'DECLARE FUNCTION VALIDBUTTON` (handle AS INTEGER)

'Ritchie's QB64 Sprite Library declarations
DECLARE SUB SPRITEANIMATESET (handle AS INTEGER, startcell AS INTEGER, endcell AS INTEGER)
DECLARE SUB SPRITEANIMATION (handle AS INTEGER, onoff AS INTEGER, behavior AS INTEGER)
DECLARE SUB SPRITEANIMATIONCELLSET (handleAS INTEGER, cell AS INTEGER)
DECLARE SUB SPRITECOLLIDETYPE (handle AS INTEGER, behavior AS INTEGER)
DECLARE SUB SPRITEDIRECTIONSET (handle AS INTEGER, direction AS SINGLE)
DECLARE SUB SPRITEFLIP (handle AS INTEGER, behavior AS INTEGER)
DECLARE SUB SPRITEFREE (handle AS INTEGER)
DECLARE SUB SPRITEHIDE (handle AS INTEGER)
DECLARE SUB SPRITEMOTION (handle AS INTEGER, behavior AS INTEGER)
DECLARE SUB SPRITENEXT (handle AS INTEGER)
DECLARE SUB SPRITEPREVIOUS (handle AS INTEGER)
DECLARE SUB SPRITEPUT (x AS SINGLE, y AS SINGLE, handle AS INTEGER)
'DECLARE SUB SPRITESTRETCH (x AS SINGLE, y AS SINGLE, x2 AS SINGLE, y2 AS SINGLE, handle AS INTEGER)
DECLARE SUB SPRITEREVERSEX (handle AS INTEGER)
DECLARE SUB SPRITEREVERSEY (handle AS INTEGER)
DECLARE SUB SPRITEROTATE (handle AS INTEGER, degrees AS SINGLE)
DECLARE SUB SPRITESCORESET (handle AS INTEGER, value AS SINGLE)
DECLARE SUB SPRITESET (handle AS INTEGER, cell AS INTEGER)
DECLARE SUB SPRITESHOW (handle AS INTEGER)
DECLARE SUB SPRITESPEEDSET (handle AS INTEGER, speed AS SINGLE)
DECLARE SUB SPRITESPINSET (handle AS INTEGER, spin AS SINGLE)
DECLARE SUB SPRITESTAMP (x AS INTEGER, y AS INTEGER, handle AS INTEGER)
DECLARE SUB SPRITETRAVEL (handle AS INTEGER, direction AS SINGLE, speed AS SINGLE)
DECLARE SUB SPRITETRAVEL (handle AS INTEGER, direction AS SINGLE, speed AS SINGLE)
DECLARE SUB SPRITEZOOM (handle AS INTEGER, zoom AS INTEGER)
DECLARE FUNCTION SPRITECELLS (handle AS INTEGER)
DECLARE FUNCTION SPRITEANGLE (handle AS INTEGER, handle2 AS INTEGER)
DECLARE FUNCTION SPRITEANIMATIONCELL (handle AS INTEGER)
DECLARE FUNCTION SPRITEAX (handle AS INTEGER)
DECLARE FUNCTION SPRITEAY (handle AS INTEGER)
DECLARE FUNCTION SPRITECOLLIDE (handle AS INTEGER, handle2 AS INTEGER)
DECLARE FUNCTION SPRITECOLLIDEWITH (handle AS INTEGER)
DECLARE FUNCTION SPRITECOPY (handle AS INTEGER)
DECLARE FUNCTION SPRITECURRENTHEIGHT (handle AS INTEGER)
DECLARE FUNCTION SPRITECURRENTWIDTH (handle AS INTEGER)
DECLARE FUNCTION SPRITEDIRECTION (handle AS INTEGER)
DECLARE FUNCTION SPRITEFILEEXISTS (filename AS STRING)
DECLARE FUNCTION SPRITEMOUSE (handle AS INTEGER)
DECLARE FUNCTION SPRITEMOUSEAX (handle AS INTEGER)
DECLARE FUNCTION SPRITEMOUSEAY (handle AS INTEGER)
DECLARE FUNCTION SPRITEMOUSEX (handle AS INTEGER)
DECLARE FUNCTION SPRITEMOUSEY (handle AS INTEGER)
DECLARE FUNCTION SPRITENEW (sheet AS INTEGER, cell AS INTEGER, behavior AS INTEGER)
DECLARE FUNCTION SPRITEROTATION (handle AS INTEGER)
DECLARE FUNCTION SPRITESCORE (handle AS INTEGER)
DECLARE FUNCTION SPRITESHEETLOAD (filename AS STRING, spritewidth AS INTEGER, spriteheight AS INTEGER, transparent AS LONG)
DECLARE FUNCTION SPRITESHOWING (handle AS INTEGER)
DECLARE FUNCTION SPRITEX (handle AS INTEGER)
DECLARE FUNCTION SPRITEX1 (handle AS INTEGER)
DECLARE FUNCTION SPRITEX2 (handle AS INTEGER)
DECLARE FUNCTION SPRITEY (handle AS INTEGER)
DECLARE FUNCTION SPRITEY1 (handle AS INTEGER)
DECLARE FUNCTION SPRITEY2 (handle AS INTEGER)
DECLARE FUNCTION SPRITEZOOMLEVEL (handle AS INTEGER)

'primary windows type declarations
TYPE LPPOINT
    x AS _UNSIGNED LONG
    y AS _UNSIGNED LONG
END TYPE
TYPE POINTL
    x AS LONG
    y AS LONG
END TYPE
TYPE RECT
    left AS LONG
    top AS LONG
    right AS LONG
    bottom AS LONG
END TYPE

'secondary windows type declarations
TYPE DEVMODE
    dmDeviceName AS STRING * 32
    dmSpecVersion AS _UNSIGNED INTEGER
    dmDriverVersion AS _UNSIGNED INTEGER
    dmSize AS _UNSIGNED INTEGER
    dmDriverExtra AS _UNSIGNED INTEGER
    dmFields AS _UNSIGNED LONG
    dmPosition AS POINTL
    dmDisplayOrientation AS _UNSIGNED LONG
    dmDisplayFixedOutput AS _UNSIGNED LONG
    dmColor AS INTEGER
    dmDuples AS INTEGER
    dmYResoluction AS INTEGER
    dmTTOption AS INTEGER
    dmCollate AS INTEGER
    dmFormName AS STRING * 32
    dmLogPixels AS _UNSIGNED INTEGER
    dmBitsPerPixel AS _UNSIGNED LONG
    dmPelsWidth AS _UNSIGNED LONG
    dmPelsHeight AS _UNSIGNED LONG
    dmDisplayFlags AS _UNSIGNED LONG
    dmDisplayFrequency AS _UNSIGNED LONG
    dmICMMethod AS _UNSIGNED LONG
    dmICMIntent AS _UNSIGNED LONG
    dmMediaType AS _UNSIGNED LONG
    dmDitherType AS _UNSIGNED LONG
    dmReserved1 AS _UNSIGNED LONG
    dmReserved2 AS _UNSIGNED LONG
    dmPlanningWidth AS _UNSIGNED LONG
    dmPlanningHeight AS _UNSIGNED LONG
END TYPE
TYPE OSVERSIONINFOEX
    dwOSVersionInfoSize AS _UNSIGNED LONG
    dwMajorVersion AS _UNSIGNED LONG
    dwMinorVersion AS _UNSIGNED LONG
    dwBuildNumber AS _UNSIGNED LONG
    dwPlatformId AS _UNSIGNED LONG
    szCSDVersion AS STRING * 128
    wServicePackMajor AS _UNSIGNED INTEGER
    wServicePackMinor AS _UNSIGNED INTEGER
    wSuiteMask AS _UNSIGNED INTEGER
    wProductType AS _UNSIGNED _BYTE
    wReserved AS _UNSIGNED _BYTE
END TYPE

'custom primary type declarations
TYPE RANGE
    min AS LONG
    max AS LONG
END TYPE

'custom type declarations
TYPE metrics
    sound AS _BYTE
    fx AS _BYTE
    lps AS _UNSIGNED INTEGER
    fps AS _UNSIGNED INTEGER
    ssloc AS STRING * 128
    cursor AS _BYTE
    hidecursor AS _BYTE
    races AS STRING * 16
END TYPE
TYPE outfit
    helm AS LONG
    body AS LONG
    leg AS LONG
    boot AS LONG
    glove AS LONG
    shield AS LONG
    weapon AS LONG
    belt AS LONG
    shoulder AS LONG
    mantle AS LONG
    pendant AS LONG
    lring AS LONG
    rring AS LONG
    earring AS LONG
    bracelet AS LONG
    other AS LONG
    tatoo AS LONG
END TYPE
TYPE character
    file AS STRING * 128
    name AS STRING * 32
    race AS STRING * 16
    gender AS STRING * 1
    class AS STRING * 16
    str AS _BYTE
    dex AS _BYTE
    int AS _BYTE
    wis AS _BYTE
    con AS _BYTE
    chr AS _BYTE
    alignment AS STRING * 32
    faction AS STRING * 32
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
TYPE monsterinstance
    monsternum AS LONG
    lv AS _UNSIGNED _BYTE
    alignment AS _UNSIGNED _BYTE
    type AS STRING * 16
    variation AS STRING * 40
    status AS STRING * 8
    locx AS LONG
    locy AS LONG
    memory AS _BYTE
    age AS LONG
    zoom AS SINGLE
    maxhealth AS LONG
    maxmana AS LONG
    maxstamina AS LONG
    health AS LONG
    mana AS LONG
    stamina AS LONG
    attack AS LONG
    defense AS LONG
    speed AS LONG
    intelligence AS _BYTE
    equipment AS outfit
    exp AS LONG
    gold AS LONG
    loot AS STRING * 4096 'loot(512, 2) AS _UNSIGNED LONG
    traindif AS _UNSIGNED _BYTE
    psionics AS _UNSIGNED _BYTE
END TYPE

'Gorlock's QB64 Animation Library type declarations
'TYPE animation
'    inuse AS _BYTE
'    status AS _BYTE
'    x1 AS SINGLE
'    y1 AS SINGLE
'    x2 AS SINGLE
'    y2 AS SINGLE
'    speed AS SINGLE
'    slope AS SINGLE
'    x AS LONG
'    y AS LONG
'    time AS SINGLE
'    timer AS LONG
'    oldTIMER AS SINGLE
'END TYPE

'Gorlock's QB64 Button Library type declarations
'TYPE buttonimage
'    true AS INTEGER
'    false AS INTEGER
'END TYPE
'TYPE button
'    inuse AS _BYTE
'    show AS _BYTE
'    value AS _BYTE
'    status AS _BYTE
'    click AS _BYTE
'    hit AS _BYTE
'    spritesheet AS INTEGER
'    width AS LONG
'    height AS LONG
'    buffer AS INTEGER
'    stand AS buttonimage
'    hover AS buttonimage
'    active AS buttonimage
'    locked AS buttonimage
'    area AS RECT
'    activearea AS RECT
'    time AS SINGLE
'    timer AS LONG
'    oldTIMER AS SINGLE
'END TYPE

'Ritchie's QB64 Sprite Library type declarations
TYPE SPRLIB_SHEET
    inuse AS INTEGER '         sheet is in use              (true / false)
    sheetimage AS DOUBLE '     image handle of sheet
    sheetwidth AS INTEGER '    width of sheet
    sheetheight AS INTEGER '   height of sheet
    spritewidth AS INTEGER '   width of each sprite
    spriteheight AS INTEGER '  height of each sprite
    transparent AS DOUBLE '    transparent color on sheet   (negative = none, 0 and greater = color)
    columns AS INTEGER '       number of sprite columns
END TYPE
TYPE SPRLIB_SPRITE
    inuse AS INTEGER '         sprite is in use             (true / false)
    sheet AS INTEGER '         what sheet is sprite on
    onscreen AS INTEGER '      sprite showing on screen     (true / false)
    visible AS INTEGER '       sprite hidden/showing        (true / false)
    currentwidth AS INTEGER '  current width of sprite      (width after zoom/rotate)
    currentheight AS INTEGER ' current height of sprite     (height after zoom/rotate)
    restore AS INTEGER '       sprite restores background   (true / false)
    image AS DOUBLE '          current image on screen      (use for pixel accurate detection)
    background AS DOUBLE '     sprite background image
    currentcell AS INTEGER '   current animation cell       (1 to cells)
    flip AS INTEGER '          flip vertical/horizonatal    (0 = none, 1 = horizontal, 2 = vertical, 3 = both)
    animation AS INTEGER '     automatic sprite animation   (true / false)
    animtype AS INTEGER '      automatic animation type     (0 = acsending loop, 1 = descending loop, 2 = forward/backward loop
    animdir AS INTEGER '       forward/backward loop dir    (1 = forward, -1 = backward)
    animstart AS INTEGER '     animation sequence start     (=> 1 to <= animend)
    animend AS INTEGER '       animation sequence end       (=> animstart to <= cells)
    transparent AS DOUBLE '    transparent color            (-1 = none, 0 and higher = color)
    zoom AS INTEGER '          zoom level in percentage     (1 to x%)
    rotation AS SINGLE '       rotation in degrees          (0 to 359.9999 degrees)
    motion AS INTEGER '        sprite auto motion           (true / false)
    speed AS SINGLE '          sprite auto motion speed     (any numeric value)
    direction AS SINGLE '      sprite auto motion angle     (0 to 359.9999 degrees)
    xdir AS SINGLE '           x vector for automotion
    ydir AS SINGLE '           y vector for automotion
    spindir AS SINGLE '        spin direction for automotion
    actualx AS SINGLE '        actual x location
    actualy AS SINGLE '        actual y location
    currentx AS INTEGER '      current x location on screen (INT(actualx))
    currenty AS INTEGER '      current y location on screen (INT(actualy))
    backx AS INTEGER '         x location of background image
    backy AS INTEGER '         y location of background image
    screenx1 AS INTEGER '      upper left x of sprite
    screeny1 AS INTEGER '      upper left y of sprite
    screenx2 AS INTEGER '      lower right x of sprite
    screeny2 AS INTEGER '      lower right y of sprite
    layer AS INTEGER '         layer the sprite resides on (1 to x, lower sprite layers drawn first)
    detect AS INTEGER '        collision detection          (true / false)
    detecttype AS INTEGER '    the type of detection use    (0 = do not detect collisions, 1 = box, 2 = pixel accurate)
    collx1 AS INTEGER '        upper left x collision area  (pixel accurate = x location of hit, box = upper left x)
    colly1 AS INTEGER '        upper left y collision area  (pixel accurate = y location of hit, box = upper left x)
    collx2 AS INTEGER '        lower right x collision area
    colly2 AS INTEGER '        lower right y collision area
    collsprite AS INTEGER '    sprite number colliding with (0 = none, 1 to x = sprite colliding with)
    pointer AS INTEGER '       mouse pointer interaction    (0 none, 1 left button, 2 right button, 3 hovering)
    mouseax AS INTEGER '       actual x location of pointer (x = 0 to screen width)
    mouseay AS INTEGER '       actual y location of pointer (y = 0 to screen height)
    mousecx AS INTEGER '       x location pointer on sprite (x = 0 to sprite width)
    mousecy AS INTEGER '       y location pointer on sprite (y = 0 to sprite height)
    score AS SINGLE '          sprite score value for games
END TYPE

'boolean constant definitions
CONST FALSE = 0
CONST TRUE = NOT FALSE

'contant definitions
CONST CURSOR_NUM = 2
CONST DB_ITEM_SIZE = 0
CONST DB_MAP_SIZE = 0
CONST DB_MONSTER_SIZE = 16384
CONST DB_NPC_SIZE = 0
CONST DB_QUEST_SIZE = 0
CONST DB_SPELL_SIZE = 0
CONST FONT_DEFAULT = 2
CONST FONT_NUM = 13
CONST LONG_MAX = 2147483647
CONST NAME_MAXLEN = 32
CONST NAME_MINLEN = 4
CONST PRIMESTATS_ALLOCATABLE = 36
CONST PRIMESTATS_MAX = 18
CONST PRIMESTATS_NUM = 6
CONST RACES_NUM = 3
CONST REFRESHRATE_DEFAULT = 60
CONST SCRX = 640
CONST SCRY = 480
CONST SPI_GETWORKAREA = &H30
CONST SPRITESHEET_CHARACTER_LENGTH = 56
CONST SPRITESHEET_ITEM_LENGTH = 0
CONST SPRITESHEET_MAP_LENGTH = 0
CONST SPRITESHEET_MONSTER_LENGTH = 40
CONST SPRITESHEET_NPC_LENGTH = 0
CONST SPRITESHEET_QUEST_LENGTH = 0
CONST SPRITESHEET_SPELL_LENGTH = 0
CONST VK_CAPITAL = &H14
CONST VK_F4 = &H73
CONST VK_NUMLOCK = &H90
CONST VK_SCROLL = &H91
CONST WM_SETHOTKEY = &H32
CONST WM_SHOWWINDOW = &H18

'Gorlock's QB64 Animation Library constant definitions
'CONST ANIMATION_AUTOUPDATE_OFF = FALSE
'CONST ANIMATION_AUTOUPDATE_ON = TRUE
'CONST ANIMATION_CREATED = 1
'CONST ANIMATION_FINISHED = 4
'CONST ANIMATION_PAUSED = 3
'CONST ANIMATION_STARTED = 2
'CONST ANIMATION_UNCREATED = FALSE

'Gorlock's QB64 Button Library constant definitions
'CONST BUTTON_ALLBUTTONS = TRUE
'CONST BUTTON_AUTOUPDATE_OFF = FALSE
'CONST BUTTON_AUTOUPDATE_ON = TRUE
'CONST BUTTON_ACTION = 4
'CONST BUTTON_CREATED = 1
'CONST BUTTON_HIDE = FALSE
'CONST BUTTON_HOVER = 3
'CONST BUTTON_LCLICK = 1
'CONST BUTTON_LMCLICK = 5
'CONST BUTTON_LOCKED = 5
'CONST BUTTON_LRCLICK = 4
'CONST BUTTON_LRMCLICK = 7
'CONST BUTTON_MCLICK = 3
'CONST BUTTON_NOCLICK = FALSE
'CONST BUTTON_OFF = 0
'CONST BUTTON_ON = -1
'CONST BUTTON_RCLICK = 2
'CONST BUTTON_RMCLICK = 6
'CONST BUTTON_SHOW = TRUE
'CONST BUTTON_STAND = 2
'CONST BUTTON_UNCREATED = FALSE

'Ritchie's QB64 Sprite Library constant definitions
CONST SPRITE_ALLSPRS = -1 '          check all sprites for collision
CONST SPRITE_ANIMATE = TRUE '        animate
CONST SPRITE_AUTOTRANSPARENCY = -2 ' automatically discover transparency
CONST SPRITE_BACKFORTHLOOP = 2 '     animate an oscilating loop
CONST SPRITE_BACKWARDLOOP = 1 '      animate a backward loop
CONST SPRITE_BOTH = 3 '              flip both horiz/vertical
CONST SPRITE_BOXDETECT = 1 '         use rectangular detection
CONST SPRITE_DONTMOVE = FALSE '      disable automotion
CONST SPRITE_DONTSAVE = FALSE '      don't save background image
CONST SPRITE_FORWARDLOOP = 0 '       animate a forward loop
CONST SPRITE_HORIZONTAL = 1 '        flip sprite horizontal
CONST SPRITE_MOUSEHOVER = 3 '        mouse hovering over sprite
CONST SPRITE_MOUSELEFT = 1 '         left button clicked on sprite
CONST SPRITE_MOUSERIGHT = 2 '        right button clicked on sprite
CONST SPRITE_MOVE = TRUE '           enable automotion
CONST SPRITE_NOANIMATE = FALSE '     no animation
CONST SPRITE_NODETECT = FALSE '      do not detect collisions
CONST SPRITE_NOMOUSE = FALSE '       no current mouse interaction
CONST SPRITE_NONE = FALSE '          no sprite flipping
CONST SPRITE_NOTRANSPARENCY = -1 '   sheet has no transparency
CONST SPRITE_NOVALUE = -32767 '      variables with no value assigned
CONST SPRITE_PIXELDETECT = 2 '       use pixel accurate detection
CONST SPRITE_SAVE = TRUE '           save background image
CONST SPRITE_VERTICAL = 2 '          flip sprite vertical

'shared variable dimensioning
DIM SHARED Hovering AS _BIT
DIM SHARED Isfg AS _BIT
DIM SHARED Keyboardinput AS _BIT
DIM SHARED Loading AS _BIT
DIM SHARED Escact AS _BYTE
DIM SHARED Numoftitlebutton AS _BYTE
DIM SHARED Textcolor AS _BYTE
DIM SHARED Winos AS _BYTE
DIM SHARED Framespeed AS _UNSIGNED INTEGER
DIM SHARED Numoferrormessage AS _UNSIGNED INTEGER
DIM SHARED Numofinstruction AS _UNSIGNED INTEGER
DIM SHARED Layer AS LONG
DIM SHARED Refreshrate AS LONG
DIM SHARED Tcpip AS LONG
DIM SHARED Pi AS _FLOAT
DIM SHARED Version AS _FLOAT
DIM SHARED Crlf AS STRING
DIM SHARED Q AS STRING
DIM SHARED lpDevMode AS DEVMODE
DIM SHARED osinfo AS OSVERSIONINFOEX
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

'getinput variable dimensioning
DIM SHARED Alt AS _BIT '           alt key, -1 = down
DIM SHARED Ams AS _BIT '           alt + _/- key
DIM SHARED Apk AS _BIT '           application key
DIM SHARED Aps AS _BIT '           alt + =/+ key
DIM SHARED Bsp AS _BIT '           backspace char, -1=down
DIM SHARED Click AS _BIT '         if a mouse button is being pressed click = -1
DIM SHARED Clk AS _BIT '           clear key
DIM SHARED Ctrl AS _BIT '          control key, -1 = down
DIM SHARED Dlk AS _BIT '           delete key, -1=down
DIM SHARED Edk AS _BIT '           end key, -1=down
DIM SHARED Esc AS _BIT '           -1 if esc is pressed, should lead to terminating functions
DIM SHARED Exk AS _BIT '           execute key
DIM SHARED Fs AS _BIT '            change fs if you use _FULLSCREEN or _FULLSCREEN _OFF, 0=off, -1=fullscreen
DIM SHARED Getinputinit AS _BIT '  initiation flag
DIM SHARED Help AS _BIT '          use this to send a user to a help menu, -1= F1 pressed
DIM SHARED Hlk AS _BIT '           help key
DIM SHARED Hme AS _BIT '           home key, -1=down
DIM SHARED Ins AS _BIT '           insert key, -1=down
DIM SHARED Isinput AS _BIT '       if there is input isinput = -1
DIM SHARED Nlk AS _BIT '           numlock key
DIM SHARED Ntk AS _BIT '           next track key
DIM SHARED oldClick AS _BIT '      the value of Click last loop
DIM SHARED Osc AS _BIT '           off screen click, a click or any mouse button, not necessarily on the program window
DIM SHARED Pak AS _BIT '           pause key
DIM SHARED Pdn AS _BIT '           page down key, -1=down
DIM SHARED Ppk AS _BIT '           play/pause media key
DIM SHARED Prk AS _BIT '           print key
DIM SHARED Psk AS _BIT '           print screen key
DIM SHARED Ptk AS _BIT '           previous track key
DIM SHARED Pup AS _BIT '           page up key, -1 = down
DIM SHARED Pw AS _BIT '            change pw if you show or hide the program window with _SCRENSHOW and _SCREENHIDE, 0=hidden, -1=shown
DIM SHARED Rtn AS _BIT '           enter char, -1= down
DIM SHARED Sbk AS _BIT '           start browser key
DIM SHARED Sft AS _BIT '           shift key, -1 = down
DIM SHARED Sle AS _BIT '           sleep key
DIM SHARED Slk AS _BIT '           scroll lock key
DIM SHARED Smk AS _BIT '           start mail key
DIM SHARED Spk AS _BIT '           stop media key
DIM SHARED Stk AS _BIT '           select key
DIM SHARED Tbc AS _BIT '           tab key, -1=down
DIM SHARED Vdk AS _BIT '           volume down key
DIM SHARED Vmk AS _BIT '           volume mute key
DIM SHARED Vuk AS _BIT '           volume up key
DIM SHARED Wnk AS _BIT '           windows key
DIM SHARED Zmk AS _BIT '           zoom key
DIM SHARED Act AS SINGLE '         TIMER of last activity
DIM SHARED Char AS SINGLE '        char, val=ASC(char)
DIM SHARED Day AS SINGLE '         day
DIM SHARED Hour AS SINGLE '        hour
DIM SHARED Keys AS SINGLE '        the number of keys() down at that moment >=0
DIM SHARED Minute AS SINGLE '      minute
DIM SHARED Month AS SINGLE '       month
DIM SHARED Num AS SINGLE '         number, val=ASC(number)
DIM SHARED Second AS SINGLE '      second
DIM SHARED T AS SINGLE '           TIMER
DIM SHARED Year AS SINGLE '        year
DIM SHARED Hwnd AS LONG '          program window handle, static
DIM SHARED Mouseswap AS LONG '     system metric
DIM SHARED Td AS DOUBLE '          TIMER(.01)
DIM SHARED Tf AS _FLOAT '          TIMER(.001)
DIM SHARED Dtwin AS _OFFSET '      desktop window handle, static
DIM SHARED K AS STRING '           CHR$() from INKEY$
DIM SHARED Programname AS STRING ' (same as your _TITLE()) MUST BE DEFINED AT THE START OF THE PROGRAM!
DIM SHARED Timestamp AS STRING '   %year%%month%%day%%hour%%minute%%second%

'keyboard shared variables
DIM SHARED Keyboardcaps AS _UNSIGNED _BIT
DIM SHARED Keyboardshift AS _UNSIGNED _BIT * 2
DIM SHARED Khit AS _UNSIGNED _BYTE
DIM SHARED Keyboardclick AS _UNSIGNED INTEGER

'newgamemenubutons shared variables
DIM SHARED Newgamemenulast AS _BIT
DIM SHARED Newgamemenuoldclick AS _BIT
DIM SHARED Newgamemenunext AS _BIT

'textbox shared variables
DIM SHARED Newprints AS INTEGER

'updatescreen shared variables
DIM SHARED Displaytimer AS _FLOAT
DIM SHARED oldDisplaytimer AS _FLOAT

'variable initiations
Pi = 4 * ATN(1)
Crlf = CHR$(13) + CHR$(10)
Q = CHR$(34)
Version = .01
Programname$ = "Chronicles of Lorria"
Getinputinit = 0
Tcpip = 0
Textcolor = 15

'array options
OPTION BASE 1

'shared array dimensioning
REDIM SHARED fonts(0) AS LONG
REDIM SHARED GUI_frame(0, 0, 0) AS LONG
REDIM SHARED screenlayer(0) AS LONG
REDIM SHARED index_item(0) AS _UNSIGNED LONG
REDIM SHARED index_map(0) AS _UNSIGNED LONG
REDIM SHARED index_monster(0) AS _UNSIGNED LONG
REDIM SHARED index_npc(0) AS _UNSIGNED LONG
REDIM SHARED index_quest(0) AS _UNSIGNED LONG
REDIM SHARED index_spell(0) AS _UNSIGNED LONG

'array dimensioning
REDIM primestat(0) AS _BYTE
REDIM monsters_sounds(0, 0) AS _BYTE
REDIM monsters_soundname(0, 0) AS _BYTE
REDIM monsters_sprites(0, 0) AS _BYTE
REDIM tempmonstersoundname(0) AS _BYTE
REDIM tempmonstersounds(0) AS _BYTE
REDIM tempmonstersprites(0) AS _BYTE
REDIM newgamepass(0) AS _UNSIGNED _BYTE
REDIM freedmonsterimage(0) AS INTEGER
REDIM monsters_image(0, 0, 0) AS INTEGER
REDIM racehave(0) AS _UNSIGNED INTEGER
REDIM keybd(0, 0, 0) AS _UNSIGNED INTEGER
REDIM monsters_sound(0, 0) AS LONG
REDIM tempmonsterspell(0) AS _UNSIGNED LONG
REDIM monsters_spell(0, 0) AS _UNSIGNED LONG
REDIM tempmonsterinteract(0, 0) AS _UNSIGNED LONG
REDIM tempmonsterloot(0) AS _UNSIGNED LONG
REDIM monsters_interact(0, 0, 0) AS _UNSIGNED LONG
REDIM monsters_loot(0, 0) AS _UNSIGNED LONG
REDIM tempmonsterarmour(0, 0) AS _UNSIGNED LONG
REDIM monsters_armour(0, 0, 0) AS _UNSIGNED LONG
REDIM tempmonsterlootchance(0) AS SINGLE
REDIM hexp(0, 0) AS SINGLE
REDIM monsters_lootchance(0, 0) AS SINGLE
REDIM setprimestatpoint(0, 0) AS SINGLE
REDIM tempmonsterarmourchance(0, 0) AS SINGLE
REDIM monsters_armourchance(0, 0, 0) AS SINGLE
REDIM errormessage(0) AS STRING
REDIM instruction(0) AS STRING
REDIM newgamemenuframe(0) AS STRING
REDIM primestatdescription(0) AS STRING
REDIM primestatname(0) AS STRING
REDIM racedescription(0) AS STRING
REDIM races(0) AS STRING
REDIM textures(0) AS STRING
REDIM titlebuttons(0) AS STRING
REDIM tempmonsterlootquantity(0) AS RANGE
REDIM monsters_lootquantity(0, 0) AS RANGE
REDIM monsters(0) AS monster

'getinput array dimensioning
REDIM SHARED Akey(4) AS _BIT '        directional keys, akey(1) = up, akey(2) = left, akey(3) = right, akey(4) = down
REDIM SHARED Alt(34) AS _BIT '        alt + letter charatcers
REDIM SHARED Ctrl(26) AS _BIT '       ctrl-X character, A-Z
REDIM SHARED Fkey(12) AS _BIT '       F1 through F12
REDIM SHARED Fkeya(12) AS _BIT '      F1 through F12 with alt held
REDIM SHARED Fkeyc(12) AS _BIT '      F1 through F12 with control held
REDIM SHARED Fkeys(12) AS _BIT '      F1 through F12 with shift held
REDIM SHARED Keys(256) AS _BIT '      -1=down, 0=not down, supports multiple keys, num of keys down can be obtained by the variable 'keys', http://msdn.microsoft.com/en-us/library/windows/desktop/dd375731(v=vs.85).aspx collected even when program is not foreground window
REDIM SHARED Numa(10) AS _BIT '       number with alt down
REDIM SHARED Numc(4) AS _BIT '        numpad with ctrl key down
REDIM SHARED Locks(3) AS INTEGER '    capslock, numlock, scrolllock (0=off, 1=on, -127=was off now held, -128=was on now held)
REDIM SHARED Mousedata(8) AS SINGLE ' mousedata(1) = mouse x position on program window, mousedata(2) = mouse y position on program window, mousedata(3) = mouse x position on screen, mousedata(4) = mouse y position on screen, mousedata(5) = left click, -1=clicked, mousedata(6) = right click, -1 = clicked, mousedata(7) = middle click, -1 = clicked, mousedata(8) = scroll wheel
REDIM SHARED Screendim(4) AS SINGLE ' screendim(1) = screen resolution x, screendim(2) = screen resolution y, screendim(3) = screen work area x, screendim(4) = screen work area y

'textbox array dimensioning
REDIM newtext(1024) AS STRING
REDIM text(16, 32767) AS STRING

'Gorlock's QB64 Animation Library array dimensioning
'REDIM animations(0) AS animation

'Gorlock's QB64 Button Library array dimensioning
'REDIM buttons(0) AS button

'Ritchie's QB64 Sprite Library array dimensioning
REDIM sprlib_sheet(1) AS SPRLIB_SHEET
REDIM sprlib_sprite(1) AS SPRLIB_SPRITE

'shared structure size definitions
lpDevMode.dmSize = LEN(lpDevMode) '156 bytes
lpDevMode.dmDriverExtra = 64
osinfo.dwOSVersionInfoSize = LEN(osinfo) '156 bytes

'get Windows OS version
Winos = -1
IF GetVersionExA(_OFFSET(osinfo)) THEN
    SELECT CASE osinfo.dwMajorVersion
        CASE 5
            SELECT CASE osinfo.dwMinorVersion
                CASE 0
                    Winos = 0 'Windows 2000
                CASE 1, 2
                    Winos = 1 'Windows XP
            END SELECT
        CASE 6
            SELECT CASE osinfo.dwMinorVersion
                CASE 0
                    Winos = 2 'Windows Vista / 2008
                CASE 1
                    Winos = 3 'Windows 7 / 2008 R2
                CASE 2
                    Winos = 4 'Windows 8
            END SELECT
    END SELECT
END IF

'load settings
IF _FILEEXISTS("data\settings.inf") THEN
    'OPEN "data\settings.inf" FOR BINARY AS #1
    'IF LOF(1) = LEN(setting) THEN
    'GET #1, , setting
    'ELSE
    'CALL resetsettings
    'END IF
    'CLOSE #1
    OPEN "data\settings.inf" FOR INPUT AS #1
    INPUT #1, setting.sound
    INPUT #1, setting.fx
    INPUT #1, setting.lps
    INPUT #1, setting.fps
    LINE INPUT #1, setting.ssloc
    INPUT #1, setting.cursor
    INPUT #1, setting.hidecursor
    LINE INPUT #1, setting.races
    CLOSE #1
ELSE
    CALL resetsettings
END IF
IF setting.fps = 0 THEN setting.fps = getdefaultfps

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

'load data files
DIM getkeyboard AS _BYTE
DIM getkeyboardcol AS _BYTE
DIM getkeyboardrow AS _BYTE
DIM getprimestatdescription AS _BYTE
DIM getprimestatname AS _BYTE
DIM getraces AS _BYTE
DIM getracedescription AS _BYTE
DIM ripkeyboard AS _BYTE
DIM gettextures AS _UNSIGNED _BYTE
DIM keyboardrow AS STRING
REDIM errormessage(1024) AS STRING
Numoferrormessage = 0
OPEN "resource\data\errormessage.txt" FOR INPUT AS #1
DO
    Numoferrormessage = Numoferrormessage + 1
    LINE INPUT #1, errormessage$(Numoferrormessage)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE errormessage(Numoferrormessage) AS STRING
REDIM instruction(1024) AS STRING
Numofinstruction = 0
OPEN "resource\data\instruction.txt" FOR INPUT AS #1
DO
    Numofinstruction = Numofinstruction + 1
    LINE INPUT #1, instruction$(Numofinstruction)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE instruction(Numofinstruction) AS STRING
REDIM keybd(2, 5, 14) AS _UNSIGNED INTEGER
OPEN "resource\data\keybd.txt" FOR INPUT AS #1
FOR getkeyboard = 1 TO 2
    FOR getkeyboardrow = 1 TO 5
        LINE INPUT #1, keyboardrow$
        FOR ripkeyboardkey = 1 TO 14
            keybd(getkeyboard, getkeyboardrow, ripkeyboardkey) = VAL(MID$(keyboardrow$, (ripkeyboardkey - 1) * 3 + 1, 3))
        NEXT ripkeyboardkey
NEXT getkeyboardrow, getkeyboard
CLOSE #1
REDIM primestatdescription(PRIMESTATS_NUM) AS STRING
OPEN "resource\data\primestatdescription.txt" FOR INPUT AS #1
FOR getprimestatdescription = 1 TO PRIMESTATS_NUM
    LINE INPUT #1, primestatdescription$(getprimestatdescription)
NEXT getprimestatdescription
CLOSE #1
REDIM primestatname(PRIMESTATS_NUM) AS STRING
OPEN "resource\data\primestatname.txt" FOR INPUT AS #1
FOR getprimestatname = 1 TO PRIMESTATS_NUM
    LINE INPUT #1, primestatname$(getprimestatname)
NEXT getprimestatname
CLOSE #1
REDIM racedescription(RACES_NUM) AS STRING
OPEN "resource\data\racedescription.txt" FOR INPUT AS #1
FOR getracedescription = 1 TO RACES_NUM
    LINE INPUT #1, racedescription$(getracedescription)
NEXT getracedescription
CLOSE #1
REDIM races(RACES_NUM) AS STRING
OPEN "resource\data\races.txt" FOR INPUT AS #1
FOR getraces = 1 TO RACES_NUM
    LINE INPUT #1, races$(getraces)
NEXT getraces
CLOSE #1
REDIM textures(255) AS STRING
OPEN "resource\data\textures.txt" FOR INPUT AS #1
FOR gettextures = 1 TO 255
    LINE INPUT #1, textures$(gettextures)
NEXT gettextures
CLOSE #1

'load cursor
DIM SHARED Cursoraction AS INTEGER
DIM SHARED Cursorhover AS INTEGER
DIM SHARED Cursorloading AS INTEGER
DIM SHARED Cursorsheet AS INTEGER
DIM SHARED Cursorstand AS INTEGER
GOSUB getcursor

'load gui
DIM SHARED GUI_box AS LONG
DIM SHARED GUI_box_trans AS LONG
DIM SHARED GUI_box_special AS LONG
DIM SHARED GUI_box_special_trans AS LONG
DIM SHARED GUI_box_special_large AS LONG
DIM SHARED GUI_box_special_large_trans AS LONG
REDIM SHARED GUI_frame(2, 8, 4) AS LONG
GUI_box = _LOADIMAGE("resource\image\gui\box.png")
GUI_box_trans = _LOADIMAGE("resource\image\gui\box_trans.png")
GUI_box_special = _LOADIMAGE("resource\image\gui\box_special.png")
GUI_box_special_trans = _LOADIMAGE("resource\image\gui\box_special_trans.png")
GUI_box_special_large = _LOADIMAGE("resource\image\gui\box_special_large.png")
GUI_box_special_large_trans = _LOADIMAGE("resource\image\gui\box_special_large_trans.png")
'GUI_frame(1, 1, 1) = _LOADIMAGE("resource\image\gui\frame\frame_bar.png")
'GUI_frame(1, 2, 1) = _LOADIMAGE("resource\image\gui\frame\frame_side_bottom.png")
'GUI_frame(1, 2, 2) = _LOADIMAGE("resource\image\gui\frame\frame_side_left.png")
'GUI_frame(1, 2, 3) = _LOADIMAGE("resource\image\gui\frame\frame_side_right.png")
'GUI_frame(1, 2, 4) = _LOADIMAGE("resource\image\gui\frame\frame_side_top.png")
'GUI_frame(1, 3, 1) = _LOADIMAGE("resource\image\gui\frame\frame_corner_1.png")
'GUI_frame(1, 3, 2) = _LOADIMAGE("resource\image\gui\frame\frame_corner_2.png")
'GUI_frame(1, 3, 3) = _LOADIMAGE("resource\image\gui\frame\frame_corner_3.png")
'GUI_frame(1, 3, 4) = _LOADIMAGE("resource\image\gui\frame\frame_corner_4.png")
'GUI_frame(1, 4, 1) = _LOADIMAGE("resource\image\gui\frame\frame_cross.png")
'GUI_frame(1, 5, 1) = _LOADIMAGE("resource\image\gui\frame\frame_t_bottom.png")
'GUI_frame(1, 5, 2) = _LOADIMAGE("resource\image\gui\frame\frame_t_left.png")
'GUI_frame(1, 5, 3) = _LOADIMAGE("resource\image\gui\frame\frame_t_right.png")
'GUI_frame(1, 5, 4) = _LOADIMAGE("resource\image\gui\frame\frame_t_top.png")
'GUI_frame(1, 6, 1) = _LOADIMAGE("resource\image\gui\frame\frame_cap_bottom.png")
'GUI_frame(1, 6, 2) = _LOADIMAGE("resource\image\gui\frame\frame_cap_left.png")
'GUI_frame(1, 6, 3) = _LOADIMAGE("resource\image\gui\frame\frame_cap_right.png")
'GUI_frame(1, 6, 4) = _LOADIMAGE("resource\image\gui\frame\frame_cap_top.png")
'GUI_frame(1, 7, 1) = _LOADIMAGE("resource\image\gui\frame\frame_box_large_bottom.png")
'GUI_frame(1, 7, 2) = _LOADIMAGE("resource\image\gui\frame\frame_box_large_left.png")
'GUI_frame(1, 7, 3) = _LOADIMAGE("resource\image\gui\frame\frame_box_large_right.png")
'GUI_frame(1, 7, 4) = _LOADIMAGE("resource\image\gui\frame\frame_box_large_top.png")
'GUI_frame(1, 8, 1) = _LOADIMAGE("resource\image\gui\frame\frame_box_small_bottom.png")
'GUI_frame(1, 8, 2) = _LOADIMAGE("resource\image\gui\frame\frame_box_small_left.png")
'GUI_frame(1, 8, 3) = _LOADIMAGE("resource\image\gui\frame\frame_box_small_right.png")
'GUI_frame(1, 8, 4) = _LOADIMAGE("resource\image\gui\frame\frame_box_small_top.png")
'GUI_frame(2, 1, 1) = _LOADIMAGE("resource\image\gui\frame\frame_bar_double.png")
'GUI_frame(2, 2, 1) = _LOADIMAGE("resource\image\gui\frame\frame_side_bottom_double.png")
'GUI_frame(2, 2, 2) = _LOADIMAGE("resource\image\gui\frame\frame_side_left_double.png")
'GUI_frame(2, 2, 3) = _LOADIMAGE("resource\image\gui\frame\frame_side_right_double.png")
'GUI_frame(2, 2, 4) = _LOADIMAGE("resource\image\gui\frame\frame_side_top_double.png")
'GUI_frame(2, 3, 1) = _LOADIMAGE("resource\image\gui\frame\frame_corner_1_double.png")
'GUI_frame(2, 3, 2) = _LOADIMAGE("resource\image\gui\frame\frame_corner_2_double.png")
'GUI_frame(2, 3, 3) = _LOADIMAGE("resource\image\gui\frame\frame_corner_3_double.png")
'GUI_frame(2, 3, 4) = _LOADIMAGE("resource\image\gui\frame\frame_corner_4_double.png")
'GUI_frame(2, 4, 1) = _LOADIMAGE("resource\image\gui\frame\frame_cross_double.png")
'GUI_frame(2, 5, 1) = _LOADIMAGE("resource\image\gui\frame\frame_t_bottom_double.png")
'GUI_frame(2, 5, 2) = _LOADIMAGE("resource\image\gui\frame\frame_t_left_double.png")
'GUI_frame(2, 5, 3) = _LOADIMAGE("resource\image\gui\frame\frame_t_right_double.png")
'GUI_frame(2, 5, 4) = _LOADIMAGE("resource\image\gui\frame\frame_t_top_double.png")
'GUI_frame(2, 6, 1) = _LOADIMAGE("resource\image\gui\frame\frame_cap_bottom_double.png")
'GUI_frame(2, 6, 2) = _LOADIMAGE("resource\image\gui\frame\frame_cap_left_double.png")
'GUI_frame(2, 6, 3) = _LOADIMAGE("resource\image\gui\frame\frame_cap_right_double.png")
'GUI_frame(2, 6, 4) = _LOADIMAGE("resource\image\gui\frame\frame_cap_top_double.png")

'load fonts
REDIM fonts(FONT_NUM) AS LONG
fonts(1) = _LOADFONT("resource\font\unispace.ttf", 8)
fonts(2) = _LOADFONT("resource\font\unispace.ttf", 10)
fonts(3) = _LOADFONT("resource\font\unispace.ttf", 12)
fonts(4) = _LOADFONT("resource\font\unispace.ttf", 16)
fonts(5) = _LOADFONT("resource\font\unispace.ttf", 18)
fonts(6) = _LOADFONT("resource\font\unispace.ttf", 24)
fonts(7) = _LOADFONT("resource\font\unispace.ttf", 36)
fonts(8) = _LOADFONT("resource\font\Salterio Shadow.ttf", 12)
fonts(9) = _LOADFONT("resource\font\Salterio Shadow.ttf", 24)
fonts(10) = _LOADFONT("resource\font\Salterio Shadow.ttf", 36)
fonts(11) = _LOADFONT("resource\font\Salterio Shadow.ttf", 48)
fonts(12) = _LOADFONT("resource\font\Salterio Shadow.ttf", 60)
fonts(13) = _LOADFONT("resource\font\Salterio Shadow.ttf", 72)

'open error log
OPEN "data\errorlog.log" FOR APPEND AS #4

'tcp/ip connections
IF Tcpip = 0 THEN
END IF

'preparation
RANDOMIZE TIMER
PLAY "MF"
SHELL _HIDE "exit"
_MOUSEHIDE
getrefreshrate = getdefaultfps
GOSUB getinput
oldDisplaytimer = TIMER(.001)
CLS

_SCREENSHOW
_AUTODISPLAY

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''''''''''''''''''''''''''''''''MAIN PROGRAM''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

PRINT "hi"
SLEEP
SYSTEM
'startup
IF titlelogo THEN _FREEIMAGE titlelogo

titlescreen:
DIM activemenubutton AS _BYTE
DIM drawtitlebutton AS _BYTE
DIM newactivemenubutton AS _BYTE
DIM titlebuttony1 AS SINGLE
DIM titlebuttony2 AS SINGLE
Loading = -1
REDIM titlebuttons(16) AS STRING
OPEN "resource\data\titlebuttons.txt" FOR INPUT AS #1
DO
    Numoftitlebutton = Numoftitlebutton + 1
    LINE INPUT #1, titlebuttons$(Numoftitlebutton)
LOOP UNTIL EOF(1)
CLOSE #1
REDIM _PRESERVE titlebuttons(Numoftitlebutton) AS STRING

CALL resetscreenlayer(2, 0)
CALL texturizebg(1, 640, 480, screenlayer(1))
PCOPY screenlayer(1), screenlayer(2)
CALL texturize(120, 300, 300, screenlayer(2), 50, 20, 590, 235)
Layer = 2
Loading = 0

'DIM but AS INTEGER
'but = NEWBUTTON("resource\image\button\selectionbox_gold.png", 50, 250, 300, 260, 0, 0, 0, 0, BUTTON_OFF, 0, BUTTON_SHOW, BUTTON_AUTOUPDATE_OFF)

DO
    _LIMIT setting.lps

    IF updatescreen THEN
        _DISPLAY
        GOSUB resetscreen
        CALL printtitle
        _FONT fonts(8)
        'UPDATEBUTTON but
        FOR drawtitlebutton = Numoftitlebutton TO 1 STEP -1
            titlebuttony1 = SCRY - 30 - (30 * (Numoftitlebutton - drawtitlebutton))
            titlebuttony2 = SCRY - 5 - (30 * (Numoftitlebutton - drawtitlebutton))
            IF activebutton = drawtitlebutton THEN
                _PUTIMAGE (((SCRX - 200) / 2), titlebuttony1)-(((SCRX - 200) / 2) + 200, titlebuttony2), GUI_box_special
            ELSE
                _PUTIMAGE (((SCRX - 200) / 2), titlebuttony1)-(((SCRX - 200) / 2) + 200, titlebuttony2), GUI_box
            END IF
            _PRINTSTRING (((SCRX - 200) / 2) + (((200 - _PRINTWIDTH(titlebuttons$(drawtitlebutton))) / 2)), (titlebuttony1 + ((titlebuttony2 - titlebuttony1 - _FONTHEIGHT) / 2))), titlebuttons$(drawtitlebutton)
        NEXT drawtitlebutton
        GOSUB cursor
        CALL versionstamp(4)
        _DISPLAY
        _AUTODISPLAY
    END IF

    Escact = 0
    GOSUB getinput
    IF Mousedata(5) AND Isfg THEN
        IF activemenubutton THEN CALL resetscreenlayer(0, 0)
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
    Escact = 1
    GOSUB getinput
LOOP

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



'''''''''''''''''''''''''''''GOSUBS'''''''''''''''''''''''''''''

'shuts down the program properly
cleanup:
CALL updatesettings
DIM freefonts AS _UNSIGNED _BYTE
'create emergency backup
'release image handles
'release sound handles
'release font and sprite handles
'pcopys should be cleared by program
_FONT 16
FOR freefonts = 1 TO FONT_NUM
    IF fonts(freefonts) > 0 THEN _FREEFONT fonts(freefonts)
NEXT freefonts
CLOSE #3
CLOSE #4
CLOSE
KILL "temp\si.tmp"
CLEAR
SYSTEM
RETURN

'the credits window
credits:
DO
    _LIMIT setting.lps
    GOSUB resetscreen
    PRINT "credits"
    Escact = 1
    GOSUB getinput
LOOP UNTIL Keyboardinput
RETURN

'draws a cursor on the screen at the mouse location
cursor:
IF setting.hidecursor = 0 THEN
    IF Loading THEN
        SPRITEPUT Mousedata(1), Mousedata(2), Cursorloading
    ELSE IF Click THEN
            SPRITEPUT Mousedata(1), Mousedata(2), Cursoraction
        ELSE IF Hovering THEN
                SPRITEPUT Mousedata(1), Mousedata(2), Cursorhover
            ELSE
                SPRITEPUT Mousedata(1), Mousedata(2), Cursorstand
            END IF
        END IF
    END IF
END IF
RETURN

'emptys the arrays used in the new game creation process
emptynewgamearrays:
REDIM primestat(0) AS _BYTE
REDIM newgamepass(0) AS _UNSIGNED _BYTE
REDIM racehave(0) AS _UNSIGNED INTEGER
REDIM hexp(0, 0) AS SINGLE
RETURN

'loads cursor images
getcursor:
DIM cursorsheetlook AS LONG
DIM cursorsheetloc AS STRING
IF Cursorsheet THEN
    SPRITEFREE Cursorstand
    SPRITEFREE Cursorhover
    SPRITEFREE Cursoraction
    SPRITEFREE Cursorloading
    SPRITEFREE Cursorsheet
END IF
cursorsheetloc = "resource\image\cursor\cursor_" + STRING$(3 - LEN(TRIMnum$(setting.cursor)), 48) + TRIMnum$(setting.cursor) + ".png"
IF NOT _FILEEXISTS(cursorsheetloc) THEN
    setting.cursor = 5
    cursorsheetloc = "resource\image\cursor\cursor_005.png"
END IF
cursorsheetlook = _LOADIMAGE(cursorsheetloc)
Cursorsheet = SPRITESHEETLOAD(cursorsheetloc, INT(_WIDTH(cursorsheetlook) / 4), _HEIGHT(cursorsheetlook), SPRITE_NOTRANSPARENCY)
_FREEIMAGE cursorsheetlook
IF Cursorsheet THEN
    Cursorstand = SPRITENEW(Cursorsheet, 1, SPRITE_SAVE)
    Cursorhover = SPRITENEW(Cursorsheet, 2, SPRITE_SAVE)
    Cursoraction = SPRITENEW(Cursorsheet, 3, SPRITE_SAVE)
    Cursorloading = SPRITENEW(Cursorsheet, 4, SPRITE_SAVE)
END IF
RETURN

'calls the getinput sub
getinput:
CALL getinput
IF Help = 1 THEN GOSUB help
IF Esc THEN
    SELECT CASE Escact
        CASE 0
            GOSUB cleanup
        CASE 1
            GOTO titlescreen
        CASE 2
            GOSUB emptynewgamearrays
            GOTO titlescreen
    END SELECT
END IF
IF _EXIT THEN GOSUB cleanup
Isfg = 0
IF Hwnd = GetForegroundWindow THEN Isfg = -1
Keyboardinput = 0
IF Isfg AND K$ > "" THEN Keyboardinput = -1
RETURN

'the help window
help:
''$incldrhude:'source\help.txt'
RETURN

'loads a profile
loadgame:
RETURN

'creates a new profile
newgame:
''$iddthrnclude:'source\newgame.txt'
RETURN

'refreshes the randomization
refreshrandom:
DIM refreshrandomcount AS INTEGER
DIM refreshrandomwait AS INTEGER
refreshrandomcount = refreshrandomcount + 1
IF refreshrandomcount = refreshrandomwait OR refreshrandomwait = 0 THEN
    RANDOMIZE TIMER
    refreshrandomwait = INT(RND * 32767 + 1)
    refreshrandomcount = 0
END IF
RETURN

'clears the screen and resets screen settings
resetscreen:
IF Layer THEN
    PCOPY screenlayer(Layer), 0
ELSE
    CLS
END IF
_PRINTMODE _KEEPBACKGROUND
COLOR ctorgb(Textcolor)
_FONT fonts(FONT_DEFAULT)
GOSUB refreshrandom
RETURN

'the settings window
settings:
DO
    _LIMIT setting.lps
    GOSUB resetscreen
    PRINT "settings"
    'change lps then reset loops and reget framespeed
    Escact = 1
    GOSUB getinput
LOOP UNTIL Keyboardinput
RETURN

'the single instance checker error catcher
sierr:
IF ERR = 70 THEN SYSTEM
GOTO sierrpass

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''''SUBS''''''''''''''''''''''''''''''

'clears an array
'parameter: an array of strings
'parameter: the stream of the array to use
SUB cleartextbox (text() AS STRING, stream AS _UNSIGNED _BYTE)
DIM clearing AS _UNSIGNED INTEGER
FOR clearing = 1 TO 32767
    IF text(stream, clearing) = "" THEN EXIT FOR
    text(stream, clearing) = ""
NEXT clearing
END SUB

'creates a message box for an error
'parameter: the error code
SUB errorhandler (errorcode AS INTEGER)
'create a message window
END SUB

'collects input of various forms
'precondition: required libraries are set, required variables are dimensioned and shared, programname$ is set properly
'note: when getinputinit = 0, getinput initates and collects data that doesn't need to be collected at each call
'note: look at the getinput variable dimensioning to see the descriptions of the variables
SUB getinput
IF Getinputinit = 0 THEN
    DIM resolution AS LONG
    DIM titletag AS LONG
    DIM oidesk AS _OFFSET
    DIM stdesk AS _OFFSET
    DIM LPP AS LPPOINT
    DIM Rec AS RECT
    resolution = _SCREENIMAGE
    Screendim(1) = _WIDTH(resolution)
    Screendim(2) = _HEIGHT(resolution)
    IF SystemParametersInfoW&(SPI_GETWORKAREA, 0, _OFFSET(Rec), 0) <> 0 THEN
        Screendim(3) = Rec.right
        Screendim(4) = Rec.bottom
    END IF
    Dtwin = GetDesktopWindow
    oidesk = OpenInputDesktop(0, 0, GENERIC_ALL)
    IF oidesk <> Dtwin AND oidesk > 0 THEN stdesk = SetThreadDesktop(oidesk)
    titletag = RND * &H1000000
    _TITLE Programname + " - " + HEX$(titletag)
    Hwnd = FindWindow(0, Programname + " - " + HEX$(titletag) + CHR$(0))
    _TITLE Programname
    IF SendMessageA(Hwnd, WM_SETHOTKEY, VK_F4, 0) = 1 THEN bringtotop& = DefWindowProcA(Hwnd, WM_SHOWWINDOW, 0, 0)
    Mouseswap = GetSystemMetrics(23)
    Getinputinit = -1
END IF
DIM storescroll AS _BYTE
DIM altfind AS _UNSIGNED _BYTE
DIM anumfind AS _UNSIGNED _BYTE
DIM cnumfind AS _UNSIGNED _BYTE
DIM ctrlchar AS _UNSIGNED _BYTE
DIM fkeyfind AS _UNSIGNED _BYTE
DIM fkeyafind AS _UNSIGNED _BYTE
DIM fkeycfind AS _UNSIGNED _BYTE
DIM fkeysfind AS _UNSIGNED _BYTE
DIM thekey AS _UNSIGNED _BYTE
DIM getmousepos AS LONG
DIM stampday AS STRING
DIM stamphour AS STRING
DIM stampminute AS STRING
DIM stampmonth AS STRING
DIM stampsecond AS STRING
DIM stampyear AS STRING
REDIM Akey(4) AS _BIT
REDIM Alt(34) AS _BIT
REDIM Ctrl(26) AS _BIT
REDIM Fkey(12) AS _BIT
REDIM Fkeya(12) AS _BIT
REDIM Fkeyc(12) AS _BIT
REDIM Fkeys(12) AS _BIT
REDIM Keys(256) AS _BIT
REDIM Numc(6) AS _BIT
REDIM Locks(3) AS INTEGER
Alt = 0
Ams = 0
Apk = 0
Aps = 0
Bsp = 0
Char = 0
Click = 0
Clk = 0
Ctrl = 0
Dlk = 0
Edk = 0
Esc = 0
Exk = 0
Help = 0
Hlk = 0
Hme = 0
Ins = 0
Isinput = 0
Keys = 0
Nlk = 0
Ntk = 0
Num = 0
Osc = 0
Pak = 0
Pdn = 0
Ppk = 0
Prk = 0
Psk = 0
Ptk = 0
Pup = 0
Rtn = 0
Sbk = 0
Sft = 0
Sle = 0
Slk = 0
Smk = 0
Spk = 0
Stk = 0
Tbc = 0
Vdk = 0
Vmk = 0
Vuk = 0
Wnk = 0
Zmk = 0
T = TIMER
Td = TIMER(.01)
Tf = TIMER(.001)
stampmonth = LEFT$(DATE$, 2)
Month = VAL(stampmonth)
stampday = MID$(DATE$, 4, 2)
Day = VAL(stampday)
stampyear = RIGHT$(DATE$, 4)
Year = VAL(stampyear)
stamphour = LEFT$(TIME$, 2)
Hour = VAL(stamphour)
stampminute = MID$(TIME$, 4, 2)
Minute = VAL(stampminute)
stampsecond = RIGHT$(TIME$, 2)
Second = VAL(stampsecond)
Timestamp = stampyear + stampmonth + stampday + stamphour + stampminute + stampsecond
K = INKEY$
IF K > "" THEN
    keyd = ASC(K)
    Act = TIMER
END IF
FOR ctrlchar = 1 TO 26
    IF keyd = ctrlchar THEN Ctrl(ctrlchar) = -1
NEXT ctrlchar
IF keyd = 8 THEN Bsp = -1
IF keyd = 9 THEN Tbc = -1
IF keyd = 13 THEN Rtn = -1
IF keyd = 27 THEN Esc = -1
IF keyd >= 48 AND keyd <= 57 THEN Num = keyd
IF keyd >= 32 AND keyd <= 126 THEN Char = keyd
FOR altfind = 1 TO 34
    IF K = (CHR$(0) + CHR$((15 + altfind))) THEN Alt(altfind) = -1
NEXT altfind
FOR fkeyfind = 1 TO 10
    IF K = (CHR$(0) + CHR$((58 + fkeyfind))) THEN Fkey(fkeyfind) = -1
NEXT fkeyfind
IF K = (CHR$(0) + CHR$(59)) THEN Help = -1
IF K = (CHR$(0) + CHR$(61)) THEN
    SELECT CASE Pw
        CASE -1
            _SCREENHIDE
            Pw = 0
        CASE 0
            _SCREENSHOW
            Pw = -1
    END SELECT
END IF
IF K = (CHR$(0) + CHR$(66)) THEN
    DIM ssc AS _UNSIGNED _BYTE
    DIM ssdirt AS _UNSIGNED _BYTE
    DIM bpp AS LONG
    DIM bytesperpixel AS LONG
    DIM cv AS LONG
    DIM lastsource AS LONG
    DIM pssx AS LONG
    DIM pssy AS LONG
    DIM ssx AS LONG
    DIM ssy AS LONG
    DIM paddessr AS STRING
    DIM ssb AS STRING
    DIM ssd AS STRING
    DIM ssname AS STRING
    DIM ssnamee AS STRING
    DIM ssnamer AS STRING
    DIM ssr AS STRING
    ssname = RTRIM$(setting.ssloc) + Timestamp
    ssnamer = RTRIM$(setting.ssloc) + Timestamp + ".bmp"
    IF _FILEEXISTS(ssnamer) = -1 THEN
        ssdirt = 0
        DO
            ssdirt = ssdirt + 1
            ssnamee = ssname + "_" + LTRIM$(RTRIM$(STR$(ssdirt)))
            ssnamer = ssnamee + ".bmp"
            IF NOT _FILEEXISTS(ssnamer) THEN EXIT DO
        LOOP
        ssname = ssnamer
    END IF
    bytesperpixel = _PIXELSIZE(0)
    IF bytesperpixel > 0 THEN
        IF bytesperpixel = 1 THEN bpp = 8 ELSE bpp = 24
        ssx = _WIDTH(0)
        ssy = _HEIGHT(0)
        ssb = "BM????" + STRING$(4, 0) + "????" + MKL$(40) + MKL$(ssx&) + MKL$(ssy&) + MKI$(1) + MKI$(bpp&) + MKL$(0) + "????" + STRING$(16, 0)
        IF bytesperpixel = 1 THEN
            FOR ssc = 0 TO 255
                cv = _PALETTECOLOR(ssc, 0)
                ssb = ssb + CHR$(_BLUE32(cv)) + CHR$(_GREEN32(cv)) + CHR$(_RED32(cv)) + CHR$(0)
            NEXT
        END IF
        MID$(ssb, 11, 4) = MKL$(LEN(ssb))
        lastsource = _SOURCE
        _SOURCE 0
        IF ((ssx * 3) MOD 4) THEN paddessr = STRING$(4 - ((ssx * 3) MOD 4), 0)
        FOR pssy = ssy - 1 TO 0 STEP -1
            ssr = ""
            FOR pssx = 0 TO ssx - 1
                ssc = POINT(pssx, pssy)
                IF bytesperpixel = 1 THEN
                    ssr = ssr + CHR$(ssc)
                ELSE
                    ssr = ssr + LEFT$(MKL$(ssc), 3)
                END IF
            NEXT pssx
            ssd = ssd + ssr + paddessr
        NEXT pssy
        _SOURCE lastsource
        MID$(ssb, 35, 4) = MKL$(LEN(ssd))
        ssb = ssb + ssd
        MID$(ssb, 3, 4) = MKL$(LEN(ssb))
        OPEN ssname FOR BINARY AS #7
        PUT #7, , ssb
        CLOSE #7
    END IF
END IF
IF K = (CHR$(0) + CHR$(71)) THEN Hme = -1
IF K = (CHR$(0) + CHR$(73)) THEN Pup = -1
IF K = (CHR$(0) + CHR$(79)) THEN Edk = -1
IF K = (CHR$(0) + CHR$(81)) THEN Pdn = -1
IF K = (CHR$(0) + CHR$(82)) THEN Ins = -1
IF K = (CHR$(0) + CHR$(83)) THEN Dlk = -1
Akey(1) = _KEYDOWN(18432)
Akey(2) = _KEYDOWN(19200)
Akey(3) = _KEYDOWN(19712)
Akey(4) = _KEYDOWN(20480)
FOR fkeysfind = 1 TO 10
    IF K = (CHR$(0) + CHR$(83 + fkeysfind)) THEN Fkeys(fkeysfind) = -1
NEXT fkeysfind
FOR fkeycfind = 1 TO 10
    IF K = (CHR$(0) + CHR$(93 + fkeycfind)) THEN Fkeyc(fkeycfind) = -1
NEXT fkeycfind
FOR fkeyafind = 1 TO 10
    IF K = (CHR$(0) + CHR$(103 + fkeyafind)) THEN Fkeya(fkeyafind) = -1
NEXT fkeyafind
FOR cnumfind = 1 TO 6
    IF K = (CHR$(0) + CHR$((113 + cnumfind))) THEN Numc(cnumfind) = -1
NEXT cnumfind
FOR anumfind = 1 TO 10
    IF K = (CHR$(0) + CHR$((119 + anumfind))) THEN Numa(anumfind) = -1
NEXT anumfind
IF K = (CHR$(0) + CHR$(130)) THEN Ams = -1
IF K = (CHR$(0) + CHR$(130)) THEN Aps = -1
IF K = (CHR$(0) + CHR$(133)) THEN
    Fkey(11) = -1
    SELECT CASE Fs
        CASE -1
            _FULLSCREEN _OFF
            Fs = 0
        CASE 0
            _FULLSCREEN
            Fs = -1
    END SELECT
END IF
IF K = (CHR$(0) + CHR$(134)) THEN Fkey(12) = -1
IF K = (CHR$(0) + CHR$(135)) THEN Fkeys(11) = -1
IF K = (CHR$(0) + CHR$(136)) THEN Fkeys(12) = -1
IF K = (CHR$(0) + CHR$(137)) THEN Fkeyc(11) = -1
IF K = (CHR$(0) + CHR$(138)) THEN Fkeyc(12) = -1
IF K = (CHR$(0) + CHR$(139)) THEN Fkeya(11) = -1
IF K = (CHR$(0) + CHR$(140)) THEN Fkeya(12) = -1
FOR thekey = &H01 TO &HFE
    IF GetAsyncKeyState(thekey) THEN
        Keys = Keys + 1
        Keys(thekey) = -1
    END IF
NEXT
IF Keys(1) OR Keys(2) OR Keys(3) THEN Osc = -1
IF Keys(12) THEN Clk = -1
IF Keys(16) THEN Sft = -1
IF Keys(17) THEN Ctrl = -1
IF Keys(18) THEN Alt = -1
IF Keys(19) THEN Pak = -1
IF Keys(41) THEN Stk = -1
IF Keys(42) THEN Prk = -1
IF Keys(43) THEN Exk = -1
IF Keys(44) THEN Psk = -1
IF Keys(47) THEN Hlk = -1
IF Keys(91) OR Keys(92) THEN Wnk = -1
IF Keys(93) THEN Apk = -1
IF Keys(95) THEN Sle = -1
IF Keys(144) THEN Nlk = -1
IF Keys(145) THEN Slk = -1
IF Keys(172) THEN Sbk = -1
IF Keys(173) THEN Vmk = -1
IF Keys(174) THEN Vdk = -1
IF Keys(175) THEN Vuk = -1
IF Keys(176) THEN Ntk = -1
IF Keys(177) THEN Ptk = -1
IF Keys(178) THEN Spk = -1
IF Keys(179) THEN Ppk = -1
IF Keys(180) THEN Smk = -1
IF Keys(251) THEN Zmk = -1
Locks(1) = GetKeyState(VK_CAPITAL)
Locks(2) = GetKeyState(VK_NUMLOCK)
Locks(3) = GetKeyState(VK_SCROLL)
Mousedata(8) = 0
DO WHILE _MOUSEINPUT
    storescroll = Mousedata(8)
    REDIM Mousedata(8) AS SINGLE
    Mousedata(1) = _MOUSEX
    Mousedata(2) = _MOUSEY
    getmousepos = GetCursorPos(_OFFSET(LPP))
    Mousedata(3) = LPP.x
    Mousedata(4) = LPP.y
    SELECT CASE Mouseswap
        CASE 0
            IF _MOUSEBUTTON(1) THEN Mousedata(5) = -1
            IF _MOUSEBUTTON(2) THEN Mousedata(6) = -1
        CASE ELSE
            IF _MOUSEBUTTON(2) THEN Mousedata(5) = -1
            IF _MOUSEBUTTON(1) THEN Mousedata(6) = -1
    END SELECT
    IF _MOUSEBUTTON(3) THEN Mousedata(7) = -1
    Mousedata(8) = storescroll + _MOUSEWHEEL
LOOP
Click = (Mousedata(5) OR Mousedata(6) OR Mousedata(7))
Isinput = (Keys OR Click)
END SUB

'fills primestat() with the prime base stats based on your race
'parameter: the string of your race
'parameter: an array of singles (output)
'precondition: primestat() must be dimensioned to an array of singles of appropriate size
SUB getminprimebasestats (race AS STRING, primestat() AS _BYTE)
DIM stat AS _UNSIGNED _BYTE
FOR stat = 1 TO PRIMESTATS_NUM
    primestat(stat) = 3
NEXT stat
SELECT CASE race
    CASE "Dwarf"
        primestat(1) = primestat(1) + 1
        primestat(2) = primestat(2) + 1
        primestat(3) = primestat(3) - 1
        primestat(4) = primestat(4) - 1
        primestat(5) = primestat(5) + 1
        primestat(6) = primestat(6) - 1
    CASE "Elf"
        primestat(1) = primestat(1) - 1
        primestat(2) = primestat(2) - 1
        primestat(3) = primestat(3) + 1
        primestat(4) = primestat(4) + 1
        primestat(5) = primestat(5) - 1
        primestat(6) = primestat(6) + 1
END SELECT
END SUB

'draws a hexagon
'parameter: the center x coordinate
'parameter: the center y coordinate
'parameter: the side length
'parameter: the color
SUB HEXAGON (x AS SINGLE, y AS SINGLE, s AS LONG, c AS LONG)
DIM side AS _UNSIGNED _BYTE
PSET (x + ((s / 2) * SQR(3)), y + (s / 2)), c
FOR side = 0 TO 5
    DRAW "TA" + STR$(side * 60) + "U" + STR$(s)
NEXT side
DRAW "TA0"
END SUB

'creates an on screen keyboard
'parameter: the x coordinate of the upper left corner of the keyboard
'parameter: the y coordinate of the upper left corner of the keyboard
'parameter: the array of ascii values read from keyboard.txt
'parameter: the ascii of the character hit, if any
SUB keyboard (x AS SINGLE, y AS SINGLE, keybd() AS _UNSIGNED INTEGER)
DIM colorscheme AS _UNSIGNED _BIT
DIM board AS _UNSIGNED _BYTE
DIM keywidth AS _BYTE
DIM drawkeyboardrow AS _UNSIGNED _BYTE
DIM drawkeyboardcol AS _UNSIGNED _BYTE
DIM getwidth AS _UNSIGNED _BYTE
DIM keyprint AS INTEGER
Khit = 0
IF Keyboardshift = 1 THEN Keyboardshift = 0
IF Sft THEN Keyboardshift = 1
IF Locks(1) = 1 THEN
    Keyboardcaps = 1
ELSE IF Locks(1) = -128 THEN
        Keyboardcaps = 0
    END IF
END IF
board = 1
IF Keyboardshift OR Keyboardcaps THEN board = 2
FOR drawkeyboardrow = 0 TO 4
    FOR drawkeyboardcol = 0 TO 13
        keyprint = keybd(board, drawkeyboardrow + 1, drawkeyboardcol + 1)
        IF keyprint THEN
            keywidth = 1
            FOR getwidth = drawkeyboardcol + 1 TO 13
                IF keybd(board, drawkeyboardrow + 1, getwidth + 1) = keyprint THEN
                    keywidth = keywidth + 1
                ELSE
                    EXIT FOR
                END IF
            NEXT getwidth
            LINE (x + drawkeyboardcol * 32, y + drawkeyboardrow * 32)-STEP(keywidth * 32, 32), ctorgb(15), B
            IF isonbox(Mousedata(1), Mousedata(2), x + drawkeyboardcol * 32, y + drawkeyboardrow * 32, x + drawkeyboardcol * 32 + (keywidth * 32 - 2), y + drawkeyboardrow * 32 + 30) AND Mousedata(5) THEN
                Keyboardclick = keyprint
            ELSE
                IF isonbox(Mousedata(1), Mousedata(2), x + drawkeyboardcol * 32, y + drawkeyboardrow * 32, x + drawkeyboardcol * 32 + (keywidth * 32 - 2), y + drawkeyboardrow * 32 + 30) THEN
                    IF Keyboardclick = keyprint THEN
                        SELECT CASE Keyboardclick
                            CASE 256
                                IF NOT Sft THEN Keyboardshift = 2
                            CASE 257
                                Keyboardcaps = Keyboardcaps XOR 2 ^ 0
                            CASE ELSE
                                Khit = keyprint
                                Keyboardshift = 0
                        END SELECT
                    END IF
                    Keyboardclick = 0
                END IF
            END IF
            colorscheme = 0
            SELECT CASE keyprint
                CASE 39
                    IF _KEYDOWN(39) THEN colorscheme = 1
                CASE 45
                    IF Keys(189) THEN colorscheme = 1
                CASE 46
                    IF Keys(190) THEN colorscheme = 1
                CASE 96
                    IF _KEYDOWN(96) THEN colorscheme = 1
                CASE 97 TO 122
                    IF Keys(keyprint - 32) THEN colorscheme = 1
                CASE 256
                    IF Keyboardshift THEN colorscheme = 1
                CASE 257
                    IF Keyboardcaps THEN colorscheme = 1
                CASE ELSE
                    IF Keys(keyprint) THEN colorscheme = 1
            END SELECT
            IF isonbox(Mousedata(1), Mousedata(2), x + drawkeyboardcol * 32, y + drawkeyboardrow * 32, x + drawkeyboardcol * 32 + (keywidth * 32 - 2), y + drawkeyboardrow * 32 + 30) AND Mousedata(5) THEN colorscheme = 1
            SELECT CASE colorscheme
                CASE 0
                    COLOR ctorgb(15)
                    IF isonbox(Mousedata(1), Mousedata(2), x + drawkeyboardcol * 32, y + drawkeyboardrow * 32, x + drawkeyboardcol * 32 + (keywidth * 32 - 2), y + drawkeyboardrow * 32 + 30) THEN LINE (x + drawkeyboardcol * 32 + 1, y + drawkeyboardrow * 32 + 1)-STEP(keywidth * 32 - 2, 30), ctorgb(8), BF
                CASE 1
                    COLOR ctorgb(0)
                    LINE (x + drawkeyboardcol * 32 + 1, y + drawkeyboardrow * 32 + 1)-STEP(keywidth * 32 - 2, 30), ctorgb(8), BF
            END SELECT
            SELECT CASE keyprint
                CASE 8
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 24, y + drawkeyboardrow * 32 + 8), "<-"
                CASE 13
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 8, y + drawkeyboardrow * 32 + 8), "Return"
                CASE 32
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 108, y + drawkeyboardrow * 32 + 8), "Space"
                CASE 256
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 12, y + drawkeyboardrow * 32 + 8), "Shift"
                CASE 257
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 16, y + drawkeyboardrow * 32 + 8), "Caps"
                CASE ELSE
                    _PRINTSTRING (x + drawkeyboardcol * 32 + 12, y + drawkeyboardrow * 32 + 8), CHR$(keyprint)
            END SELECT
            drawkeyboardcol = drawkeyboardcol + keywidth - 1
        ELSE
            LINE (x + drawkeyboardcol * 32, y + drawkeyboardrow * 32)-STEP(32, 32), ctorgb(15), B
            LINE (x + drawkeyboardcol * 32 + 1, y + drawkeyboardrow * 32 + 1)-STEP(30, 30), ctorgb(8), BF
        END IF
NEXT drawkeyboardcol, drawkeyboardrow
END SUB

'puts a rectangular area of an image to a rectangular area of another image
'the handle of the source image
'the upper left corner x coordinate of the source image area
'the upper left corner y coordinate of the source image area
'the lower right corner x coordinate of the source image area
'the lower right corner y coordinate of the source image area
'the handle of the destination image
'the upper left corner x coordinate of the destination image area
'the upper left corner y coordinate of the destination image area
'the lower right corner x coordinate of the destination image area
'the lower right corner y coordinate of the destination image area
SUB MAPRECT (source AS LONG, sourceleft AS LONG, sourcetop AS LONG, sourceright AS LONG, sourcebottom AS LONG, dest AS LONG, destleft AS LONG, desttop AS LONG, destright AS LONG, destbottom AS LONG)
_MAPTRIANGLE _SEAMLESS(sourceleft, sourcetop)-(sourceleft, sourcebottom)-(sourceright, sourcebottom), source TO(destleft, desttop)-(destleft, destbottom)-(destright, destbottom), dest
_MAPTRIANGLE _SEAMLESS(sourceleft, sourcetop)-(sourceright, sourcetop)-(sourceright, sourcebottom), source TO(destleft, desttop)-(destright, desttop)-(destright, destbottom), dest
END SUB

'prints the game title for the title screen
SUB printtitle
DIM commontitlespace AS SINGLE
commontitlespace = INT((SCRY - ((_FONTHEIGHT(fonts(12)) * 2) + _FONTHEIGHT(fonts(11)) + 20 + (Numoftitlebutton * 30))) / 3)
COLOR ctorgb(0)
_FONT fonts(12)
_PRINTSTRING ((SCRX - _PRINTWIDTH("CHRONICLES")) / 2, commontitlespace), "CHRONICLES"
_PRINTSTRING ((SCRX - _PRINTWIDTH("LORRIA")) / 2, commontitlespace + _FONTHEIGHT(fonts(12)) + 20 + _FONTHEIGHT(fonts(11))), "LORRIA"
_FONT fonts(11)
_PRINTSTRING ((SCRX - _PRINTWIDTH("OF")) / 2, commontitlespace + _FONTHEIGHT(fonts(12)) + 10), "OF"
COLOR ctorgb(Textcolor)
_FONT fonts(FONT_DEFAULT)
END SUB

'clears a file
'parameter: the name of the file
SUB resetfile (filename AS STRING)
OPEN filename FOR OUTPUT AS #30
CLOSE #30
END SUB

'resets the shared keyboard variables
SUB resetkeyboard
Keyboardcaps = 0
Keyboardclick = 0
Keyboardshift = 0
END SUB

'resets the screenlayer array
'parameter: the number of layers to make in the new array
SUB resetscreenlayer (layers AS _UNSIGNED _BYTE, savelayers AS _UNSIGNED _BYTE)
DIM freescreenlayer AS _UNSIGNED _BYTE
DIM makescreenlayer AS _UNSIGNED _BYTE
FOR freescreenlayer = savelayers + 1 TO UBOUND(screenlayer)
    IF screenlayer(freescreenlayer) THEN _FREEIMAGE screenlayer(freescreenlayer)
NEXT freescreenlayer
REDIM screenlayer(layers) AS LONG
FOR makescreenlayer = savelayers + 1 TO layers
    screenlayer(makescreenlayer) = _NEWIMAGE(640, 480, 32)
NEXT makescreenlayer
Layer = 0
END SUB

'resets to the default settings
SUB resetsettings
setting.sound = -1
setting.fx = -1
setting.lps = 64
setting.fps = getdefaultfps
setting.ssloc = ""
setting.cursor = 1
setting.hidecursor = 0
setting.races = "abc"
END SUB

'saves the current profile to a file
SUB saveprofile
OPEN profile.file FOR OUTPUT AS #1
CLOSE #1
'OPEN profile.file FOR BINARY AS #1
'PUT #1, , profile
'CLOSE #1
OPEN profile.file FOR OUTPUT AS #1
PRINT #1, profile.file
PRINT #1, profile.name
PRINT #1, profile.race
PRINT #1, profile.gender
PRINT #1, profile.class
PRINT #1, profile.str
PRINT #1, profile.dex
PRINT #1, profile.int
PRINT #1, profile.wis
PRINT #1, profile.con
PRINT #1, profile.chr
PRINT #1, profile.alignment
PRINT #1, profile.faction
CLOSE #1
END SUB

'sorts an array of string using the insertion sort method
'parameter: an array of strings
SUB sort_insertion_str (array() AS STRING)
DIM sortx AS LONG
DIM sorty AS LONG
FOR sortx = 1 TO UBOUND(array)
    IF array(sortx) = "" THEN EXIT FOR
    FOR sorty = sortx TO 1 STEP -1
        IF array(sorty) < array(sorty - 1) THEN SWAP array(sorty), array(sorty - 1)
    NEXT sorty
NEXT sortx
END SUB

'creates a text box on the screen
'parameter: location of the text box
'parameter: the x coordinate of the upper left corner of a custom location text box
'parameter: the y coordinate of the upper left corner of a custom location text box
'parameter: the width in pixels of a custom text box (text$() must be formatted seperately)
'parameter: whether to clear the screen or not
'parameter: the behaviour of the text box
'parameter: number of rows of the text box
'parameter: location in the rows of the text box
'parameter: whether to have ticks or not
'parameter: the speed of the text printing
'parameter: the color of the trim of the text box
'parameter: the color of the shading of the text box
'parameter: the color of the text of the text box
'parameter: the array of strings to print in the text box
'parameter: the the stream of the array to use
SUB textbox (location AS _BYTE, locx AS SINGLE, locy AS SINGLE, customwidth AS LONG, clrscr AS _BYTE, behaviour AS _BYTE, rows AS _BYTE, row AS _BYTE, new AS _BYTE, ticks AS _BYTE, speed AS _UNSIGNED _BYTE, colortrim AS LONG, colorshade AS LONG, colortext AS LONG, text() AS STRING, stream AS _UNSIGNED _BYTE)
DIM rowprint AS _BYTE
DIM itsnew AS _UNSIGNED _BYTE
DIM printrows AS _UNSIGNED _BYTE
DIM counttick AS INTEGER
DIM findnew AS INTEGER
DIM getnew AS INTEGER
DIM replacenew AS INTEGER
IF location = 2 THEN
    IF locx = 0 THEN locx = 1
    IF locy = 0 THEN locy = 2
    IF customwidth = 0 THEN customwidth = SCRX - locx - 4
END IF
FOR findnew = 1 TO 32767
    IF text(stream, findnew) = "" AND findnew >= new THEN
        IF new THEN
            REDIM newtext(1024) AS STRING
            FOR getnew = 1 TO new
                newtext(getnew) = text(stream, findnew - getnew)
            NEXT getnew
        END IF
        EXIT FOR
    END IF
NEXT findnew
IF row < 1 THEN row = 1
IF row > findnew - rows THEN row = findnew - rows
IF clrscr THEN
    CALL cleartextbox(text(), stream)
    IF new THEN
        FOR replacenew = 1 TO new
            text(stream, replacenew) = newtext(new - replacenew + 1)
        NEXT replacenew
    END IF
    findnew = new + 1
END IF
IF rows = -1 THEN rows = new
SELECT CASE location
    CASE 0
        LINE (1, SCRY - (4 + (16 * rows)))-(SCRX - 2, SCRY - 2), colortrim, B
        PAINT (2, SCRY - (16 * rows) + 1), colorshade, colortrim
    CASE 1
        LINE (1, 2)-(SCRX - 2, 4 + (16 * rows)), colortrim, B
        PAINT (2, 3), colorshade, colortrim
    CASE 2
        LINE (locx, locy)-(locx + customwidth, locy + 2 + (16 * rows)), colortrim, B
        PAINT (locx + 1, locy + 1), colorshade, colortrim
END SELECT
IF findnew = 1 THEN EXIT SUB
_PRINTMODE _KEEPBACKGROUND
COLOR colortext
IF behaviour = 0 THEN
    row = 1
ELSE IF row = 0 THEN
        row = findnew - rows
        IF row < 1 THEN row = 1
        IF row > findnew - new THEN row = findnew - new
    END IF
END IF
rowprint = 0
Newprints = 0
IF new THEN
    DO
        IF speed OR ticks THEN
            SELECT CASE location
                CASE 0
                    PAINT (2, SCRY - (16 * rows) + 1), colorshade, colortrim
                CASE 1
                    PAINT (2, 3), colorshade, colortrim
                CASE 2
                    PAINT (locx + 1, locy + 1), colorshade, colortrim
            END SELECT
            row = findnew - rows - new + Newprints
            rowprint = 0
        END IF
        FOR printrows = row TO row + (rows - 1)
            rowprint = rowprint + 1
            IF printrows > findnew THEN EXIT FOR
            itsnew = 0
            FOR isnew = 1 TO new
                IF newtext(isnew) = text(stream, printrows) THEN
                    itsnew = 1
                    EXIT FOR
                END IF
            NEXT isnew
            IF itsnew = 1 AND speed THEN
                IF (findnew - (new - (findnew - printrows))) - row > rows THEN row = (findnew - (new - (findnew - printrows))) - rows
                counttick = 0
                DO
                    _LIMIT speed
                    IF counttick = LEN(text(stream, printrows)) THEN EXIT DO
                    SELECT CASE location
                        CASE 0
                            _PRINTSTRING (4 + (8 * counttick), SCRY - (2 + (16 * (rows - (rowprint - 1))))), MID$(text(stream, printrows), counttick + 1, 1)
                        CASE 1
                            _PRINTSTRING (4 + (8 * counttick), 4 + (16 * (rowprint - 1))), MID$(text(stream, printrows), counttick + 1, 1)
                        CASE 2
                            _PRINTSTRING (locx + 2 + (8 * counttick), locy + 2 + (16 * (rowprint - 1))), MID$(text(stream, printrows), counttick + 1, 1)
                    END SELECT
                    IF ticks THEN PLAY "MB L64 O4 C"
                    counttick = counttick + 1
                    Isinput = (INKEY$ > "")
                    DO WHILE _MOUSEINPUT
                        Isinput = (Isinput OR _MOUSEBUTTON(1) OR _MOUSEBUTTON(2) OR _MOUSEBUTTON(3))
                    LOOP
                    IF Isinput THEN
                        IF Newprints = new THEN Newprints = Newprints - 1
                        newtext(isnew) = ""
                        EXIT FOR
                    END IF
                    _DISPLAY
                LOOP
                newtext(isnew) = ""
            ELSE
                SELECT CASE location
                    CASE 0
                        _PRINTSTRING (4, SCRY - (2 + (16 * (rows - (rowprint - 1))))), text(stream, printrows)
                    CASE 1
                        _PRINTSTRING (4, 4 + (16 * (rowprint - 1))), text(stream, printrows)
                    CASE 2
                        _PRINTSTRING (locx + 2, locy + 2 + (16 * (rowprint - 1))), text(stream, printrows)
                END SELECT
            END IF
        NEXT printrows
        IF speed = 0 THEN EXIT DO
        Newprints = Newprints + 1
    LOOP UNTIL Newprints > new
ELSE
    FOR printrows = row TO row + (rows - 1)
        rowprint = rowprint + 1
        IF printrows >= findnew THEN EXIT FOR
        SELECT CASE location
            CASE 0
                _PRINTSTRING (4, SCRY - (2 + (16 * (rows - (rowprint - 1))))), text(stream, printrows)
            CASE 1
                _PRINTSTRING (4, 4 + (16 * (rowprint - 1))), text(stream, printrows)
            CASE 2
                _PRINTSTRING (locx + 2, locy + 2 + (16 * (rowprint - 1))), text(stream, printrows)
        END SELECT
    NEXT printrows
END IF
END SUB

'puts a texture over an area of the screen
'parameter: the filename of a seamless tile image
'parameter: the desired width of the tile in pixels, 0 for actual size
'parameter: the desired height of the tile in pixels, 0 for actual size
'parameter: the area of the screen to be texturized
SUB texturize (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG, destleft AS LONG, desttop AS LONG, destright AS LONG, destbottom AS LONG)
DIM putextratexturex AS _UNSIGNED _BYTE
DIM putextratexturey AS _UNSIGNED _BYTE
DIM puttexturex AS _UNSIGNED _BYTE
DIM puttexturey AS _UNSIGNED _BYTE
DIM destheight AS LONG
DIM destwidth AS LONG
DIM texture AS LONG
DIM textureheight AS LONG
DIM texturewidth AS LONG
DIM xextraspace AS SINGLE
DIM xextratexture AS SINGLE
DIM yextraspace AS SINGLE
DIM yextratexture AS SINGLE
SHARED textures() AS STRING
texture = _LOADIMAGE("resource\image\texture\" + textures(texturechoice))
destright = destright + 1
destbottom = destbottom + 1
IF texture THEN
    destheight = destbottom - desttop
    destwidth = destright - destleft
    IF width THEN
        texturewidth = width
    ELSE
        texturewidth = _WIDTH(texture)
    END IF
    IF height THEN
        textureheight = height
    ELSE
        textureheight = _HEIGHT(texture)
    END IF
    FOR puttexturex = 1 TO INT(destwidth / texturewidth)
        FOR puttexturey = 1 TO INT(destheight / textureheight)
            _PUTIMAGE (destleft + (puttexturex - 1) * texturewidth, desttop + (puttexturey - 1) * textureheight)-(destleft + puttexturex * texturewidth, desttop + puttexturey * textureheight), texture, dest
    NEXT puttexturey, puttexturex
    xextraspace = destwidth MOD texturewidth
    xextratexture = xextraspace * (_WIDTH(texture) / texturewidth)
    IF xextraspace THEN
        FOR putextratexturey = 1 TO INT(destheight / textureheight)
            MAPRECT texture, 0, 0, xextratexture, _HEIGHT(texture), dest, destright - xextraspace, desttop + (putextratexturey - 1) * textureheight, destright, desttop + putextratexturey * textureheight
        NEXT putextratexturey
    END IF
    yextraspace = destheight MOD textureheight
    yextratexture = yextraspace * (_HEIGHT(texture) / textureheight)
    IF yextraspace THEN
        FOR putextratexturex = 1 TO INT(destwidth / texturewidth)
            MAPRECT texture, 0, 0, _WIDTH(texture), yextratexture, dest, destleft + (putextratexturex - 1) * texturewidth, destbottom - yextraspace, destleft + putextratexturex * texturewidth, destbottom
        NEXT putextratexturex
    END IF
    IF xextraspace * yextraspace THEN
        MAPRECT texture, 0, 0, xextratexture, yextratexture, dest, destright - xextraspace, destbottom - yextraspace, destright, destbottom
    END IF
    _FREEIMAGE texture
END IF
END SUB

'creates a background image
'parameter: the filename of a seamless tile image
'parameter: the desired width of the tile in pixels, 0 for actual size
'parameter: the desired height of the tile in pixels, 0 for actual size
SUB texturizebg (texturechoice AS _UNSIGNED _BYTE, width AS LONG, height AS LONG, dest AS LONG)
DIM putbgtexturex AS _UNSIGNED _BYTE
DIM putbgtexturey AS _UNSIGNED _BYTE
DIM bgtexture AS LONG
DIM textureheight AS LONG
DIM texturewidth AS LONG
SHARED textures() AS STRING
bgtexture = _LOADIMAGE("resource\image\texture\" + textures(texturechoice))
IF bgtexture THEN
    IF width * height THEN
        texturewidth = _WIDTH(bgtexture)
        textureheight = _HEIGHT(bgtexture)
        FOR putbgtexturex = 1 TO (INT(SCRX / texturewidth) + 1)
            FOR putbgtexturey = 1 TO (INT(SCRY / textureheight) + 1)
                _PUTIMAGE ((putbgtexturex - 1) * texturewidth, (putbgtexturey - 1) * textureheight)-(putbgtexturex * texturewidth, putbgtexturey * textureheight), bgtexture, dest
        NEXT putbgtexturey, putbgtexturex
    ELSE
        FOR putbgtexturex = 1 TO (INT(SCRX / width) + 1)
            FOR putbgtexturey = 1 TO (INT(SCRY / height) + 1)
                _PUTIMAGE ((putbgtexturex - 1) * width, (putbgtexturey - 1) * height)-(putbgtexturex * width, putbgtexturey * height), bgtexture, dest
        NEXT putbgtexturey, putbgtexturex
    END IF
    _FREEIMAGE bgtexture
END IF
END SUB

'updates the settings file with the current metrics
SUB updatesettings
OPEN "data\settings.inf" FOR OUTPUT AS #1
CLOSE #1
'OPEN "data\settings.inf" FOR BINARY AS #1
'PUT #1, , setting
'CLOSE #1
OPEN "data\settings.inf" FOR OUTPUT AS #1
PRINT #1, setting.sound
PRINT #1, setting.fx
PRINT #1, setting.lps
PRINT #1, setting.fps
PRINT #1, setting.ssloc
PRINT #1, setting.cursor
PRINT #1, setting.hidecursor
PRINT #1, setting.races
CLOSE #1
END SUB

'calculates all valid fps options
'precondition: setting must be set
SUB validfps (fpsoption() AS LONG)
DIM fpsoptions AS _UNSIGNED _BYTE
DIM findmultiple AS INTEGER
DIM getfactors AS INTEGER
REDIM fpsoption(255) AS LONG
FOR getfactors = 10 TO Refreshrate / 2
    IF Refreshrate MOD getfactors = 0 THEN
        fpsoptions = fpsoptions + 1
        fpsoption(fpsoptions) = getfactors
    END IF
NEXT getfactors
IF Refreshrate <= setting.lps THEN
    fpsoptions = fpsoptions + 1
    fpsoption(fpsoptions) = Refreshrate
    findmultiple = Refreshrate
    DO
        findmultiple = findmultiple * 2
        IF findmultiple <= setting.lps THEN
            fpsoptions = fpsoptions + 1
            fpsoption(fpsoptions) = findmultiple
        ELSE
            EXIT DO
        END IF
    LOOP
END IF
REDIM _PRESERVE fpsoption(fpsoptions) AS LONG
END SUB

'prints the version number to the screen
'parameter: the corner to print the version to
SUB versionstamp (sector AS _BYTE)
DIM versionprint AS STRING
versionprint = "v" + STRING$(-1 * (Version < 1), 48) + TRIMnum$(Version)
COLOR ctorgb(8)
_FONT fonts(1)
SELECT CASE sector
    CASE 1
        _PRINTSTRING (SCRX - _PRINTWIDTH(versionprint), 0), versionprint
    CASE 2
        _PRINTSTRING (0, 0), versionprint
    CASE 3
        _PRINTSTRING (0, SCRY - _FONTHEIGHT), versionprint
    CASE 4
        _PRINTSTRING (SCRX - _PRINTWIDTH(versionprint), SCRY - _FONTHEIGHT), versionprint
END SELECT
COLOR Textcolor
_FONT fonts(FONT_DEFAULT)
END SUB

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''FUNCTION''''''''''''''''''''''''''''

'adds a string to the textbox string with proper division of lines
'parameter: a string of arrays of the textbox text
'parameter: the stream from the array to add to
'parameter: a string of text to add to the textbox text array
'parameter: the width in characters of the textbox
'return: the number of new lines added to the textbox text array
FUNCTION addtotextbox% (text() AS STRING, stream AS _UNSIGNED _BYTE, add AS STRING, size AS _UNSIGNED INTEGER)
DIM adding AS _UNSIGNED INTEGER
DIM addloc AS _UNSIGNED INTEGER
DIM adds AS _UNSIGNED INTEGER
DIM findlast AS _UNSIGNED INTEGER
DIM remlast AS _UNSIGNED INTEGER
FOR findlast = 1 TO 32767
    IF text(stream, findlast) = "" THEN EXIT FOR
NEXT findlast
IF add = "" THEN
    addtotextbox = 0
    EXIT FUNCTION
END IF
REDIM adds(1024) AS STRING
adds = 1
addloc = 1
DO
    adds(adds) = MID$(add, addloc, size)
    IF MID$(add, addloc + (size - 1), 1) <> " " AND MID$(add, addloc + (size - 1), 1) <> "" THEN
        FOR remlast = LEN(adds(adds)) TO 1 STEP -1
            IF MID$(adds(adds), remlast - 1, 1) = " " THEN
                adds(adds) = LEFT$(adds(adds), remlast - 1)
                EXIT FOR
            END IF
        NEXT remlast
    END IF
    addloc = addloc + LEN(adds(adds))
    IF addloc >= LEN(add) THEN EXIT DO
    adds = adds + 1
LOOP
FOR adding = 1 TO adds
    text(stream, (findlast - 1) + adding) = adds(adding)
NEXT adding
addtotextbox = adds
END FUNCTION

'finds the index of an element in an array of integers
'parameter: an array of integers
'parameter: the integer to search for
'return: the index of the first element matching the referrence
FUNCTION arrayloc_int& (array() AS INTEGER, reference AS INTEGER)
FOR arrayloc_int = LBOUND(array) TO UBOUND(array)
    IF array(checkarray) = reference THEN EXIT FUNCTION
NEXT arrayloc_int
arrayloc_int = 0
END FUNCTION

'calculates a chance event
'parameter: the probability of the event occurring
'return: true or false
FUNCTION chance` (probability AS SINGLE)
chance = probability >= RND
END FUNCTION

'finds the element of the array closest to the reference
'note: if multiple elements are equidistant from the reference the earlier element in the array takes precedence
'precondition: array() is not empty
'parameter: the reference
'parameter: the array
'return: the location of the closest element within the array
FUNCTION closestelement& (reference AS LONG, array() AS LONG)
DIM closestloc AS LONG
DIM closestval AS LONG
DIM getcloseness AS LONG
closestval = LONG_MAX
FOR getcloseness = 1 TO UBOUND(array)
    IF ABS(array(getcloseness) - reference) < closestval THEN
        closestval = ABS(array(getcloseness) - reference)
        closestloc = getcloseness
    END IF
NEXT getcloseness
closestelement = array(closestloc)
END FUNCTION

'converts 4bit colors to 32bit colors
'parameter: a 4bit color
'return: the value of a 32bit color
FUNCTION ctorgb& (c AS _BYTE)
SELECT CASE c
    CASE 0
        ctorgb = 4278190080
    CASE 1
        ctorgb = 4278190248
    CASE 2
        ctorgb = 4278233088
    CASE 3
        ctorgb = 4278233256
    CASE 4
        ctorgb = 4289200128
    CASE 5
        ctorgb = 4289200296
    CASE 6
        ctorgb = 4289221632
    CASE 7
        ctorgb = 4289243304
    CASE 8
        ctorgb = 4283716692
    CASE 9
        ctorgb = 4283716860
    CASE 10
        ctorgb = 4283759700
    CASE 11
        ctorgb = 4283759868
    CASE 12
        ctorgb = 4294726740
    CASE 13
        ctorgb = 4294726908
    CASE 14
        ctorgb = 4294769748
    CASE 15
        ctorgb = 4294769916
    CASE ELSE
        ctorgb = 4278190080
END SELECT
END FUNCTION

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

'converts an angle from degrees to radians
'parameter: an angle in degrees
'return: an andle in radians
FUNCTION degtorad! (d AS SINGLE)
degtorad = d * Pi / 180
END FUNCTION

'simulates a dice roll
'parameter: number of sides on the dice
'return: the result of the roll
FUNCTION dice& (sides AS LONG)
dice = INT(RND * sides + 1)
END FUNCTION

'returns the distance between 2 points on a plane
'parameter: the x coordinate of point 1
'parameter: the y coordinate of point 1
'parameter: the x coordinate of point 2
'parameter: the y coordinate of point 2
'return: the distance
FUNCTION distance## (x1 AS LONG, y1 AS LONG, x2 AS LONG, y2 AS LONG)
distance = SQR(((x1 - x2) ^ 2) + ((y1 - y2) ^ 2))
END FUNCTION

'finds the file title in a file name
'parameter: the file name
'return: the file title
FUNCTION filetitle$ (filename AS STRING)
DIM findslash AS LONG
DIM slash AS STRING
IF INSTR(_OS$, "[WINDOWS]") THEN
    slash = CHR$(92)
ELSE
    slash = CHR$(47)
END IF
FOR findslash = LEN(filename) TO 1 STEP -1
    IF MID$(filename, findslash, 1) = slash OR findslash = 1 THEN
        filetitle$ = remfilesuffix$(RIGHT$(filename, LEN(filename) - findslash))
        EXIT FUNCTION
    END IF
NEXT findslash
END FUNCTION

'finds the file type in a file name
'parameter: the file name
'return: the file type
FUNCTION filetype$ (filename AS STRING)
DIM finddot AS LONG
FOR finddot = LEN(filename) TO 1 STEP -1
    IF MID$(filename, finddot, 1) = CHR$(46) THEN
        filetype$ = RIGHT$(filename, LEN(filename) - finddot + 1)
        EXIT FUNCTION
    END IF
NEXT finddot
END FUNCTION

'calculates the default fps
'return: the fps
FUNCTION getdefaultfps%
DIM eds AS LONG
REDIM fpss(255) AS LONG
eds = EnumDisplaySettingsA&(0, 0, _OFFSET(lpDevMode))
Refreshrate = _ROUND(lpDevMode.dmDisplayFrequency)
IF Refreshrate MOD 2 THEN Refreshrate = Refreshrate + 1
IF Refreshrate = 0 THEN Refreshrate = REFRESHRATE_DEFAULT
IF Refreshrate < 10 THEN Refreshrate = 10
CALL validfps(fpss())
getdefaultfps = closestelement((Refreshrate / 2), fpss())
END FUNCTION

'determines whether a point is on a box or not
'parameter: the x coordinate of the point
'parameter: the y coordinate of the point
'parameter: the x coordinate of the upper left corner of box
'parameter: the y coordinate of the upper left corner of box
'parameter: the x coordinate of the lower right corner of box
'parameter: the y coordinate of the lower right corner of box
'return: whether the point is on it or not
FUNCTION isonbox` (x AS LONG, y AS LONG, x1 AS LONG, y1 AS LONG, x2 AS LONG, y2 AS LONG)
isonbox = -1
IF x < x1 OR x > x2 THEN isonbox = 0
IF y < y1 OR y > y2 THEN isonbox = 0
END FUNCTION

'calculates the maximum characters for a textbox
'paramter: the width in pixels of the textbox
'return: the maximum characters
FUNCTION maxchars~% (width AS _UNSIGNED INTEGER)
IF width = 0 THEN width = SCRX - 4
maxchars = INT(width / _FONTWIDTH) - 2
END FUNCTION

'calculates the midpoint of 2 values
'parameter: the first value
'parameter: the second value
'return: the midpoint
FUNCTION midpoint## (p1 AS LONG, p2 AS LONG)
midpoint = (p1 + p2) / 2
END FUNCTION

'determines the minimum value for a particular stat of a particular race
'parameter: the string of the race
'parameter: the number of the stat in primestat()
'return: the minumum value
FUNCTION minprimebasestat%% (race AS STRING, stat AS _UNSIGNED _BYTE)
minprimebasestat = 3
SELECT CASE race
    CASE "Dwarf"
        SELECT CASE stat
            CASE 1
                minprimebasestat = minprimebasestat + 1
            CASE 2
                minprimebasestat = minprimebasestat + 1
            CASE 3
                minprimebasestat = minprimebasestat - 1
            CASE 4
                minprimebasestat = minprimebasestat - 1
            CASE 5
                minprimebasestat = minprimebasestat + 1
            CASE 6
                minprimebasestat = minprimebasestat - 1
        END SELECT
    CASE "Elf"
        SELECT CASE stat
            CASE 1
                minprimebasestat = minprimebasestat - 1
            CASE 2
                minprimebasestat = minprimebasestat - 1
            CASE 3
                minprimebasestat = minprimebasestat + 1
            CASE 4
                minprimebasestat = minprimebasestat + 1
            CASE 5
                minprimebasestat = minprimebasestat - 1
            CASE 6
                minprimebasestat = minprimebasestat + 1
        END SELECT
END SELECT
END FUNCTION

'determines the zoom aspect of a monster sprite
'parameter: the range of ages for the monster
'parameter: the age of the monster
'return: the zoom aspect
FUNCTION monsterzoom! (agerange AS RANGE, age AS LONG)
DIM spread AS LONG
DIM midage AS DOUBLE
DIM normality AS DOUBLE
DIM offness AS DOUBLE
spread = agerange.max - agerange.min
midage = midpoint(agerange.min, agerange.max)
offness = age - midage
normality = offness / spread
monsterzoom = 100 + (normality * 100)
END FUNCTION

'creates buttons for the new game menu
'parameter: the number of the window sending the request
'parameter: the completion value of the last window
'parameter: the completion value of the next window
'return: the status of the button system
FUNCTION newgamemenubuttons%% (frame AS _BYTE, lastframe AS _BYTE, nextframe AS _BYTE, frames() AS STRING)
DIM lastframename AS STRING
DIM nextframename AS STRING
IF frame > 1 THEN lastframename = frames(frame - 1)
IF frame < 8 THEN nextframename = frames(frame + 1)
IF frame = 8 THEN lastframename = "REVISE"
SELECT CASE lastframe
    CASE 0
        LINE (2, 22)-STEP(84, 20), ctorgb(8), B
        COLOR ctorgb(8)
        _PRINTSTRING (2 + ((84 - (LEN(lastframename) * 8)) / 2), 25), lastframename
    CASE 1
        IF isonbox(Mousedata(1), Mousedata(2), 2, 22, 86, 42) THEN
            LINE (2, 22)-STEP(84, 20), ctorgb(7), BF
            LINE (2, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(0)
            _PRINTSTRING (2 + ((84 - (LEN(lastframename$) * 8)) / 2), 25), lastframename
        ELSE
            LINE (2, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(15)
            _PRINTSTRING (2 + ((84 - (LEN(lastframename) * 8)) / 2), 25), lastframename
        END IF
        IF Click AND (NOT Newgamemenuoldclick) THEN
            IF isonbox(Mousedata(1), Mousedata(2), 2, 22, 86, 42) THEN Newgamemenulast = -1
        END IF
        IF Click AND Newgamemenuoldclick THEN
            IF NOT isonbox(Mousedata(1), Mousedata(2), 2, 22, 86, 42) THEN Newgamemenulast = 0
        END IF
        IF (NOT Click) AND Newgamemenuoldclick THEN
            IF Newgamemenulast THEN
                newgamemenubuttons = -1
                Newgamemenulast = 0
                COLOR ctorgb(15)
                EXIT FUNCTION
            END IF
        END IF
END SELECT
SELECT CASE nextframe
    CASE 0
        LINE (554, 22)-STEP(84, 20), ctorgb(8), B
        COLOR ctorgb(8)
        _PRINTSTRING (554 + ((84 - (LEN(nextframename) * 8)) / 2), 25), nextframename
    CASE 1
        IF isonbox(Mousedata(1), Mousedata(2), 554, 22, 638, 42) THEN
            LINE (554, 22)-STEP(84, 20), ctorgb(7), BF
            LINE (554, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(0)
            _PRINTSTRING (554 + ((84 - (LEN(nextframename) * 8)) / 2), 25), nextframename
        ELSE
            LINE (554, 22)-STEP(84, 20), ctorgb(15), B
            COLOR ctorgb(15)
            _PRINTSTRING (554 + ((84 - (LEN(nextframename) * 8)) / 2), 25), nextframename
        END IF
        IF Click AND (NOT Newgamemenuoldclick) THEN
            IF isonbox(Mousedata(1), Mousedata(2), 554, 22, 638, 42) THEN Newgamemenunext = -1
        END IF
        IF Click AND Newgamemenuoldclick THEN
            IF NOT isonbox(Mousedata(1), Mousedata(2), 554, 22, 638, 42) THEN Newgamemenunext = 0
        END IF
        IF (NOT Click) AND Newgamemenuoldclick THEN
            IF Newgamemenunext THEN
                newgamemenubuttons = 1
                Newgamemenunext = 0
                COLOR ctorgb(15)
                EXIT FUNCTION
            END IF
        END IF
END SELECT
Newgamemenuoldclick = Click
COLOR ctorgb(15)
END FUNCTION

'calculates the x coordinate of a point on a circle
'parameter: the x coordinate of the center of the circle
'parameter: the y coordinate of the center of the circle
'parameter: the radius of the circle
'parameter: the angle (in radians) of the point from center of the circle
'return: the x coordinate of the point on the circumference
FUNCTION pointoncirclex! (x AS SINGLE, y AS SINGLE, r AS LONG, a AS SINGLE)
pointoncirclex = x + (r * COS(a))
END FUNCTION

'calculates the y coordinate of a point on a circle
'parameter: the x coordinate of the center of the circle
'parameter: the y coordinate of the center of the circle
'parameter: the radius of the circle
'parameter: the angle (in radians) of the point from center of the circle
'return: the y coordinate of the point on the circumference
FUNCTION pointoncircley! (x AS SINGLE, y AS SINGLE, r AS LONG, a AS SINGLE)
pointoncircley = y + (r * SIN(a))
END FUNCTION

'converts the location of the prime stat on the base prime stat hexagon to the location of it in the array
'parameter: the number of the stat on the hexagon (by angle)
'return: the location of the same stat in primestat()
FUNCTION primestathextoloc~%% (hex AS _BYTE)
SELECT CASE hex
    CASE 1
        primestathextoloc = 6
    CASE 2
        primestathextoloc = 3
    CASE 3
        primestathextoloc = 2
    CASE 4
        primestathextoloc = 1
    CASE 5
        primestathextoloc = 5
    CASE 6
        primestathextoloc = 4
END SELECT
END FUNCTION

'finds the location of a race in the races array
'parameter: the string of the race being searched for
'parameter: the array races$()
'return: the location of the race in the array, else -1
FUNCTION raceloc%% (race AS STRING, races() AS STRING)
FOR raceloc = 1 TO RACES_NUM
    IF races(raceloc) = race THEN EXIT FUNCTION
NEXT raceloc
raceloc = -1
END FUNCTION

'converts an angle from radians to degrees
'parameter: an angle in radians
'return: the angle in degrees
FUNCTION radtodeg! (r AS SINGLE)
radtodeg = r * 180 / Pi
END FUNCTION

'picks a number from a range
'parameter: the range
'return: a number within the range
FUNCTION rangepick& (set AS RANGE)
rangepick = INT(RND * (set.max - set.min) + set.min)
END FUNCTION

'removes the file suffix from a file name string
'parameter: the file name
'return: the filename without the file suffix
FUNCTION remfilesuffix$ (filename AS STRING)
DIM finddot AS LONG
remfilesuffix$ = filename
FOR finddot = LEN(filename) TO 1 STEP -1
    IF MID$(filename, finddot, 1) = CHR$(46) THEN
        remfilesuffix$ = LEFT$(filename, finddot - 1)
        EXIT FUNCTION
    END IF
NEXT finddot
END FUNCTION

'sums the minimum prime stats for a particular race
'parameter: the race of the profile
'return: the sum of the minimum prime stats
FUNCTION summinprimebasestats~%% (race AS STRING)
DIM addminprimestat AS _UNSIGNED _BYTE
FOR addminprimestat = 1 TO PRIMESTATS_NUM
    summinprimebasestats = summinprimebasestats + minprimebasestat(race, addminprimestat)
NEXT addminprimestat
END FUNCTION

'sums the prime stats of a profile
'parameter: the array of prime stats
'parameter: the remaining allocatable stats
'return: the sum of the prime stats
'precondition: primestat() must be dimensioned to an array of singles of appropriate size
FUNCTION sumprimebasestats~%% (primestat() AS _BYTE, allocatestats AS _UNSIGNED _BYTE)
DIM addprimestat AS _UNSIGNED _BYTE
sumprimebasestats = allocatestats
FOR addprimestat = 1 TO PRIMESTATS_NUM
    sumprimebasestats = sumprimebasestats + primestat(addprimestat)
NEXT addprimestat
END FUNCTION

'trims the beginning and end of a string for spaces
'parameter: the string to be trimmed
'return: the trimmed string
FUNCTION TRIM$ (s AS STRING)
TRIM$ = LTRIM$(RTRIM$(s))
END FUNCTION

'trims a number to a certain number of decimal places
'parameter: the number to be trimmed
'parameter: the number of decimal places desired
'return: the trimmed number
FUNCTION trimdec## (num AS _FLOAT, dec AS _UNSIGNED _BYTE)
trimdec = INT(num * (dec * 10)) / (dec * 10)
END FUNCTION

'trims the beginning and end of a number for spaces
'parameter: the number to be trimmed
'return: the trimmed number converted to a string
FUNCTION TRIMnum$ (n AS SINGLE)
TRIMnum$ = LTRIM$(RTRIM$(STR$(n)))
END FUNCTION

'determines whether to update the screen or not
'return: whether to update the screen or not
FUNCTION updatescreen`
Displaytimer = TIMER(.001)
IF oldDisplaytimer > Displaytimer THEN oldDisplaytimer = 0
IF Displaytimer - oldDisplaytimer >= 1 / setting.fps THEN
    updatescreen = -1
    oldDisplaytimer = TIMER(.001)
END IF
END FUNCTION

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



''''''''''''''''''''''''''''LIBRARIES'''''''''''''''''''''''''''

''QB64 Animation Library by Gorlock
'safgdg'$INCLdtyUDE:'lib\animation.bi'

''QB64 Button Library by Gorlock
'gdfsgd'$INCdgjLUDE:'lib\button.bi'

'QB64 Sprite Library by Terry Ritchie
'$INCLUDE:'lib\sprite.bi_bak'

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
