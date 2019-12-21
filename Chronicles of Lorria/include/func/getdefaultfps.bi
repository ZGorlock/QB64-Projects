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