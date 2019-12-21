_TITLE "Journey Through The Digestive System"
SCREEN 13
bgm = _SNDOPEN("journey through the digestive system\audio\bgm.ogg", "SYNC, PAUSE")
event = _SNDOPEN("journey through the digestive system\audio\event.ogg", "SYNC")
turn = _SNDOPEN("journey through the digestive system\audio\turn.ogg", "SYNC")
win = _SNDOPEN("journey through the digestive system\audio\win.ogg")
title = _LOADIMAGE("journey through the digestive system\graphics\title.png")
board = _LOADIMAGE("journey through the digestive system\graphics\board.png")
REDIM questions$(64)
REDIM answers$(64)
REDIM chance$(16)
REDIM hardquestions$(8)
REDIM hardanswers$(8)
REDIM spotlocx(64)
REDIM spotlocy(64)
REDIM spotlocx$(64)
REDIM spotlocy$(64)
REDIM teamnames$(16)
REDIM teamcolors(16)
REDIM teamscore(16)
REDIM teamorder(16)
REDIM teamroster$(16)
REDIM spotvalue(64)
OPEN "journey through the digestive system\data\questions.txt" FOR INPUT AS #1
FOR questions = 1 TO 64
    LINE INPUT #1, questions$(questions)
NEXT questions
CLOSE #1
OPEN "journey through the digestive system\data\answers.txt" FOR INPUT AS #1
FOR answers = 1 TO 64
    LINE INPUT #1, answers$(answers)
NEXT answers
CLOSE #1
OPEN "journey through the digestive system\data\chance.txt" FOR INPUT AS #1
FOR chance = 1 TO 16
    LINE INPUT #1, chance$(chance)
NEXT chance
CLOSE #1
OPEN "journey through the digestive system\data\hardquestions.txt" FOR INPUT AS #1
FOR hardquestions = 1 TO 8
    LINE INPUT #1, hardquestions$(hardquestions)
NEXT hardquestions
CLOSE #1
OPEN "journey through the digestive system\data\hardanswers.txt" FOR INPUT AS #1
FOR hardanswers = 1 TO 8
    LINE INPUT #1, hardanswers$(hardanswers)
NEXT hardanswers
CLOSE #1
OPEN "journey through the digestive system\data\spotlocx.txt" FOR INPUT AS #1
FOR spotlocxget = 1 TO 33
    LINE INPUT #1, spotlocx$(spotlocxget)
    spotlocx(spotlocxget) = VAL(spotlocx$(spotlocxget))
NEXT spotlocxget
CLOSE #1
OPEN "journey through the digestive system\data\spotlocy.txt" FOR INPUT AS #1
FOR spotlocyget = 1 TO 33
    LINE INPUT #1, spotlocy$(spotlocyget)
    spotlocy(spotlocyget) = VAL(spotlocy$(spotlocyget))
NEXT spotlocyget
CLOSE #1
SCREEN 0
SCREEN 12
_SCREENMOVE _MIDDLE
_SNDLOOP bgm
DO
    teams$ = ""
    DO
        _LIMIT 64
        CLS
        PRINT "Number of teams: "; teams$
        GOSUB controls
        IF k$ >= CHR$(48) AND k$ <= CHR$(57) THEN teams$ = teams$ + k$
        IF k$ = CHR$(8) THEN teams$ = MID$(teams$, 1, (LEN(teams$) - 1))
        IF LEN(teams$) > 2 THEN teams$ = MID$(teams$, 1, (LEN(teams$) - 1))
        _DISPLAY
    LOOP UNTIL k$ = CHR$(13)
    _SNDPLAY event
    teams = VAL(teams$)
    IF teams > 0 AND teams <= 16 THEN EXIT DO
LOOP
teamon = 1
DO
    _LIMIT 64
    CLS
    PRINT "Enter your team names..."
    PRINT
    FOR namer = 1 TO teams
        IF namer = teamon THEN
            COLOR 0, 15
        ELSE
            COLOR 15, 0
        END IF
        PRINT "Team"; RTRIM$(STR$(namer));
        COLOR 15, 0
        PRINT ": "; teamnames$(namer)
    NEXT namer
    GOSUB controls
    IF k$ >= CHR$(32) AND k$ <= CHR$(126) THEN teamnames$(teamon) = teamnames$(teamon) + k$
    IF k$ = CHR$(8) THEN teamnames$(teamon) = MID$(teamnames$(teamon), 1, (LEN(teamnames$(teamon)) - 1))
    IF k$ = CHR$(13) AND teamnames$(teamon) <> "" THEN
        teamon = teamon + 1
        _SNDPLAY event
    END IF
    _DISPLAY
LOOP UNTIL teamon = teams + 1
block$ = SPACE$(160)
blockette$ = SPACE$(25)
turner = 1
spotvalue(1) = teams
FOR starter = 1 TO teams
    teamscore(starter) = 1
    teamorder(starter) = starter
    teamroster$(starter) = teamnames$(starter)
NEXT starter
teamcolors(1) = 12
teamcolors(2) = 10
teamcolors(3) = 9
teamcolors(4) = 14
teamcolors(5) = 15
teamcolors(6) = 13
teamcolors(7) = 11
teamcolors(8) = 4
teamcolors(9) = 2
teamcolors(10) = 1
teamcolors(11) = 6
teamcolors(12) = 7
teamcolors(13) = 5
teamcolors(14) = 3
teamcolors(15) = 8
teamcolors(16) = 0
full = 0
DO
    _LIMIT 32
    loops&& = loops&& + 1
    GOSUB turner
    GOSUB graphics
    IF loops&& = 1 THEN GOSUB selector
    GOSUB controls
    GOSUB endcheck
LOOP

controls:
k$ = INKEY$
IF k$ = (CHR$(0) + CHR$(62)) THEN
    CLEAR
    SYSTEM
END IF
IF k$ = (CHR$(0) + CHR$(133)) THEN
    IF full = 1 THEN
        _SNDPLAY event
        _FULLSCREEN _OFF
        full = 0
    ELSE
        _SNDPLAY event
        _FULLSCREEN
        full = 1
    END IF
END IF
RETURN

diceroll:
DO
    _LIMIT 8
    RANDOMIZE TIMER
    diceroll = INT(RND * 6 + 1)
    type$ = "---DICE ROLL---"
    text$ = "rolling dice:" + STR$(diceroll)
    GOSUB graphics
    GOSUB controls
LOOP UNTIL k$ = CHR$(32)
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = ""
GOSUB graphics
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = CHR$(32)
_SNDPLAY event
spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
teamscore(turner) = teamscore(turner) + diceroll
IF teamscore(turner) > 33 THEN teamscore(turner) = 33
spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
loops&& = 0
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = ""
GOSUB endcheck
IF didit = 0 THEN turner = turner + 1
didit = 0
loops&& = 0
RETURN

endcheck:
IF teamscore(turner) = 33 THEN GOSUB ender
RETURN

ender:
didit = 1
_SNDPAUSE bgm
RANDOMIZE TIMER
hardqa = INT(RND * 8 + 1)
finaltimer = 16
answerdisplay = 0
instructions = 0
DO
    _LIMIT 64
    CLS
    IF instructions = 0 THEN finaltext$ = "Anyone can answer this question, if the teams whos turn it is answers first they win. You will have 16 seconds to answer."
    IF instructions = 1 THEN finaltext$ = hardquestions$(hardqa)
    PRINT "---FINAL QUESTION---"
    PRINT
    PRINT finaltext$
    PRINT
    IF instructions = 1 THEN PRINT finaltimer
    PRINT
    IF finaltimer <= 0 THEN
        BEEP
        answerdisplay = 1
        finaltimer = 0
    END IF
    IF answerdisplay = 1 THEN PRINT hardanswers$(hardqa)
    IF instructions = 0 THEN
        _DISPLAY
        DO
            _LIMIT 64
            GOSUB controls
        LOOP UNTIL k$ = CHR$(32)
        _SNDPLAY event
        instructions = 1
        starttimer = TIMER
    END IF
    IF instructions = 1 AND answerdisplay = 0 THEN
        finaltimer = 16 - INT((TIMER - starttimer))
    END IF
    IF answerdisplay = 1 THEN
        _DISPLAY
        DO
            _LIMIT 64
            GOSUB controls
        LOOP UNTIL k$ = CHR$(122) OR k$ = CHR$(120)
        IF k$ = CHR$(122) THEN
            _SNDPLAY win
            wintext$ = "TEAM " + teamnames$(turner) + " WINS"
            wintextlen = LEN(wintext$)
            centerwintext = ((80 - wintextlen) / 2)
            DO
                _LIMIT 64
                GOSUB controls
            LOOP UNTIL k$ <> CHR$(32)
            DO
                _LIMIT 8
                CLS
                wintextcolor = wintextcolor + 1
                wintextcolor = wintextcolor MOD 16
                COLOR teamcolors(wintextcolor), 0
                LOCATE 12, centerwintext
                PRINT wintext$
                GOSUB controls
                _DISPLAY
            LOOP UNTIL k$ = CHR$(32)
            CLEAR
            SYSTEM
        END IF
        IF k$ = CHR$(120) THEN
            turner = turner + 1
            _SNDPLAY bgm
            EXIT DO
        END IF
        _SNDPLAY event
    END IF
    _DISPLAY
LOOP
RETURN

graphics:
CLS
PAINT (0, 0), 15
_PUTIMAGE (21, 3), title
_PUTIMAGE (379, 44), board
PSET (19, 1), 0
DRAW "R602 D38 L602 U38"
PSET (377, 42), 0
DRAW "R251 D404 L251 U404"
down$ = LTRIM$(RTRIM$(STR$((16 * (teams + 1)) + 5)))
PSET (0, 109), 0
DRAW "R202 D" + down$ + " L202 U" + down$
PSET (0, 448), 0
DRAW "R640"
LOCATE 8, 1
FOR filler = 1 TO (teams + 1)
    PRINT blockette$
NEXT filler
LOCATE 8, 1
PRINT "       SCOREBOARD"
FOR order = 1 TO teams
    teamscorer$ = LTRIM$(RTRIM$(STR$(teamscore(order))))
    IF LEN(teamscorer$) = 1 THEN teamscorer$ = "0" + teamscorer$
    COLOR teamcolors(order), 0
    PRINT CHR$(254); " - "; teamscorer$; " - ";
    IF turner = teamorder(order) THEN
        COLOR 0, 15
    ELSE
        COLOR 15, 0
    END IF
    PRINT teamroster$(order)
NEXT order
COLOR 0, 15
LOCATE 28, 1
PRINT type$
VIEW PRINT 29 TO 30
COLOR 15, 0
LOCATE 29, 1
PRINT block$
LOCATE 29, 1
PRINT ">"; text$
VIEW PRINT
GOSUB pieces
_DISPLAY
RETURN

pause1:
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = CHR$(32)
_SNDPLAY event
GOSUB endcheck
IF didit = 0 THEN turner = turner + 1
didit = 0
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = ""
RETURN

pause2:
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = CHR$(32)
_SNDPLAY event
type$ = "---ANSWER---"
text$ = answers$(qaselect)
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = ""
GOSUB graphics
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = CHR$(122) OR k$ = CHR$(120)
_SNDPLAY event
IF k$ = CHR$(122) THEN GOSUB diceroll
IF k$ = CHR$(120) THEN turner = turner + 1
DO
    _LIMIT 64
    GOSUB controls
LOOP UNTIL k$ = ""
RETURN

pieces:
FOR spots = 1 TO 33
    IF spotvalue(spots) > 0 THEN
        REDIM who(16)
        amount = 1
        FOR who = 1 TO teams
            IF teamscore(who) = spots THEN
                who(amount) = teamcolors(who)
                amount = amount + 1
            END IF
        NEXT who
        CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), 6, 0
        SELECT CASE spotvalue(spots)
            CASE 1
                FOR onecolor = 1 TO 5
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), onecolor, who(1)
                NEXT onecolor
            CASE 2
                FOR twocolor1 = 1 TO 3
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), twocolor1, who(1)
                NEXT twocolor1
                FOR twocolor2 = 1 TO 2
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), twocolor2, who(2)
                NEXT twocolor2
            CASE 3
                FOR threecolor1 = 1 TO 2
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), threecolor1, who(1)
                NEXT threecolor1
                FOR threecolor2 = 1 TO 2
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), threecolor2, who(2)
                NEXT threecolor2
                CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), 5, who(3)
            CASE 4
                FOR fourcolor = 1 TO 2
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), fourcolor, who(1)
                NEXT fourcolor
                CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), 3, who(2)
                CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), 4, who(3)
                CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), 5, who(4)
            CASE ELSE
                FOR filler = 1 TO 6
                    CIRCLE ((spotlocx(spots) + 379), (spotlocy(spots) + 44)), filler, 0
                NEXT filler
        END SELECT
    END IF
NEXT spots
RETURN

selector:
RANDOMIZE TIMER
typer = INT(RND * 3)
SELECT CASE typer
    CASE 0, 1
        RANDOMIZE TIMER
        qaselect = INT(RND * 64 + 1)
        type$ = "---QUESTION---"
        text$ = questions$(qaselect)
        GOSUB graphics
        GOSUB pause2
    CASE 2
        RANDOMIZE TIMER
        chancecard = INT(RND * 16 + 1)
        SELECT CASE chancecard
            CASE 2, 4, 6
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) + 1
                IF teamscore(turner) > 33 THEN teamscore(turner) = 33
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
            CASE 3, 5, 7
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) - 1
                IF teamscore(turner) < 1 THEN teamscore(turner) = 1
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
            CASE 8, 10, 15
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) + 2
                IF teamscore(turner) > 33 THEN teamscore(turner) = 33
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
            CASE 9, 11, 14
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) - 2
                IF teamscore(turner) < 1 THEN teamscore(turner) = 1
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
            CASE 12
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) + 3
                IF teamscore(turner) > 33 THEN teamscore(turner) = 33
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
            CASE 13, 16
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) - 1
                teamscore(turner) = teamscore(turner) - 3
                IF teamscore(turner) < 1 THEN teamscore(turner) = 1
                spotvalue(teamscore(turner)) = spotvalue(teamscore(turner)) + 1
        END SELECT
        type$ = "---CHANCE---"
        text$ = chance$(chancecard)
        GOSUB graphics
        GOSUB pause1
        GOSUB endcheck
END SELECT
RETURN

turner:
turner = (turner MOD teams)
IF turner = 0 THEN turner = teams
IF oldturn <> turner THEN
    _SNDPLAY turn
    type$ = "---TURN---"
    text$ = "Team " + teamnames$(turner) + "'s turn"
    GOSUB graphics
    DO
        _LIMIT 64
        GOSUB controls
    LOOP UNTIL k$ = CHR$(32)
    DO
        _LIMIT 64
        GOSUB controls
    LOOP UNTIL k$ = ""
    loops&& = 0
END IF
oldturn = turner
RETURN