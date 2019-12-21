DECLARE SUB GENERATETRANSLAYER (handle AS INTEGER)
DECLARE SUB LAYERBRINGTOFRONT (handle AS INTEGER)
DECLARE SUB LAYERFADE (handle AS INTEGER, trans AS _UNSIGNED _BYTE, speed AS INTEGER)
DECLARE SUB LAYERFADESTART (handle AS INTEGER)
DECLARE SUB LAYERFADESTOP (handle AS INTEGER)
DECLARE SUB LAYERFADEUPDATE (handle AS INTEGER)
DECLARE SUB LAYERFREE (handle AS INTEGER)
DECLARE SUB LAYERHIDE (handle AS INTEGER)
DECLARE SUB LAYERPUT (x AS LONG, y AS LONG, dest AS LONG, handle AS INTEGER)
DECLARE SUB LAYERSENDTOBACK (handle AS INTEGER)
DECLARE SUB LAYERSETQUEUE (handle AS INTEGER, queue AS INTEGER)
DECLARE SUB LAYERSETTRANSPARENCY (handle AS INTEGER, trans AS _UNSIGNED _BYTE)
DECLARE SUB LAYERSHOW (handle AS INTEGER)
DECLARE SUB PRINTLAYER (handle AS INTEGER)
DECLARE SUB SWAPLAYER (handle1 AS INTEGER, handle2 AS INTEGER)
DECLARE FUNCTION LAYER% (handle AS INTEGER)
DECLARE FUNCTION LAYERDESCRIPTION$ (handle AS INTEGER)
DECLARE FUNCTION LAYERDEST& (handle AS INTEGER)
DECLARE FUNCTION LAYERQUEUE& (handle AS INTEGER)
DECLARE FUNCTION LAYERSTATUS%% (handle AS INTEGER)
DECLARE FUNCTION LAYERTRANSPARENCY~%% (handle AS INTEGER)
DECLARE FUNCTION LAYERX! (handle AS INTEGER)
DECLARE FUNCTION LAYERY! (handle AS INTEGER)
DECLARE FUNCTION NEWLAYER% (x AS LONG, y AS LONG, description AS STRING, mother AS INTEGER, status AS _BYTE)
DECLARE FUNCTION VALIDLAYER` (handle AS INTEGER)

TYPE LAYER
    inuse AS _BYTE
    layer AS LONG
    layerbak AS LONG
    status AS _BYTE
    queue AS INTEGER
    x AS SINGLE
    y AS SINGLE
    trans AS _UNSIGNED _BYTE
    fade AS INTEGER
    dest AS LONG
    timer AS LONG
    description AS STRING * 32
END TYPE

CONST LAYER_ALLLAYERS = TRUE
CONST LAYER_FULLTRANSPARENCY = 0
CONST LAYER_HIDE = FALSE
CONST LAYER_NOTRANSPARENCY = 255
CONST LAYER_SHOW = TRUE

OPTION BASE 1

REDIM SHARED fonts(0) AS LONG

REDIM stacklayers(0) AS INTEGER
REDIM layers(0) AS LAYER