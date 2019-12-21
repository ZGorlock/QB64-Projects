'finds the element of the array closest to the reference
'note: if multiple elements are equidistant from the reference the earlier element in the array takes precedence
'precondition: array() is not empty
'parameter: the reference
'parameter: the array
'return: the location of the closest element within the array
FUNCTION closestelement& (reference AS LONG, array() AS LONG)
DIM closestloc AS LONG
DIM closestval AS LONG
DIM getcloseness AS LONG
closestval = LONG_MAX
FOR getcloseness = 1 TO UBOUND(array)
    IF ABS(array(getcloseness) - reference) < closestval THEN
        closestval = ABS(array(getcloseness) - reference)
        closestloc = getcloseness
    END IF
NEXT getcloseness
closestelement = array(closestloc)
END FUNCTION