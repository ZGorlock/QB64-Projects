'determines whether to update the screen or not
'return: whether to update the screen or not
FUNCTION updatescreen`
Displaytimer = TIMER(.001)
IF oldDisplaytimer > Displaytimer THEN oldDisplaytimer = 0
IF Displaytimer - oldDisplaytimer >= 1 / setting.fps THEN
    updatescreen = -1
    Updatecursor = -1
    oldDisplaytimer = TIMER(.001)
END IF
END FUNCTION