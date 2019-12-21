'finds the index of an element in an array of integers
'parameter: an array of integers
'parameter: the integer to search for
'return: the index of the first element matching the referrence
FUNCTION arrayloc_int& (array() AS INTEGER, reference AS INTEGER)
FOR arrayloc_int = LBOUND(array) TO UBOUND(array)
    IF array(checkarray) = reference THEN EXIT FUNCTION
NEXT arrayloc_int
arrayloc_int = 0
END FUNCTION