'checks for the activation of hotkeys
checkhotkeys:
IF Hotkeys.help = TRUE THEN
    IF TIMER < Hotkeys.help_clock THEN Hotkeys.help_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.help_clock THEN
        Hotkeys.help_clock = TIMER
        GOSUB help
    END IF
    Hotkeys.help = FALSE
END IF
IF Hotkeys.close = TRUE THEN
    IF TIMER < Hotkeys.close_clock THEN Hotkeys.close_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.close_clock THEN
        Hotkeys.close_clock = TIMER
        GOSUB cleanup
    END IF
    Hotkeys.close = FALSE
END IF
IF Hotkeys.screenshot = TRUE THEN
    IF TIMER < Hotkeys.screenshot_clock THEN Hotkeys.screenshot_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.screenshot_clock THEN
        Hotkeys.screenshot_clock = TIMER
        SCREENSHOT SCREENSHOT_MONITOR, Ssloc, ""
    END IF
    Hotkeys.screenshot = FALSE
END IF
IF Hotkeys.windowshot = TRUE THEN
    IF TIMER < Hotkeys.windowshot_clock THEN Hotkeys.windowshot_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.windowshot_clock THEN
        Hotkeys.windowshot_clock = TIMER
        SCREENSHOT SCREENSHOT_WINDOW, Ssloc, ""
    END IF
    Hotkeys.screenshot = FALSE
END IF
IF Hotkeys.fullscreen = TRUE THEN
    IF TIMER < Hotkeys.fullscreen_clock THEN Hotkeys.fullscreen_clock = 0
    IF TIMER - HOTKEYWAIT >= Hotkeys.fullscreen_clock THEN
        Hotkeys.fullscreen_clock = TIMER
        FULLSCREEN
    END IF
    Hotkeys.fullscreen = FALSE
END IF
RETURN