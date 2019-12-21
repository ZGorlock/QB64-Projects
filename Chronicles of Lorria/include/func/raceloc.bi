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