DECLARE SUB ANIMATIONFREE (handle AS INTEGER)
DECLARE SUB STARTANIMATION (handle AS INTEGER)
DECLARE SUB STOPANIMATION (handle AS INTEGER)
DECLARE SUB UPDATEANIMATION (handle AS INTEGER)

DECLARE FUNCTION ANIMATIONSTATUS%% (handle AS INTEGER)
DECLARE FUNCTION ANIMATIONTIME! (handle AS INTEGER)
DECLARE FUNCTION ANIMATIONX! (handle AS INTEGER)
DECLARE FUNCTION ANIMATIONY! (handle AS INTEGER)
DECLARE FUNCTION NEWANIMATION% (x1 AS SINGLE, y1 AS SINGLE, x2 AS SINGLE, y2 AS SINGLE, time AS SINGLE)
DECLARE FUNCTION VALIDANIMATION` (handle AS INTEGER)

TYPE animation
    inuse AS _BYTE
    status AS _BYTE
    x1 AS SINGLE
    y1 AS SINGLE
    x2 AS SINGLE
    y2 AS SINGLE
    speed AS SINGLE
    slope AS SINGLE
    x AS LONG
    y AS LONG
    time AS SINGLE
    timer AS LONG
    oldTIMER AS _FLOAT
END TYPE

CONST FALSE = 0
CONST TRUE = NOT FALSE

CONST ANIMATION_UNCREATED = FALSE
CONST ANIMATION_CREATED = 1
CONST ANIMATION_STARTED = 2
CONST ANIMATION_PAUSED = 3
CONST ANIMATION_FINISHED = 4

OPTION BASE 1

REDIM animation(0) AS animation






SCREEN 12

DIM a AS INTEGER
DIM b AS INTEGER
DIM c AS INTEGER
DIM g AS _BYTE

a = NEWANIMATION(100, 100, 300, 213, 2)
b = NEWANIMATION(300, 213, 500, 80, 3)
c = NEWANIMATION(639, 479, 50, 400, 5)

STARTANIMATION a
STARTANIMATION c

DO

    _LIMIT 60
    CLS
    g = ANIMATIONSTATUS(a)
    h = ANIMATIONSTATUS(b)
    i = ANIMATIONSTATUS(c)

    IF g = ANIMATION_FINISHED AND h = ANIMATION_CREATED THEN
        STARTANIMATION b
        UPDATEANIMATION b
    END IF

    PSET (animation(a).x1, animation(a).y1), 7
    PSET (animation(a).x2, animation(a).y2), 7
    PSET (animation(b).x2, animation(b).y2), 7
    PSET (animation(c).x1, animation(c).y1), 7
    PSET (animation(c).x2, animation(c).y2), 7

    IF g = ANIMATION_FINISHED THEN
        CIRCLE (ANIMATIONX(b), ANIMATIONY(b)), 20, 15
    ELSE
        CIRCLE (ANIMATIONX(a), ANIMATIONY(a)), 20, 15
    END IF

    CIRCLE (ANIMATIONX(c), ANIMATIONY(c)), 10, 15

    _DISPLAY

LOOP UNTIL g = ANIMATION_FINISHED AND h = ANIMATION_FINISHED AND i = ANIMATION_FINISHED

ANIMATIONFREE a
ANIMATIONFREE b
ANIMATIONFREE c

END







SUB ANIMATIONFREE (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT SUB
IF animation(handle).timer THEN TIMER(animation(handle).timer) FREE
IF handle = UBOUND(animation) THEN
    REDIM _PRESERVE animation(UBOUND(animation) - 1) AS animation
ELSE
    animation(handle).inuse = 0
END IF
END SUB

SUB STARTANIMATION (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT SUB
animation(handle).status = 2
ON TIMER(animation(handle).timer, .05) UPDATEANIMATION handle
TIMER(animation(handle).timer) ON
animation(handle).oldTIMER = TIMER
END SUB

SUB STOPANIMATION (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT SUB
animation(handle).status = 3
TIMER(animation(handle).timer) OFF
END SUB

SUB UPDATEANIMATION (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT SUB
IF animation(handle).time >= animation(handle).speed THEN
    STOPANIMATION handle
    animation(handle).status = 4
    EXIT SUB
END IF
IF TIMER < animation(handle).oldTIMER THEN animation(handle).oldTIMER = 0
animation(handle).time = animation(handle).time + (TIMER - animation(handle).oldTIMER)
animation(handle).oldTIMER = TIMER
IF animation(handle).time > animation(handle).speed THEN animation(handle).time = animation(handle).speed
animation(handle).x = animation(handle).x1 + animation(handle).time / animation(handle).speed * (animation(handle).x2 - animation(handle).x1)
animation(handle).y = animation(handle).slope * (animation(handle).x - animation(handle).x1) + animation(handle).y1
END SUB

FUNCTION ANIMATIONSTATUS%% (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT FUNCTION
ANIMATIONSTATUS = animation(handle).status
END FUNCTION

FUNCTION ANIMATIONTIME! (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT FUNCTION
ANIMATIONTIME = animation(handle).time
END FUNCTION

FUNCTION ANIMATIONX! (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT FUNCTION
ANIMATIONX = animation(handle).x
END FUNCTION

FUNCTION ANIMATIONY! (handle AS INTEGER)
SHARED animation() AS animation
IF NOT VALIDANIMATION(handle) THEN EXIT FUNCTION
ANIMATIONY = animation(handle).y
END FUNCTION

FUNCTION NEWANIMATION% (x1 AS SINGLE, y1 AS SINGLE, x2 AS SINGLE, y2 AS SINGLE, speed AS SINGLE)
DIM findfreeanimation AS INTEGER
SHARED animation() AS animation
FOR findfreeanimation = 1 TO UBOUND(animation)
    IF NOT animation(findfreeanimation).inuse THEN
        NEWANIMATION = findfreeanimation
        EXIT FOR
    END IF
NEXT findfreeanimation
IF NOT NEWANIMATION THEN
    REDIM _PRESERVE animation(UBOUND(animation) + 1) AS animation
    NEWANIMATION = UBOUND(animation)
END IF
animation(NEWANIMATION).inuse = -1
animation(NEWANIMATION).status = 1
animation(NEWANIMATION).x1 = x1
animation(NEWANIMATION).y1 = y1
animation(NEWANIMATION).x2 = x2
animation(NEWANIMATION).y2 = y2
animation(NEWANIMATION).speed = speed
animation(NEWANIMATION).slope = (y2 - y1) / (x2 - x1)
animation(NEWANIMATION).x = x1
animation(NEWANIMATION).y = y1
animation(NEWANIMATION).time = 0
animation(NEWANIMATION).timer = _FREETIMER
END FUNCTION

FUNCTION VALIDANIMATION` (handle AS INTEGER)
SHARED animation() AS animation
IF handle > UBOUND(animation) OR handle = 0 THEN EXIT FUNCTION
IF NOT animation(handle).inuse THEN EXIT FUNCTION
VALIDANIMATION = -1
END FUNCTION