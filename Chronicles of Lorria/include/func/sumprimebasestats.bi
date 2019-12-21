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