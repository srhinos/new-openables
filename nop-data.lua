-- Data tables
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
-- local AddOn
local ADDON, P = ...
local NOP = LibStub("AceAddon-3.0"):GetAddon(ADDON)
--
local PRI_OPEN = P.PRI_OPEN; assert(PRI_OPEN ~= nil,'PRI_OPEN')
local PRI_REP = P.PRI_REP; assert(PRI_REP ~= nil,'PRI_REP')
local PRI_REST = P.PRI_REST; assert(PRI_REST ~= nil,'PRI_REST')
local PRI_TOKEN = P.PRI_TOKEN; assert(PRI_TOKEN ~= nil,'PRI_TOKEN')
local SALVAGE_YARD = P.SALVAGE_YARD; assert(SALVAGE_YARD ~= nil,'SALVAGE_YARD')
local MINE_HORDE = P.MINE_HORDE; assert(MINE_HORDE ~= nil,'MINE_HORDE')
local MINE_ALLIANCE = P.MINE_ALLIANCE; assert(MINE_ALLIANCE ~= nil,'MINE_ALLIANCE')
local SHIPYARD_HORDE = P.SHIPYARD_HORDE; assert(SHIPYARD_HORDE ~= nil,'SHIPYARD_HORDE')
local SHIPYARD_ALLIANCE = P.SHIPYARD_ALLIANCE; assert(SHIPYARD_ALLIANCE ~= nil,'SHIPYARD_ALLIANCE')
local FROSTWALL1 = P.FROSTWALL1; assert(FROSTWALL1 ~= nil,'FROSTWALL1')
local FROSTWALL2 = P.FROSTWALL2; assert(FROSTWALL2 ~= nil,'FROSTWALL2')
local FROSTWALL3 = P.FROSTWALL3; assert(FROSTWALL3 ~= nil,'FROSTWALL3')
local FROSTWALL4 = P.FROSTWALL4; assert(FROSTWALL4 ~= nil,'FROSTWALL4')
local LUNARFALL1 = P.LUNARFALL1; assert(LUNARFALL1 ~= nil,'LUNARFALL1')
local LUNARFALL2 = P.LUNARFALL2; assert(LUNARFALL2 ~= nil,'LUNARFALL2')
local LUNARFALL3 = P.LUNARFALL3; assert(LUNARFALL3 ~= nil,'LUNARFALL3')
local LUNARFALL4 = P.LUNARFALL4; assert(LUNARFALL4 ~= nil,'LUNARFALL4')
local TIMELESS_ISLE1 = P.TIMELESS_ISLE1; assert(TIMELESS_ISLE1 ~= nil,'TIMELESS_ISLE1')
local TIMELESS_ISLE2 = P.TIMELESS_ISLE2; assert(TIMELESS_ISLE2 ~= nil,'TIMELESS_ISLE2')
local FROSTFIRE_RIDGE1 = P.FROSTFIRE_RIDGE1; assert(FROSTFIRE_RIDGE1 ~= nil,'FROSTFIRE_RIDGE1')
local FROSTFIRE_RIDGE2 = P.FROSTFIRE_RIDGE2; assert(FROSTFIRE_RIDGE2 ~= nil,'FROSTFIRE_RIDGE2')
local FROSTFIRE_RIDGE3 = P.FROSTFIRE_RIDGE3; assert(FROSTFIRE_RIDGE3 ~= nil,'FROSTFIRE_RIDGE3')
local FROSTFIRE_RIDGE4 = P.FROSTFIRE_RIDGE4; assert(FROSTFIRE_RIDGE4 ~= nil,'FROSTFIRE_RIDGE4')
local FROSTFIRE_RIDGE5 = P.FROSTFIRE_RIDGE5; assert(FROSTFIRE_RIDGE5 ~= nil,'FROSTFIRE_RIDGE5')
local FROSTFIRE_RIDGE6 = P.FROSTFIRE_RIDGE6; assert(FROSTFIRE_RIDGE6 ~= nil,'FROSTFIRE_RIDGE6')
local FROSTFIRE_RIDGE7 = P.FROSTFIRE_RIDGE7; assert(FROSTFIRE_RIDGE7 ~= nil,'FROSTFIRE_RIDGE7')
local FROSTFIRE_RIDGE8 = P.FROSTFIRE_RIDGE8; assert(FROSTFIRE_RIDGE8 ~= nil,'FROSTFIRE_RIDGE8')
local FROSTFIRE_RIDGE9 = P.FROSTFIRE_RIDGE9; assert(FROSTFIRE_RIDGE9 ~= nil,'FROSTFIRE_RIDGE9')
local SHADOWMOON_VALLEY1 = P.SHADOWMOON_VALLEY1; assert(SHADOWMOON_VALLEY1 ~= nil,'SHADOWMOON_VALLEY1')
local SHADOWMOON_VALLEY3 = P.SHADOWMOON_VALLEY3; assert(SHADOWMOON_VALLEY3 ~= nil,'SHADOWMOON_VALLEY3')
local SHADOWMOON_VALLEY3 = P.SHADOWMOON_VALLEY3; assert(SHADOWMOON_VALLEY3 ~= nil,'SHADOWMOON_VALLEY3')
--
NOP.T_INSTA_WQ = { -- [spellID] = itemID, list of OH advancements and spells for instant completion non-elite WQ
  [221602] = 140038, -- Might of Dalaran
  [221587] = 140155, -- Vanguard of the Silver Hand
  [221561] = 140158, -- Rift Cannon
}
NOP.T_SPELL_BY_NAME = { -- [itemID] = {{count_to_use,priority},{"sub-Zone",...},{[mapID]=true,...}} table to fetch via GetItemSpell(itemID) for group of items where spell-name is the same
  [137908] = {{1,PRI_OPEN},nil,nil}, -- Recipe: Battlebound Armbands, produce spell Learning
  [ 99726] = {{1,PRI_OPEN},nil,nil}, -- Create Item, Leggings of the Cursed Vanquisher
  [113355] = {{1,PRI_OPEN},nil,nil}, -- Flip Card, Card of Omens
  [112023] = {{1,PRI_OPEN},nil,nil}, -- Learning, Recipe: Draenic Philosopher's Stone, all learnable, it should replace most items in table T_RECIPES
  [114171] = {{1,PRI_OPEN},nil,nil}, -- Crate Restored Artifact, common for all
  [113271] = {{1,PRI_OPEN},nil,nil}, -- Convert to garrison resources, Giant Kaliri Egg, Gain xxx Garrison Resources, common for all
  [128316] = {{1,PRI_OPEN},nil,nil}, -- Convert to Oil, Bulging Barrel of Oil,
  [143733] = {{1,PRI_OPEN},nil,nil}, -- Ancient Mana Shards
  [143734] = {{1,PRI_OPEN},nil,nil}, -- Ancient Mana Crystal Cluster
  [141655] = {{1,PRI_OPEN},nil,nil}, -- Shimmering Ancient Mana Cluster
  [137010] = {{1,PRI_OPEN},nil,nil}, --  50 Ancient Mana
  [140401] = {{1,PRI_OPEN},nil,nil}, --  75 Ancient Mana
  [140236] = {{1,PRI_OPEN},nil,nil}, -- 100 Ancient Mana 
  [140240] = {{1,PRI_OPEN},nil,nil}, -- 150 Ancient Mana
  [140242] = {{1,PRI_OPEN},nil,nil}, -- 200 Ancient Mana
  [140239] = {{1,PRI_OPEN},nil,nil}, -- 300 Ancient Mana
  [140526] = {{1,PRI_OPEN},nil,nil}, -- Eredar Signet, Use: Provides a significant increase to character experience.
  [141028] = {{1,PRI_OPEN},nil,nil}, -- Grimoire of Knowledge, Use: Open your Followers page and use this item to grant 4000 XP directly to a Champion.
  [147837] = {{1,PRI_TOKEN},nil,nil}, -- Create Relic, Relinquished Life Relic
  [114116] = {{1,PRI_REST},{SALVAGE_YARD},{[FROSTWALL1]=true,[FROSTWALL2]=true,[FROSTWALL3]=true,[FROSTWALL4]=true,[LUNARFALL1]=true,[LUNARFALL2]=true,[LUNARFALL3]=true,[LUNARFALL4]=true}}, -- Create Relic, Relinquished Life Relic
  [116158] = {{1,PRI_REST},nil,{[FROSTWALL1]=true,[FROSTWALL2]=true,[FROSTWALL3]=true,[FROSTWALL4]=true,[LUNARFALL1]=true,[LUNARFALL2]=true,[LUNARFALL3]=true,[LUNARFALL4]=true}}, -- Toss Fish, Lunarfall Carp, can be used only in garrison shown on button only in garrison.
  [ 94223] = {{1,PRI_REP},nil,nil}, -- Stolen Shado-Pan Insignia
  [ 94225] = {{1,PRI_REP},nil,nil}, -- Stolen Celestial Insignia
  [ 94226] = {{1,PRI_REP},nil,nil}, -- Stolen Stolen Klaxxi Insignia
  [ 94227] = {{1,PRI_REP},nil,nil}, -- Stolen Golden Lotus Insignia
}
NOP.T_RECIPES = { -- [ItemId] = {{count_to_use,priority}, "gsub regex" | tooltip-line-number,{"sub-Zone",...},{[mapID]=true,...}, factionID}, item tooltip template only text to 1st match is compared, that mean all items of same school would be looked up.
  [153135] = {{1,PRI_TOKEN},4,nil,nil}, -- Unsullied Cloth Robes, why Blizzard did put in type of armor?
  [153143] = {{1,PRI_TOKEN},4,nil,nil}, -- Unsullied Plate Breastplate, why Blizzard did put in type of armor?
  [152741] = {{1,PRI_TOKEN},4,nil,nil}, -- Unsullied Mail Chestguard, why Blizzard did put in type of armor?
  [153151] = {{1,PRI_TOKEN},4,nil,nil}, -- Unsullied Leather Tunic, why Blizzard did put in type of armor?
  [127799] = {{1,PRI_TOKEN},3,nil,nil}, -- Baleful Pendant, for another slots than armor.
  [139879] = {{1,PRI_OPEN},3,nil,nil}, -- Crate of Champion Equipment
  [ 82800] = {{1,PRI_OPEN},1,nil,nil}, -- Pet Cage
  [162536] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Scouting Report: Swiftwind Post
  [140744] = {{1,PRI_REST},"(.+:).*",nil,nil}, -- Treasure Map: Azsuna
  [138797] = {{1,PRI_REST},"(.+:).*",nil,nil}, -- Illusion: Mongoose
  [122219] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Music Roll: Way of the Monk
  [122594] = {{1,PRI_OPEN},"(.+:).*",nil,{[FROSTWALL1]=true,[FROSTWALL2]=true,[FROSTWALL3]=true,[FROSTWALL4]=true,[LUNARFALL1]=true,[LUNARFALL2]=true,[LUNARFALL3]=true,[LUNARFALL4]=true}}, -- Rush Order: Tailoring Emporium, can be used only in garrison shown on button only in garrison.
  [100865] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Plans: Balanced Trillium Ingot and Its Uses, some old recipes has no learning spell
  [118592] = {{2,PRI_OPEN},"(.+:).*",nil,nil}, -- Partial Receipt: Gizmothingies
  [128440] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Contract: Dowser Goodwell
  [100863] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Pattern: Celestial Cloth and Its Uses, some old recipes has no learning spell
  [141064] = {{1,PRI_OPEN},"(.+:).*",nil,nil}, -- Technique: Glyph of the Shivarra
  [138883] = {{1,PRI_REST},4,nil,nil}, -- 4th line contains Use: Target one of your troops to restore 1 vitality.
  [111972] = {{1,PRI_OPEN},2,nil,nil}, -- Enchanter's Study, Level 2, 2nd line contains "Garrison Blueprint"
  [128315] = {{1,PRI_REST},2,nil,nil}, -- Medallion of the Legion, 2nd line contains "Use: Crush the medallion, increasing reputation with the denizens of Draenor by 1,000. (1 Sec Cooldown)"
  [127751] = {{1,PRI_OPEN},3,nil,nil}, -- Fel-Touched Pet Supplies, 3rd line Use: Open the bag. (1 Sec Cooldown)
  [151638] = {{1,PRI_OPEN},3,nil,nil}, -- Leprous Sack of Pet Supplies, 3rd line in german translation is different from Fel-Touched Pet Supplies, so creative ...
  [ 44983] = {{1,PRI_OPEN},3,nil,nil}, -- Strand Crawler, 3rd line contains "Use: Teaches you how to summon this companion."
  [104165] = {{1,PRI_OPEN},3,nil,nil}, -- Kovok, 3rd line contains "Use: Teaches you how to summon and dismiss this companion."
  [118427] = {{1,PRI_OPEN},3,nil,nil}, -- Autographed Hearthstone Card, 3rd line contains "Use: Adds this toy to your toy box."
  [127413] = {{1,PRI_OPEN},3,nil,nil}, -- Jeweled Arakkoa Effigy, 3rd line contains "Use: Pry out the eyes of the statue."
  [146748] = {{1,PRI_OPEN},3,nil,nil}, -- Highmountain Tribute open containers
  [152958] = {{1,PRI_REP},1,nil,nil,2165}, -- Army of the Light Insignia
  [152955] = {{1,PRI_REP},1,nil,nil,2165}, -- Greater Army of the Light Insignia
  [152959] = {{1,PRI_REP},1,nil,nil,2170}, -- Argussian Reach Insignia
  [152961] = {{1,PRI_REP},1,nil,nil,2170}, -- Greater Argussian Reach Insignia
  [141340] = {{1,PRI_REP},1,nil,nil,1900}, -- Court of Farondis Insignia
  [141989] = {{1,PRI_REP},1,nil,nil,1900}, -- Greater Court of Farondis Insignia 
  [139021] = {{1,PRI_REP},1,nil,nil,1883}, -- Dreamweaver Insignia 
  [141988] = {{1,PRI_REP},1,nil,nil,1883}, -- Greater Dreamweaver Insignia 
  [139024] = {{1,PRI_REP},1,nil,nil,1828}, -- Highmountain Tribe Insignia 
  [141990] = {{1,PRI_REP},1,nil,nil,1828}, -- Greater Highmountain Tribe Insignia 
  [146949] = {{1,PRI_REP},1,nil,nil,2045}, -- Legionfall Insignia
  [147727] = {{1,PRI_REP},1,nil,nil,2045}, -- Greater Legionfall Insignia
  [139026] = {{1,PRI_REP},1,nil,nil,1859}, -- Nightfallen Insignia 
  [141992] = {{1,PRI_REP},1,nil,nil,1859}, -- Greater Nightfallen Insignia 
  [139020] = {{1,PRI_REP},1,nil,nil,1948}, -- Valarjar Insignia 
  [141987] = {{1,PRI_REP},1,nil,nil,1948}, -- Greater Valarjar Insignia 
  [141342] = {{1,PRI_REP},1,nil,nil,1894}, -- Wardens Insignia
  [141991] = {{1,PRI_REP},1,nil,nil,1894}, -- Greater Wardens Insignia
}
NOP.T_ITEMS = { -- [itemID] = {{count_to_use,priority},{"sub-Zone",...},{[mapID]=true,...},auraID}, table for opening/use item by itemID, when is no possible to check for any common text
  [166999] = {{1,PRI_OPEN},nil,nil}, -- [Treasure Map]
  [ 47030] = {{1,PRI_OPEN},nil,nil}, -- [Huge Seaforium Bombs]
  [ 46847] = {{1,PRI_OPEN},nil,nil}, -- [Huge Seaforium Bombs]
  [146328] = {{1,PRI_OPEN},nil,nil}, -- Petrified Wyrmtongue
  [  5523] = {{1,PRI_OPEN},nil,nil}, -- Small Barnacled clam
  [  5524] = {{1,PRI_OPEN},nil,nil}, -- Thick-shelled clam
  [141071] = {{1,PRI_REP},nil,nil}, -- Badge of Honor
  [154879] = {{1,PRI_OPEN},nil,nil}, -- Awoken Titan Essence
  [  2934] = {{3,PRI_OPEN},nil,nil}, -- Ruined Leather Scraps
  [  7973] = {{1,PRI_OPEN},nil,nil}, -- Big-Mouth Clam
  [ 16885] = {{1,PRI_OPEN},nil,nil}, -- Heavy Junkbox
  [ 25649] = {{5,PRI_OPEN},nil,nil}, -- Knothide Leather Scraps
  [ 32971] = {{1,PRI_OPEN},nil,nil}, -- Water Bucket
  [ 33567] = {{5,PRI_OPEN},nil,nil}, -- Borean Leather Scraps
  [ 52977] = {{5,PRI_OPEN},nil,nil}, -- Savage Leather Scraps
  [ 69838] = {{1,PRI_OPEN},nil,nil}, -- Chirping Box
  [ 72162] = {{5,PRI_OPEN},nil,nil}, -- Sha-Touched Leather
  [ 78890] = {{1,PRI_OPEN},nil,nil}, -- Crystalline Geode
  [ 78891] = {{1,PRI_OPEN},nil,nil}, -- Elementium-Coated Geode
  [ 89112] = {{10,PRI_REST},nil,nil}, -- Motes of Harmony
  [ 89125] = {{1,PRI_OPEN},nil,nil}, -- Sack of Pet Supplies
  [ 91085] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 91086] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 93146] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 93147] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 93148] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 93149] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 94207] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 97512] = {{10,PRI_OPEN},nil,nil}, -- Ghost Iron Nugget
  [ 97546] = {{10,PRI_OPEN},nil,nil}, -- Kyparite Fragment
  [ 97619] = {{10,PRI_OPEN},nil,nil}, -- Torn Green Tea Leaf
  [ 97620] = {{10,PRI_OPEN},nil,nil}, -- Rain Poppy Petal
  [ 97621] = {{10,PRI_OPEN},nil,nil}, -- Silkweed Stem
  [ 97622] = {{10,PRI_OPEN},nil,nil}, -- Snow Lily Petal
  [ 97623] = {{10,PRI_OPEN},nil,nil}, -- Fool's Cap Spores
  [ 98095] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [ 98134] = {{1,PRI_OPEN},nil,nil}, -- Scenario Loot
  [ 98546] = {{1,PRI_OPEN},nil,nil}, -- Scenario Loot
  [103641] = {{1,PRI_REST},nil,{[TIMELESS_ISLE1]=true,[TIMELESS_ISLE2]=true},147055}, -- Singing Crystal
  [103642] = {{1,PRI_REST},nil,{[TIMELESS_ISLE1]=true,[TIMELESS_ISLE2]=true},147226}, -- Book of the Ages
  [103643] = {{1,PRI_REST},nil,{[TIMELESS_ISLE1]=true,[TIMELESS_ISLE2]=true},147476}, -- Dew of Eternal Morning
  [104287] = {{1,PRI_REST},nil,{[TIMELESS_ISLE1]=true,[TIMELESS_ISLE2]=true},148521}, -- Windfeather Plume
  [108294] = {{10,PRI_OPEN},nil,nil}, -- Silver Ore Nugget
  [108295] = {{10,PRI_OPEN},nil,nil}, -- Tin Ore Nugget
  [108296] = {{10,PRI_OPEN},nil,nil}, -- Gold Ore Nugget
  [108297] = {{10,PRI_OPEN},nil,nil}, -- Iron Ore Nugget
  [108298] = {{10,PRI_OPEN},nil,nil}, -- Thorium Ore Nugget
  [108299] = {{10,PRI_OPEN},nil,nil}, -- Truesilver Ore Nugget
  [108300] = {{10,PRI_OPEN},nil,nil}, -- Mithril Ore Nugget
  [108301] = {{10,PRI_OPEN},nil,nil}, -- Fel Iron Ore Nugget
  [108302] = {{10,PRI_OPEN},nil,nil}, -- Adamantite Ore Nugget
  [108303] = {{10,PRI_OPEN},nil,nil}, -- Eternium Ore Nugget
  [108304] = {{10,PRI_OPEN},nil,nil}, -- Khorium Ore Nugget
  [108305] = {{10,PRI_OPEN},nil,nil}, -- Cobalt Ore Nugget
  [108306] = {{10,PRI_OPEN},nil,nil}, -- Saronite Ore Nugget
  [108307] = {{10,PRI_OPEN},nil,nil}, -- Obsidium Ore Nugget
  [108308] = {{10,PRI_OPEN},nil,nil}, -- Elementium Ore Nugget
  [108309] = {{10,PRI_OPEN},nil,nil}, -- Pyrite Ore Nugget
  [108318] = {{10,PRI_OPEN},nil,nil}, -- Mageroyal Petal
  [108319] = {{10,PRI_OPEN},nil,nil}, -- Earthroot Stem
  [108320] = {{10,PRI_OPEN},nil,nil}, -- Briarthorn Bramble
  [108321] = {{10,PRI_OPEN},nil,nil}, -- Swiftthistle Leaf
  [108322] = {{10,PRI_OPEN},nil,nil}, -- Bruiseweed Stem
  [108323] = {{10,PRI_OPEN},nil,nil}, -- Wild Steelbloom Petal
  [108324] = {{10,PRI_OPEN},nil,nil}, -- Kingsblood Petal
  [108325] = {{10,PRI_OPEN},nil,nil}, -- Liferoot Stem
  [108326] = {{10,PRI_OPEN},nil,nil}, -- Khadgar's Whisker Stem
  [108327] = {{10,PRI_OPEN},nil,nil}, -- Grave Moss Leaf
  [108328] = {{10,PRI_OPEN},nil,nil}, -- Fadeleaf Petal
  [108329] = {{10,PRI_OPEN},nil,nil}, -- Dragon's Teeth Stem
  [108330] = {{10,PRI_OPEN},nil,nil}, -- Stranglekelp Blade
  [108331] = {{10,PRI_OPEN},nil,nil}, -- Goldthorn Bramble
  [108332] = {{10,PRI_OPEN},nil,nil}, -- Firebloom Petal
  [108333] = {{10,PRI_OPEN},nil,nil}, -- Purple Lotus Petal
  [108334] = {{10,PRI_OPEN},nil,nil}, -- Arthas' Tears Petal
  [108335] = {{10,PRI_OPEN},nil,nil}, -- Sungrass Stalk
  [108336] = {{10,PRI_OPEN},nil,nil}, -- Blindweed Stem
  [108337] = {{10,PRI_OPEN},nil,nil}, -- Ghost Mushroom Cap
  [108338] = {{10,PRI_OPEN},nil,nil}, -- Gromsblood Leaf
  [108339] = {{10,PRI_OPEN},nil,nil}, -- Dreamfoil Blade
  [108340] = {{10,PRI_OPEN},nil,nil}, -- Golden Sansam Leaf
  [108341] = {{10,PRI_OPEN},nil,nil}, -- Mountain Silversage Stalk
  [108342] = {{10,PRI_OPEN},nil,nil}, -- Sorrowmoss Leaf
  [108343] = {{10,PRI_OPEN},nil,nil}, -- Icecap Petal
  [108344] = {{10,PRI_OPEN},nil,nil}, -- Felweed Stalk
  [108345] = {{10,PRI_OPEN},nil,nil}, -- Dreaming Glory Petal
  [108346] = {{10,PRI_OPEN},nil,nil}, -- Ragveil Cap
  [108347] = {{10,PRI_OPEN},nil,nil}, -- Terocone Leaf
  [108348] = {{10,PRI_OPEN},nil,nil}, -- Ancient Lichen Petal
  [108349] = {{10,PRI_OPEN},nil,nil}, -- Netherbloom Leaf
  [108350] = {{10,PRI_OPEN},nil,nil}, -- Nightmare Vine Stem
  [108351] = {{10,PRI_OPEN},nil,nil}, -- Mana Thistle Leaf
  [108352] = {{10,PRI_OPEN},nil,nil}, -- Goldclover Leaf
  [108353] = {{10,PRI_OPEN},nil,nil}, -- Adder's Tongue Stem
  [108354] = {{10,PRI_OPEN},nil,nil}, -- Tiger Lily Petal
  [108355] = {{10,PRI_OPEN},nil,nil}, -- Lichbloom Stalk
  [108356] = {{10,PRI_OPEN},nil,nil}, -- Icethorn Bramble
  [108357] = {{10,PRI_OPEN},nil,nil}, -- Talandra's Rose Petal
  [108358] = {{10,PRI_OPEN},nil,nil}, -- Deadnettle Bramble
  [108359] = {{10,PRI_OPEN},nil,nil}, -- Fire Leaf Bramble
  [108360] = {{10,PRI_OPEN},nil,nil}, -- Cinderbloom Petal
  [108361] = {{10,PRI_OPEN},nil,nil}, -- Stormvine Stalk
  [108362] = {{10,PRI_OPEN},nil,nil}, -- Azshara's Veil Stem
  [108363] = {{10,PRI_OPEN},nil,nil}, -- Heartblossom Petal
  [108364] = {{10,PRI_OPEN},nil,nil}, -- Twilight Jasmine Petal
  [108365] = {{10,PRI_OPEN},nil,nil}, -- Whiptail Stem
  [108391] = {{10,PRI_OPEN},nil,nil}, -- Titanium Ore Nugget
  [109558] = {{1,PRI_OPEN},nil,nil}, -- Draenor 700 skills
  [109586] = {{1,PRI_OPEN},nil,nil}, -- Draenor 700 skills
  [109624] = {{10,PRI_OPEN},nil,nil}, -- Broken Frostweed Stem
  [109625] = {{10,PRI_OPEN},nil,nil}, -- Broken Fireweed Stem
  [109626] = {{10,PRI_OPEN},nil,nil}, -- Gorgrond Flytrap Ichor
  [109627] = {{10,PRI_OPEN},nil,nil}, -- Starflower Petal
  [109628] = {{10,PRI_OPEN},nil,nil}, -- Nagrand Arrowbloom Petal
  [109629] = {{10,PRI_OPEN},nil,nil}, -- Talador Orchid Petal
  [109991] = {{10,PRI_OPEN},nil,nil}, -- True Iron Nugget
  [109992] = {{10,PRI_OPEN},nil,nil}, -- Blackrock Fragment
  [110508] = {{1,PRI_REST},nil,nil}, -- "Fragrant" Pheromone Fish
  [110610] = {{10,PRI_OPEN},nil,nil}, -- Raw Beast Hide Scraps
  [111349] = {{1,PRI_OPEN},nil,nil},
  [111350] = {{1,PRI_OPEN},nil,nil},
  [111351] = {{1,PRI_OPEN},nil,nil},
  [111356] = {{1,PRI_OPEN},nil,nil},
  [111364] = {{1,PRI_OPEN},nil,nil},
  [111387] = {{1,PRI_OPEN},nil,nil},
  [111589] = {{5,PRI_OPEN},nil,nil}, [111595] = {{5,PRI_OPEN},nil,nil}, [111601] = {{5,PRI_OPEN},nil,nil}, -- Crescent Saberfish
  [111650] = {{5,PRI_OPEN},nil,nil}, [111669] = {{5,PRI_OPEN},nil,nil}, [111676] = {{5,PRI_OPEN},nil,nil}, -- Jawless Skulker
  [111651] = {{5,PRI_OPEN},nil,nil}, [111668] = {{5,PRI_OPEN},nil,nil}, [111675] = {{5,PRI_OPEN},nil,nil}, -- Fat Sleeper
  [111652] = {{5,PRI_OPEN},nil,nil}, [111667] = {{5,PRI_OPEN},nil,nil}, [111674] = {{5,PRI_OPEN},nil,nil}, -- Blind Lake Sturgeon
  [111656] = {{5,PRI_OPEN},nil,nil}, [111666] = {{5,PRI_OPEN},nil,nil}, [111673] = {{5,PRI_OPEN},nil,nil}, -- Fire Ammonite
  [111658] = {{5,PRI_OPEN},nil,nil}, [111665] = {{5,PRI_OPEN},nil,nil}, [111672] = {{5,PRI_OPEN},nil,nil}, -- Sea Scorpion
  [111659] = {{5,PRI_OPEN},nil,nil}, [111664] = {{5,PRI_OPEN},nil,nil}, [111671] = {{5,PRI_OPEN},nil,nil}, -- Abyssal Gulper Eel
  [111662] = {{5,PRI_OPEN},nil,nil}, [111663] = {{5,PRI_OPEN},nil,nil}, [111670] = {{5,PRI_OPEN},nil,nil}, -- Blackwater Whiptail
  [111921] = {{1,PRI_OPEN},nil,nil},
  [111922] = {{1,PRI_OPEN},nil,nil},
  [111923] = {{1,PRI_OPEN},nil,nil},
  [112087] = {{1,PRI_OPEN},nil,nil}, -- Obsidian Frostwolf Petroglyph
  [112158] = {{10,PRI_OPEN},nil,nil}, -- Icy Dragonscale Fragment
  [112177] = {{10,PRI_OPEN},nil,nil}, -- Nerubian Chitin Fragment
  [112178] = {{10,PRI_OPEN},nil,nil}, -- Jormungar Scale Fragment
  [112179] = {{10,PRI_OPEN},nil,nil}, -- Patch of Thick Clefthoof Leather
  [112180] = {{10,PRI_OPEN},nil,nil}, -- Patch of Crystal Infused Leather
  [112181] = {{10,PRI_OPEN},nil,nil}, -- Fel Scale Fragment
  [112182] = {{10,PRI_OPEN},nil,nil}, -- Patch of Fel Hide
  [112183] = {{10,PRI_OPEN},nil,nil}, -- Nether Dragonscale Fragment
  [112184] = {{10,PRI_OPEN},nil,nil}, -- Cobra Scale Fragment
  [112185] = {{10,PRI_OPEN},nil,nil}, -- Wind Scale Fragment
  [113992] = {{1,PRI_OPEN},nil,nil}, -- Scribe's Research Notes
  [114002] = {{1,PRI_OPEN},nil,nil}, -- Encoded Message
  [115356] = {{1,PRI_OPEN},nil,nil},
  [115357] = {{1,PRI_OPEN},nil,nil},
  [115358] = {{1,PRI_OPEN},nil,nil},
  [115359] = {{1,PRI_OPEN},nil,nil},
  [115504] = {{10,PRI_OPEN},nil,nil}, -- Fractured Temporal Crystal
  [115510] = {{300,PRI_OPEN},nil,nil}, -- Elemental Rune
  [115981] = {{1,PRI_OPEN},nil,nil}, -- Abrogator Stone Cluster
  [118267] = {{1,PRI_OPEN},nil,nil}, -- Ravenmother Offering
  [118697] = {{1,PRI_OPEN},nil,nil}, -- Pet Supplies
  [118897] = {{1,PRI_REST},{MINE_HORDE,MINE_ALLIANCE},nil,176049}, -- Miner's Coffee
  [118903] = {{1,PRI_REST},{MINE_HORDE,MINE_ALLIANCE},nil,176061}, -- Preserved Mining Pick
  [120301] = {{1,PRI_OPEN},nil,nil}, [120302] = {{1,PRI_OPEN},nil,nil}, -- Create Armor Enhancement, Weapon Boost
  [120321] = {{1,PRI_OPEN},nil,nil}, -- Mystery Bag
  [122514] = {{1,PRI_OPEN},nil,nil}, -- Mission Completion Orders
  [122535] = {{1,PRI_OPEN},nil,nil}, -- Traveler's Pet Supplies
  [122599] = {{1,PRI_OPEN},nil,nil}, -- Tome of Sorcerous Elements
  [122605] = {{1,PRI_OPEN},nil,nil}, -- Tome of the Stones
  [128225] = {{1,PRI_OPEN},nil,nil}, -- Empowered Apexis Fragment
  [128294] = {{1,PRI_OPEN},nil,nil}, -- Trade Agreement: Arakkoa Outcasts
  [128373] = {{1,PRI_OPEN},{SHIPYARD_HORDE,SHIPYARD_ALLIANCE},{
    [FROSTFIRE_RIDGE1]=true,[FROSTFIRE_RIDGE2]=true,[FROSTFIRE_RIDGE3]=true,[FROSTFIRE_RIDGE4]=true,[FROSTFIRE_RIDGE5]=true,[FROSTFIRE_RIDGE6]=true,[FROSTFIRE_RIDGE7]=true,[FROSTFIRE_RIDGE8]=true,[FROSTFIRE_RIDGE9]=true,
    [SHADOWMOON_VALLEY1]=true,[SHADOWMOON_VALLEY3]=true,[SHADOWMOON_VALLEY3]=true}}, -- Rush Order: Shipyard, special handling for sub-zone
  [128446] = {{1,PRI_OPEN},nil,nil}, -- Saberstalker Teachings: Trailblazer
  [128488] = {{1,PRI_OPEN},nil,nil}, -- Ship: The Awakener
  [128490] = {{1,PRI_OPEN},nil,nil}, -- Blueprint: Oil Rig
  [128980] = {{1,PRI_OPEN},nil,nil}, -- Scroll of Forgotten Knowledge
  [132523] = {{1,PRI_REST},nil,nil}, -- Reaves Battery
  [136269] = {{1,PRI_OPEN},nil,nil}, -- Kel'danath's Manaflask
  [136342] = {{100,PRI_OPEN},nil,nil},-- Obliterum Ash
  [136412] = {{1,PRI_OPEN},nil,nil}, -- Heavy Armor Set
  [136806] = {{1,PRI_OPEN},nil,nil}, -- Glass of Arcwine
  [137207] = {{1,PRI_OPEN},nil,nil}, -- Fortified Armor Set
  [137208] = {{1,PRI_OPEN},nil,nil}, -- Indestructible Armor Set
  [138410] = {{1,PRI_REST},nil,nil}, -- Summoning Portal
  [139010] = {{1,PRI_OPEN},nil,nil}, -- Petrified Silkweave
  [139011] = {{1,PRI_OPEN},nil,nil}, -- Berserking Helm of Ondry'el
  [139017] = {{1,PRI_OPEN},nil,nil}, -- Soothing Leystone Shard
  [139018] = {{1,PRI_OPEN},nil,nil}, -- Box of Calming Whispers
  [139019] = {{1,PRI_OPEN},nil,nil}, -- Spellmask of Alla'onus
  [139027] = {{1,PRI_OPEN},nil,nil}, -- Lenses of Spellseer Dellian
  [139028] = {{1,PRI_REST},nil,nil}, -- Disc of the Starcaller
  [139177] = {{1,PRI_REST},nil,nil}, -- Shattered Soul
  [139419] = {{1,PRI_REST},nil,nil}, -- Golden Banana
  [139428] = {{1,PRI_REST},nil,nil}, -- A Master Plan
  [139591] = {{1,PRI_REST},nil,nil}, -- Stolen Tome of Artifact Lore
  [139670] = {{1,PRI_REST},nil,nil}, -- Scream of the Dead
  [139786] = {{1,PRI_OPEN},nil,nil}, -- 25 mana
  [140156] = {{1,PRI_REST},nil,nil}, -- Blessing of the Order
  [140260] = {{1,PRI_OPEN},nil,nil}, -- Arcane Remnant of Falanaar
  [140326] = {{1,PRI_OPEN},nil,nil}, -- Enchanted Burial Urn
  [140327] = {{1,PRI_OPEN},nil,nil}, -- Kyrtos's Research Notes
  [140328] = {{1,PRI_OPEN},nil,nil}, -- Volatile Leyline Crystal
  [140329] = {{1,PRI_OPEN},nil,nil}, -- Infinite Stone
  [140397] = {{1,PRI_OPEN},nil,nil,223670}, -- G'Hanir's Blossom
  [140439] = {{1,PRI_OPEN},nil,nil,223722}, -- Sunblossom Pollen
  [140448] = {{1,PRI_REST},nil,nil}, -- Lens of Qin'dera
  [140450] = {{1,PRI_OPEN},nil,nil}, -- Berserking Helm of Taenna
  [140451] = {{1,PRI_OPEN},nil,nil}, -- Spellmask of Azsylla
  [140749] = {{1,PRI_REST},nil,nil}, -- Horn of Winter
  [140760] = {{1,PRI_REST},nil,nil}, -- Libram of Truth
  [140767] = {{5,PRI_REST},nil,nil}, -- Pile of Bits and Bones
  [140922] = {{1,PRI_REST},nil,nil}, -- Imp Pact
  [140924] = {{1,PRI_REST},nil,nil}, -- Ashtongue Beacon
  [140925] = {{1,PRI_REST},nil,nil}, -- Enchanted Bark
  [140926] = {{1,PRI_REST},nil,nil}, -- Bowmen's Orders
  [140927] = {{1,PRI_REST},nil,nil}, -- Water Globe
  [140928] = {{1,PRI_REST},nil,nil}, -- Ox Initiate's Pledge
  [140929] = {{1,PRI_REST},nil,nil}, -- Squire's Oath
  [140932] = {{1,PRI_REST},nil,nil}, -- Earthen Mark
  [140933] = {{1,PRI_REST},nil,nil}, -- Runed Aspirant's Band
  [141870] = {{1,PRI_OPEN},nil,nil}, -- Arcane Tablet of Falanaar
  [142156] = {{1,PRI_OPEN},nil,nil}, -- Order Resources Cache
  [142156] = {{1,PRI_OPEN},nil,nil}, -- Order Resources Cache
  [142363] = {{1,PRI_REST},nil,nil}, -- Mark of Prey
  [142447] = {{1,PRI_OPEN},nil,nil}, -- Torn Sack of Pet Supplies
  [143605] = {{1,PRI_REST},nil,nil}, -- Strange Ball of Energy
  [143748] = {{1,PRI_OPEN},nil,nil}, -- Ancient Mana Crystal
  [143849] = {{1,PRI_REST},nil,nil}, -- Summon Royal Guard
  [143850] = {{1,PRI_REST},nil,nil}, -- Summon Grimtotem Warrior
  [143852] = {{1,PRI_REST},nil,nil}, -- Lucky Rabbit's Foot
  [146757] = {{10,PRI_OPEN},nil,nil},-- Prepared Ingredients
  [147348] = {{1,PRI_REST},nil,nil}, -- Bulky Armor Set
  [147349] = {{1,PRI_REST},nil,nil}, -- Spiked Armor Set
  [147350] = {{1,PRI_REST},nil,nil}, -- Invincible Armor Set
  [147351] = {{1,PRI_REST},nil,nil}, -- Fel Armor Enhancement Token
  [147384] = {{1,PRI_REST},nil,nil}, -- Legionfall Recompense
  [147416] = {{1,PRI_OPEN},nil,nil}, -- Arcane Tablet of Falanaar
  [147418] = {{1,PRI_OPEN},nil,nil}, -- Arcane Remnant of Falanaar
  [147729] = {{1,PRI_OPEN},nil,nil}, -- Netherchunk
  [147860] = {{1,PRI_REST},nil,nil}, -- Empowered Elven Tome
  [150737] = {{1,PRI_OPEN},nil,nil}, -- Abundant Order Resources Cache
  [151653] = {{10,PRI_OPEN},nil,nil}, -- Broken Isles Recipe Scrap
  [151842] = {{1,PRI_REST},nil,nil}, -- Krokul Armor Set
  [151843] = {{1,PRI_REST},nil,nil}, -- Mac'Aree Armor Set
  [151844] = {{1,PRI_REST},nil,nil}, -- Xenedar Armor Set
  [152095] = {{1,PRI_REST},nil,nil}, -- Krokul Ridgestalker
  [152096] = {{1,PRI_REST},nil,nil}, -- Void-Purged Krokul
  [152097] = {{1,PRI_REST},nil,nil}, -- Lightforged Bulwark
  [152998] = {{1,PRI_OPEN},nil,nil}, -- Carefully Hidden Muffin
  [153113] = {{1,PRI_REP},nil,{[1135] = true, [1170] = true, [1171] = true}}, -- Demon's Soulstone, usable on Argus maps
  [153114] = {{1,PRI_REST},nil,nil}, -- Nathrezim Tome of Manipulation
-- 9.0
-- Memories of the Runecarver
  [182617] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Death's Embrace
  [182625] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of an Everlasting Grip
  [182626] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Phearomones
  [182627] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Superstrain
  [182628] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Bryndaor
  [182629] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Crimson Runes
  [182630] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Gorefiend's Domination
  [182631] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Vampiric Aura
  [182632] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Absolute Zero
  [182633] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Biting Cold
  [182634] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Frozen Champion's Rage
  [182635] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Koltira
  [182636] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Deadliest Coil
  [182637] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Death's Certainty
  [182638] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Frenzied Monstrosity
  [182640] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Reanimated Shambler
  [183211] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Hour of Darkness
  [183212] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Darkglare Medallion
  [183213] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Anguish of the Collective
  [183214] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Chaos Theory
  [183215] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of an Erratic Fel Core
  [183216] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Burning Wound
  [183217] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of my Darker Nature
  [183218] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Fortified Fel Flame
  [183219] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Soul of Fire
  [183220] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Razelikh's Defilement
  [183221] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Dark Flame Spirit
  [183222] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Elder Druid
  [183223] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Circle of Life and Death
  [183224] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Deep Focus Draught
  [183225] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Lycara
  [183226] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Balance of All Things
  [183227] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Oneth
  [183228] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Arcane Pulsars
  [183229] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Timeworn Dreambinder
  [183230] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Apex Predator
  [183231] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Cat-Eye Curio (Druid-Feral)
  [183232] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Symmetrical Eye (Druid-Feral)
  [183233] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Frenzyband (Druid-Feral)
  [183234] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Luffa-Infused Embrace (Druid-Guardian)
  [183235] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Natural Order (Druid-Guardian)
  [183236] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Ursoc (Druid-Guardian)
  [183237] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Sleeper (Druid-Guardian)
  [183238] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Verdant Infusion (Druid-Restoration)
  [183239] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of an Unending Growth (Druid-Restoration)
  [183240] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Mother Tree (Druid-Restoration)
  [183241] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Dark Titan (Druid-Restoration)
  [183242] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Eonar (The Wild Hunt - Revered)
  [183243] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Arbiter's Judgment (The Ascended - Revered)
  [183244] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Rattle of the Maw ( The Undying Army - Revered)
  [183245] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Memory of Norgannon (Court of Harvesters - Revered)
  [183246] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Sephuz (Honor-Purchase)
  [183247] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Stable Phantasma Lure (Torghast-Drop L6+)
  [183248] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Jailer's Eye (Ve'nari-Ambivalent)
  [183249] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of a Vital Sacrifice (Covenant-Renown 14+)
  [183250] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183251] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183252] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183253] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183254] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183255] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183256] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183257] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183258] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183259] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183260] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183261] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183262] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183263] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183264] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183265] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183266] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183267] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183268] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183269] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183270] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183271] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183272] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183273] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183274] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183275] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183276] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183277] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183278] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183279] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183280] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183281] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183282] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183283] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183284] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183285] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183286] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183287] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183288] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183289] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183290] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183291] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183292] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183293] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183294] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183295] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183296] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183297] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183298] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183299] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183300] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183301] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183302] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183303] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183304] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183305] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183306] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183307] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183308] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183309] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183310] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183311] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183312] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183313] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183314] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183315] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183316] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183317] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183318] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183319] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183320] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183321] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183322] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183323] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183324] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183325] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183326] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183327] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183328] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183329] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183330] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183331] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183332] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183333] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183334] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183335] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183336] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183337] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183338] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183339] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183340] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183341] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183342] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Akaari's Soul Fragment (Rogue-Sublety|Torghast, Skoldus Hall, L3+)
  [183343] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Deathly Shadows (Rogue|Torghast, Fracture Chambers, L3+)
  [183344] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Finality (Rogue-Sublety|Castle Nathria, Sire Denathrius)
  [183345] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Rotten (Rogue-Sublety|Plaguefall, Domina Venomblade)
  [183346] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of an Ancestral Reminder (Shaman|Castle Nathria, Stone Legion Generals)
  [183347] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Devastating Chains (Shaman|Honor-Purchase)
  [183348] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Deeply Rooted Elements
  [183349] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183350] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183351] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183352] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Demise of Skybreaker
  [183353] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Windspeaker's Lava Resurgence
  [183354] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183355] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Frost Witch
  [183356] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Primal Lava Actuators
  [183357] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Witch Doctor
  [183358] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183359] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183360] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183361] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Spiritwalker's Tidal Totem
  [183362] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183363] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183364] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183365] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183366] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183367] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183368] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183369] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183370] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183371] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183372] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183373] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183374] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183375] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183376] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183377] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183378] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183379] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183380] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183381] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183382] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183383] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183384] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183385] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183386] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183387] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183388] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183389] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183390] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183391] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183392] = {{1,PRI_REP},nil,{[1912] = true,}},
  [183393] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186565] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Rampant Transference
  [186566] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of the Final Sentence
  [186567] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of Insatiable Hunger
  [186568] = {{1,PRI_REP},nil,{[1912] = true,}}, -- Memory of an Abomination's Frenzy
  [186570] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186572] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186576] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186577] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186591] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186609] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186621] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186635] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186673] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186676] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186687] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186689] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186710] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186712] = {{1,PRI_REP},nil,{[1912] = true,}},
  [186775] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187105] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187106] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187107] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187109] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187111] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187118] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187127] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187132] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187160] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187161] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187162] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187163] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187217] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187223] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187224] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187225] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187226] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187227] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187228] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187229] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187230] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187231] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187232] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187237] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187258] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187259] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187277] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187280] = {{1,PRI_REP},nil,{[1912] = true,}},
  [187511] = {{1,PRI_REP},nil,{[1912] = true,}},
-- The Maw & Torghast
  [178040] = {{1,PRI_OPEN},nil,nil}, -- Condensed Stygia
  [168207] = {{1,PRI_REST},nil,nil}, -- Plundered Anima Cell
  [170540] = {{1,PRI_REST},nil,nil}, -- Ravenous Anima Cell
  [183870] = {{1,PRI_REST},nil,nil}, -- Recipe: Crafter's Mark II
  [184359] = {{1,PRI_REST},nil,nil}, -- Unbound Reality Fragment
  [184662] = {{1,PRI_REST},nil,nil}, -- Requisitioned Anima Cell
----M&T upgrades
  [180949] = {{1,PRI_OPEN},nil,nil}, -- Animaflow Stabilizer, The Maw
  [180952] = {{1,PRI_OPEN},nil,nil}, -- Possibility Matrix, Torghast
  [184588] = {{1,PRI_OPEN},nil,nil}, -- Soul-Stabilizing Talisman, The Maw
  [184605] = {{1,PRI_OPEN},nil,nil}, -- Sigil of the Unseen, The Maw
  [184613] = {{1,PRI_OPEN},nil,nil}, -- Encased Riftwalker Essence, The Maw
  [184615] = {{1,PRI_OPEN},nil,nil}, -- Extradimensional Pockets, Torghast
  [184618] = {{1,PRI_OPEN},nil,nil}, -- Rank Insignia: Acquisitionist, Torghast
  [184619] = {{1,PRI_OPEN},nil,nil}, -- Loupe of Unusual Charm, Torghast
  [184620] = {{1,PRI_OPEN},nil,nil}, -- Vessel of Unfortunate Spirits, Torghast
  [184621] = {{1,PRI_OPEN},nil,nil}, -- Ritual Prism of Fortune, Torghast
  [184617] = {{1,PRI_OPEN},nil,nil}, -- Bangle of Seniority, Torghast
  [184653] = {{1,PRI_OPEN},nil,nil}, -- Animated Levitating Chain, The Maw
  [184901] = {{1,PRI_OPEN},nil,nil}, -- Broker Traversal Enhancer, Torghast
-- Court of Embers
  [177235] = {{1,PRI_OPEN},nil,nil}, -- Tubbins's Lucky Teapot
  [177239] = {{1,PRI_OPEN},nil,nil}, -- Racing Permit
  [181536] = {{1,PRI_OPEN},nil,nil}, -- Guest List Page
---- RSVP
  [176058] = {{1,PRI_REST},nil,nil}, -- RSVP Baroness Vashj-Begin New Ember Court Items RSVPS
  [176090] = {{1,PRI_REST},nil,nil}, -- RSVP Lady Moonberry
  [176091] = {{1,PRI_REST},nil,nil}, -- RSVP The Countess
  [176092] = {{1,PRI_REST},nil,nil}, -- RSVP Mikanikos
  [176093] = {{1,PRI_REST},nil,nil}, -- RSVP Alexandros Mograine
  [176097] = {{1,PRI_REST},nil,nil}, -- RSVP Baroness Vashj
  [176112] = {{1,PRI_REST},nil,nil}, -- RSVP Lady Moonberry
  [176113] = {{1,PRI_REST},nil,nil}, -- RSVP Mikanikos
  [176114] = {{1,PRI_REST},nil,nil}, -- RSVP The Countess
  [176115] = {{1,PRI_REST},nil,nil}, -- RSVP Alexandros Mograine
  [176116] = {{1,PRI_REST},nil,nil}, -- RSVP Hunt Captain Korayn
  [176117] = {{1,PRI_REST},nil,nil}, -- RSVP Polemarch Adrestes
  [176118] = {{1,PRI_REST},nil,nil}, -- RSVP Rendle and Cudgelface
  [176119] = {{1,PRI_REST},nil,nil}, -- RSVP Choofa
  [176120] = {{1,PRI_REST},nil,nil}, -- RSVP Cryptkeeper Kassir
  [176121] = {{1,PRI_REST},nil,nil}, -- RSVP Droman Aliothe
  [176122] = {{1,PRI_REST},nil,nil}, -- RSVP Grandmaster Vole
  [176123] = {{1,PRI_REST},nil,nil}, -- RSVP Kleia and Pelagos
  [176124] = {{1,PRI_REST},nil,nil}, -- RSVP Plague Deviser Marileth
  [176125] = {{1,PRI_REST},nil,nil}, -- RSVP Sika
  [178686] = {{1,PRI_REST},nil,nil}, -- RSVP Stonehead
---- Contracts
  [176126] = {{1,PRI_REST},nil,nil}, -- Contract Traditional Theme
  [176128] = {{1,PRI_REST},nil,nil}, -- Contract Mortal Reminders
  [176130] = {{1,PRI_REST},nil,nil}, -- Contract Atoning Rituals
  [176131] = {{1,PRI_REST},nil,nil}, -- Contract Glimpse of the Wilds
  [176132] = {{1,PRI_REST},nil,nil}, -- Contract Lost Chalice Band
  [176134] = {{1,PRI_REST},nil,nil}, -- Contract Tubbinss Tea Party
  [176135] = {{1,PRI_REST},nil,nil}, -- Contract Divine Desserts
  [176136] = {{1,PRI_REST},nil,nil}, -- Contract Mushroom Surprise
  [176138] = {{1,PRI_REST},nil,nil}, -- Contract Venthyr Volunteers
  [176139] = {{1,PRI_REST},nil,nil}, -- Contract Stoneborn Reserves
---- Buildings
  [181517] = {{1,PRI_REST},nil,nil}, -- Building Dredger Pool
  [181518] = {{1,PRI_REST},nil,nil}, -- Building Guardhouse
  [184663] = {{1,PRI_REST},nil,nil}, -- Building Guardhouse

-- Conduits
--- Death Knight
  [181786] = {{1,PRI_OPEN},nil,nil}, -- Eternal Hunger
  [181834] = {{1,PRI_OPEN},nil,nil}, -- Chilled Resilience
  [181836] = {{1,PRI_OPEN},nil,nil}, -- Spirit Drain
  [181841] = {{1,PRI_OPEN},nil,nil}, -- Reinforced Shell
  [181848] = {{1,PRI_OPEN},nil,nil}, -- Accelerated Cold
  [181866] = {{1,PRI_OPEN},nil,nil}, -- Withering Plague
  [181943] = {{1,PRI_OPEN},nil,nil}, -- Eradicating Blow
  [181963] = {{1,PRI_OPEN},nil,nil}, -- Blood Bond
  [181975] = {{1,PRI_OPEN},nil,nil}, -- Hardened Bones
  [181980] = {{1,PRI_OPEN},nil,nil}, -- Embrace Death
  [181982] = {{1,PRI_OPEN},nil,nil}, -- Everfrost
  [182113] = {{1,PRI_OPEN},nil,nil}, -- Fleeting Wind
  [182132] = {{1,PRI_OPEN},nil,nil}, -- Unending Grip
  [182133] = {{1,PRI_OPEN},nil,nil}, -- Insatiable Appetite
  [182187] = {{1,PRI_OPEN},nil,nil}, -- Meat Shield
  [182201] = {{1,PRI_OPEN},nil,nil}, -- Unleashed Frenzy
  [182203] = {{1,PRI_OPEN},nil,nil}, -- Debilitating Malady
  [182206] = {{1,PRI_OPEN},nil,nil}, -- Convocation of the Dead
  [182208] = {{1,PRI_OPEN},nil,nil}, -- Lingering Plague
  [182288] = {{1,PRI_OPEN},nil,nil}, -- Impenetrable Gloom
  [182292] = {{1,PRI_OPEN},nil,nil}, -- Brutal Grasp
  [182295] = {{1,PRI_OPEN},nil,nil}, -- Proliferation
  [183199] = {{1,PRI_OPEN},nil,nil}, -- Unending Grip

--- Demon Hunter
  [182316] = {{1,PRI_OPEN},nil,nil}, -- Fel Defender
  [182317] = {{1,PRI_OPEN},nil,nil}, -- Shattered Restoration
  [182318] = {{1,PRI_OPEN},nil,nil}, -- Viscous Ink
  [182324] = {{1,PRI_OPEN},nil,nil}, -- Felfire Haste
  [182325] = {{1,PRI_OPEN},nil,nil}, -- Ravenous Consumption
  [182330] = {{1,PRI_OPEN},nil,nil}, -- Demonic Parole
  [182344] = {{1,PRI_OPEN},nil,nil}, -- Lost in Darkness
  [182368] = {{1,PRI_OPEN},nil,nil}, -- Relentless Onslaught
  [182383] = {{1,PRI_OPEN},nil,nil}, -- Dancing with Fate
  [182384] = {{1,PRI_OPEN},nil,nil}, -- Serrated Glaive
  [182385] = {{1,PRI_OPEN},nil,nil}, -- Growing Inferno
  [182385] = {{1,PRI_OPEN},nil,nil}, -- Growing Inferno
  [182471] = {{1,PRI_OPEN},nil,nil}, -- Soul Furnace
  [182598] = {{1,PRI_OPEN},nil,nil}, -- Demon Muzzle
  [182604] = {{1,PRI_OPEN},nil,nil}, -- Roaring Fire
  [182646] = {{1,PRI_OPEN},nil,nil}, -- Repeat Decree
  [182685] = {{1,PRI_OPEN},nil,nil}, -- Increased Scrutiny
  [182706] = {{1,PRI_OPEN},nil,nil}, -- Brooding Pool
  [183463] = {{1,PRI_OPEN},nil,nil}, -- Unnatural Malice

--- Druid
  [183464] = {{1,PRI_OPEN},nil,nil}, -- Tough as Bark
  [183465] = {{1,PRI_OPEN},nil,nil}, -- Ursine Vigor
  [183466] = {{1,PRI_OPEN},nil,nil}, -- Innate Resolve
  [183467] = {{1,PRI_OPEN},nil,nil}, -- Tireless Pursuit
  [183468] = {{1,PRI_OPEN},nil,nil}, -- Born Anew
  [183469] = {{1,PRI_OPEN},nil,nil}, -- Front of the Pack
  [183470] = {{1,PRI_OPEN},nil,nil}, -- Born of the Wilds
  [183471] = {{1,PRI_OPEN},nil,nil}, -- Deep Allegiance
  [183472] = {{1,PRI_OPEN},nil,nil}, -- Evolved Swarm
  [183473] = {{1,PRI_OPEN},nil,nil}, -- Conflux of Elements
  [183474] = {{1,PRI_OPEN},nil,nil}, -- Endless Thirst
  [183476] = {{1,PRI_OPEN},nil,nil}, -- Stellar Inspiration
  [183477] = {{1,PRI_OPEN},nil,nil}, -- Precise Alignment
  [183478] = {{1,PRI_OPEN},nil,nil}, -- Fury of the Skies
  [183479] = {{1,PRI_OPEN},nil,nil}, -- Umbral Intensity
  [183480] = {{1,PRI_OPEN},nil,nil}, -- Taste for Blood
  [183481] = {{1,PRI_OPEN},nil,nil}, -- Incessant Hunter
  [183482] = {{1,PRI_OPEN},nil,nil}, -- Sudden Ambush
  [183483] = {{1,PRI_OPEN},nil,nil}, -- Carnivorous Instinct
  [183484] = {{1,PRI_OPEN},nil,nil}, -- Unchecked Aggression
  [183485] = {{1,PRI_OPEN},nil,nil}, -- Savage Combatant
  [183486] = {{1,PRI_OPEN},nil,nil}, -- Well-Honed Instincts
  [183487] = {{1,PRI_OPEN},nil,nil}, -- Layered Mane
  [183488] = {{1,PRI_OPEN},nil,nil}, -- Unstoppable Growth
  [183489] = {{1,PRI_OPEN},nil,nil}, -- Flash of Clarity
  [183490] = {{1,PRI_OPEN},nil,nil}, -- Floral Recycling
  [183491] = {{1,PRI_OPEN},nil,nil}, -- Ready for Anything

--- Hunter
  [182321] = {{1,PRI_OPEN},nil,nil}, -- Enfeebled Mark
  [182331] = {{1,PRI_OPEN},nil,nil}, -- Empowered Release
  [182335] = {{1,PRI_OPEN},nil,nil}, -- Spirit Attunement
  [182339] = {{1,PRI_OPEN},nil,nil}, -- Necrotic Barrage
  [182441] = {{1,PRI_OPEN},nil,nil}, -- Marksman's Advantage
  [182464] = {{1,PRI_OPEN},nil,nil}, -- Harmony of the Tortollan
  [182469] = {{1,PRI_OPEN},nil,nil}, -- Rejuvenating Wind
  [182476] = {{1,PRI_OPEN},nil,nil}, -- Resilience of the Hunter
  [182480] = {{1,PRI_OPEN},nil,nil}, -- Reversal of Fortune
  [182584] = {{1,PRI_OPEN},nil,nil}, -- Cheetah's Vigor
  [182605] = {{1,PRI_OPEN},nil,nil}, -- Tactical Retreat
  [182610] = {{1,PRI_OPEN},nil,nil}, -- Ferocious Appetite
  [182621] = {{1,PRI_OPEN},nil,nil}, -- One With the Beast
  [182648] = {{1,PRI_OPEN},nil,nil}, -- Sharpshooter's Focus
  [182649] = {{1,PRI_OPEN},nil,nil}, -- Brutal Projectiles
  [182657] = {{1,PRI_OPEN},nil,nil}, -- Deadly Chain
  [182686] = {{1,PRI_OPEN},nil,nil}, -- Powerful Precision
  [183132] = {{1,PRI_OPEN},nil,nil}, -- Echoing Call
  [183167] = {{1,PRI_OPEN},nil,nil}, -- Strength of the Pack
  [183184] = {{1,PRI_OPEN},nil,nil}, -- Stinging Strike
  [183202] = {{1,PRI_OPEN},nil,nil}, -- Deadly Tandem
  [183396] = {{1,PRI_OPEN},nil,nil}, -- Flame Infusion
  [183402] = {{1,PRI_OPEN},nil,nil}, -- Bloodletting
  [184587] = {{1,PRI_OPEN},nil,nil}, -- Ambuscade

--- Mage
  [181383] = {{1,PRI_OPEN},nil,nil}, -- Unrelenting Cold
  [181389] = {{1,PRI_OPEN},nil,nil}, -- Shivering Core
  [181455] = {{1,PRI_OPEN},nil,nil}, -- Icy Propulsion
  [181461] = {{1,PRI_OPEN},nil,nil}, -- Ice Bite
  [181464] = {{1,PRI_OPEN},nil,nil}, -- Winter's Protection
  [181467] = {{1,PRI_OPEN},nil,nil}, -- Flow of Time
  [181498] = {{1,PRI_OPEN},nil,nil}, -- Grounding Surge
  [181504] = {{1,PRI_OPEN},nil,nil}, -- Infernal Cascade
  [181506] = {{1,PRI_OPEN},nil,nil}, -- Master Flame
  [181509] = {{1,PRI_OPEN},nil,nil}, -- Arcane Prodigy
  [181511] = {{1,PRI_OPEN},nil,nil}, -- Nether Precision
  [181539] = {{1,PRI_OPEN},nil,nil}, -- Discipline of the Grove
  [181553] = {{1,PRI_OPEN},nil,nil}, -- Gift of the Lich
  [181600] = {{1,PRI_OPEN},nil,nil}, -- Ire of the Ascended
  [181639] = {{1,PRI_OPEN},nil,nil}, -- Siphoned Malice
  [181698] = {{1,PRI_OPEN},nil,nil}, -- Cryo-Freeze
  [181707] = {{1,PRI_OPEN},nil,nil}, -- Diverted Energy
  [181734] = {{1,PRI_OPEN},nil,nil}, -- Magi's Brand
  [181736] = {{1,PRI_OPEN},nil,nil}, -- Flame Accretion
  [181738] = {{1,PRI_OPEN},nil,nil}, -- Artifice of the Archmage
  [181756] = {{1,PRI_OPEN},nil,nil}, -- Incantation of Swiftness
  [181769] = {{1,PRI_OPEN},nil,nil}, -- Tempest Barrier
  [183197] = {{1,PRI_OPEN},nil,nil}, -- Controlled Destruction

--- Monk
  [181700] = {{1,PRI_OPEN},nil,nil}, -- Scalding Brew
  [181742] = {{1,PRI_OPEN},nil,nil}, -- Walk with the Ox
  [181705] = {{1,PRI_OPEN},nil,nil}, -- Celestial Effervescence
  [181740] = {{1,PRI_OPEN},nil,nil}, -- Evasive Stride
  [181495] = {{1,PRI_OPEN},nil,nil}, -- Jade Bond
  [181737] = {{1,PRI_OPEN},nil,nil}, -- Nourishing Chi
  [181505] = {{1,PRI_OPEN},nil,nil}, -- Resplendent Mist
  [181641] = {{1,PRI_OPEN},nil,nil}, -- Rising Sun Revival
  [181435] = {{1,PRI_OPEN},nil,nil}, -- Calculated Strikes
  [181462] = {{1,PRI_OPEN},nil,nil}, -- Coordinated Offensive
  [181376] = {{1,PRI_OPEN},nil,nil}, -- Inner Fury
  [181465] = {{1,PRI_OPEN},nil,nil}, -- Xuen's Bond
  [181759] = {{1,PRI_OPEN},nil,nil}, -- Strike with Clarity
  [181774] = {{1,PRI_OPEN},nil,nil}, -- Imbued Reflections
  [181770] = {{1,PRI_OPEN},nil,nil}, -- Bone Marrow Hops
  [181508] = {{1,PRI_OPEN},nil,nil}, -- Fortifying Ingredients
  [181775] = {{1,PRI_OPEN},nil,nil}, -- Way of the Fae
  [181466] = {{1,PRI_OPEN},nil,nil}, -- Grounding Breath
  [181373] = {{1,PRI_OPEN},nil,nil}, -- Harm Denial
  [181512] = {{1,PRI_OPEN},nil,nil}, -- Dizzying Tumble
  [181510] = {{1,PRI_OPEN},nil,nil}, -- Lingering Numbness
  [181624] = {{1,PRI_OPEN},nil,nil}, -- Swift Transference
  [181640] = {{1,PRI_OPEN},nil,nil}, -- Tumbling Technique

--- Paladin
  [182304] = {{1,PRI_OPEN},nil,nil}, -- Divine Call
  [182307] = {{1,PRI_OPEN},nil,nil}, -- Shielding Words
  [182336] = {{1,PRI_OPEN},nil,nil}, -- Golden Path
  [182338] = {{1,PRI_OPEN},nil,nil}, -- Pure Concentration
  [182448] = {{1,PRI_OPEN},nil,nil}, -- Light's Barding
  [182456] = {{1,PRI_OPEN},nil,nil}, -- Wrench Evil
  [182461] = {{1,PRI_OPEN},nil,nil}, -- Echoing Blessings
  [182462] = {{1,PRI_OPEN},nil,nil}, -- Expurgation
  [182465] = {{1,PRI_OPEN},nil,nil}, -- Truth's Wake
  [182559] = {{1,PRI_OPEN},nil,nil}, -- Templar's Vindication
  [182582] = {{1,PRI_OPEN},nil,nil}, -- Enkindled Spirit
  [182608] = {{1,PRI_OPEN},nil,nil}, -- Virtuous Command
  [182622] = {{1,PRI_OPEN},nil,nil}, -- Resplendent Light
  [182667] = {{1,PRI_OPEN},nil,nil}, -- Focused Light
  [182675] = {{1,PRI_OPEN},nil,nil}, -- Untempered Dedication
  [182677] = {{1,PRI_OPEN},nil,nil}, -- Punish the Guilty
  [182681] = {{1,PRI_OPEN},nil,nil}, -- Vengeful Shock
  [182684] = {{1,PRI_OPEN},nil,nil}, -- Resolute Defender
  [182753] = {{1,PRI_OPEN},nil,nil}, -- Royal Decree
  [182767] = {{1,PRI_OPEN},nil,nil}, -- The Long Summer
  [182770] = {{1,PRI_OPEN},nil,nil}, -- Righteous Might
  [182777] = {{1,PRI_OPEN},nil,nil}, -- Hallowed Discernment
  [182778] = {{1,PRI_OPEN},nil,nil}, -- Ringing Clarity

--- Priest
  [181826] = {{1,PRI_OPEN},nil,nil}, -- Translucent Image
  [181827] = {{1,PRI_OPEN},nil,nil}, -- Move with Grace
  [181837] = {{1,PRI_OPEN},nil,nil}, -- Clear Mind
  [181838] = {{1,PRI_OPEN},nil,nil}, -- Charitable Soul
  [181840] = {{1,PRI_OPEN},nil,nil}, -- Light's Inspiration
  [181842] = {{1,PRI_OPEN},nil,nil}, -- Power Unto Others
  [181843] = {{1,PRI_OPEN},nil,nil}, -- Shining Radiance
  [181844] = {{1,PRI_OPEN},nil,nil}, -- Pain Transformation
  [181845] = {{1,PRI_OPEN},nil,nil}, -- Exaltation
  [181847] = {{1,PRI_OPEN},nil,nil}, -- Lasting Spirit
  [181867] = {{1,PRI_OPEN},nil,nil}, -- Swift Penitence
  [181942] = {{1,PRI_OPEN},nil,nil}, -- Focused Mending
  [181944] = {{1,PRI_OPEN},nil,nil}, -- Resonant Words
  [181962] = {{1,PRI_OPEN},nil,nil}, -- Mental Recovery
  [181974] = {{1,PRI_OPEN},nil,nil}, -- Courageous Ascension
  [181981] = {{1,PRI_OPEN},nil,nil}, -- Festering Transfusion
  [182129] = {{1,PRI_OPEN},nil,nil}, -- Fae Fermata
  [182130] = {{1,PRI_OPEN},nil,nil}, -- Shattered Perceptions
  [182131] = {{1,PRI_OPEN},nil,nil}, -- Haunting Apparitions
  [182138] = {{1,PRI_OPEN},nil,nil}, -- Mind Devourer
  [182139] = {{1,PRI_OPEN},nil,nil}, -- Rabid Shadows
  [182140] = {{1,PRI_OPEN},nil,nil}, -- Dissonant Echoes
  [182141] = {{1,PRI_OPEN},nil,nil}, -- Holy Oration

--- Rogue
  [183492] = {{1,PRI_OPEN},nil,nil}, -- Reverberation
  [183493] = {{1,PRI_OPEN},nil,nil}, -- Sudden Fractures
  [183494] = {{1,PRI_OPEN},nil,nil}, -- Septic Shock
  [183495] = {{1,PRI_OPEN},nil,nil}, -- Lashing Scars
  [183496] = {{1,PRI_OPEN},nil,nil}, -- Nimble Fingers
  [183497] = {{1,PRI_OPEN},nil,nil}, -- Recuperator
  [183498] = {{1,PRI_OPEN},nil,nil}, -- Cloaked in Shadows
  [183499] = {{1,PRI_OPEN},nil,nil}, -- Quick Decisions
  [183500] = {{1,PRI_OPEN},nil,nil}, -- Fade to Nothing
  [183501] = {{1,PRI_OPEN},nil,nil}, -- Rushed Setup
  [183502] = {{1,PRI_OPEN},nil,nil}, -- Prepared for All
  [183503] = {{1,PRI_OPEN},nil,nil}, -- Poisoned Katar
  [183504] = {{1,PRI_OPEN},nil,nil}, -- Well-Placed Steel
  [183505] = {{1,PRI_OPEN},nil,nil}, -- Maim, Mangle
  [183506] = {{1,PRI_OPEN},nil,nil}, -- Lethal Poisons
  [183507] = {{1,PRI_OPEN},nil,nil}, -- Triple Threat
  [183508] = {{1,PRI_OPEN},nil,nil}, -- Ambidexterity
  [183509] = {{1,PRI_OPEN},nil,nil}, -- Sleight of Hand
  [183510] = {{1,PRI_OPEN},nil,nil}, -- Count the Odds
  [183511] = {{1,PRI_OPEN},nil,nil}, -- Deeper Daggers
  [183512] = {{1,PRI_OPEN},nil,nil}, -- Planned Execution
  [183513] = {{1,PRI_OPEN},nil,nil}, -- Stiletto Staccato
  [183514] = {{1,PRI_OPEN},nil,nil}, -- Perforated Veins

--- Shaman
  [182105] = {{1,PRI_OPEN},nil,nil}, -- Astral Protection
  [182106] = {{1,PRI_OPEN},nil,nil}, -- Refreshing Waters
  [182107] = {{1,PRI_OPEN},nil,nil}, -- Vital Accretion
  [182108] = {{1,PRI_OPEN},nil,nil}, -- Thunderous Paws
  [182109] = {{1,PRI_OPEN},nil,nil}, -- Totemic Surge
  [182110] = {{1,PRI_OPEN},nil,nil}, -- Crippling Hex
  [182111] = {{1,PRI_OPEN},nil,nil}, -- Spiritual Resonance
  [182125] = {{1,PRI_OPEN},nil,nil}, -- Pyroclastic Shock
  [182126] = {{1,PRI_OPEN},nil,nil}, -- High Voltage
  [182127] = {{1,PRI_OPEN},nil,nil}, -- Shake the Foundations
  [182128] = {{1,PRI_OPEN},nil,nil}, -- Call of Flame
  [182134] = {{1,PRI_OPEN},nil,nil}, -- Unruly Winds
  [182135] = {{1,PRI_OPEN},nil,nil}, -- Focused Lightning
  [182136] = {{1,PRI_OPEN},nil,nil}, -- Chilled to the Core
  [182137] = {{1,PRI_OPEN},nil,nil}, -- Magma Fist
  [182142] = {{1,PRI_OPEN},nil,nil}, -- Embrace of Earth
  [182143] = {{1,PRI_OPEN},nil,nil}, -- Swirling Currents
  [182144] = {{1,PRI_OPEN},nil,nil}, -- Nature's Focus
  [182145] = {{1,PRI_OPEN},nil,nil}, -- Heavy Rainfall
  [182345] = {{1,PRI_OPEN},nil,nil}, -- Elysian Dirge
  [182346] = {{1,PRI_OPEN},nil,nil}, -- Tumbling Waves
  [182347] = {{1,PRI_OPEN},nil,nil}, -- Essential Extraction
  [182348] = {{1,PRI_OPEN},nil,nil}, -- Lavish Harvest

--- Warlock
  [182340] = {{1,PRI_OPEN},nil,nil}, -- Fel Celerity
  [182449] = {{1,PRI_OPEN},nil,nil}, -- Resolute Barrier
  [182460] = {{1,PRI_OPEN},nil,nil}, -- Accrued Vitality
  [182466] = {{1,PRI_OPEN},nil,nil}, -- Shade of Terror
  [182470] = {{1,PRI_OPEN},nil,nil}, -- Demonic Momentum
  [182478] = {{1,PRI_OPEN},nil,nil}, -- Corrupting Leer
  [182736] = {{1,PRI_OPEN},nil,nil}, -- Rolling Agony
  [182743] = {{1,PRI_OPEN},nil,nil}, -- Focused Malignancy
  [182747] = {{1,PRI_OPEN},nil,nil}, -- Withering Bolt
  [182748] = {{1,PRI_OPEN},nil,nil}, -- Borne of Blood
  [182750] = {{1,PRI_OPEN},nil,nil}, -- Carnivorous Stalkers
  [182751] = {{1,PRI_OPEN},nil,nil}, -- Tyrant's Soul
  [182752] = {{1,PRI_OPEN},nil,nil}, -- Fel Commando
  [182754] = {{1,PRI_OPEN},nil,nil}, -- Duplicitous Havoc
  [182755] = {{1,PRI_OPEN},nil,nil}, -- Ashen Remains
  [182769] = {{1,PRI_OPEN},nil,nil}, -- Combusting Engine
  [182772] = {{1,PRI_OPEN},nil,nil}, -- Infernal Brand
  [182960] = {{1,PRI_OPEN},nil,nil}, -- Soul Tithe
  [182961] = {{1,PRI_OPEN},nil,nil}, -- Fatal Decimation
  [182962] = {{1,PRI_OPEN},nil,nil}, -- Catastrophic Origin
  [182964] = {{1,PRI_OPEN},nil,nil}, -- Soul Eater
  [183044] = {{1,PRI_OPEN},nil,nil}, -- Kilrogg's Cunning
  [183076] = {{1,PRI_OPEN},nil,nil}, -- Diabolic Bloodstone

--- Warrior
  [180842] = {{1,PRI_OPEN},nil,nil}, -- Stalwart Guardian
  [180844] = {{1,PRI_OPEN},nil,nil}, -- Brutal Vitality
  [180847] = {{1,PRI_OPEN},nil,nil}, -- Inspiring Presence
  [180896] = {{1,PRI_OPEN},nil,nil}, -- Safeguard
  [180932] = {{1,PRI_OPEN},nil,nil}, -- Fueled by Violence
  [180933] = {{1,PRI_OPEN},nil,nil}, -- Ashen Juggernaut
  [180935] = {{1,PRI_OPEN},nil,nil}, -- Crash the Ramparts
  [180943] = {{1,PRI_OPEN},nil,nil}, -- Cacophonous Roar
  [180944] = {{1,PRI_OPEN},nil,nil}, -- Merciless Bonegrinder
  [181469] = {{1,PRI_OPEN},nil,nil}, -- Indelible Victory
  [181709] = {{1,PRI_OPEN},nil,nil}, -- Unnerving Focus
  [181712] = {{1,PRI_OPEN},nil,nil}, -- Depths of Insanity
  [181735] = {{1,PRI_OPEN},nil,nil}, -- Hack and Slash
  [181776] = {{1,PRI_OPEN},nil,nil}, -- Vicious Contempt
  [182440] = {{1,PRI_OPEN},nil,nil}, -- Piercing Verdict
  [182442] = {{1,PRI_OPEN},nil,nil}, -- Veteran's Repute
  [182463] = {{1,PRI_OPEN},nil,nil}, -- Harrowing Punishment
  [182468] = {{1,PRI_OPEN},nil,nil}, -- Mortal Combo
  [182624] = {{1,PRI_OPEN},nil,nil}, -- Show of Force
  [182651] = {{1,PRI_OPEN},nil,nil}, -- Destructive Reverberations
  [182656] = {{1,PRI_OPEN},nil,nil}, -- Disturb the Peace

}
