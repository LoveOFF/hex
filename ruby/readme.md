# ruby_hex

---

run_parse_weapons -> add weapons
run_parse_inventory -> add items / check for unknown items
run_parse_accessories -> add accessories

`run_code_dump.rb` - dumps codes from a save file.

slot 2 - valid
slot 3 - all


--

Useful tools:

- codes http://web.save-editor.com/tool/wse_patchcode_usercheats_xml.html
- usercheats.xml http://web.save-editor.com/tool/wse_patchcode_usercheats_xml.html

C: \ Users \ user name \ Documents \ PS4Saves_Backup \ usercheats.xml

C:\Users\surface\Documents\Save Wizard for PS4 MAX\PS4 Saves Backup\swusercheats.xml

bypasses the 128 limit -- that's just imposed by the GUI.

--

Import procedure:

- Advance edit -> Replace files in %TEMP%\SWPS4MAX
- Open slot. Edit the save (replace any value). Now press import button.
- `_file___gameplay____slot4__gameplay0.save` will be generated for each modified slot and that's what's uploaded.

Workflow:

- Copy known good save onto flash drive to benefit from caching
- Advanced edit in Save Wizard. Advanced edit in Save Wizard. Wait for saves to populate in the temp folder `%Temp%\SWPS4MAX`
- Apply Ruby flask patch via main.rb
- Select slot 2 in advance mode. Now press export button to load in the changes from the temp dir.
- Reload via export button (patched executable using reflexil code injection & reflector)
- Now save and load onto the console

---


- Must use 1 indexing on items because item quantity starts at 1 (not zero).

---

save location:

FF XV (US):
D:\PS4\SAVEDATA\70ac5dc3fa09b89f\CUSA01633

FF XV (EU):
D:\PS4\SAVEDATA\21d7a54e456978b5\CUSA01615

---

Must use File.binread / File.binwrite. Regular file methods will corrupt the data.

----

```
Discovered Item Codes  
Type            Count
Battle Items      64
Event Items      207
Ingredients      118
Treasures        256
Car Parts        220
Leisure Items    159

Inventory Section Limits  
Type         Count
Battle Items    64
Event Items    256
Ingredients    256
Treasures      256
Car Parts      256
Leisure Items  256
```

-----

Slots: (baseline_flares.save)
Flare [slot 0]
 Limit Break Level 99
 Amount x99
 Potency 9999
Electron
 Limit Break Level 99
 Amount x99
 Potency 9999
Freeze
 Limit Break Level 99
 Amount x99
 Potency 9999
Freecast: Firaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Freecast: Thundaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Freecast: Blizzaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Flare
  Limit Break Level 99
  Amount x99
  Potency 9999
Electron
  Limit Break Level 99
  Amount x99
  Potency 9999
Freeze
  Limit Break Level 99
  Amount x99
  Potency 9999
Freecast: Firaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Freecast: Thundaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Freecast: Blizzaga
 Limit Break Level 99
 Amount x99
 Potency 9999
Flare
 Limit Break Level 99
 Amount x99
 Potency 9999
Electron
 Limit Break Level 99
 Amount x99
 Potency 9999
Freeze
 Limit Break Level 99
 Amount x6
 Potency 191
  
  ----
  
  
Flare - missing icon, no limit break
 Level 25,345
 Amount 99
 Potency 2559745


-

'8A D2 D1 01 AF 89 E6 90  73 80 03 01'.gsub(' ', '')

-----


Flares:


Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

0026E950                                              8A D2                 ŠÒ
0026E960   D1 01 AF 89 E6 90 73 80  03 01 63 00 00 00 00 FF   Ñ ¯‰æ s€  c    ÿ
0026E970   FF FF FF FF FF FF FF 8B  2A 01 0B B3 2B 01 0B 09   ÿÿÿÿÿÿÿ‹*  ³+   
0026E980   00 00 00 92 81 03 01 0F  27 00 00 9C 31 03 01 63      ’    '  œ1  c
0026E990   00 00 00                                              

----

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

0026EA90                                        8A D2 D1 01               ŠÒÑ 
0026EAA0   AF 89 E6 90 73 80 03 01  63 00 00 00 00 FF FF FF   ¯‰æ s€  c    ÿÿÿ
0026EAB0   FF FF FF FF FF 8B 2A 01  0B B3 2B 01 0B 09 00 00   ÿÿÿÿÿ‹*  ³+     
0026EAC0   00 92 81 03 01 0F 27 00  00 9C 31 03 01 63 00 00    ’    '  œ1  c  
0026EAD0   00                                                  

---

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

0026EBD0                                  8A D2 D1 01 AF 89             ŠÒÑ ¯‰
0026EBE0   E6 90 73 80 03 01 63 00  00 00 00 FF FF FF FF FF   æ s€  c    ÿÿÿÿÿ
0026EBF0   FF FF FF 8B 2A 01 0B B3  2B 01 0B 09 00 00 00 92   ÿÿÿ‹*  ³+      ’
0026EC00   81 03 01 0F 27 00 00 9C  31 03 01 63 00 00 00          '  œ1  c   


1: 8AD2D101AF89E690738003016300000000FFFFFFFFFFFFFFFF8B2A010BB32B010B09000000928103010F2700009C31030163000000
2: 8AD2D101AF89E690738003016300000000FFFFFFFFFFFFFFFF8B2A010BB32B010B09000000928103010F2700009C31030163000000
3: 8AD2D101AF89E690738003016300000000FFFFFFFFFFFFFFFF8B2A010BB32B010B09000000928103010F2700009C31030163000000

1: 8B 2A 01 0B B3 2B 01 0B 09
2: 8B 2A 01 0B B3 2B 01 0B 09
3: 8B 2A 01 0B B3 2B 01 0B 09 

'73 80 03 01  63'
'92 81 03 01  0F 27'
'9C 31 03 01  63'

--

dropbox containing codes:

https://www.dropbox.com/sh/y61pif3dcyc81rl/AAAPYBdOBgL-2e4wZhrCNnCFa?dl=0

