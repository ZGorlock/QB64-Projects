'sums the minimum prime stats for a particular race
'parameter: the race of the profile
'return: the sum of the minimum prime stats
FUNCTION summinprimebasestats~%% (race AS STRING)
DIM addminprimestat AS _UNSIGNED _BYTE
FOR addminprimestat = 1 TO PRIMESTATS_NUM
    summinprimebasestats = summinprimebasestats + minprimebasestat(race, addminprimestat)
NEXT addminprimestat
END FUNCTION