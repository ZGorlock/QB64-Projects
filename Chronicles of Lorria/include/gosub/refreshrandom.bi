'refreshes the randomization
refreshrandom:
DIM refreshrandomcount AS INTEGER
DIM refreshrandomwait AS INTEGER
refreshrandomcount = refreshrandomcount + 1
IF refreshrandomcount = refreshrandomwait OR refreshrandomwait = 0 THEN
    RANDOMIZE TIMER
    refreshrandomwait = INT(RND * 32767 + 1)
    refreshrandomcount = 0
END IF
RETURN