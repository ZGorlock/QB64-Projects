'sorts an array of string using the insertion sort method
'parameter: an array of strings
SUB sort_insertion_str (array() AS STRING)
DIM sortx AS LONG
DIM sorty AS LONG
FOR sortx = 1 TO UBOUND(array)
    IF array(sortx) = "" THEN EXIT FOR
    FOR sorty = sortx TO 1 STEP -1
        IF array(sorty) < array(sorty - 1) THEN SWAP array(sorty), array(sorty - 1)
    NEXT sorty
NEXT sortx
END SUB