RANDOMIZE TIMER
DIM a AS LONG
a = INT(RND * 65535 + 1)
a$ = LTRIM$(RTRIM$(HEX$(a)))
a$ = STRING$(4 - LEN(a$), 48) + a$
_CLIPBOARD$ = a$
SYSTEM 15