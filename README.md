# New Openables

Creates a single bar for openable / usable items currently in the players bags.

Features: 

 - Create single button to click on to combine/open/use/lockpick item in bags.
 - Button can have assigned hot-key to be able use keyboard short-cut.
 - When click to use item add-on will continue to scan bags and change to next usable item in your inventory.
 - Is possible skip item (remove from button) by right-click, when no other items are found then all skipped items are placed back on button.
 - Is possible permanently blacklist item (remove from button) by CTRL right-click, this permanent blacklist can be cleared via slash command "/nop clear" or from Game Menu, Interface, AddOns.
 - Is possible remove permanently blacklisted item just one with /nop unlist itemID. ItemID come from query via /nop list.
 - Quest items. For each quest item in bags is added separate button.
 - Auto-accept and auto-turnin quests from new Quest Tracker.

Supported items: 

 - Many items, list did grow by time I think is time just say "many" here :)
 - Rogues have placed locked lock-boxes on button, according to level of lock-picking skill. 1st click lock-pick and second click open.
 - Items used for standing gain, be warned addon deosn't check actual standing so if item is consumed on exalted staning it become void. This is not a problem for Legion Tokens because these can be used past Exalted as well.

Let me know item names to add to wish list. I will grow list as I find items suitable to add. Please I need people who will send me translations for nop-locale-enUS.lua to other languages. Localized SubZones are in for deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN and zhTW.

Source pulled from [this curseforge](https://www.curseforge.com/wow/addons/new-openables) project as the author has since abandoned it 