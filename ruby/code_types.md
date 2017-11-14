```
Add Ardyn to guest slot
80010007 0BE999E5
5D010100 00000000
28000007 00000004
80050005 3F89CFA5
62000000 00000000
28000005 00000004
````

offsets are zero indexed!!

starting hex value:
0B E9 99 E5 5D 01 01 FF FF FF FF 03 01
                     ^ offset 7  ^ offset 11
                     
offset 0 is start of search.

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

001FC6F0   C1 B1 0C 94 C0 05 00 00  00 C0 55 F2 3F 89 CF A5 
001FC700   62 00 00 00 00 C0 55 F2  3F 89 CF A5 62 01 00 00 
001FC710   00 C0 55 F2 3F 89 CF A5  62 02 00 00 00 C0 55 F2 
001FC720   3F 89 CF A5 62 03 00 00  00 C0 55 F2 3F 89 CF A5
001FC730   62 FF FF FF FF 06 00 00  00 F1 23 ED AB 33 51 EE 
001FC740   5F                                                 _

match 5th '3F 89 CF A5 62'

3F 89 CF A5 62 FF FF FF FF 06
               ^ offset 5
----

I think this is what it means:

80010007 0BE999E5
5D010100 00000000

search (8) one time (001) and match 7 bytes (0007) for the value "0BE999E55D0101". Each hex pair is a byte.

28000007 00000004

32-bit write (2) offset from pointer (8) using offset 7 (000007) write "04 00 00 00".
write contents are reversed due to big edian vs little edian.

1800000B 00000003 
16 bit write (1) offset from pointer (8) using offset 11 (B) write "03 00"	

80050005 3F89CFA5
62000000 00000000

search (8) five times (005) and match 5 bytes (0005) for the value "3F89CFA562"

28000005 00000004

32-bit write (2) offset from pointer (8) using offset 5 (000005) write "04 00 00 00"


----


before hex:

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

000E04B0                                           0B E9 99                 é™
000E04C0   E5 5D 01 01 FF FF FF FF  03 01 00 00 00 0C 00 00   å]  ÿÿÿÿ        
000E04D0   00 00 03 00 00 00 03 00  00 00 00 32 08 00 00 32              2   2

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

001FC720                                        3F 89 CF A5               ?‰Ï¥
001FC730   62 FF FF FF FF 06 00 00  00 F1 23 ED AB 33 51 EE   bÿÿÿÿ    ñ#í«3Qî
001FC740   5F A3 AE 01 01 00 00 00  00 00 00 00 00 00 13 00   _£®             



-----


Add Ardyn to guest slot
80010007 0BE999E5
5D010100 00000000
28000007 00000004
1800000B 00000003
80050005 3F89CFA5
62000000 00000000
28000005 00000004

Add Aranea Highwind to guest slot 
80010007 0BE999F0
97000100 00000000
28000007 00000004
1800000B 00000003
80050005 3F89CFA5
62000000 00000000
28000005 00000005

Add Cor Leonis to guest slot
80010007 0BE999AC
97000100 00000000
28000007 00000004
1800000B 00000003
80050005 3F89CFA5
62000000 00000000
28000005 00000006

Add Iris Amicitia to guest slot
80010007 0BE999E6
5D010100 00000000
28000007 00000004
1800000B 00000003
80050005 3F89CFA5
62000000 00000000
28000005 00000007

Add Umbra to guest slot
80010007 0BE999E7
5D010100 00000000
28000007 00000004
1800000B 00000003
80050005 3F89CFA5
62000000 00000000
28000005 00000008

Clear guest slot
80050005 3F89CFA5
62000000 00000000
28000005 FFFFFFFF

------

Code Types																									
																									
0TXXXXXX 000000YY = 8Bit Write																									
1TXXXXXX 0000YYYY = 16Bit Write					http://forum.thegamegenie.com/viewtopic.php?f=36&t=5744																				
2TXXXXXX YYYYYYYY = 32Bit Write																									
																									
X= Address/Offset																									
Y= Value to write																									
T=Address/Offset type (0 = Normal / 8 = Offset From Pointer																									
					80010008 B2692691	means search for B269269167BCE244 																			
Multi Write					67BCE244 00000000																				
4TXXXXXX YYYYYYYY																									
4NNNWWWW VVVVVVVV																									
																									
X= Address/Offset																									
Y= Value to write (Starting)																									
N=Times to Write																									
W=Increase Address By			save wizard limits to 128 codes per named cheat i think																						
V=Increase Value By																									
T=Address/Offset type																									
Normal/Pointer				FF XV:																					
0 / 8 = 8bit				XXXXXXX = LITTLE-ENDIAN FORMAT																					
1 / 9 = 16bit				YYYYYYYY = BIG-ENDIAN FORMAT																					
2 / A = 32bit				Replace ALL xItem with yItem																					
				80010008 AE5F92XX																					
Search Type				XXXXXX02 00000000																					
8ZZZXXXX YYYYYYYY				28000003 YYYYYYYY																					
																									
Z= Amount of times to find before Write																									
X= Amount of data to Match																									
Y= Seach For (note can be xtended for more just continue it like YYYYYYYY YYYYYYYY under it)																									
Once u have your Seach type done then place one of the standerd code types under it with setting T to the Pointer type																									
																									
Fill Type																									
ATXXXXXX 0000YYYY																									
																									
T = type 0 = Normal Address 8 = Pointer Style																									
X = Address/Offset																									
Y = Amount to Fill																									
																									
A0000000 0000000C																									
99999999 99999999																									
99999999 00000000																									
would write 99 From 00 to 0B																									
																									
-----																									
																									
0 = single byte																									
1 = 2 bytes																									
2 = 4 bytes																									
4 = multi-line (begin from - end to)																									
8 = search value																									
