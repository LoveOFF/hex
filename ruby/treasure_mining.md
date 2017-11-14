Treasures not counted in the list:

[Anak Fetlock x6] -- CC 8C 03 01 :: 01038CCC
Giant Curlhorn x2 -- in my inventory -- CE 8C 03 01
[Sahagin Scale x36]

[Behemoth Horn x93]
Griffon Claw x1 -- in my inventory -- DD 8C 03 01
[Bulette Carapace x2]


[Colorful Griffon Claw x3]
Griffon Feather x2 -- in my inventory -- DC 8C 03 01
[Heavy Scale x33]

[Platinum Ingot x19]
Hydraulic Cylinder x1 -- in my inventory -- B5 8C 03 01
[Magnificent Crest x6]

[Arapaima Scales x3]
Dace Scales x3 -- in my inventory - 5B FC 04 01
[Catfish Barbel x3]

'King Catfish Heart' is jst called Catfish Heart

----

https://battlecalculator.com/final-fantasy-xv/final-fantasy-xv-fishing-guide

----


http://finalfantasyxv.wiki.fextralife.com/Treasures

```javascript
var treasures = "";
$x('//*[@id="sub-main"]/div[2]/table/tbody/tr/td[1]').forEach(function(item) { treasures += item.innerText + "\n" });
copy(treasures);
```

http://finalfantasy.wikia.com/wiki/Treasures_(Final_Fantasy_XV)

```javascript
var treasures = "";
$x('//*[@id="mw-content-text"]/table/tbody/tr/th[1]/span').forEach(function(item) { treasures += item.innerText + "\n" });
copy(treasures);
```

https://ff15wiki.com/wiki/Treasures

```javascript
var treasures = "";
$x('//*[@id="mw-content-text"]/table/tbody/tr/td[1]/a')
.forEach(function(item) { treasures += item.innerText + "\n" });
copy(treasures);
```

----

https://samurai-gamers.com/final-fantasy-15-ffxv/treasures-list-final-fantasy-15-ffxv/
http://gamewise.co/games/14235/Final-Fantasy-XV/Item-Encyclopedia/Treasures

```javascript
var treasures = "";
$x('//*/td[1]').forEach(function(item) { treasures += item.innerText + "\n" });
copy(treasures);
```

---

FF XV item database
https://docs.google.com/spreadsheets/d/1JSW2HgNbZWICN0oIs_LrqrKbefuoNqZ9rZb0jxFq89M/htmlview#

```javascript
var treasures = "";
$x('//*[@id="8499387"]/div/table/tbody/tr/td[1]').forEach(function(item) { treasures += item.innerText + "\n" });
copy(treasures);
```
