CHDIR ".\programs\samples\thebob\chess"

'CHESSGFX.BAS
DEFINT A-Z
DIM Box(1 TO 26000)
SCREEN 12

GOSUB SetPALETTE
GOSUB DrawPIX
GOSUB DrawBOARD

DEF SEG = VARSEG(Box(1))
BSAVE "chesspcs.bsv", VARPTR(Box(1)), 39000
DEF SEG

'position black pieces
PUT (31, 31), Box(7501), PSET
PUT (81, 31), Box(15751), PSET
PUT (131, 31), Box(6001), PSET
PUT (181, 31), Box(14251), PSET
PUT (231, 31), Box(4501), PSET
PUT (281, 31), Box(15001), PSET
PUT (331, 31), Box(6751), PSET
PUT (381, 31), Box(16501), PSET
FOR x = 31 TO 331 STEP 100
PUT (x, 81), Box(17251), PSET
PUT (x + 50, 81), Box(8251), PSET
NEXT x

'position white pieces
PUT (31, 381), Box(12001), PSET
PUT (81, 381), Box(2251), PSET
PUT (131, 381), Box(10501), PSET
PUT (181, 381), Box(751), PSET
PUT (231, 381), Box(9001), PSET
PUT (281, 381), Box(1501), PSET
PUT (331, 381), Box(11251), PSET
PUT (381, 381), Box(3001), PSET
FOR x = 31 TO 331 STEP 100
PUT (x, 331), Box(3751), PSET
PUT (x + 50, 331), Box(12751), PSET
NEXT x
GOSUB SaveSCREEN

CLS
LINE (100, 100)-(539, 349), 3, B
COLOR 14
LOCATE 13, 26
PRINT "The chess graphics files have"
LOCATE 14, 28
PRINT "been successfully created."
LOCATE 16, 28
PRINT "You may now run CHESSUBS"

a$ = INPUT$(1)
END

SetPALETTE:
RESTORE PaletteDATA
OUT &H3C8, 0
FOR n = 1 TO 48
READ Colr
OUT &H3C9, Colr
NEXT n
RETURN

DrawPIX:
RESTORE PictureDATA
MaxWIDTH = 465
MaxDEPTH = 46
x = 0: y = 0
DO
READ Count, Colr
FOR Reps = 1 TO Count
PSET (x, y), Colr
x = x + 1
IF x > MaxWIDTH THEN
x = 0
y = y + 1
END IF
NEXT Reps
LOOP UNTIL y > MaxDEPTH
RETURN

SaveSCREEN:
FileNUM = 0
DEF SEG = VARSEG(Box(1))
FOR y = 0 TO 320 STEP 160
GET (0, y)-(639, y + 159), Box
FileNUM = FileNUM + 1
FileNAME$ = "ChessBD" + LTRIM$(STR$(FileNUM)) + ".BSV"
BSAVE FileNAME$, VARPTR(Box(1)), 52000
NEXT y
DEF SEG
RETURN

DrawBOARD:
LINE (0, 47)-(46, 93), 7, BF
FOR x = 0 TO 46
FOR y = 0 TO 46
SELECT CASE POINT(x, y)
CASE 3: PSET (x, y + 47), 5
CASE 1: PSET (x, y + 47), 6
END SELECT
NEXT y
NEXT x

GET (0, 0)-(46, 46), Box(1000)
PUT (0, 0), Box(1000)
GET (0, 47)-(46, 93), Box(2000)
PUT (0, 47), Box(2000)

xx = 100: y = 100
LINE (100, 100)-(300, 450), 0, BF
FOR x = 55 TO 450 STEP 35
GET (x, 0)-(x + 30, 47), Box
PUT (xx, y), Box
PUT (xx - 50, y), Box(2000)
FOR xxx = xx TO xx + 35
FOR yy = y TO y + 48
IF POINT(xxx, yy) <> 0 THEN
PSET (xxx - 42, yy), POINT(xxx, yy)
PSET (xxx, yy), 0
END IF
NEXT yy
NEXT xxx
y = y + 50
IF y = 400 THEN xx = xx + 100: y = 100
NEXT x
FOR x = 55 TO 450 STEP 35
GET (x, 0)-(x + 30, 47), Box
PUT (x, 0), Box
PUT (xx, y), Box
PUT (xx - 50, y), Box(1000)
FOR xxx = xx TO xx + 35
FOR yy = y TO y + 48
IF POINT(xxx, yy) <> 0 THEN
PSET (xxx - 42, yy), POINT(xxx, yy)
PSET (xxx, yy), 0
END IF
NEXT yy
NEXT xxx
y = y + 50
IF y = 400 THEN xx = xx + 100: y = 100
NEXT x
PUT (0, 0), Box(1000)
PUT (0, 47), Box(2000)

Index = 1
FOR x = 50 TO 350 STEP 100
FOR y = 100 TO 350 STEP 50
GET (x, y)-(x + 46, y + 46), Box(Index)
PUT (x, y), Box(Index)
Index = Index + 750
NEXT y
NEXT x

GET (0, 0)-(46, 46), Box(18001)
PUT (0, 0), Box(18001)
GET (0, 47)-(46, 93), Box(18751)
PUT (0, 47), Box(18751)

LINE (16, 16)-(444, 444), 1, BF
LINE (15, 15)-(445, 445), 8, B
LINE (15, 15)-(445, 15), 3
LINE (15, 15)-(15, 445), 3
LINE (25, 25)-(435, 435), 2, BF
FOR Reps = 1 TO 1600
x = FIX(RND * 11) + 14
y = FIX(RND * 430) + 14
IF FIX(RND * 2) = 0 THEN Colr = 3 ELSE Colr = 8
IF POINT(x, y) = 1 THEN
PSET (x, y), Colr
PSET (x + 420, y), Colr
END IF
x = FIX(RND * 430) + 14
y = FIX(RND * 11) + 14
IF FIX(RND * 2) = 0 THEN Colr = 3 ELSE Colr = 8
IF POINT(y, x) = 1 THEN
PSET (x, y), Colr
PSET (x, y + 420), Colr
END IF
NEXT Reps
LINE (25, 25)-(435, 435), 7, BF
LINE (29, 29)-(430, 430), 13, B
LINE (28, 28)-(431, 431), 14, B
LINE (29, 430)-(430, 430), 8
LINE (431, 29)-(431, 430), 8
LINE (25, 25)-(435, 435), 8, B
LINE (435, 26)-(435, 435), 3
LINE (25, 435)-(435, 435), 3
FOR x = 30 TO 380 STEP 50
n = n + 1
FOR y = 30 TO 380 STEP 50
n = n + 1
IF n MOD 2 THEN PUT (x + 1, y + 1), Box(18751), PSET ELSE PUT (x + 1, y + 1), Box(18001), PSET
LINE (x, y)-(x + 49, y + 49), 14, B
LINE (x, y)-(x + 48, y + 48), 13, B
NEXT y
NEXT x
LINE (5, 5)-(634, 474), 1, B
LINE (8, 8)-(631, 471), 1, B
RETURN

PaletteDATA:
DATA 12,0,10, 12,14,12, 15,17,15, 16,20,16
DATA 63,0,0, 63,60,50, 58,55,45, 53,50,40
DATA 0,0,0, 42,42,48, 50,50,55, 40,40,63
DATA 15,15,34, 58,37,15, 60,52,37, 63,63,63

PictureDATA:
DATA 4,3,2,2,11,3,6,2,1,3,4,2,4,3,8,1,1,2,1,3,3,1,2,2,20,0
DATA 7,8,392,0,18,3,4,2,1,1,1,2,3,1,1,2,4,3,5,1,3,2,5,1
DATA 2,2,20,0,2,8,3,15,2,8,204,0,1,15,3,8,184,0,8,3,1,2
DATA 9,3,4,2,1,1,1,2,2,1,2,2,1,3,1,2,2,3,1,2,8,1,1,3,3,1
DATA 2,2,18,0,4,8,3,15,4,8,202,0,1,11,3,8,184,0,2,2,6,3
DATA 1,2,5,3,8,2,2,1,10,2,5,1,1,2,1,3,1,2,3,1,2,2,18,0,2,8
DATA 7,15,2,8,200,0,1,15,7,8,182,0,3,2,5,3,1,2,5,3,7,2,1,3
DATA 2,1,4,2,5,1,2,2,1,1,1,2,2,1,5,2,1,1,1,2,1,1,18,0,2,8
DATA 7,15,2,8,200,0,1,11,7,8,182,0,3,2,5,3,1,2,6,3,3,2,3,3
DATA 2,2,1,1,1,2,3,3,5,1,2,2,1,1,1,2,2,1,3,2,1,3,2,2,2,1
DATA 18,0,4,8,3,15,4,8,28,0,3,8,171,0,1,11,3,8,184,0,1,1
DATA 2,2,13,3,1,2,1,1,2,2,3,3,1,2,1,1,1,2,2,3,3,1,1,2,1,1
DATA 2,2,1,1,3,2,2,3,1,1,2,3,3,2,20,0,2,8,3,15,2,8,28,0
DATA 2,8,2,15,1,10,2,8,169,0,1,11,3,8,32,0,1,15,2,8,149,0
DATA 3,1,1,2,1,1,2,2,7,3,2,2,8,3,1,2,3,3,1,2,1,3,1,2,1,3
DATA 1,2,1,1,2,2,1,1,5,2,3,1,2,2,14,0,7,8,3,15,2,10,7,8
DATA 17,0,6,8,2,15,3,10,6,8,163,0,1,11,5,8,30,0,1,11,4,8
DATA 148,0,1,2,5,1,1,2,14,3,1,2,10,3,2,2,1,1,1,2,1,1,3,2
DATA 1,1,1,2,1,1,4,2,13,0,2,8,17,15,2,8,15,0,1,8,17,15,1,8
DATA 157,0,2,11,2,15,3,11,7,8,2,12,1,8,18,0,2,15,3,8,2,11
DATA 3,8,2,12,2,8,2,12,1,8,142,0,3,2,3,1,1,2,8,3,1,2,1,3
DATA 1,2,1,3,2,2,2,3,1,2,8,3,2,2,1,1,1,2,1,1,4,2,6,1,12,0
DATA 2,8,2,9,3,10,1,9,1,10,11,9,1,10,2,8,13,0,1,8,3,15,1,10
DATA 1,9,1,10,2,15,1,10,1,9,1,10,2,15,1,10,1,9,1,10,3,15
DATA 1,8,23,0,3,8,129,0,19,8,16,0,1,12,3,8,1,11,4,8,1,12
DATA 4,8,1,12,3,8,1,12,24,0,1,11,2,12,114,0,3,2,2,1,2,2
DATA 2,3,2,2,3,3,6,2,3,3,1,1,2,2,4,3,6,2,1,1,3,2,1,3,5,1
DATA 1,2,13,0,2,8,1,9,3,10,1,9,1,10,10,9,1,10,2,8,14,0,2,8
DATA 1,9,1,10,3,15,1,10,1,9,3,15,2,9,3,15,1,9,1,10,2,8,21,0
DATA 2,8,3,9,2,8,127,0,19,8,16,0,19,8,24,0,3,8,114,0,7,1
DATA 1,2,8,3,1,2,6,3,1,2,1,1,2,2,5,3,1,2,2,1,9,2,3,1,14,0
DATA 2,8,1,9,3,10,1,9,1,10,8,9,1,10,2,8,16,0,2,8,1,9,3,10
DATA 1,9,1,10,8,9,1,10,2,8,21,0,2,8,5,9,2,8,56,0,4,8,2,0
DATA 7,8,2,0,4,8,52,0,17,8,18,0,17,8,24,0,1,12,4,8,113,0
DATA 4,1,3,2,1,1,1,2,1,1,4,3,3,2,6,3,1,2,1,3,1,2,6,3,10,2
DATA 4,3,1,2,14,0,2,8,1,9,3,10,1,9,1,10,8,9,1,10,2,8,16,0
DATA 2,8,1,9,3,10,1,9,1,10,8,9,1,10,2,8,20,0,1,8,3,9,4,15
DATA 1,9,2,8,21,0,3,8,31,0,1,8,1,15,1,10,1,8,2,0,1,8,4,15
DATA 1,9,1,8,2,0,1,8,1,9,1,10,1,8,52,0,16,8,19,0,16,8,24,0
DATA 1,12,1,8,1,15,1,11,1,12,2,8,58,0,1,8,1,15,1,11,3,0
DATA 5,12,3,0,3,12,37,0,4,1,1,2,1,3,1,2,4,1,2,2,1,3,2,2
DATA 1,3,7,2,8,3,2,1,3,2,1,1,4,2,4,3,1,2,15,0,2,8,1,9,3,10
DATA 1,9,1,10,6,9,1,10,2,8,18,0,2,8,1,9,3,10,1,9,1,10,6,9
DATA 1,10,2,8,21,0,3,8,6,15,2,8,21,0,1,8,2,15,5,8,26,0,1,8
DATA 1,15,1,10,1,8,2,0,1,8,4,15,1,9,1,8,2,0,1,8,1,9,1,10
DATA 1,8,53,0,15,8,20,0,15,8,23,0,3,8,1,11,3,12,2,8,24,0
DATA 2,8,31,0,1,8,1,15,1,11,3,0,5,8,3,0,2,12,1,8,37,0,3,2
DATA 2,1,2,2,2,1,1,2,1,1,6,2,4,1,4,2,7,3,3,1,1,2,2,1,3,2
DATA 5,3,1,2,15,0,2,8,1,9,3,10,1,9,1,10,6,9,1,10,2,8,18,0
DATA 2,8,1,9,3,10,1,9,1,10,6,9,1,10,2,8,21,0,1,8,1,9,2,8
DATA 5,15,1,10,2,8,19,0,1,8,1,10,1,9,1,15,1,10,3,15,4,8
DATA 23,0,1,8,1,15,1,10,1,8,2,0,1,8,4,15,1,9,1,8,2,0,1,8
DATA 1,9,1,10,1,8,54,0,13,8,22,0,13,8,25,0,3,8,2,12,3,8
DATA 23,0,1,8,1,15,5,8,27,0,1,8,1,15,1,11,3,0,5,8,3,0,2,12
DATA 1,8,37,0,2,2,1,3,1,1,4,2,1,1,4,2,8,1,3,2,2,3,1,2,5,3
DATA 2,1,2,2,1,1,4,2,5,3,1,2,16,0,2,8,1,9,3,10,1,9,1,10
DATA 4,9,1,10,2,8,20,0,2,8,1,9,3,10,1,9,1,10,4,9,1,10,2,8
DATA 21,0,1,8,3,9,2,8,4,15,1,10,2,8,19,0,1,8,1,15,1,9,2,10
DATA 6,15,3,8,21,0,1,8,1,15,1,10,4,8,4,15,1,9,4,8,1,9,1,10
DATA 1,8,54,0,13,8,22,0,13,8,23,0,2,8,1,12,1,0,7,8,22,0
DATA 1,8,1,11,2,12,6,8,24,0,1,8,1,15,4,11,5,8,5,12,1,8,37,0
DATA 3,2,3,3,1,2,1,3,13,1,3,2,1,3,1,2,2,1,4,3,4,2,1,1,3,2
DATA 2,3,2,2,2,3,1,2,15,0,2,8,13,15,2,8,18,0,2,8,13,15,2,8
DATA 20,0,1,8,3,15,1,9,2,8,2,15,3,10,1,8,18,0,1,8,1,10,3,15
DATA 3,10,1,9,5,15,1,10,1,8,20,0,1,8,1,15,1,10,8,15,4,10
DATA 2,9,1,10,1,8,53,0,15,8,20,0,15,8,22,0,3,8,1,12,1,0
DATA 6,8,21,0,1,8,1,11,4,8,1,12,1,11,1,12,4,8,22,0,1,8,1,15
DATA 2,11,2,12,7,8,3,12,1,8,37,0,8,3,1,2,4,3,1,2,1,3,1,2
DATA 2,3,8,2,3,1,3,2,4,3,2,2,1,1,3,2,2,1,1,2,2,3,14,0,2,8
DATA 15,9,2,8,16,0,2,8,15,9,2,8,19,0,1,8,4,15,1,9,2,8,1,15
DATA 2,10,1,9,1,8,18,0,1,8,3,15,1,10,4,15,2,10,1,9,4,15
DATA 1,8,19,0,1,8,1,15,1,10,8,15,4,10,2,9,1,10,1,8,52,0
DATA 2,8,2,15,3,11,5,12,2,8,1,12,2,8,18,0,2,8,2,15,3,11
DATA 5,12,2,8,1,12,2,8,21,0,2,8,1,15,2,12,1,0,5,8,21,0,1,8
DATA 1,12,8,8,1,12,4,8,20,0,1,8,1,15,2,11,2,12,7,8,3,12
DATA 1,8,37,0,8,3,1,2,9,3,3,2,3,3,2,2,3,1,3,2,6,3,7,1,1,2
DATA 1,3,13,0,2,8,17,15,2,8,14,0,2,8,17,15,2,8,18,0,1,8
DATA 1,15,1,10,3,15,1,9,1,8,3,10,1,9,1,8,17,0,1,8,1,10,3,15
DATA 2,10,5,15,2,10,1,9,3,15,1,8,18,0,1,8,1,15,1,10,8,15
DATA 4,10,2,9,1,10,1,8,51,0,19,8,16,0,19,8,20,0,2,8,2,12
DATA 1,8,1,12,1,0,4,8,20,0,1,8,1,12,2,8,1,12,8,8,1,12,3,8
DATA 19,0,1,8,1,15,2,11,2,12,7,8,3,12,1,8,37,0,8,3,1,2,16,3
DATA 2,2,2,1,3,2,6,3,3,2,5,1,1,2,12,0,2,8,19,15,2,8,12,0
DATA 2,8,19,15,2,8,18,0,1,8,4,15,1,10,1,9,2,10,1,9,1,8,18,0
DATA 1,8,3,15,2,10,8,15,1,10,1,9,2,15,2,8,17,0,1,8,1,15
DATA 1,10,8,15,4,10,2,9,1,10,1,8,24,0,3,8,23,0,2,8,3,15
DATA 3,11,5,12,5,8,1,12,2,8,14,0,2,8,3,15,3,11,5,12,4,8
DATA 1,12,3,8,19,0,6,8,1,12,4,8,20,0,3,8,2,12,12,8,19,0
DATA 1,8,1,15,2,11,2,12,7,8,3,12,1,8,37,0,2,2,6,3,1,2,16,3
DATA 3,2,3,1,1,2,8,3,1,2,6,1,13,0,2,8,17,15,2,8,14,0,2,8
DATA 17,15,2,8,19,0,1,8,7,10,2,9,1,8,17,0,1,8,1,10,1,15
DATA 2,8,1,10,10,15,2,10,2,15,2,8,16,0,1,8,1,15,1,10,8,15
DATA 4,10,2,9,1,10,1,8,23,0,1,8,3,15,1,8,23,0,19,8,16,0
DATA 19,8,21,0,9,8,20,0,2,8,1,11,2,12,11,8,1,12,2,8,18,0
DATA 1,8,1,15,2,11,2,12,7,8,3,12,1,8,25,0,2,12,1,8,9,0,5,1
DATA 1,2,20,3,3,2,2,1,1,2,9,3,3,1,2,2,1,1,14,0,6,8,7,9,6,8
DATA 16,0,6,8,7,9,6,8,21,0,1,8,2,9,2,10,3,9,1,8,18,0,1,8
DATA 3,15,1,8,1,10,11,15,1,10,1,9,2,15,1,8,16,0,2,8,15,9
DATA 2,8,22,0,1,8,5,15,1,8,27,0,9,8,26,0,9,8,26,0,9,8,20,0
DATA 2,8,2,11,16,8,17,0,1,8,1,15,2,11,2,12,7,8,3,12,1,8
DATA 24,0,1,12,4,8,8,0,1,2,4,1,1,2,20,3,6,2,10,3,1,2,1,1
DATA 1,2,2,1,18,0,2,8,7,9,2,8,24,0,2,8,7,9,2,8,26,0,1,8
DATA 6,9,1,8,17,0,1,8,1,10,1,15,1,10,14,15,1,10,1,9,2,15
DATA 2,8,17,0,2,8,11,9,2,8,23,0,1,8,6,15,1,10,1,8,26,0,9,8
DATA 26,0,9,8,27,0,7,8,20,0,2,8,1,11,6,8,1,12,8,8,1,12,2,8
DATA 18,0,15,8,24,0,1,12,2,15,1,11,3,8,7,0,1,2,3,1,2,2,19,3
DATA 7,2,10,3,2,2,1,3,2,2,18,0,2,8,7,9,2,8,24,0,2,8,7,9
DATA 2,8,27,0,1,8,4,9,1,8,18,0,1,8,1,15,1,10,8,15,2,10,5,15
DATA 2,10,2,15,2,8,19,0,2,8,7,9,2,8,25,0,1,8,6,15,1,10,1,8
DATA 26,0,9,8,26,0,9,8,28,0,5,8,21,0,1,8,1,11,7,8,1,12,8,8
DATA 1,12,2,8,20,0,11,8,25,0,1,12,1,8,2,15,1,11,1,12,3,8
DATA 6,0,2,2,2,1,1,2,20,3,7,2,14,3,1,2,18,0,2,8,5,10,2,9
DATA 2,8,24,0,2,8,5,10,2,9,2,8,22,0,5,8,4,15,2,10,5,8,12,0
DATA 1,8,2,10,8,15,3,10,5,15,2,10,1,9,2,15,1,8,20,0,1,8
DATA 7,9,1,8,26,0,1,8,6,15,1,10,1,8,26,0,9,8,26,0,9,8,26,0
DATA 9,8,18,0,1,8,1,11,8,8,1,12,12,8,20,0,9,8,26,0,1,12
DATA 1,8,2,11,2,12,2,8,1,12,6,0,1,3,3,2,22,3,6,2,15,3,17,0
DATA 2,8,2,15,5,10,2,9,2,8,22,0,2,8,2,15,5,10,2,9,2,8,20,0
DATA 2,8,11,15,2,10,1,15,2,8,11,0,1,8,4,15,1,9,5,15,1,8
DATA 1,9,1,10,5,15,2,10,1,9,2,15,1,8,17,0,3,8,10,15,2,8
DATA 23,0,1,8,1,10,2,15,4,10,1,8,25,0,11,8,24,0,11,8,22,0
DATA 3,8,2,15,2,11,3,12,5,8,15,0,4,8,1,12,15,8,1,12,2,8
DATA 17,0,15,8,23,0,1,12,1,8,3,12,3,8,1,12,6,0,26,3,6,2
DATA 15,3,17,0,2,8,3,15,4,10,2,9,2,8,22,0,2,8,3,15,4,10
DATA 2,9,2,8,19,0,2,8,16,9,2,8,9,0,1,8,1,10,5,15,1,9,3,15
DATA 1,8,2,9,6,15,1,10,2,9,2,15,1,8,16,0,1,8,15,10,1,8,23,0
DATA 1,8,5,10,1,8,26,0,11,8,24,0,11,8,21,0,17,8,13,0,6,8
DATA 1,12,4,8,1,12,9,8,1,12,2,8,16,0,17,8,23,0,1,12,5,8
DATA 1,12,7,0,24,3,1,1,6,3,1,2,2,3,4,2,1,1,1,2,7,3,17,0
DATA 2,8,4,15,3,10,2,9,2,8,22,0,2,8,4,15,3,10,2,9,2,8,19,0
DATA 1,8,13,15,4,10,1,15,1,8,9,0,1,8,1,15,1,8,1,9,2,15,1,10
DATA 1,15,1,9,2,8,2,9,1,10,6,15,1,10,2,9,2,15,1,8,15,0,1,8
DATA 17,15,1,8,23,0,1,8,3,10,1,8,27,0,11,8,24,0,11,8,20,0
DATA 3,8,2,15,2,11,3,12,6,8,3,12,12,0,1,8,1,11,1,12,2,8
DATA 1,12,1,8,2,12,1,8,1,12,10,8,1,12,2,8,15,0,1,8,2,15
DATA 3,11,4,12,6,8,2,12,1,8,22,0,1,12,4,8,2,12,7,0,31,3
DATA 1,2,2,3,4,2,1,1,2,2,6,3,17,0,2,8,4,15,4,10,1,9,2,8
DATA 22,0,2,8,4,15,4,10,1,9,2,8,19,0,2,8,8,15,8,10,2,8,9,0
DATA 1,8,1,15,2,9,2,8,2,10,2,8,2,9,1,10,6,15,1,10,3,9,2,15
DATA 1,8,16,0,6,8,5,9,6,8,24,0,1,8,3,9,1,8,27,0,11,8,24,0
DATA 11,8,21,0,17,8,13,0,1,8,2,12,2,8,2,12,1,0,1,8,1,12
DATA 14,8,16,0,17,8,25,0,1,12,2,8,9,0,34,3,7,2,6,3,16,0
DATA 2,8,5,15,4,10,2,9,2,8,20,0,2,8,5,15,4,10,2,9,2,8,19,0
DATA 6,8,6,9,6,8,11,0,1,8,1,9,1,15,1,8,1,15,1,10,2,8,1,9
DATA 2,10,6,15,2,10,2,9,2,15,2,8,21,0,1,8,5,9,1,8,26,0,1,8
DATA 9,9,1,8,23,0,13,8,22,0,13,8,25,0,7,8,18,0,1,8,1,12
DATA 3,8,1,12,1,0,1,8,1,12,14,8,22,0,7,8,26,0,11,8,5,0,31,3
DATA 1,2,3,3,7,2,5,3,16,0,2,8,5,15,4,10,2,9,2,8,20,0,2,8
DATA 5,15,4,10,2,9,2,8,23,0,2,8,6,9,2,8,16,0,2,8,1,15,1,10
DATA 2,8,1,9,2,10,6,15,5,10,2,15,1,8,22,0,1,8,5,9,1,8,25,0
DATA 1,8,11,15,1,8,22,0,13,8,22,0,13,8,25,0,7,8,20,0,2,8
DATA 1,12,1,0,1,8,1,12,12,8,1,12,2,8,22,0,7,8,25,0,1,8,2,15
DATA 3,11,4,12,3,8,4,0,25,3,6,2,8,3,3,2,5,3,16,0,2,8,6,15
DATA 3,10,2,9,2,8,20,0,2,8,6,15,3,10,2,9,2,8,23,0,2,8,6,9
DATA 2,8,18,0,4,8,1,10,6,15,7,10,1,15,2,8,22,0,1,8,2,15
DATA 3,10,1,8,26,0,4,8,3,9,4,8,23,0,13,8,22,0,13,8,25,0
DATA 7,8,23,0,1,8,1,11,12,8,1,12,2,8,23,0,7,8,26,0,11,8
DATA 5,0,2,3,1,2,23,3,2,2,2,3,2,2,15,3,16,0,2,8,11,9,2,8
DATA 20,0,2,8,11,9,2,8,23,0,1,8,2,15,4,10,2,9,1,8,19,0,2,8
DATA 17,15,1,8,22,0,1,8,4,15,1,10,1,8,29,0,1,8,3,9,1,8,26,0
DATA 13,8,22,0,13,8,24,0,9,8,21,0,1,8,1,11,1,12,16,8,21,0
DATA 9,8,29,0,3,8,9,0,26,3,1,2,5,3,1,2,14,3,15,0,2,8,6,15
DATA 6,10,1,9,2,8,18,0,2,8,6,15,6,10,1,9,2,8,22,0,1,8,3,15
DATA 4,10,1,9,1,8,18,0,1,8,20,15,1,8,20,0,1,8,1,9,4,15,2,10
DATA 1,8,28,0,1,8,3,15,1,8,25,0,2,8,1,15,3,11,3,12,6,8,20,0
DATA 2,8,1,15,3,11,3,12,6,8,23,0,9,8,21,0,1,8,1,12,1,11
DATA 4,12,11,8,1,12,1,8,20,0,9,8,28,0,5,8,8,0,6,3,3,2,23,3
DATA 1,2,14,3,14,0,2,8,9,15,4,10,1,9,1,10,2,8,16,0,2,8,9,15
DATA 4,10,1,9,1,10,2,8,20,0,1,8,5,15,3,10,2,9,1,8,18,0,2,8
DATA 16,9,2,8,20,0,1,8,2,9,5,15,1,10,1,9,1,8,26,0,1,8,3,15
DATA 2,10,1,8,23,0,2,8,3,15,1,11,1,12,8,8,1,12,1,8,18,0
DATA 2,8,3,15,1,11,1,12,9,8,1,12,21,0,11,8,21,0,15,8,2,12
DATA 1,8,20,0,11,8,27,0,5,8,8,0,2,2,1,3,3,2,3,1,2,2,10,3
DATA 4,2,7,3,1,2,12,3,2,2,13,0,2,8,10,15,4,10,2,9,1,10,2,8
DATA 14,0,2,8,10,15,4,10,2,9,1,10,2,8,18,0,2,8,6,15,2,10
DATA 2,9,2,8,16,0,2,8,18,15,2,8,19,0,1,8,1,9,6,15,1,10,1,9
DATA 1,8,25,0,1,8,5,15,2,10,1,8,21,0,2,8,3,15,2,11,1,12
DATA 9,8,1,12,1,8,16,0,2,8,3,15,2,11,1,12,9,8,1,12,1,8,20,0
DATA 11,8,20,0,2,8,2,15,4,11,5,12,6,8,20,0,11,8,26,0,7,8
DATA 7,0,3,2,1,3,2,2,3,1,2,2,13,3,1,2,2,1,1,2,4,3,2,2,13,3
DATA 13,0,2,8,9,15,5,10,3,9,2,8,14,0,2,8,9,15,5,10,3,9,2,8
DATA 18,0,2,8,10,9,2,8,17,0,2,8,16,9,2,8,20,0,1,8,9,9,1,8
DATA 24,0,2,8,7,9,2,8,20,0,1,8,1,12,1,11,1,15,2,11,1,12
DATA 11,8,1,12,16,0,1,8,1,12,1,11,1,15,2,11,1,12,11,8,1,12
DATA 20,0,11,8,21,0,17,8,21,0,11,8,25,0,9,8,6,0,2,2,3,3
DATA 2,2,3,1,1,2,14,3,3,2,2,3,1,2,1,3,1,2,14,3,12,0,2,8
DATA 9,15,6,10,3,9,1,10,2,8,12,0,2,8,9,15,6,10,3,9,1,10
DATA 2,8,16,0,2,8,6,15,3,10,3,9,2,8,18,0,2,8,9,10,3,9,2,8
DATA 21,0,1,8,6,15,3,10,2,9,1,8,22,0,1,8,6,15,3,10,2,9,1,8
DATA 19,0,1,8,2,12,2,11,1,12,12,8,1,12,16,0,1,8,2,12,2,11
DATA 1,12,12,8,1,12,19,0,2,8,1,15,2,11,3,12,5,8,22,0,2,8
DATA 1,15,2,11,3,12,5,8,22,0,2,8,1,15,3,11,3,12,4,8,23,0
DATA 2,8,1,15,2,11,3,12,3,8,5,0,6,3,3,2,14,3,5,2,3,3,1,2
DATA 15,3,12,0,2,8,8,15,6,10,4,9,1,10,2,8,12,0,2,8,8,15
DATA 6,10,4,9,1,10,2,8,15,0,2,8,8,15,3,10,3,9,2,8,17,0,1,8
DATA 6,15,5,10,3,9,1,8,20,0,1,8,8,15,3,10,2,9,1,8,20,0,1,8
DATA 8,15,3,10,2,9,1,8,18,0,18,8,1,12,16,0,18,8,1,12,18,0
DATA 2,8,1,15,1,11,1,12,8,8,1,12,1,8,20,0,2,8,2,15,1,11
DATA 1,12,7,8,1,12,1,8,20,0,2,8,1,15,2,11,1,12,7,8,1,12
DATA 1,8,21,0,2,8,1,15,1,11,1,12,6,8,1,12,1,8,4,0,7,3,1,2
DATA 14,3,1,2,2,1,2,2,19,3,1,2,12,0,2,8,6,15,7,10,5,9,1,10
DATA 2,8,12,0,2,8,6,15,7,10,5,9,1,10,2,8,14,0,2,8,9,15,3,10
DATA 4,9,2,8,15,0,1,8,9,15,3,10,4,9,1,8,18,0,1,8,9,15,3,10
DATA 3,9,1,8,18,0,1,8,9,15,3,10,3,9,1,8,16,0,20,8,1,12,14,0
DATA 20,8,1,12,17,0,1,8,3,15,2,12,8,8,1,12,1,8,18,0,2,8
DATA 2,15,2,11,1,12,8,8,1,12,1,8,18,0,2,8,3,15,1,11,2,12
DATA 7,8,1,12,1,8,19,0,2,8,3,15,2,12,6,8,1,12,1,8,3,0,6,3
DATA 1,2,1,1,5,2,9,3,1,2,2,1,1,2,10,3,3,2,1,3,7,2,12,0,2,8
DATA 4,15,8,10,6,9,1,10,2,8,12,0,2,8,4,15,8,10,6,9,1,10
DATA 2,8,14,0,2,8,8,15,4,10,4,9,2,8,15,0,1,8,8,15,4,10,4,9
DATA 1,8,18,0,1,8,8,15,4,10,3,9,1,8,18,0,1,8,8,15,4,10,3,9
DATA 1,8,16,0,20,8,1,12,14,0,21,8,16,0,2,8,1,11,1,15,2,11
DATA 1,12,9,8,1,12,18,0,2,8,3,11,2,12,9,8,1,12,18,0,2,8
DATA 1,11,1,15,2,11,2,12,8,8,1,12,19,0,2,8,1,11,1,15,1,11
DATA 2,12,7,8,1,12,3,0,2,3,2,2,8,1,4,2,5,3,1,2,4,1,1,2,9,3
DATA 2,2,6,3,3,2,11,0,2,8,2,15,10,10,8,9,1,10,2,8,10,0,2,8
DATA 2,15,10,10,8,9,1,10,2,8,13,0,2,8,6,15,4,10,6,9,2,8
DATA 14,0,1,8,7,15,4,10,7,9,1,8,17,0,1,8,6,15,4,10,5,9,1,8
DATA 17,0,1,8,7,15,4,10,6,9,1,8,14,0,22,8,1,12,12,0,22,8
DATA 1,12,15,0,2,8,4,12,10,8,1,12,18,0,2,8,4,12,10,8,1,12
DATA 18,0,2,8,4,12,10,8,1,12,19,0,2,8,4,12,8,8,1,12,3,0
DATA 1,2,14,1,5,2,5,1,1,2,5,3,1,2,13,3,2,2,10,0,2,8,22,9
DATA 1,10,2,8,8,0,2,8,22,9,1,10,2,8,11,0,2,8,3,15,5,10,10,9
DATA 2,8,12,0,2,8,3,15,5,10,10,9,2,8,15,0,1,8,3,15,5,10
DATA 9,9,1,8,16,0,1,8,3,15,5,10,9,9,1,8,13,0,1,8,4,15,4,11
DATA 8,12,7,8,1,12,10,0,1,8,4,15,4,11,8,12,5,8,3,12,13,0
DATA 18,8,1,12,16,0,18,8,1,12,16,0,18,8,1,12,17,0,16,8,1,12
DATA 2,0,17,1,2,2,6,1,1,2,4,3,2,2,15,3,10,0,1,8,25,15,1,8
DATA 8,0,1,8,25,15,1,8,10,0,3,8,18,9,3,8,10,0,2,8,20,9,1,8
DATA 13,0,3,8,17,9,3,8,13,0,2,8,17,9,1,8,13,0,24,8,1,12
DATA 10,0,24,8,1,12,13,0,18,8,1,12,16,0,18,8,1,12,16,0,18,8
DATA 1,12,17,0,16,8,1,12,2,0,1,1,1,2,23,1,1,2,21,3,10,0
DATA 1,8,7,15,1,10,1,15,5,10,9,9,2,10,1,8,8,0,1,8,7,15,1,10
DATA 1,15,5,10,9,9,2,10,1,8,10,0,1,8,22,15,1,8,10,0,1,8
DATA 22,15,1,8,12,0,1,8,21,15,1,8,13,0,1,8,19,15,1,8,12,0
DATA 24,8,1,12,10,0,24,8,1,12,11,0,1,8,3,15,3,11,5,12,10,8
DATA 1,12,12,0,1,8,3,15,3,11,5,12,10,8,1,12,12,0,2,8,3,15
DATA 3,11,5,12,9,8,1,12,13,0,1,8,3,15,3,11,5,12,8,8,1,12
DATA 1,2,1,3,1,2,22,1,1,2,21,3,10,0,1,8,7,15,1,10,1,15,5,10
DATA 9,9,2,10,1,8,8,0,1,8,7,15,1,10,1,15,5,10,9,9,2,10,1,8
DATA 10,0,1,8,8,15,6,10,7,9,1,10,1,8,10,0,1,8,8,15,6,10
DATA 7,9,1,10,1,8,12,0,1,8,8,15,6,10,7,9,1,8,13,0,1,8,7,15
DATA 6,10,6,9,1,8,12,0,24,8,1,12,10,0,24,8,1,12,11,0,22,8
DATA 1,12,12,0,22,8,1,12,12,0,22,8,1,12,13,0,20,8,1,12,1,1
DATA 2,2,1,1,2,2,19,1,1,2,2,3,1,2,1,3,2,2,15,3,10,0,1,8
DATA 7,15,1,10,1,15,5,10,9,9,2,10,1,8,8,0,1,8,7,15,1,10
DATA 1,15,5,10,9,9,2,10,1,8,10,0,1,8,8,15,6,10,7,9,1,10
DATA 1,8,10,0,1,8,8,15,6,10,7,9,1,10,1,8,12,0,1,8,8,15,6,10
DATA 7,9,1,8,13,0,1,8,7,15,6,10,6,9,1,8,12,0,24,8,1,12,10,0
DATA 24,8,1,12,11,0,22,8,1,12,12,0,22,8,1,12,12,0,22,8,1,12
DATA 13,0,20,8,1,12
