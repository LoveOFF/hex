slot 2 [3]
sold Squeaky Hammer (no item description) ~ F5 0B 03 01 02


F5 0B 03 01 02 -> F5 0B 03 01 00 !
C5 0F 05 01 04 ** deleted
17 11 03 01 05 added


slot 3 [4]
sold Death Penalty ~ 33 66 03 01 02

33 66 03 01 02 x2 => 33 66 03 01 02 x1  !
C5 0F 05 01 04 ** deleted
33 66 03 01 00 added
33 66 03 01 04 added

slot 4 [5]
sold Apocalypse ~ 0C 66 03 01 02

0C 66 03 01 02 x2 => 0C 66 03 01 02 x1  !
0C 66 03 01 00 added
C5 0F 05 01 04 ** deleted
D4 CF 04 01 05 added

slot 5 [6]
sold Balmung ~ FF 65 03 01 02

C5 0F 05 01 04 ** deleted
00 66 03 01 05 added
FF 65 03 01 00 x1 => FF 65 03 01 00 x2  !
FF 65 03 01 02 deleted


slot 6 [7]
sold Flayer ~ 19 66 03 01 02

19 66 03 01 00 x1 => 19 66 03 01 00 x2  !
19 66 03 01 02 deleted
1A 66 03 01 05 added
C5 0F 05 01 04 ** deleted

slot 7 [8]
sold Drill breaker Plus ~ 4C 9E 03 01 06

4C 9E 03 01 06 x1 => 4C 9E 03 01 04 x1  !
C5 0F 05 01 04 ** deleted
D4 FB 01 01 04 added

slot 8 [9]
sold Noiseblaster Plus ~ 4B 9E 03 01 06

4B 9E 03 01 06 => 4B 9E 03 01 04  !
4C 9E 03 01 04 added
C5 0F 05 01 04 ** deleted

slot 9 [10]
sold Gravity Well Plus ~ 49 9E 03 01 06

49 9E 03 01 06 => 49 9E 03 01 04  !
4B 9E 03 01 04 added
C5 0F 05 01 04 ** deleted


-----

valid numbers [present] -> [sold]

F5 0B 03 01 02 -> F5 0B 03 01 00 !
33 66 03 01 02 x2 => 33 66 03 01 02 x1  !
0C 66 03 01 02 x2 => 0C 66 03 01 02 x1  !
FF 65 03 01 00 x1 => FF 65 03 01 00 x2  !
19 66 03 01 00 x1 => 19 66 03 01 00 x2  !
4C 9E 03 01 06 x1 => 4C 9E 03 01 04 x1  !
4B 9E 03 01 06 => 4B 9E 03 01 04  !
49 9E 03 01 06 => 49 9E 03 01 04  !


present -> sold

02 -> 00
02 -> deleted completely
00 -> 2x 00
06 -> 04


06/03/02 -- all seem valid
00/04 -- not present?


----

Afrosword can't be sold

------

todo ... after collecting item ids ....

buy a ton of items. then add unkown items in incremental order.

x1
x2
x3 etc.

determine how many base items are needed if we want to uncover 200 items using 8 save slots.

item_amounts = (1..200).to_a

puts item_amounts :&+

---

 item_amounts[0..40].inject(0, :+)
=> 861

looks like ~40 item ids can be discovered per save with 9 known items.
will take 5 save slots to discover each item.


-------------------------

C:\Users\surface\Desktop\ps4\saves\FF_XV\tmp_weapon_debug

Blazefire Saber
Ragnarok
Masamune
Genji Blade
Gae Bolg
Mage Mashers
Lion Heart

todo:
* save decrypted baseline
* add 500 apoc & verify they show up in game
  it worked!!!
* add remaining weapon codes


SW is having problems.... servers appear to be down.
https://www.facebook.com/savewizardps4/

----

110 valid weapons out of 200 weapon codes.
valid = shows up in weapon sell screen.

----

Slot #2 [3]
14 AA 01 01 x2
15 AA 01 01 x3
16 AA 01 01 x4
17 AA 01 01 x5
18 AA 01 01 x6
19 AA 01 01 x7
1A AA 01 01 x8
1B AA 01 01 x9
1C AA 01 01 x10
1D AA 01 01 x11
1E AA 01 01 x12
1F AA 01 01 x13
20 AA 01 01 x14
21 AA 01 01 x15
22 AA 01 01 x16
23 AA 01 01 x17
24 AA 01 01 x18
25 AA 01 01 x19
26 AA 01 01 x20
4A AA 01 01 x21
D4 FB 01 01 x22 - Gravity Well
D5 FB 01 01 x23 - Bioblaster
15 4B 02 01 x24
F7 5F 02 01 x25
E6 64 02 01 x26 - Squeaky Hammer
96 6F 02 01 x27
DB CE 02 01 x28 - Toy Sword
61 08 03 01 x29
62 08 03 01 x30

Slot #3 [4]
F5 0B 03 01 x2 - Squeaky Hammer (no desc)
0D 0C 03 01 x3 
17 11 03 01 x4 - Supersized Squeaky Hammer
8F 24 03 01 x5
77 56 03 01 x6
78 56 03 01 x7
79 56 03 01 x8
7A 56 03 01 x9
7B 56 03 01 x10
7C 56 03 01 x11
7D 56 03 01 x12
7E 56 03 01 x13
7F 56 03 01 x14
80 56 03 01 x15
81 56 03 01 x16
82 56 03 01 x17
83 56 03 01 x18
A7 5D 03 01 x19 - Noiseblaster
A8 5D 03 01 x20 - Drillbreaker
A9 5D 03 01 x21 - Auto Crossbow
AA 5D 03 01 x22 - Circular Saw
F4 65 03 01 x23 - Broadsword *
F5 65 03 01 x24 - Flame Tongue
F6 65 03 01 x25 - Airstep Sword
F7 65 03 01 x26 - Rune Saber
F8 65 03 01 x27 - Ice Brand
FA 65 03 01 x28 - Blood Sword
FB 65 03 01 x29 - Durandal
FC 65 03 01 x30 - Enhancer

Slot #4 [5]
FD 65 03 01 x2 - Engine Blade
FE 65 03 01 x3 - Soul Saber
FF 65 03 01 x4 - Balmung
00 66 03 01 x5 - Blazefire Saber
01 66 03 01 x6 - Two-handed Sword *
02 66 03 01 x7 - War Sword
03 66 03 01 x8 - Blade of Brennaere
04 66 03 01 x9  - Claymore
05 66 03 01 x10 - Thunderbolt
06 66 03 01 x11 - Hardedge
07 66 03 01 x12 - Force Stealer
08 66 03 01 x13 - Duel Code
09 66 03 01 x14 - Dominator
0A 66 03 01 x15 - Iron Duke
0C 66 03 01 x16 - Apocalypse *
0D 66 03 01 x17 - Masamune
0E 66 03 01 x18 - Javelin
0F 66 03 01 x19 - Drain Lance
10 66 03 01 x20 - Radiant Lance
11 66 03 01 x21 - Mythril Lance
12 66 03 01 x22 - Precision Lance
13 66 03 01 x23 - Wyvern Lance
14 66 03 01 x24 - Storm Lance
15 66 03 01 x25 - Ice Spear
16 66 03 01 x26 - Rapier Lance
17 66 03 01 x27 - Dragoon Lance
19 66 03 01 x28 - Flayer
1A 66 03 01 x29 - Gae Bolg
1B 66 03 01 x30 - Daggers

Slot #5 [6]
1C 66 03 01 x2 - Avengers
1D 66 03 01 x3 - Cutlasses
1E 66 03 01 x4 - Plunderers
1F 66 03 01 x5 - Mythril Knives
20 66 03 01 x6 - Assassin's Daggers
21 66 03 01 x7 - Vigilantes
22 66 03 01 x8 - Delta Daggers
23 66 03 01 x9 - Orichalcum
24 66 03 01 x10 - Organyx
26 66 03 01 x11 - Zwill Crossblades *
27 66 03 01 x12 - Mage Mashers
28 66 03 01 x13 - Handgun (?)
29 66 03 01 x14 - Calamity (?)
2A 66 03 01 x15 - Cocytus
2B 66 03 01 x16 - Mythril Pistol
2C 66 03 01 x17 - Valiant
2E 66 03 01 x18 - Rebellion
2F 66 03 01 x19 - Flame Gun
30 66 03 01 x20 - Enforcer
31 66 03 01 x21 - Hyper Magnum
32 66 03 01 x22 - Executioner
33 66 03 01 x23 - Death Penalty
34 66 03 01 x24 - Cerberus
35 66 03 01 x25 - Kite Shield
36 66 03 01 x26 - Flame Shield
37 66 03 01 x27 - Ice Shield
38 66 03 01 x28 - Power Shield
39 66 03 01 x29 - Thunder Shield
3A 66 03 01 x30 - Hero's Shield

Slot #6 [7]
3C 66 03 01 x2 - Absorb Shield
3D 66 03 01 x3 - Black Prince
3E 66 03 01 x4 - Wizard Shield
3F 66 03 01 x5 - Ziedrich
40 66 03 01 x6 - Aegis Shield
E5 7A 03 01 x7 - Hyperion
FF 7A 03 01 x8 - Main Gauches
0C 7B 03 01 x9 - Quicksilver
42 9E 03 01 x10 - Engine Blade II
43 9E 03 01 x11 - Engine Blade III
44 9E 03 01 x12 - Force Stealer II
45 9E 03 01 x13 - Drain Lance II
46 9E 03 01 x14 - Plunderers II
47 9E 03 01 x15 - Valiant II
48 9E 03 01 x16 - Absorb Shield II
49 9E 03 01 x17 - Gravity Well Plus
4A 9E 03 01 x18 - Bioblaster Plus
4B 9E 03 01 x19 - Noiseblaster Plus
4C 9E 03 01 x20 - Drillbreaker Plus
4D 9E 03 01 x21 - Auto Crossbow Plus
4E 9E 03 01 x22 - Circular Saw Plus
84 0F 04 01 x23
85 0F 04 01 x24
86 0F 04 01 x25
87 0F 04 01 x26
88 0F 04 01 x27
89 0F 04 01 x28
57 10 04 01 x29 - Claymore
58 10 04 01 x30

Slot #7 [8]
49 58 04 01 x2 - Ulric's Kukris
EB A7 04 01 x3
14 B4 04 01 x4 - Drain Lance III
C2 B4 04 01 x5 - Ultima Blade
D3 CF 04 01 x6 - Ragnarok (?)
D4 CF 04 01 x7 - Afrosword (?)
D5 CF 04 01 x8
D6 CF 04 01 x9
D7 CF 04 01 x10 - Genji Blade
D8 CF 04 01 x11 - Lion Heart (magic)
D9 CF 04 01 x12
DA CF 04 01 x13 - Lion Heart (no magic)
DB CF 04 01 x14
DC CF 04 01 x15
DD CF 04 01 x16
DE CF 04 01 x17
DF CF 04 01 x18
E0 CF 04 01 x19
E1 CF 04 01 x20
E2 CF 04 01 x21
E3 CF 04 01 x22
E4 CF 04 01 x23
E5 CF 04 01 x24
E6 CF 04 01 x25
E7 CF 04 01 x26
E8 CF 04 01 x27
E9 CF 04 01 x28
EA CF 04 01 x29
EB CF 04 01 x30

Slot #8 [9]
EC CF 04 01 x2
ED CF 04 01 x3
EE CF 04 01 x4
EF CF 04 01 x5
F0 CF 04 01 x6
F1 CF 04 01 x7
F2 CF 04 01 x8
52 EB 04 01 x9
53 EB 04 01 x10
C5 0F 05 01 x11
A0 18 05 01 x12
2C 28 05 01 x13 - Twin Squeaky Hammers
B7 44 05 01 x14
B8 44 05 01 x15
0A 5F 05 01 x16 - Audax Blade
0B 5F 05 01 x17 - Handgun
0C 5F 05 01 x18
0D 5F 05 01 x19
0E 5F 05 01 x20
B5 5F 05 01 x21
6E 66 05 01 x22
B2 6D 05 01 x23
B3 6D 05 01 x24
83 71 05 01 x25
3B 9F 05 01 x26
AA 9F 05 01 x27 - Enhancer

-- Unknown weapons --

C:\Ruby23-x64\bin\ruby.exe -e $stdout.sync=true;$stderr.sync=true;load($0=ARGV.shift) C:/Users/surface/code/ruby_hex/lib/parse_weapons.rb
Weapon count: [12, 12, 12, 12, 12, 12, 12, 6] (90)
Slot #2 [3]
14 AA 01 01 x2
15 AA 01 01 x3
16 AA 01 01 x4
17 AA 01 01 x5
18 AA 01 01 x6
19 AA 01 01 x7
1A AA 01 01 x8
1B AA 01 01 x9
1C AA 01 01 x10
1D AA 01 01 x11
1E AA 01 01 x12
1F AA 01 01 x13

Slot #3 [4]
20 AA 01 01 x2
21 AA 01 01 x3
22 AA 01 01 x4
23 AA 01 01 x5
24 AA 01 01 x6
25 AA 01 01 x7 - Noctis
26 AA 01 01 x8 - ??? sword (?)
4A AA 01 01 x9 - Kotetsu - Cor's weapon (?)
15 4B 02 01 x10 - Unnamed huge sword.
F7 5F 02 01 x11 - Stoss Spear Aranea's weapon
96 6F 02 01 x12
61 08 03 01 x13

Slot #4 [5]
62 08 03 01 x2
0D 0C 03 01 x3
8F 24 03 01 x4 - Kikuichimonji (locks)
77 56 03 01 x5
78 56 03 01 x6
79 56 03 01 x7
7A 56 03 01 x8
7B 56 03 01 x9
7C 56 03 01 x10
7D 56 03 01 x11
7E 56 03 01 x12
7F 56 03 01 x13

Slot #5 [6] 
80 56 03 01 x2
81 56 03 01 x3
82 56 03 01 x4
83 56 03 01 x5 - unnamed sword polearm (?)
84 0F 04 01 x6 - unnamed pointy polearm
85 0F 04 01 x7 - unnamed huge greatsword (?)
86 0F 04 01 x8 - unnamed huge pointy greatsword (?)
87 0F 04 01 x9
88 0F 04 01 x10 - unnamed huge sword
89 0F 04 01 x11
58 10 04 01 x12
EB A7 04 01 x13 - handgun (atk 1)

Slot #6 [7]
D5 CF 04 01 x2 - unnamed zero attack sword
D6 CF 04 01 x3 - unnamed zero attack sword
D9 CF 04 01 x4 - unnamed zero attack sword
DB CF 04 01 x5 - unnamed zero attack sword
DC CF 04 01 x6 - unnamed zero attack sword
DD CF 04 01 x7 - unnamed zero attack sword
DE CF 04 01 x8 - unnamed zero attack sword
DF CF 04 01 x9 - Zwill Crossblades Noctis model
E0 CF 04 01 x10 - unnamed zero attack sword
E1 CF 04 01 x11 - unnamed zero attack sword
E2 CF 04 01 x12 - unnamed zero attack sword
E3 CF 04 01 x13 - unnamed zero attack sword

Slot #7 [8]
E4 CF 04 01 x2 - unnamed zero attack sword
E5 CF 04 01 x3 - unnamed zero attack sword
E6 CF 04 01 x4 - unnamed zero attack sword
E7 CF 04 01 x5 - unnamed zero attack sword
E8 CF 04 01 x6 - unnamed zero attack sword
E9 CF 04 01 x7 - unnamed zero attack sword
EA CF 04 01 x8 - unnamed zero attack sword
EB CF 04 01 x9 - unnamed zero attack sword
EC CF 04 01 x10 - unnamed zero attack sword
ED CF 04 01 x11 - unnamed zero attack sword
EE CF 04 01 x12 - unnamed zero attack sword
EF CF 04 01 x13 - unnamed zero attack sword

Slot #8 [9]
F0 CF 04 01 x2
F1 CF 04 01 x3
F2 CF 04 01 x4
52 EB 04 01 x5 - huge katana daggers
53 EB 04 01 x6 - huge katana greatsword
C5 0F 05 01 x7 - machinegun (no damage)
A0 18 05 01 x8 - Column
B7 44 05 01 x9 - unnamed zero attack sword
B8 44 05 01 x10
0C 5F 05 01 x11
0D 5F 05 01 x12
0E 5F 05 01 x13

Slot #9 [10] -- Ignis glitched giant gold sword. disappears on unequip
B5 5F 05 01 x2
6E 66 05 01 x3
B2 6D 05 01 x4
B3 6D 05 01 x5
83 71 05 01 x6
3B 9F 05 01 x7 - Sagitta Rifle

