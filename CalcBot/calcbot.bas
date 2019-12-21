CLS
PRINT "  ;:::::::::::,      '::::'      '::::::,       ;:::::::::::,       "
PRINT ",::::                ::::::         ::        ,::::                 "
PRINT "'::::               ::'  '::        ::        '::::                 "
PRINT "'::::              ::      ::       ::        '::::                 "
PRINT "'::::             ::,,,,,,,,::      ::        '::::                 "
PRINT "'::::             ::        ::      ::        '::::                 "
PRINT "  .:::::::::::'   ::        :,    ;:::::::::'   .:::::::::::'       "
PRINT "                                                                    "
PRINT "             ';::::::,     ,;:::,    ;:::::::::;                    "
PRINT "              :''''''':   :'''''':       ;:;                        "
PRINT "              :,,,,,,,:   :      :       ;:;                        "
PRINT "              ::::::::    :      :       ;:;                        "
PRINT "              :''''''':   :      :       ;:;                        "
PRINT "              :,,,,,,,:   :,,,,,,;     ;:::::;                      "
PRINT "              ,''''''''     ''''                                    "
PRINT "                                                                    "
PRINT "                                                         PRESS SPACE"
SLEEP
CLS
PRINT "Welcome to CalcBot!"
PRINT "Zachary Gill"
SLEEP
CLS
BEGIN:
CLS
PRINT "What type of math would you like to do? "
PRINT "         0-Addition, 1-Subtraction, 2-Multiplication, 3-Division, 4-Advanced"
INPUT ": ", A
IF A = 0 THEN
	CLS
	PRINT "Enter your first number"
		INPUT ": ", A
	CLS
	PRINT "Enter your second number"
		INPUT ": ", B
	CLS
	PRINT "The answer is: "; A + B
	SLEEP
	CLS
	PRINT "Would you like to do another problem?"
	PRINT "0-No, 1-Yes"
		INPUT ": ", A
		IF A = 0 THEN
			END
		END IF
		IF A = 1 THEN
		       GOTO BEGIN
		END IF
END IF
IF A = 1 THEN
	CLS
	PRINT "Enter your first number"
		INPUT ": ", A
	CLS
	PRINT "Enter your second number"
		INPUT ": ", B
	CLS
	PRINT ": "; A - B
	SLEEP
	CLS
	PRINT "Would you like to do another problem?"
	PRINT "0-No, 1-Yes"
		INPUT ": ", A
		IF A = 0 THEN
			END
		END IF
		IF A = 1 THEN
			GOTO BEGIN
		END IF
END IF
IF A = 2 THEN
	CLS
	PRINT "Enter your first number"
		INPUT ": ", A
	CLS
	PRINT "Enter your second number"
		INPUT ": ", B
	CLS
	PRINT ": "; A * B
	SLEEP
	CLS
	PRINT "Would you like to do another problem?"
	PRINT "0-No, 1-Yes"
		INPUT ": ", A
		IF A = 0 THEN
			END
		END IF
		IF A = 1 THEN
			GOTO BEGIN
		END IF
END IF
IF A = 3 THEN
	CLS
	PRINT "Enter your first number"
		INPUT ": ", A
	CLS
	PRINT "Enter your second number"
		INPUT ": ", B
	CLS
	PRINT ": "; A / B
	SLEEP
	CLS
	PRINT "Would you like to do another problem?"
	PRINT "0-No, 1-Yes"
		INPUT ": ", A
		IF A = 0 THEN
			END
		END IF
		IF A = 1 THEN
			GOTO BEGIN
		END IF
END IF
IF A = 4 THEN
	CLS
	PRINT "What would you like to do?"
	PRINT "         0-Complex Expresions,   1-Inequalities,         2-Equations,"
	PRINT "         3-Dice,                 4-Matracies,            5-@@@@@@@@@,"
	PRINT "         -                       -                       -"
		INPUT ": ", A
			CLS
			IF A = 1 THEN
			END IF
			IF A = 2 THEN
			END IF
			IF A = 3 THEN
				PRINT "What side die do you want to use? "
				PRINT "         Acceptable: 2,4,6,8,10,12,20,100,1000"
					INPUT ": ", A
						CLS
						IF A = 2 THEN
							INPUT "Press enter to flip coin: ", A$
BEGINCOINFLIP:
							PRINT
							RANDOMIZE TIMER
							FLIP = INT(RND * 2 + 1)
							IF FLIP = 1 THEN
								PRINT "Heads"
							END IF
							IF FLIP = 2 THEN
								PRINT "Tails"
							END IF
							SLEEP
							PRINT "Would you like to flip again?"
							PRINT "         0-No, 1-Yes"
								INPUT ": ", A
									CLS
									IF A = 1 THEN
										GOTO BEGINCOINFLIP
									END IF
									IF A = 0 THEN
										PRINT "Would you like to do another problem?"
										PRINT "         0-No, 1-Yes"
											INPUT ": ", A
												IF A = 0 THEN
													END
												END IF
												IF A = 1 THEN
													GOTO BEGIN
												END IF
									END IF

							END IF
						END IF
						IF A = 4 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN4SIDE:
								  PRINT
								  RANDOMIZE TIMER
								  ROLL = INT(RND * 4 + 1)
								  PRINT ROLL
								  SLEEP
								  PRINT "Would you like to roll again?"
								  PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN4SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 6 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN6SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 6 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN6SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 8 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN8SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 8 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN8SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 10 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN10SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 10 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN10SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 12 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN12SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 12 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN12SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 20 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN20SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 20 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN20SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 100 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN100SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 100 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN100SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
						IF A = 1000 THEN
							INPUT "Press enter to roll die: ", A$
BEGIN1000SIDE:
								PRINT
								RANDOMIZE TIMER
								ROLL = INT(RND * 1000 + 1)
								PRINT ROLL
								SLEEP
								PRINT "Would you like to roll again?"
								PRINT "          0-No, 1-Yes"
									INPUT ": ", A
										CLS
										IF A = 1 THEN
											GOTO BEGIN1000SIDE
										END IF
										IF A = 0 THEN
											PRINT "Would you like to do another problem?"
											PRINT "          0-No, 1-Yes"
												INPUT ": ", A
													IF A = 0 THEN
														END
													END IF
													IF A = 1 THEN
														GOTO BEGIN
													END IF
										END IF
						END IF
			END IF
			IF A = 4 THEN
			END IF

