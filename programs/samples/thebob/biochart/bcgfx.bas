CHDIR ".\programs\samples\thebob\biochart"

'*******************************************************
'----------------------- BCGFX.BAS ---------------------
'*******************************************************

DEFINT A-Z
DECLARE SUB PrintSTRING (x, y, Prnt$)
DIM SHARED Box(12000)
DIM SHARED FontBOX(6000)

SCREEN 12
GOSUB SetPALETTE

MaxWIDTH = 485
MaxDEPTH = 114
x = 0: y = 0
RESTORE PixDATA
DO
READ DataSTRING$
FOR n = 1 TO LEN(DataSTRING$)
Char$ = MID$(DataSTRING$, n, 1)
SELECT CASE Char$
CASE "!"
n = n + 1
a$ = MID$(DataSTRING$, n, 1)
Count = ASC(a$) + 68
CASE "#"
n = n + 1
B$ = MID$(DataSTRING$, n)
FOR i = 1 TO LEN(B$)
t$ = MID$(B$, i, 1)
IF t$ = "#" THEN EXIT FOR
c$ = c$ + t$
NEXT i
Count = VAL("&H" + c$)
n = n + LEN(c$)
c$ = ""
CASE ELSE
Count = ASC(Char$) - 60
END SELECT
n = n + 1
Colr = VAL("&H" + MID$(DataSTRING$, n, 1))
FOR Reps = 1 TO Count
PSET (x, y), Colr
x = x + 1
IF x > MaxWIDTH THEN x = 0: y = y + 1
NEXT Reps
NEXT n
LOOP UNTIL y > MaxDEPTH 'DATA drawing loop ends here --------------------

DIM NumBOX(300)
FOR x = 227 TO 362 STEP 15
GET (x, 74)-(x + 6, 86), NumBOX(Index)
Index = Index + 30
NEXT x
DEF SEG = VARSEG(NumBOX(0))
BSAVE "brsnums.bsv", VARPTR(NumBOX(0)), 600
DEF SEG

GET (112, 55)-(198, 72), Box
PUT (112, 55), Box
PUT (16, 438), Box
GET (0, 55)-(104, 72), Box
PUT (0, 55), Box
PUT (158, 438), Box
GET (208, 55)-(338, 72), Box
PUT (208, 55), Box
PUT (320, 438), Box
GET (348, 55)-(448, 72), Box
PUT (348, 55), Box
PUT (503, 438), Box
CIRCLE (110, 447), 5, 5
PAINT STEP(0, 0), 9, 5
CIRCLE (272, 447), 5, 5
PAINT STEP(0, 0), 8, 5
CIRCLE (460, 447), 5, 5
PAINT STEP(0, 0), 6, 5
CIRCLE (614, 447), 5, 5
PAINT STEP(0, 0), 13, 5
GET (0, 0)-(490, 55), Box '7000
PUT (0, 0), Box
GET (20, 438)-(620, 454), Box(7000)
PUT (20, 438), Box(7000)

FontBOX(0) = 60: FontBOX(1) = 3
Index = 2
FOR y = 74 TO 102 STEP 14
FOR x = 0 TO 465 STEP 15
GET (x, y)-(x + 14, y + 13), FontBOX(Index)
PUT (x, y), FontBOX(Index)
Index = Index + 60
NEXT x
NEXT y
FOR Index = 2 TO 93 * 60 + 2 STEP 60
LINE (0, 200)-(20, 220), 0, BF
PUT (0, 200), FontBOX(Index)
x1 = -1: x2 = -1
FOR x = 0 TO 20
FOR y = 200 TO 220
IF POINT(x, y) <> 0 AND x1 = -1 THEN x1 = x
NEXT y: NEXT x
FOR x = 20 TO 0 STEP -1
FOR y = 200 TO 220
IF POINT(x, y) <> 0 AND x2 = -1 THEN x2 = x
NEXT y: NEXT x
FOR cx = x1 TO x2
FOR cy = 200 TO 207
IF POINT(cx, cy) <> 0 THEN PSET (cx, cy), 7
NEXT cy
NEXT cx
IF Index = 3242 THEN Margin = 0 ELSE Margin = 1
GET (x1, 200)-(x2 + Margin, 213), FontBOX(Index)
NEXT Index
LINE (0, 200)-(20, 220), 0, BF
DEF SEG = VARSEG(FontBOX(0))
BSAVE "brsmssb.fnt", VARPTR(FontBOX(0)), 5643 * 2
DEF SEG
PrintSTRING 10, 6, "Freeware - Copyright (C) 2007 by Bob Seguin"
PrintSTRING 500, 6, "BOBSEG@sympatico.ca"
FOR x = 10 TO 630
IF x = 264 THEN x = 500
FOR y = 6 TO 20
IF y > 13 THEN Colr = 1 ELSE Colr = 2
IF POINT(x, y) <> 0 THEN PSET (x, y), Colr
NEXT y
NEXT x
GET (10, 6)-(264, 18), Box(10000)
PUT (10, 6), Box(10000)
GET (500, 6)-(630, 18), Box(11200)
PUT (500, 6), Box(11200)
DEF SEG = VARSEG(Box(0))
BSAVE "brsheads.bsv", VARPTR(Box(0)), 24000
DEF SEG

LINE (160, 185)-(477, 227), 2, BF
LINE (160, 185)-(477, 227), 0, B
LINE (160, 185)-(477, 185), 5
LINE (160, 185)-(160, 227), 5

LINE (376, 194)-(393, 208), 15, BF
LINE (376, 194)-(393, 208), 0, B
LINE (377, 208)-(393, 208), 5
LINE (393, 195)-(393, 208), 5

LINE (399, 194)-(416, 208), 15, BF
LINE (399, 194)-(416, 208), 0, B
LINE (400, 208)-(416, 208), 5
LINE (416, 195)-(416, 208), 5

LINE (422, 194)-(453, 208), 15, BF
LINE (422, 194)-(453, 208), 0, B
LINE (423, 208)-(453, 208), 5
LINE (453, 195)-(453, 208), 5
PSET (395, 201), 15
DRAW "R2DNL2uBR22R2dl2"
PrintSTRING 186, 194, "Enter a target date [mm-dd-yyyy]:"
PrintSTRING 202, 209, "(Just press ENTER to restore current date)"
FOR x = 182 TO 375
FOR y = 191 TO 208
IF POINT(x, y) <> 2 THEN PSET (x, y), 15
NEXT y
NEXT x
FOR x = 182 TO 432
FOR y = 209 TO 222
IF POINT(x, y) <> 2 THEN PSET (x, y), 10
NEXT y
NEXT x
GET (160, 185)-(477, 227), Box(3500)
LINE (170, 190)-(370, 216), 2, BF
LINE (170, 209)-(432, 222), 2, BF
GET (374, 188)-(470, 210), Box
PUT (374, 193), Box, PSET
PrintSTRING 190, 199, "Enter a birth date [mm-dd-yyyy]:"
FOR x = 182 TO 375
FOR y = 199 TO 214
IF POINT(x, y) <> 2 THEN PSET (x, y), 15
NEXT y
NEXT x
GET (160, 185)-(477, 227), Box
PUT (160, 185), Box
DEF SEG = VARSEG(Box(0))
BSAVE "brsinpt.bsv", VARPTR(Box(0)), 14000
DEF SEG

LINE (200, 170)-(439, 280), 14, B
LINE (197, 167)-(442, 283), 14, B
PrintSTRING 260, 195, "The graphics files for"
PrintSTRING 231, 210, "the BIORHYTHM CHART program"
PrintSTRING 231, 224, "have been successfully created."
PrintSTRING 222, 247, "It can now be run without exploding."

a$ = INPUT$(1)
END

PixDATA:

DATA "#215#0=1=3C5=20=3@5=20=3@5=2­0=3@5=2ŗ0=2H5=2M0=4J5=10C50C5Ŧ0C5¯0=3"
DATA "M5=2J0M50=3C5=40=3C5=4Ē0=3C5=4Ģ0=1=4P5=4G0=3N5=30E5=10E5=1Š0E5=1Š0"
DATA "=3T5A0=1=2S50E5=40E5=4Š0E5=4¨0V5=3=2X5=2m0=2H5=3E0=2?5=2J0F5?0=4@5=2"
DATA "J0=2B5=2?0=4@5=3K0=2=4E5=3A0=2?5=2J0F50=2E5=3D0=2?5=2J0F5g0=2H5=3E0=4"
DATA "@5=3K0=2=4E5=3D0=4u5i0=1=3N5=1A0=1A5=3I0F5>0=3B5=2H0=2D5=3=0=4C5=3E0=2"
DATA "L5=3>0=1A5=3I0F50=2I5=3A0=1A5=3I0F5c0=1=3N5=1A0=4C5=3E0=2L5=3A0=2v5g0"
DATA "=1R5=4@0C5=3H0F5>0D5=1G0F5=1F5=3>1=2=4R5=0C5=3H0F50=1M5=1?0C5=3H0F5a0"
DATA "=1R5=4?0=1F5=3>1=2=4R5@0w5f0=4U5=1=0=3D5=1G0F5>0D5=4F0=4u5=1G0F5~0=1O5"
DATA "=2=0=3D5=1G0F5`0=4U5=1=0c5?0w5d0=1X5=2E5=4G0F5>0E5E0=1v5=4G0F5A0=4@5=3"
DATA "J0=1=4?5=3^0=1Q5=2E5=4G0F5^0=1X5=2c5=4>0w5c0=1d5G0=4E5>0E5=3D0=4w5G0=4"
DATA "E5?0=1C5=4H0=1C5\0=1]5G0=4E5J0=2?5=4J0=15=1=0w5c0e5=1F0=2E5>0F5C0=1x5"
DATA "=1F0=2E5?0E5=3G0E5[0^5=1F0=2E5I0=2B5I05=4=0w5b0=3e5=4G0E5>0F5C0y5=4G0"
DATA "E5?0F5=1F0E5=3Y0=4^5=4G0E5H0=1C5=3G0=35=0q5=2=1=4=5=4=2I0=1=3G5=3G0g5"
DATA "G0E5>0F5=3A0=2z5G0E5?0G5F0F5X0=1`5G0E5H0E5=2F05=0p5=1M0=2L5=4=1D0g5G0"
DATA "=4D5>0G5A0{5G0=4D5>0=3G5=2D0=2F5=3W0a5G0=4D5F0=1G5F05=0=4Y5=1P5=4L0=2"
DATA "P5=3C0g5G0=2D5>0=4F5=1?0|5G0=2D5>0I5D0H5V0=2a5G0=2D5E0=2H5=4E05=4=0=3"
DATA "L5=2>0=3E5=0=1B5=2=0G5=2J0=1S5=4B0g5G0=1D5>0=1G5=1=2}5G0=1D5>0I5=3B0=2"
DATA "H5=1U0b5G0=1D5E0J5=1D05=2=0=1I5=4B0D5=3F0=4F5J0=1V5A0g5H0D5?05H0D5>0"
DATA "J5=1A0I5=3T0=3b5H0D5E0K5D05=4?0H5=4B0=3D5G0=3F5I0=2W5=4@0=2f5H0D5=1>0"
DATA "=3Y5=2k5H0D5=1=0K5@0=4J5T0c5H0D5=1C0=2K5=2C0=25=4@0H5=4?0=1=3F5G0=1F5"
DATA "H0=2Y5=3@0=4e5H0D5=2>0=1X5=1=0=2Q5=3=0=1=4E5=2=0F5H0D5=2=0K5=3>0=2K5S0"
DATA "=2M5=3>1=4N5H0D5=2C0M5D0=4[5=4=2Q5=3=0=1=4E5=2A0W5=1H0F5G0=1[5=1?0=1e5"
DATA "=1G0D5=3?0W5=1H0=1=4E5=1K0F5=1G0D5=3=0=4K5>4L5S0L5=1B0=2A5=3F5=1G0D5=3"
DATA "C0M5=2C0=1[5=1F0=1=4E5=1O0V5=3I0F5G0]5@0e5=2F0=3D5=4?0=1U5=2M0=4B5L0F5"
DATA "=2F0=3D5=4=0=1]5=2R0J5=2F0@1=0F5=2F0=3D5=4B0=2N5D0[5K0=4B5P0U5=3J0F5F0"
DATA "=3]5=1?0=4Y5=2F5=3C0=1H5@0T5=2O0B5L0F5=3C0=1H5=0=1]5=4Q0=3I5=1L0F5=3C0"
DATA "=1H5B0O5=3C0=4Y5=2L0B5P0T5=1K0F5F0_5?0=1Y5=0[5@0=2R5=1P0=2A5L0[5=0=4^5"
DATA "Q0H5=4N0[5B0P5C0=1Y5M0=2A5P0T5=4J0=1F5E0=3_5=1?0G5=1>0=1=4H5=1=0[5A0Q5"
DATA "=1R0A5=2K0[5=0_5Q0G5=4O0[5A0=3P5=3C0G5=1>0=1=4H5=1N0A5=2O0U5=1I0=3F5E0"
DATA "`5=4?0F5A0=1G5=3>0[5A0=2O5=1R0=1A5=3K0[5=0_5P0=1F5=4P0[5A0R5C0F5A0=1G5"
DATA "=3N0=1A5=3O0U5=4I0=4F5D0=1a5?0F5=1?0=1H5?0[5=1A0N5=1S0=3A5=3K0[5=1_5P0"
DATA "=4E5=4Q0[5=1@0G5=3=0E5=3B0F5=1?0=1H5O0=3A5=3O0K5=4=1=4D5=1H0G5D0=4a5=1"
DATA "=0=1F5=4>0=2H5@0[5=3A0=3L5=3T0B5=4K0[5=3_5P0E5=4R0[5=3?0=3G5>0F5A0=1F5"
DATA "=4>0=2H5P0B5=4O0K5?0D5=4H0G5D0b5=3=0=3G5=3I5=1@0=4Z5=4B0L5U0C5K0=4Z5=4"
DATA "_5P0E5S0=4Z5=4?0T5=3@0=3G5=3I5=1P0C5O0=4J5>0F5H0G5D0c5=0=4T5=1A0\5B0=4"
DATA "J5=1T0=1C5K0f5>4S5P0D5=1S0\5>0=1U5@0=4T5=1P0=1C5O0=3J5=4G5=3G0G5D0c5=0"
DATA "T5C0\5B0=1J5U0D5K0f5=1=0=1I5=4=2C5P0D5L0=4@5=2>0\5>0=3U5=2?0T5R0D5O0=1"
DATA "W5G0G5D0P5=1=0=1=4K5=0S5=1C0\5C0I5=4T0=1D5K0f5?0=1H5>0C5P0C5=3K0C5=1=0"
DATA "\5>0W5?0S5=1Q0=1D5P0W5G0G5D0N5=1B0=3I5=0T5=4=1A0=4[5=1B0=3H5=1T0=4D5K0"
DATA "=4e5@0=2F5=2>0C5=2O0C5K0E5=0=4[5=1=0W5=2>0T5=4=1O0=4D5P0W5=1F0G5=2C0L5"
DATA "=1E0=3H5=2V5=3@0=1[5=3C0H5T0=1E5=1J0=1e5=1@0=3D5=4?0=4C5O0C5J0F5>1[5=3"
DATA "=2X5=0=2V5=3M0=1E5=1O0W5=3F0H5=3B0I5=4=1H0H5=4X5=2?0[5=4C0H5T0=4E5=2K0"
DATA "e5=3A0=4C5@0=2C5=1N0C5=3H0G5=3=0[5=4Y5=2=4X5=2K0=4E5=2O0=3V5=4C0=1=4M5"
DATA "=3=1=0H5=1I0=1f5=2>0=1N5=3=1=4F5C0=4G5T0F5=3K0=1N5=3=1=4O5=3B0=2@5=4B0"
DATA "D5N0D5G0=4H5=0=1N5=3=1=45=2J0F5=3O0=1W5?0=1=3S5=2F5=4K0=4g5=2>0=4H5=3"
DATA "=1A0=1F5C0=3G5S0=3F5=4L0=4H5=3=1A0=1O5=4N0D5=1M0D5=4E0=4I5>0=4H5=3=1A0"
DATA "=15=2H0=3F5=4P0V5=4=0=3a5=1J0=1T5>3O5=1>0F5=1E0F5C0=1G5S0H5M0F5=1E0P5"
DATA "N0D5=4M0=4E5=1B0=4J5?0F5=1E0o5>3O5=1G0H5P0=4U5>3b5=3I0=1T5=4?0=1N5>0=3"
DATA "E5F0F5D0F5=4R0=1H5M0=3E5F0P5N0=4D5M0=1G5=3>1=4L5?0=3E5F0O5=3>0=3W5=4?0"
DATA "=1N5F0=1H5P0=1U5=1d5=4G0=3U5=1A0=3L5?0E5=1E0F5D0F5=3R0=4H5N0E5=1E0P5N0"
DATA "=1D5=1M0[5@0E5=1E0O5A0=1=4T5=1A0=3L5F0=4H5Q0U5=0g5=4=2>0=1=2=4M5=4F5C0"
DATA "=1K5?0E5=4E0F5D0F5=3R0I5N0E5=4E0P5O0D5=4M0=1Z5@0E5=4E0O5D0=2R5C0=1K5F0"
DATA "I5Q0=3S5=3=0Z5=3`5=1F5E0=4H5=4?0F5E0F5D0F5=2R0I5N0F5E0P5O0E5N0=4X5=2@0"
DATA "F5E0N5=3F0=1P5E0=4H5=4F0I5R0S5>0Z5=4`5=0F5F0=2G5=1?0F5=2D0F5D0F5S0I5N0"
DATA "F5=2D0P5O0=3D5O0X5A0F5=2D0N5=1H0=3N5F0=2G5=1F0I5R0=2Q5=1>0=3Z5=1^5=2=0"
DATA "F5G0=1F5@0=3F5D0F5D0F5S0I5N0=3F5D0P5O0=1D5O0=1V5=1A0=3F5D0N5J0=1M5G0=1"
DATA "F5G0I5S0=4O5=2@0Z5=0=2\5=4>0=3E5I0=4D5@0=1F5D0=1E5C0=1F5S0I5N0=1F5D0=1"
DATA "O5P0D5P0=1T5=1B0=1F5D0=1M5K0=2L5I0=4D5G0I5T0N5=1A0=1Y5>0=1[5@0E5J0=3C5"
DATA "A0=4E5E0=3D5C0=4F5S0=4H5O0=4E5E0=3N5P0=2C5Q0=1R5=1D0=4E5E0=3K5=3L0=3K5"
DATA "J0=3C5G0=4H5U0=4J5=1D0=1X5@0=3W5=4A0=4D5L0=4@5=4A0=1D5=3F0=3C5C0=2F5S0"
DATA "=1H5O0=1D5=3F0=3M5Q0C5S0=4N5=3F0=1D5=3F0=3J5=1M0B5=4D5L0=4@5=4G0=1H5V0"
DATA "=2F5=2I0=3M5=3>1=4A5B0=3T5=1C0C5=4M0=1?3C0=2C5H0=1A5=2D0=4E5T0=1G5P0=2"
DATA "C5H0=1A5=2F5Q0=2B5T0=1K5=3I0=2C5H0=1I5N0=3A5=0C5=4M0=1?3I0=1G5q0=3F5=3"
DATA "=1D0=3>4=2E0=1=3M5=4=1E0=1A5=4Z0=2A5=1J0=2>5=4F0=4C5=4V0=2D5=2Q0=2A5=1"
DATA "J0=2>5=4=0F5R0=2@5=1V0=1=3E5=4=1L0=2A5=1J0=2>5>4C5N0=1@5=4=0=1A5=4a0=2"
DATA "D5=2!z0C5=10F5¨0=1B5=4#10D#0=1B50F5Š0=1A5=1#10E#0=1=4?5=40=3D5=2Ģ0=2"
DATA "?5#16A#0D5#1DF#0=4A5=1#284#0=4>5=2Ĩ0=3@5=40=4=5=3U0=3@5=4i0=3@5=4!C0=3"
DATA "@5=4a0=3@5=4K0=3@5=4=1=2=1A0=2?5=4r0=2E5=2U0=3>5=2=1=3A5>3D5=1N0=4=5=3"
DATA "H0=3>5=2W0=3=5=4@0?5=0>5=4?0=4>5=2>0=2B5=2=0=3D5=1>0=2@5=3H0=3>5=2M0=3"
DATA "D5=1B0=4=5=3=0=3>5=2=1=3A5=3=2E5=2>0=3>5=2B0=3>5=2A0=2E5=2@0=2@5=3=0=3"
DATA ">5=2=1=3A5=3R0=3>5=2M0=3D5=1B0=4=5=3=0=3>5=2=1=3A5=3G0=3D5=4>5=2=1=3A5"
DATA ">3G5A0=4?5=3E5=2h0G5=2C0=1=2K0Q5=3M0=2?5=1G0=4?5=1L0=1C5=3=0?5=2?0?5=0"
DATA "?5=1=0=1?5=3=1E5=4E5=3=0=2B5=3G0=4?5=1L0E5=3A0=2?5=1S5=2=0=4?5=1A0=4?5"
DATA "=1@0G5=2>0=2B5=3H5=3?5=2=0=2?5=3G0=4?5=1L0E5=3A0=2?5=1H5=3?5=2=0=2?5=3"
DATA "]5=2?0=1K5=2g0F5=4=1=2>5=2>0=2>5=4J0O5=3=2=1G0=3>5=1>0=3?5=2?0=3=5=4A0"
DATA "@5=3L0I5=3?0?5=0?5=3=0@5=4G5=4B5=3=2>1D5=1>0=3=5=4A0@5=3L0=4B5=3=2=4>5"
DATA "=1>0=3?5=2R5=4=1=0@5=3A0@5=3@0F5=4=1=0=1P5=4@5=0A5=3>0=3=5=4A0@5=3L0=4"
DATA "B5=3=2=4>5=1>0=3?5=2H5=4@5=0A5=4B5=3=2O5=3=2?5=4?0=4J5=4=1g0=2@5=4=3=1"
DATA "@0=4?5=1=0=4?5=2?0=1=4A5=1>0=3C5=2?5=1=4A5@0=1=4A5=1>0@5=1=0=1?5=3>0=3"
DATA "?5=3?0=1@5=2L0F5=4>5=4?0?5=0=4>5=4=3D5=1>0=1@5=3=4A5?0=4@5=2=4>5=1=0=3"
DATA "?5=3?0=1@5=2L0=1=4A5>0@5=1=0=1?5>3C5=2?5=3@5=4=3=1@0=1@5=2@0=1@5=2@0=2"
DATA "@5=4=3=1A0=4@5=2=4>5=4C5=2D5=0B5=0=3?5=3?0=1@5=2L0=1=4A5>0@5=1=0=1?5>3"
DATA "C5=2D5=0B5=4A5>0=3C5=2?5=1=4A5>0=3?5>0=1@5=4=2@5=4=3=1l0?5=1C0A5=3@5=3"
DATA ">0=1D5=2A0=3?5D0?5?0=1D5=2=0A5=1=0=4>5=4>0A5=1>0=1@5M0?5=4=1>0=3A5=4?0"
DATA "?5=0=1D5=1=4?5=4=1=0=1?5=2?0?5>0=1@5?0=4=5=1=0A5=1>0=1@5Q0?5>0A5=1=0=4"
DATA ">5=4@0=3?5A0?5=1C0=1@5A0=1@5B0?5=1C0=1@5?0=4=5=1?0=3?5@0A5=0=4A5=0A5=1"
DATA ">0=1@5Q0?5>0A5=1=0=4>5=4@0=3?5@0A5=0=4A5?0?5B0=3?5D0?5>0=1?5=1=0=4@5=2"
DATA "=0?5=1o0?5=4=3=4?5=3=0=4E5=4=0=1F5=1A0?5D0?5>0=1F5=1B5=1=2>5=4=0=2A5=4"
DATA ">0=3?5=2M0?5@0=1B5=0=1=4?5=1=0=4B5=1>0=4D5=4@0?5>0=3?5C0=2A5=4>0=3?5=2"
DATA "Q0?5>0B5=1=2>5=4A0?5A0?5=4=3=4?5=3=0=3?5=2A0=3?5=2B0?5=4=3=4?5=3=0=3?5"
DATA "G0?5@0A5=0=3@5=3=2A5=4>0=3?5=2Q0?5>0B5=1=2>5=4A0?5@0A5=0=3@5=3?0?5C0?5"
DATA "D0?5?0=4>5>3A5>0?5=4=3=4?5=3h0=1F5=1F5=4=0=4F5=3A0?5D0?5>0=4F5=3=4B5=3"
DATA ">5=4=0=4B5=1=0=3>5=4N0?5=3=0=1=4I5=2=0=2A5=1@0=1=3=4A5=2@0?5>0=4>5=2C0"
DATA "=4B5=1=0=3>5=4R0?5>0=4B5=3>5=4A0?5@0=1F5=1=3>5=4B0=3>5=4B0=1F5=1=4>5=2"
DATA "G0?5@0@5=4>0@5=1=4B5=1=0=3>5=4R0?5>0=4B5=3>5=4A0?5@0@5=4>0@5=1?0?5C0?5"
DATA "D0?5?0=2D5=2=0=1F5=1g0=3F5=3F5=4=0G5=4@0=1?5C0=1?5>0G5=4=3E5=4=0C5=4=0"
DATA "=4>5=1N0E5=4=3E5=3>0@5=4F0=2?5?0=1?5>0?5D0C5=4=0=4>5=1Q0=1?5>0=3E5=4@0"
DATA "=1?5@0=3F5=3=4>5=1B0=4>5=1B0=3F5=3?5G0=1?5@0@5=3>0=4?5=0C5=4=0=4>5=1Q0"
DATA "=1?5>0=3E5=4@0=1?5@0@5=3>0=4?5?0=1?5B0=1?5C0=1?5@0C5=4>0=3F5=3g0=4@5=3"
DATA "=1=0=1>5=3?5=1C5=1A5=3=1=0=2?5@0=3?5C0=2?5=1=0A5=3=1=0=2?5=1?5=2B5=2D5"
DATA "=1=4>5O0D5=4=0=2E5=4>0=3?5=3?0=3?5=4=1=0=1?5?0=2?5=1=0?5=1>0=1>5=4=2D5"
DATA "=1=4>5R0=2?5=1=0=1?5=2B5@0=3?5@0=4@5=3=1=0=1>5=3=4>5C0=4>5C0=4@5=3=1=0"
DATA "=1>5=3?5=1>0=1>5=4@0=3?5@0=4?5=1>0=1?5=2D5=1=4>5R0=2?5=1=0=1?5=2B5@0=3"
DATA "?5@0=4?5=1>0=1?5?0=2?5=1A0=3?5C0=2?5=1?0=3B5=1>0=4@5=3=1=0=1>5=3g0=4@5"
DATA "=2=0=1=3=2>0?5A0=3>5=3?5=2?0=1@5@0=4?5A0=2=4E5=2?0=1@5=1?5>0=4@5=4D5=4"
DATA "?5>1@5I0B5=4=1?0=4?5=4=3=2?5>0=2?5=1?0G5=0=2=4F5=1=3@5=4D5=4?5>1@5J0=2"
DATA "=4B5=1?5>0=4@5@0=4?5@0=4@5=2=0=1=3=2>0?5>1@5=0?5>1@5=0=4@5=2=0=1=3=2>0"
DATA "@5=1=3@5@0=4?5@0=3?5@0H5=4?5>1@5J0=2=4B5=1?5>0=4@5@0=4?5@0=3?5@0?5>2=4"
DATA "B5=1?0=4?5A0=2=4B5=1=0=1A5=4?0=4@5=2=0=1=3=2i0G5=1?5A0=1?5=4G5@0@5@0E5"
DATA "=4G5=0?5?0=2?5=4>5=2=1=4I5=4H0=4>5=1C0=2>5=4?0?5>0=1?5=1?0=4E5=3O5=4>5"
DATA "=2=1=4I5=4H0E5=4?5?0=2?5@0@5@0G5=1E5=4E5=4G5=1=3E5@0@5@0=1?5=1?0?5=4>5"
DATA "=2=1=4I5=4H0E5=4?5?0=2?5@0@5@0=1?5=1?0H5=4?0@5@0E5=4>0A5=1?0G5=1g0K5B0"
DATA "=4>5=1F5=3@0@5@0=4O5=3=0?5@0=2A5@0I5H0=3>5D0=1?5?0?5>0=1?5=1?0=3D5=3=0"
DATA "=4E5=4C5=2?5@0I5H0=4H5@0=2>5@0@5@0h5=1=4C5=2@0@5A0=4>5=4=0=2C5@0I5H0=4"
DATA "H5@0=2>5@0@5A0=4>5=4=0=2@5=4E5?0@5@0=4E5>0=4?5=3@0H5=1f0=3J5B0=2>5=1=0"
DATA "=4C5=3A0=3?5A0=4D5=0=4C5=3>0=2>5A0>4>5=4A0>5=2@5=2M0>5=3D0=4>5?0=1=5=4"
DATA ">0=1?5A0=3B5=1?0=4D5=0=3A5=1=0>5=4A0>5=2@5=2M0=4D5=2>5A0>4@0=3?5@0=3G5"
DATA "=3@5=2@0=2@5=2@0=3G5=1=0=3A5=1A0=3?5B0=4A5=1@5=4A0>5=2@5=2M0=4D5=2>5A0"
DATA ">4@0=3?5B0=4A5=1?5=4D5?0=3?5A0=4D5>0=3>5=4A0=3G5=1m0=1=4>5=4?5}0=3=5=3"
DATA "q0=2=5=4^0=3=5=30=1=4>5=4W0=1=4>5=4[0=4?5=30=4>5l0=1=4>5=4s0=4=5=4#95C#0"
DATA "AEI0>EI0>E=0>EG0>E=0>EG0>EH0?EH0>EH0>EJ0>EH0>E0>EG0@EH0>EH0@EG0@EI0>E"
DATA "F0BEF0@EF0BEF0@EG0@E0@EG0?E?0?EG0>EI0>E=0>EG0>E=0>EF0@EF0>E=0>E=0>EC0"
DATA "@EG0>EI0>EJ0>EH0@E0>EF0>E>0>EE0@EG0>E>0>EE0>E>0>EG0?EF0>EI0>E>0>EI0>E"
DATA "E0>E>0>EE0>E>0>E0>E>0>EF0>EA0>EG0>EI0>E=0>EF0CED0BEF0?E=0>ED0@EG0>EI0"
DATA ">EJ0>EI0>E0>EF0>E>0>EG0>EK0>EI0>EG0?EF0>EI0>EL0>EF0>E>0>EE0>E>0>Ef0>E"
DATA "U0>EM0>EE0>E>0@E=0>EF0>EY0>E=0>EE0@EK0>EF0>EW0>EJ0>EH0@EI0>Ev0>EG0>E>0"
DATA ">EG0>EK0>EI0>EF0@EF0AEF0>EL0>EF0>E>0>EE0>E>0>EE0>EJ0>EJ0>EW0>EL0>EE0>E"
DATA "=0>E=0>E=0>EF0>EY0>E=0>EF0?EJ0>EG0>EW0>EJ0>EY0>Ev0>EG0>E>0>EG0>EJ0>EH0"
DATA "?EG0@EF0>E>0>EE0AEH0>EH0@EG0AEd0>EH0BEG0>EJ0>EF0>E=0>E=0>E=0>EF0>EY0>E"
DATA "=0>EG0?EH0>EG0BET0>EJ0>EW0BET0?EX0>EH0>E>0>EG0>EI0>EK0>EE0>E=0>EJ0>EE0"
DATA ">E>0>EG0>EG0>E>0>EI0>Ec0>E[0>EH0>EG0>E>0CEF0>EX0CEF0@EF0>E=0?ED0>E=0>E"
DATA "U0>EJ0>EY0>Eu0>EH0>E>0>EG0>EH0>EL0>EE0BEI0>EE0>E>0>EF0>EH0>E>0>EI0>Ed0"
DATA ">EH0BEG0>EI0>EH0>Em0>E=0>EE0BEE0>E=0>E=0>EC0>E=0>EU0>EJ0>EY0>Et0>EI0>E"
DATA ">0>EG0>EG0>EI0>E>0>EH0>EF0>E>0>EE0>E>0>EF0>EH0>E>0>EE0>E>0>Ee0>EW0>EX0"
DATA "?EM0>EY0>E=0>EF0@EJ0?EE0AET0>EJ0>Eg0>EW0>EI0>EJ0@EH0>EG0BEF0@EI0>EG0@E"
DATA "G0@EG0>EI0@EG0@EF0>EJ0>EK0>EU0>EK0>EK0@Ex0>Et0>EJ0>Ef0>E!0>E!0>EH0>E"
DATA "#6ED#0>En0>EF0AEG0AEE0AEF0BEE0BEF0AEE0>E?0>ED0>EL0>EF0>E>0>EE0>EI0>E@0"
DATA ">EC0>E?0>EE0AEE0BEF0AEE0BEF0@EF0BEE0>E?0>ED0>E@0>EC0>ED0>E?0>E@0>EC0>E"
DATA "@0>EC0DEC0?EH0>EI0?EI0@EU0>ER0>EF0>E>0>EE0>E?0>ED0>E>0>EE0>EI0>EI0>E?0"
DATA ">ED0>E?0>ED0>EL0>EF0>E=0>EF0>EI0>E@0>EC0?E>0>ED0>E?0>ED0>E?0>ED0>E?0>E"
DATA "D0>E?0>ED0>E>0>EG0>EG0>E?0>ED0>E@0>EC0>ED0>E?0>E@0>EC0>E@0>EI0>EC0>EI0"
DATA ">EJ0>EH0>E>0>EU0>EP0@EE0>E>0>EE0>EI0>E?0>ED0>EI0>EI0>EI0>E?0>ED0>EL0>E"
DATA "F0@EG0>EI0?E>0?EC0?E>0>ED0>E?0>ED0>E?0>ED0>E?0>ED0>E?0>ED0>EK0>EG0>E?0"
DATA ">EE0>E>0>EE0>E>0>E>0>EA0>E>0>EE0>E>0>EI0>ED0>EI0>EJ0>E}0@EE0>E>0>EE0>E"
DATA "I0>E?0>ED0>EI0>EI0>EI0>E?0>ED0>EL0>EF0?EH0>EI0?E>0?EC0@E=0>ED0>E?0>ED0"
DATA ">E?0>ED0>E?0>ED0>E?0>ED0>EK0>EG0>E?0>EE0>E>0>EE0>E>0>E>0>EB0@EG0@EI0>E"
DATA "E0>EJ0>EI0>E|0>E>0>ED0AEF0>EI0>E?0>ED0AEF0AEF0>E=0@ED0CED0>EL0>EF0?EH0"
DATA ">EI0DEC0@E=0>ED0>E?0>ED0BEE0>E?0>ED0BEF0@EH0>EG0>E?0>EE0>E>0>EE0>E>0>E"
DATA ">0>EC0>EI0>EI0>EF0>EJ0>EI0>E|0>E>0>ED0>E>0>EE0>EI0>E?0>ED0>EI0>EI0>E?0"
DATA ">ED0>E?0>ED0>EL0>EF0@EG0>EI0DEC0>E=0@ED0>E?0>ED0>EI0>E?0>ED0>E?0>EH0>E"
DATA "G0>EG0>E?0>EF0@EG0DEC0@EH0>EH0>EG0>EK0>EH0>E|0BED0>E>0>EE0>EI0>E?0>ED0"
DATA ">EI0>EI0>E?0>ED0>E?0>ED0>EI0>E=0>EF0>E=0>EF0>EI0>E=0>E=0>EC0>E>0?ED0>E"
DATA "?0>ED0>EI0>E=0@ED0>E?0>EH0>EG0>EG0>E?0>EF0@EG0DEB0>E>0>EG0>EG0>EH0>EK0"
DATA ">EH0>E{0>E@0>EC0>E>0>EE0>E?0>ED0>E>0>EE0>EI0>EI0>E>0?ED0>E?0>ED0>EI0>E"
DATA "=0>EF0>E>0>EE0>EI0>E=0>E=0>EC0>E>0?ED0>E?0>ED0>EI0>E>0?ED0>E?0>ED0>E>0"
DATA ">EG0>EG0>E?0>EG0>EI0>E>0>EB0>E@0>EF0>EF0>EI0>EL0>EG0>E{0>E@0>EC0AEG0AE"
DATA "E0AEF0BEE0>EJ0BED0>E?0>ED0>EJ0?EG0>E?0>ED0BEE0>E@0>EC0>E?0>EE0AEE0>EJ0"
DATA "AEE0>E?0>EE0@EH0>EH0AEH0>EI0>E>0>EB0>E@0>EF0>EF0DEC0>EL0>EG0>E#134#0>E"
DATA "!K0>EY0>E#1C5#0?EW0?EW0CE#571#0>EV0>E0>E\0>EU0>EW0>EI0>EI0>EI0>EI0>E!0"
DATA ">EH0>EJ0>E0>E\0>ET0>EX0>Eg0>EI0>E˛0>E¤0>EH0>EJ0>EI0?E=0>Ew0>E\0>ET0>E"
DATA "X0>Eg0>EI0>E˛0>E¤0>EH0>EJ0>EH0>E=0?Ej0@EF0AEG0@EG0AEF0@EF0?EI0AEE0AEF0"
DATA ">EI0>EI0>E=0>EF0>EI0CED0AEG0@EF0AEG0AEE0?EI0?EG0?EH0>E>0>EE0>E>0>EE0>E"
DATA "=0>E=0>EC0>E=0>EG0>E=0>EE0AEG0>EH0>EJ0>E0>EE0>E>0>EE0>E>0>EE0>E>0>EE0"
DATA ">E>0>EE0>EI0>E>0>EE0?E=0>EE0>EI0>EI0@EG0>EI0>E=0>E=0>EC0?E=0>EE0>E>0>E"
DATA "E0>E>0>EE0>E>0>EE0>EI0>E=0>EF0>EI0>E>0>EE0>E>0>EE0>E=0>E=0>EC0>E=0>EG0"
DATA ">E=0>EH0>EF0>EI0>EK0>E{0AEE0>E>0>EE0>EI0>E>0>EE0BEE0>EI0>E>0>EE0>E>0>E"
DATA "E0>EI0>EI0?EH0>EI0>E=0>E=0>EC0>E>0>EE0>E>0>EE0>E>0>EE0>E>0>EE0>EJ0>EH0"
DATA ">EI0>E>0>EF0@EF0DED0?EH0>E=0>EG0>EH0>EH0>EJ0>E{0>E>0>EE0>E>0>EE0>EI0>E"
DATA ">0>EE0>EI0>EI0>E>0>EE0>E>0>EE0>EI0>EI0@EG0>EI0>E=0>E=0>EC0>E>0>EE0>E>0"
DATA ">EE0>E>0>EE0>E>0>EE0>EK0>EG0>EI0>E>0>EF0@EF0DED0?EH0>E=0>EF0>EI0>EH0>E"
DATA "J0>E{0>E>0>EE0>E>0>EE0>E>0>EE0>E>0>EE0>E>0>EE0>EI0>E>0>EE0>E>0>EE0>EI0"
DATA ">EI0>E=0>EF0>EI0>E=0>E=0>EC0>E>0>EE0>E>0>EE0>E>0>EE0>E>0>EE0>EI0>E=0>E"
DATA "F0>EI0>E=0?EG0>EH0>E>0>ED0>E=0>EH0?EF0>EJ0>EH0>EJ0>E|0AEE0AEG0@EG0AEF0"
DATA "@EF0>EJ0AEE0>E>0>EE0>EI0>EI0>E>0>EE0>EI0>E=0>E=0>EC0>E>0>EF0@EF0AEG0AE"
DATA "E0>EJ0?EH0>EI0AEG0>EH0>E>0>ED0>E=0>EH0>EG0AEG0>EH0>EJ0>E!Y0>Ec0>E0>EM0"
DATA ">E°0>EX0>EG0>EI0>E!V0AEd0>E0>EM0>EŽ0?E´0"

SetPALETTE:
RESTORE SetPALETTE
DATA 0, 0, 21, 21, 8, 43, 24, 10, 48, 26, 11, 53
DATA 28,12,58, 32, 13, 63, 63, 63, 21, 42, 42, 42
DATA 63, 0, 0, 21, 31, 63, 42, 42, 42, 55, 55, 55
DATA 0, 0, 42, 63, 21, 63, 32, 32, 42, 63, 63, 63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Colr
OUT &H3C9, Colr
NEXT n
RETURN

SUB PrintSTRING (x, y, Prnt$)

FOR i = 1 TO LEN(Prnt$)
Char$ = MID$(Prnt$, i, 1)
IF Char$ = " " THEN
x = x + FontBOX(1)
ELSE
Index = (ASC(Char$) - 33) * FontBOX(0) + 2
PUT (x, y), FontBOX(Index)
x = x + FontBOX(Index)
END IF
NEXT i

END SUB
