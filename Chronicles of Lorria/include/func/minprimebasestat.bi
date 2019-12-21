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