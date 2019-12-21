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