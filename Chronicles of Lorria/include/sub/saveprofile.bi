'saves the current profile to a file
SUB saveprofile
OPEN profile.file FOR OUTPUT AS #1
CLOSE #1
'OPEN profile.file FOR BINARY AS #1
'PUT #1, , profile
'CLOSE #1
OPEN profile.file FOR OUTPUT AS #1
PRINT #1, profile.file
PRINT #1, profile.name
PRINT #1, profile.race
PRINT #1, profile.gender
PRINT #1, profile.class
PRINT #1, profile.str
PRINT #1, profile.dex
PRINT #1, profile.int
PRINT #1, profile.wis
PRINT #1, profile.con
PRINT #1, profile.chr
PRINT #1, profile.alignment
PRINT #1, profile.faction
CLOSE #1
END SUB