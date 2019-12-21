'determines the zoom aspect of a monster sprite
'parameter: the range of ages for the monster
'parameter: the age of the monster
'return: the zoom aspect
FUNCTION monsterzoom! (agerange AS RANGE, age AS LONG)
DIM spread AS LONG
DIM midage AS DOUBLE
DIM normality AS DOUBLE
DIM offness AS DOUBLE
spread = agerange.max - agerange.min
midage = midpoint(agerange.min, agerange.max)
offness = age - midage
normality = offness / spread
monsterzoom = 100 + (normality * 100)
END FUNCTION