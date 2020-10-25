-- Revisions:
--[[<p>09.16 16.12.2018</p>
<p><ul>
<li>Added Scouting Report:.</li>
<li>When on button is fake item, just to simulate button location, then tooltip is properly updated and not giving help for blacklist or skip it.</li>
</ul><hr></p>
]]
--[[<p>09.14 24.08.2018</p>
<p><ul>
<li>Fix was incorrect place, moved into tooltip match by line number.</li>
<li>Validated reason for misformated tooltip is definetely way how wow client load items into cache. Wrong patter detection happens only on 1st login when fresh wow client is started.</li>
</ul><hr></p>
]]
--[[<p>09.12 23.08.2018</p>
<p><ul>
<li>Still having problem with misformated tooltips adding quick bandaid for "Requires Level 100" detection.</li>
</ul><hr></p>
]]
--[[<p>09.10 14.08.2018</p>
<p><ul>
<li>Items with spells were erased after spec switch.</li>
<li>Still hunting down problem with consumables and junk recoginized as usable. Already fixed most reasons, but still sometime happens.</li>
<li>And finally catch it! Sometime shortly after login, usually at 1st login of the day on slow connection or slow computer seems that detection of blind mode fails and all lines in tooltip are shifted by 1. Seems that client for short time sees color blind mode enabled! This never did happens pre 8.0.x</li>
<li>New version is printed once per account not once per profile.</li>
</ul><hr></p>
]]
--[[<p>09.08 07.08.2018</p>
<p><ul>
<li>Item check cache cleared up every 10 seconds to catch new items.</li>
<li>ZONE_CHANGED event don't catch realiably zone change. Sometime addon catch continent mapID instead real zone!</li>
</ul><hr></p>
]]
--[[<p>09.06 23.07.2018</p>
<p><ul>
<li>Tooltip for couple of item can be broken when WoW client is freshly started and 1st toon does login. After switch to another toon tooltips are OK. Seems like bug in Blizzard's code because tooltips are striped off last line!.</li>
<li>Retry mechanic in pattern loading is now extended to tooltip scans and fixed tooltip reading as well.</li>
<li>Removed extra diagnostic prints, reson for problem is known now.</li>
</ul><hr></p>
]]
--[[<p>09.04 22.07.2018</p>
<p><ul>
<li>Bug Fix pattern matching and erros in match table.</li>
</ul><hr></p>
]]
--[[<p>09.02 20.07.2018</p>
<p><ul>
<li>Fix garrison mapID, missing 4th mapID for tier1.</li>
<li>Removed all code for build 7.3.x.</li>
<li>Check mapID not only on zone change, sometime event for zone chnges is not fired up!</li>
<li>More events could trigger up item rescan in bags including mail, bank, guild bank and trade. Item rescan now is staggered into 1 seconds delay to make just one call if too many events are triggered at once.</li>
<li>Artifact realted code removed as it is obsolete now</li>
</ul><hr></p>
]]
--[[<p>09.00 18.07.2018</p>
<p><ul>
<li>TOC updated to match Live.</li>
<li>New milenia new mayor version.</li>
<li>Remaped mapIDs to new build. Trash white items still are in tables and need more cleanup.</li>
</ul><hr></p>
]]
--[[<p>08.48 15.07.2018</p>
<p><ul>
<li>Updated libraries for better compatibility with WoW BFA Beta.</li>
<li>Option not to place tokes for artifact when artifact have all traits, actually when it has level 75.</li>
<li>Added Pandaria reputation tokens.</li>
</ul><hr></p>
]]
--[[<p>08.46 21.05.2018</p>
<p><ul>
<li>Fix for call to undefined function printt.</li>
</ul><hr></p>
]]
--[[<p>08.44 01.05.2018</p>
<p><ul>
<li>Added Petrified Wyrmtongue.</li>
<li>WoW 8.x support. Ace3 libraries and other libraries updated to 8.0.1 support as well. For mapID now is used HereBeDragons 1.0 and 2.0</li>
<li>Full LINT declaration and assertion check with call stack on wrong arguments.</li>
<li>Timer function calls now doesn't overlap by default.</li>
<li>Migration all references P. to local LINT friendly, prevents use of not defined variables.</li>
</ul><hr></p>
]]
--[[<p>08.42 17.04.2018</p>
<p><ul>
<li>Fix. Restore item buttom and quest bar button frame anchor according to saved anchor in profile, instead reseting position.</li>
<li>Fix. Tooltip anchor and if ElvUI is installed, then is forced to use uberTooltip anchor.</li>
<li>Fix. Save procedure calls parent frame as nil for anchor when buttons are moved.</li>
</ul><hr></p>
]]
--[[<p>08.40 04.04.2018</p>
<p><ul>
<li>Some MIA clams items returns back and Strange Ball of Energy.</li>
<li>Items with Learning spell on it reinstated back.</li>
<li>Only left text in tooltip is comared to red.</li>
<li>Removed Stabilized Titan Essence now it is vendor trash.</li>
<li>When faction is exalted and there is paragong reward pending then standing is shown as Exalted+.</li>
</ul><hr></p>
]]
--[[<p>08.38 22.03.2018</p>
<p><ul>
<li>Herald option now obey setting for artifact as well.</li>
</ul><hr></p>
]]
--[[<p>08.36 16.03.2018</p>
<p><ul>
<li>When reputation tokens aren't disabled on exalted, these will not be placed if paragon reward is pending.</li>
<li>All declarations rewriten to use LINT and strict locak check. Found 3 variables refered before use.</li>
<li>Hope it will fix Garrison mine buff problem, quest bar hotkey bind and reputation rewards.</li>
<li>Added Illusion: items and Badge of Honor.</li>
</ul><hr></p>
]]
--[[<p>08.34 21.02.2018</p>
<p><ul>
<li>Workaround for bug in WoW API function C_Reputation.GetFactionParagonInfo() it returns empty values in certain dungeon.</li>
<li>References to WoWBox removed not needit anymore it is in mainsteream.</li>
</ul><hr></p>
]]
--[[<p>08.32 01.02.2018</p>
<p><ul>
<li>If <b>/nop unlist #itemID</b> remove item from blacklist then rescan is started.</li>
<li>Clash with MogIT addon fixed.</li>
</ul><hr></p>
]]
--[[<p>08.30 29.01.2018</p>
<p><ul>
<li>Thanks to LibArtifactData now addon can notify about all artifacts seen in bags or bank when there are unsped points or free traits.</li>
<li>Some German translations corrected, thanks to Salty.</li>
</ul><hr></p>
]]
--[[<p>08.28 21.01.2018</p>
<p><ul>
<li>Updated Chinese Traditional localization thanks to BNSSNB.</li>
<li>Diagnostic message tied to pick-locking now printed only in verbose mode.</li>
<li>Red text in tooltips is now searched on both sides of tooltip.</li>
<li>When exalted is reached by using token then is validate right after and removed from button.</li>
<li>Added announce for A new trait is available at the Netherlight Crucible.</li>
<li>Rest of locale translated by Google translator if you don't like it, please, supply own translation and I will merge it into code. Even for English localization suggestions are welcomed is not my native language as well.</li>
</ul><hr></p>
]]
--[[<p>08.26 28.12.2017</p>
<ul>
<li>Ability to filter items when reputation with Legion faction is Exalted. Filtering for other pre Legion reputation tokens are not implemented yet.</li>
<li>Two new events hook for incoming items ITEM_PUSH and CHAT_MSG_LOOT.</li>
<li>Caching patterns is now more patient to fetch items from server to local cache, it should take some time until all items are recognized and placed on button.</li>
</ul>
]]
--[[<p>08.24 14.12.2017</p>
<ul>
<li>Added Carefully Hidden Muffin, Krokul Armor Set, Demon's Soulstone and Awoken Titan Essence.</li>
<li>Now are shown standings for Legion reputation in tooltip for proper tokens. When there is installed Order Hall Commander add-on then in tooltip at mission table is NOP standing disabled.</li>
<li>Legion reputation tokens optimized, now all using pattern matching.</li>
</ul>
]]
--[[<p>08.22 04.12.2017</p>
<ul>
<li>Mana Crystal and Ancient Mana Crystal as items not pattern.</li>
<li>Added Summon Grimtotem Warrior, Summoning Portal, Lucky Rabbit's Foot, Scream of the Dead</li>
</ul>
]]
--[[<p>08.20 17.11.2017</p>
<ul>
<li>Final fix for picklocking? Now when item is possible to unlock then item starts to glow.</li>
<li>Most items identified by GetItemSpell() function moved. T_SPELL_BY_USE_TEXT now use only pattern for standard global strings ITEM_OPENABLE, and ITEM_SPELL_TRIGGER_ONUSE pattern match.</li>
<li>Tokens leading to use spell Create Item.</li>
</ul>
]]
--[[<p>08.18 14.11.2017</p>
<ul>
<li>Fix announce generating error when reagent name is not yet in cache.</li>
<li>When spellLoad or itemLoad reach retry limit it prints last offending itemID and or spellID as well.</li>
</ul>
]]
--[[<p>08.16 10.11.2017</p>
<ul>
<li>Instant world quest completion skills are now announced when become ready, it does check if necessary consumable is present.</li>
<li>Implemented different priorities for groups of items like artefact power, tokens, reputation.</li>
<li>Cleanup code and updates to item button is done only when really new item is placed on.</li>
<li>Possible fix for lockpicking.</li>
<li>Possible fix for stacks of cofee in garrison mine.</li>
</ul>
]]
--[[<p>08.14 29.10.2017</p>
<ul>
<li>Verbose message when preload of items and spells does fail.</li>
<li>Fix for armor Unsullied tokens. Developers decide to put type of armor inside string!</li>
<li>SpellLoad() rewritten if there is bad item to load it does at least load all remaining patterns.</li>
<li>Option to hide items button in combat. Quest bar still is shown in combat because there could be items usable in combat.</li>
</ul>
]]
--[[<p>08.12 25.10.2017</p>
<ul>
<li>Added Golden Banana, Earthen Mark, Imp Pact, Reaves Battery, Shattered Soul, Squire's Oath</li>
<li>Some locale now using short-names.</li>
<li>ERR_SPELL_FAILED_ANOTHER_IN_PROGRESS won't trigger temp blacklist, it shall be produced when someone bash button too often.</li>
<li>Fix for itemID 129097 GetItemInfo doesn't return any value.</li>
</ul>
]]
--[[<p>08.10 12.10.2017</p>
<ul>
<li>/nop list is more verbose and /nop unlist itemID as well. Fixed printing help when /nop unlist was used even command is known and processed.</li>
<li>Added Runed Aspirant's Band, Scroll of Forgotten Knowledge, Fel Armor Enhancement Token and Ashtongue Beacon.</li>
<li>Workaround for possible Quest Watcher frame taint in AutoQuest.</li>
<li>Added option to set strata for item button, issue #34 Ability to set strata.</li>
<li>Added announce function where completion of work orders, gain in artifact points, paragon reward and others.</li>
<li>Automatic temporary blacklist item on button when click producing any error message.</li>
</ul>
]]
--[[<p>08.08 04.10.2017</p>
<ul>
<li>Added Mac'Aree Armor Set, Relinquished Relics, Lightforged Bulwark, Nathrezim Tome of Manipulation and Xenedar Armor Set.</li>
<li>Removed obsolete Artifact Research Notes.</li>
<li>Fix for ticket #35, Toggle -> Swap: Option in configuration GUI is broken.</li>
<li>Cooldown text on buttons now corectly dismiss when item on button is replaced and new item has no active cooldown.</li>
</ul>
]]
--[[<p>08.06 18.09.2017</p>
<ul>
<li>Added Libram of Truth, Krokul Ridgestalker, Argussian Reach Insignia, Greater Argussian Reach Insignia, Army of the Light Insignia, Greater Army of the Light Insignia and Void-Purged Krokul.</li>
</ul>
]]
--[[<p>08.04 01.09.2017</p>
<ul>
<li>Added Stolen Shado-Pan Insignia, Broken Isles Recipe Scrap.</li>
<li>Fix QuestButton tooltip.</li>
</ul>
]]
--[[<p>08.02 31.08.2017</p>
<ul>
<li>7.3 patch is here, lets up TOC and version to new milenia.</li>
<li>Mouse buttons have icon in tooltip.</li>
<li>Update to all libraries to 7.3 patch compatible version.</li>
</ul>
]]
--[[<p>07.40 24.07.2017</p>
<ul>
<li>Cooldown on button and quest bar, fix.</li>
<li>Exposed profiling function use <b>/nop profile</b> to start profiling, use slash command for 2nd time to get timings and turn it off.</li>
</ul>
]]
--[[<p>07.38 17.07.2017</p>
<ul>
<li>Hook to new event SPELLS_CHANGED.</li>
<li>Added Abundant Order Resources Cache, Stabilized Titan Essence</li>
<li>Cooldown on button and quest bar, fix. Swaping Count and Timer, fix. Now need to find out if cooldown will not show on button twice.</li>
</ul>
]]
--[[<p>07.36 21.06.2017</p>
<ul>
<li>Fix for colorblind mode when lines past 2nd line are used in pattern matching.</li>
<li>To detect colorblind mode CVARS is used.</li>
</ul>
]]
--[[<p>07.34 20.06.2017</p>
<ul>
<li>Fix LUA errors.</li>
</ul>
]]
--[[<p>07.32 19.06.2017</p>
<ul>
<li>Added Artifact Research Compendium up to volume nine.</li>
<li>Added Mark of Prey.</li>
</ul>
]]
--[[<p>07.30 02.06.2017</p>
<ul>
<li>Added Legionfall Insignia for exalted.</li>
<li>Added Horn of Winter, Pile of Bits and Bones, Stolen Tome of Artifact Lore and A Master Plan.</li>
<li>Fix mapIDs for Rush Order: Shipyard. Is not in garrison but at map where garrison is located.</li>
</ul>
]]
--[[<p>07.28 10.05.2017</p>
<ul>
<li>UIError messages are now handled and cleared out. It prevent showing errow when bashing NOP button. Errors now are not handled only on pre-caching items and spells, but all the time.</li>
<li>Fix for lockpicking. Because now macro have form /use item:itemID, UI could try to use locked item or unlock unlocked item. Logic now for unlock use old macro form /use bag slot as target for spell.</li>
<li>Added Artifact Research Compendium: Volumes I-IV.</li>
<li>Removed old code for bank and guild frame, now button can be used with any kind of open frames like trade, vendor and bank.</li>
<li>Other code cleanup, frame in combat handling etc.</li>
</ul>
]]
--[[<p>07.26 18.04.2017</p>
<ul>
<li>Preserved Mining Pick and Miners's Cofee as well all items using Aura check fix, should be shown only in proper sub-zone and map without <b>zone unlock</b> setting influence.</li>
</ul>
]]
--[[<p>07.24 17.04.2017</p>
<ul>
<li>Added back Pet Cage itemID 82800 it seems not to be broken anymore.</li>
<li>Stack size now play role. When item has count limit to use and if count raise above of that limit it will be placed on top.</li>
<li>Artifact power items are incosistend in Blizzard design what a surprise. Added items without item Type "artifact power", but with spell Empowering. Now both types of AP are covered.</li>
<li>NOP buttons are now hidden in petbattle and when vehicle UI is active.</li>
</ul>
]]
--[[<p>07.22 12.04.2017</p>
<ul>
<li>Added Greater Legionfall Insignia and Relinquished tokens.</li>
<li>Finally fixed Rush Order: Shipyard? After I did removed workaround it was not mapID restricted.</li>
</ul>
]]
--[[<p>07.20 12.04.2017</p>
<ul>
<li>Added Glass of Arcwine, Arcane Tablet and Remnant of Falanaar without exalted limit.</li>
<li>InZone logic is now same for all items, no special handling for Shipyard Rush Orders.</li>
<li>Workaround for item is not ready UI error when fetching tooltips for items. It is Blizzard bug, past 7.2.</li>
</ul>
]]
--[[<p>07.18 02.04.2017</p>
<ul>
<li>Added Prepared Ingredients, Obliterum Ash, Netherchunk.</li>
<li>Fixed all Legion reputation insignias, because now are duplicit with "exalted" text in description and without.</li>
</ul>
]]
--[[<p>07.16 31.03.2017</p>
<ul>
<li>Added Champion's Armor Sets, Legionfall Insignia.</li>
<li>Updated Artifact Research Notes to new ItemID.</li>
</ul>
]]
--[[<p>07.14 29.03.2017</p>
<ul>
<li>Added Empowered Elven Tome and Legionfall Recompense.</li>
<li>Removed Artifact Research Notes.</li>
</ul>
]]
--[[<p>07.12 29.03.2017</p>
<ul>
<li>Time shift decreased from 1.0 to 0.001 it shall be enough to keep order in queue becasue GetTime() has precision in three decimal places.</li>
<li>ACE3 library refresh to latest release.</li>
</ul>
]]
--[[<p>07.10 08.02.2017</p>
<ul>
<li>Fix for map locked items.</li>
<li>Last Item on Button should now persist between sessions.</li>
</ul>
]]
--[[<p>07.08 05.02.2017</p>
<ul>
<li>Added Wardens Insignia.</li>
<li>Items are used by ItemID not by bagID, slotID. This allow to have opened bank, guild or trader and items is not moved but it is really used on.</li>
</ul>
]]
--[[<p>07.06 22.12.2016</p>
<ul>
<li>Added Disc of the Starcaller, Lens of Qin'dera.</li>
<li>Fix blacklisting, is again instant, check for another usable not blacklisted item is not delayed.</li>
</ul>
]]
--[[<p>07.04 18.12.2016</p>
<ul>
<li>Extended <b>/nop list</b> output, now show itemID and name from permanent blacklist.</li>
<li>Implemented <b>/nop unlist itemID</b> to allow remove individual items from blacklist using itemID from list of blacklisted items.</li>
<li>Added Blessing of the Order.</li>
<li>Button tooltip should be updated when mouse is over and item on button being changed.</li>
<li>Fixed item flapping on button for fast computers time() nor GetTime() not being updated in bag check.</li>
<li>Fixed bug in /nop verbose.</li>
</ul>
]]
--[[<p>07.02 11.12.2016</p>
<ul>
<li>Fix skins in Masque with backdrop, what I have is ok. So now Masque support can be disabled in case if it does bad, until I'm sure it is real fix. Disabling or enabling Masque need UI reload.</li>
<li>Falanaar scenario items for withered army.</li>
</ul>
]]
--[[<p>07.00 07.12.2016</p>
<ul>
<li>Fix Masque support. Masque group is created in OnEnable(), and buttons on PLAYER_LOGIN event and later.</li>
<li>Quest buttons and Item button now have identical "SecureActionButtonTemplate, ActionButtonTemplate" frame class.</li>
<li>New mayor release.</li>
</ul>
]]
--[[<p>06.28 07.12.2016</p>
<ul>
<li>Added Order Resources Cache.</li>
<li>Fix own skinning of quest bar buttons.</li>
</ul>
]]
--[[<p>06.26 06.12.2016</p>
<ul>
<li>Added Torn Sack of Pet Supplies.</li>
<li>Bags are rechecked every 10 seconds instead 60 seconds to clean-up stuck items on button.It should fix problem with LUA where EVENTS simply aren't fired by UI.</li>
<li>Support for Masque addon. If Masque is installed then Skin Button state in toggle section of configuration is ignored. Still need testing and feedback</li>
</ul>
]]
--[[06.24 27.11.2016

[list][*]Added Order Resources Cache, Spellmask of Azsylla, Infinite Stone, Lenses of Spellseer Dellian and Berserking Helm of Ondry'el.
[*]Added +25 ancient mana items.
[*]Added no BoA Legion insignias giving +250 reputation and fixed non BoA variants.[/list]

]]
--[[06.22 15.11.2016

[list][*]Fix for some ancient mana items caused by bugged GetItemSpell(itemID) it returns item name instead of spell name, but only for certain Legion items.
[*]Added support for Blizzard's Auto Quest Tracker module.
[*]Migrate and cleanup for saved variables in profile.
[*]Added Arcane Remnant, Healing Well, Soothing Leystone Shard of Falanaar and Petrified Silkweave.
[*]Added Heavy, Fortified and Indestructible Armor Set hero boost.[/list]

]]
--[[Revisions: 06.20

06.20 27.10.2016

[list][*]Added Arcane Tablet of Falanaar.
[*]Added Legion reputation items. But be warned addon doesn't check actual standing so it will offer items even at exalted standing. It need to blacklist manually or just use session skip.
[*]Legion patch 7.1 compatible.[/list]

]]
--[[Revisions: 06.18

06.18 20.10.2016

[list][*]Added items with Read to gain new knowledge about your artifact, increasing the rate at which you earn Artifact Power.
[*]Change, moved experience items for player and champion into spells by name table[/list]

]]
--[[Revisions: 06.16

06.16 16.10.2016

[list][*]Added items with Use: Provides a significant increase to character experience spell.
[*]Added items with Use: Open your Followers page and use this item to grant 4000 XP directly to a Champion.
[*]Fix for Legion fishing items.[/list]

]]
--[[Revisions: 06.14

06.14 01.10.2016

[list][*]Added mailbox send frame to list of windows to dismiss before item use. Only works when scripts are enabled in options and running scripts are enabled in WoW client UI.
[*]Ancient mana items for +30,+50,+75,+100,+150,+200 and +300 mana gain.
[*]German localization by Ragnar_F, thx for pointing at some typo errors, "Permanent" is not my favorite word I know.[/list]

]]
--[[Revisions: 06.12

06.12 19.09.2016

[list][*]Long string with multiline is now parsed into multiple strings, and printed. Ticket-fix prevent overflow text out of chat window.
[*]Fix anchor for UberTooltips.
[*]Added powers from Legion fish catches[/list]

]]
--[[Revisions: 06.10

06.10 31.08.2016

[list][*]Removed all Legion checks. Now code is pure 7.0.3 and don't run anymore in older build.
[*]Abbrevated more hot-keys.
[*]Added ES localization thnaks to annthizze.[/list]

]]
--[[Revisions: 06.08

06.08 21.07.2016

[list][*]By request I did rewrite macro logic. Now by default macro don't contains /run NOP:ButtonClose() but only /use bag slot. In 7.0.3 Blizzard added unsecure script toggle warning. So it is impossible to run any /run or /script inside macro if user don't want to enable it. For those who still want to have old functionality which make live better enable it in option's Toggle section under "Script". Button then can be pressed even when bank, guild bank or trader window is open (it will be auto closed). If these windows remain opened and you press NOP button, then item is moved or sold instead used.[/list]

]]
--[[Revisions: 06.06

06.06 19.07.2016

[list][*]TOC update for 7.0.3 release.[/list]

]]
--[[Revisions: 06.04

06.04 03.07.2016

[list][*]Refresh libraries for Legion-compatibility.
[*]Added Tome of Sorcerous Elements and Tome of the Stones.[/list]

]]
--[[Revisions: 06.02

06.02 17.06.2016

[list][*]Added all items granting artifact power via spell "Empowering" in Legion. Thanks to yoshimo.[/list]

]]
--[[Revisions: 06.00

06.00 13.06.2016

[list][*]Fixed Verbose mode.
[*]Picklock fix for colorblind mode, thanks MartinL, pointing me out.
[*]New milenia, new mayor version, ready for Legion.
[*]Fix for some tailoring recipes Pattern:, not all have learning spell.
[*]Added Windfeather Plume just for Timeless Isle for now, most worth there because location is no-fly zone.[/list]

]]
--[[Revisions: 05.40

05.40 08.06.2016

[list][*]Added Timeless Isle specific buff items.
[*]Diagnostic for lock-picking when there is problem to determine pick-locking level.
[*]All chat frame output is now normalized.
[*]Rewriten logic for zone (map) and sub-zone in map for zone-usable items and spells.[/list]

]]
--[[Revisions: 05.38

05.38 07.06.2016

[list][*]More Legion code changes, texture coloring fix, button cooldown fix.
[*]Formating output in chat with time-stamp, addon and message.
[*]Added artifact power items from WoW Legion beta.
[*]Application is Legion compatible and detect version of client. To enable it set enable load outdated addons or change ## Interface: 60200 to ## Interface: 70000 in nop.toc file. I will not maintain separate beta addon.
[*]Fix for backdrop, highlighted and pushed button.[/list]

]]
--[[Revisions: 05.36

05.36 16.05.2016

[list][*]Blingtron gift package drop Encoded Message, it can be used and collected for achievement.
[*]Fix in library LibQuestItem-1.0. Legion beta migration, fix for missing GetAuctionItemClasses().
[*]Item and spell update runs are reported only with verbose on.[/list]

]]
--[[Revisions: 05.34

05.34 02.04.2016

[list][*]Grarrison mine fix for miner's coffee and pick[/list]

]]
--[[Revisions: 05.32

05.32 01.04.2016

[list][*]Added zhCN translation thanks to ??[/list]

]]
--[[Revisions: 05.30

05.30 31.03.2016

[list][*]Added Trade Agreement: Arakkoa Outcasts.
[*]Added follower's contracts.
[*]Enhancement for Rush Order: Shipyard, can be used only in shipyards so there is no reason place it on button outside it has no need indication like salvage crates.
[*]Verbose output has time-stamp.[/list]

]]
--[[Revisions: 05.28

05.28 15.02.2016

[list][*]Fix, oversized hot-key text on button. Now is text width for quest button fixed as width of button set in options as well.[/list]

]]
--[[Revisions: 05.26

05.26 09.02.2016

[list][*]zhTW localization updated thanks BNSSNB.
[*]Fix, oversized hot-key text on button. Now hotkeys are abrevated ALT- (A) CTRL (C), SHIFT (S) and BUTTON (M) CTRL-BUTTON1 would be CM1 etc.[/list]

]]
--[[Revisions: 05.24

05.24 25.11.2015

[list][*]Fix for map. Add-on didn't restore continent level view of map in query for actual zoneID. Tanks MartinL.
[*]Added feature to swap location for item count with item timer on button. Check new toggle option "Swap".[/list]
]]
--[[Revisions: 05.22

05.22 25.11.2015

[list][*]Added Sha-Touched Leather, another leather scrap I did miss build in.[/list]
]]
--[[Revisions: 05.20

05.20 22.11.2015

[list][*]Added Back Plans: recipes, not all have spell learn on it.
[*]Added Partial Receipt: Gizmothingies. Extedned support for combine recipes as well.
[*]Verbose output about cache update runs.
[/list]
]]
--[[Revisions: 05.18

05.18 23.10.2015

[list][*]Rush Order: Shipyard, priority add as item zone-restricted. Now it should be shown only at shipyard, where can be used.
[*]Added Water Bucket, for Halloween event.
[/list]
]]
--[[Revisions: 05.16

05.16 07.10.2015

[list][*]Frostdeep Minnow and Lunarfall Carp added and are shown only in Garrison.
[*]LibBabble-SubZone-3.0 updated to 6.2-release1.
[/list]
]]
--[[Revisions: 05.14

05.14 17.09.2015

[list][*]Filled complete "stem","leaf","bramble","stalk","cap","ichor" and "petal" fragments for herbs. How creative in naming is Blizzard again... All for herbalism combine.
[*]Filled complete fragments for mining profession.
[*]Filled complete fragments for skinning profession.
[*]Added "Fragrant" Pheromone Fish. You need to have or click on target to use.
[/list]
]]
--[[Revisions: 05.12

05.12 08.09.2015

[list][*]When anchor for Quest Bar is resized, then all buttons in bar are resized and re-anchored as well. In future there can be different size for buttons in Item Button and Quest Bar.
[*]Time shift when add more than one item at once into priority queue. Items shall not jump over on button.
[*]Salvage items are shown only in Garrison even if "zone unlock" is enabled. Outside Garrison this is not that important to know.
[*]New items, Blueprint: Oil Rig,Saberstalker Teachings: Trailblazer, Mission Completion Orders, Obsidian Frostwolf Petroglyph, Ship: The Awakener and Empowered Apexis Fragment
[/list]
]]
--[[Revisions: 05.10

05.10 14.08.2015

[list][*]Taint fix. According http://us.battle.net/wow/en/forum/topic/7414944627, there is problem with original code and use of ActionButton_ShowOverlayGlow. I see taints from NOP or ElvUI, where this function is called inside LibActionButton-1.0. I did copy/mod of these functions inside my code. So it should be now safe against taints and still i can use glow around button.
[*]Fixed typo error ItemTouse() in pet-check.
[/list]
]]
--[[Revisions: 05.08

05.08 09.08.2015

[list][*]Fix, pick-locking.
[*]Added, lazy bags check every one minute. Sometime events aren't fired and bags getting new item. Like recipes discovered during cooking. This should fix it.[/list]
]]
--[[Revisions: 05.06

05.06 08.08.2015

[list][*]Fix, blacklist function.[/list]
]]
--[[Revisions: 05.04

05.04 07.08.2015

[list][*]Fix, zone-lock back in action. Was MIA as part of priority mod.[/list]
]]
--[[Revisions: 05.02

05.02 04.08.2015

[list][*]Fix, sometime priority was reversed.[/list]
]]
--[[Revisions: 05.00

05.00 04.08.2015

[list][*]New Blueprint: oil Rig.
[*]Items finding completely rewritten to support priority. Now are newer items placed on top and replacing old ones on button.
[*]Option to swap mouse buttons will not be implemented, macro attributes are mouse button depended and is not easy swap them on fly.[/list]
]]
--[[Revisions: 04.36

04.36 21.07.2015

[list][*]New, Rush Orders and Bulging Barrel of Oil.
[*]Fix, Medallion of the Legion. strfind need to use plain compare![/list]
]]
--[[Revisions: 04.34

04.34 06.07.2015

[list][*]Optimized, workaround for broken tooltip. Now I do just SetOwner for it.
[*]New, figurines from jungle.[/list]
]]
--[[Revisions: 04.32

04.32 03.07.2015

[list][*]Placed backdrop under button and quest bar.
[*]Option to separate Item Button and Quest Item Bar. Is tricky to setup positions for both. 1st is need place Quest Item Bar with sticky enabled via Item Button, then disable sticky and move Item Button to final position. Separate mover will be build up in future.
[*]Fix for missing functions when user not using ElvUI. SetInside and SetOutside are functions added in ElvUI.[/list]
]]
--[[Revisions: 04.30

04.30 02.07.2015

[list][*]Fix. Skin button now really remove button border and skin looks like ElvUI again.
[*]New items, Medallion of the Legion and Fel-Touched Pet Supplies. Why people in Blizzard are so creative, always new string on use for new item :(/[/list]
]]
--[[Revisions: 04.28

04.28 24.06.2015

[list][*]Added Elemental Rune.
[*]Fix. Cool-down timer is reseted when item on button is changed. It prevent running cool-down from old item over actual item.
[*]Fix. Swipe on not skined button.
[*]Updated #TOC number to 60200.[/list]
]]
--[[Revisions: 04.26

04.26 06.06.2015

[list][*]Separate blacklist for Items Button and Quest Items Bar.
[*]Reset blacklist resets both balacklists. Now are separate with possible option to reset them with option.
[*]Injected variables as preparation to possible separation of anchor point for Quest Item Bar.
[*]Fix pets, tool-tip is not same for all pets. Some has "Use: Teaches you how to summon and dismiss this companion." Other have "Use: Teaches you how to summon this companion."
[*]Fix anchor for Quest Item Bar, now it move with Item Button. Prepared for breaking apart from it with options soon.[/list]
]]
--[[Revisions: 04.xx
04.24 29.04.2015

[list][*]Fix. Formatting for Cool-down numbers.
[*]Fix. When colorblind mode was on, Rare items were put on Item Bar.[/list]

04.22 25.04.2015

[list][*]Added Fool's cap spores.
[*]Cooldown number is now formated as H:MM or M:SS or SS or S.S, format depends on remaining time on CD.
[*]Fix LibQuestItem usage to prevent malfunctiin original QuestItemBar.[/list]

04.20 17.04.2015

[list][*]Fix. Cooldown formatting.
[*]Session and permanent blacklist for items at Quest Button bar.[/list]

04.18 15.04.2015

[list][*]Spacing for Quest Button bar is configurable in options.[/list]

04.16 13.04.2015

[list][*]Fix. Tooltip anchor for Quest Bar without 'Uber' tooltips.
[*]Added own cooldown text over Item Button and Quest Bar buttons.[/list]

04.14 13.04.2015

[list][*]Fix. Draenor fish catches, now combine all small, normal and large in stacks of 5.
[*]Patched LibQuestItem-1.0 to react at event QUEST_ACCEPTED. Need it to react at quest accept to change state of items starting quests.[/list]

04.12 11.04.2015

[list][*]Added herb parts for combine.
[*]Fix. Button Bar, buttons sometime aren't continuous, when item starts quest or is active in quest.[/list]

04.10 06.04.2015

[list][*]Fix item starting quest is placed only once at bar.
[*]Item starting quest, should be removed from bar, if item is not needed for quest anymore. I hope, Blizzard giving only few clues to determine it.
[*]zhTW translation by BNSSNB.[/list]

04.08 04.04.2015

[list][*]Fix hot-key on quest bar is really sticky and not over all buttons.
[*]Feature undo, from active macro is removed /stopcasting, so ppl can spam and bash button as would like.[/list]

04.06 04.04.2015

[list][*]Fix quest bar click in combat, flood of timers, client crash.[/list]

04.04 04.04.2015

[list][*]Exploit of function GetItemSpell(itemID) most of profession plans has "Learning". It will simplify detection and tables.
[*]New functionality, because QuestItemBar is abandoned project according to author (http://www.wowace.com/addons/questitembar/). I can't live without that addon I'm adding core of it as NOP extension. These two should have great synergy.
[*]On skinned button is icon no longer zoomed, it will be configurable in future release.
[*]Hot-key for qest bar is sticky between sessions. So same item will have it bound after relogin. If there is no item on bar with assigned hot-key, then 1st button have it assigned, but that assigment is not sticky.[/list]

04.02 30.03.2015

[list][*]Fix-up for ticket 4, skinning of skinned is not well, internal check should avoid it.[/list]

04.00 26.03.2015

[list][*]Removed Expired Receipt. They are in 6.1 vendor trash now.
[*]On item and spell load now is limit how many times will try cache update. Both internal tooltips are now checked against zero lines and just single line, because some tool-tip addons placing "Retrieving item information" into one line tooltip to workaround Blizzard's behave returning empty tooltip for items not in cache. This could fool my addon to think tooltip is ok.
[*]New character get 'Default' profile instead 'Realm - Name'
[*]Added inscription recipes starting with Technique:, damn Blizzard such incosistence in naming.
[*]Skining for button is now complete including pushed and hover states.[/list]

]]
--[[Revisions: 03.xx

03.28 06.03.2015

[list][*]Added feature for Miner's coffee, now is possible to configure limit of stacks.
[*]Better optimalization when searching bags for usable item.[/list]

03.26 05.03.2015

[list][*]Removed informational messages about cache.
[*]Build in, verbose mode to show why item was added on button.[/list]

03.24 05.03.2015

[list][*]Added. Mystery Bag.
[*]Added. Traveler's Pet Supplies.[/list]

03.22 01.03.2015

[list][*]Added. Glyphs.[/list]

03.20 28.02.2015

[list][*]Fix. Vendor, bank and viod storage windows closed before item use.
[*]Added. Music Rolls.
[*]Parsed NOP-CORE to more LUA files.[/list]

03.18 27.02.2015

[list][*]Solved use of pets and check against pet journal to enumerate if pet can be used, thanks to "ahak" who lead me on curse.
[*]Tooltip for pets, really in original state is empty, so I at least fake it with name of item.[/list]

03.16 26.02.2015

[list][*]Fix, garrison blueprints. Blizzard changed name, now I'm using 2nd line of tool-tip.
[*]Semi Fix, blacklisting broken pet cage itemID 82800.[/list]

03.14 25.02.2015

[list][*]Removed relics, I can't find safe way to check standing with faction to prevent use of item with exalted standing.
[*]Patch 6.1 compatible.
[*]Additional checks for combat lockdown.[/list]

03.12 22.02.2015

[list][*]Added, Broken Frostweed Stem and Broken Fireweed Stem.
[*]All functions using Show(), Hide(), SetAttribute("macrotext1",) or repositioning button, does check CombatLockdown() to prevent any taint in protected functions.
[*]Use of lockpicking is now placed in configurable options, is enabled by default.
[*]Code cleaning, all tables are embeded into NOP.[/list]

03.10 21.02.2015

[list][*]Fix. Removed diagnostic message.[/list]

03.08 21.02.2015

[list][*]Version read from .TOC file.
[*]Fix. Used correct function IsPlayerSpell() to query if player have lockpicking.[/list]

03.06 20.02.2015

[list][*]Tooltip use SetBagItem to really reflect item state in bag, not general tooltip for item. It reflect lockpick state.
[*]Rogue now with proper lockpick level have lockboxes placed on button as well. It use "lockpick" skill over lockbox.[/list]
  
03.04 17.02.2015

[list][*]Fix profile, I do use standard Ace libs, much better and localized.
[*]Fix on profile switch icon wasn't moved and resized.[/list]

03.02 15.02.2015

[list][*]Fix PreClick method. Not using it so no need refer it![/list]

03.00 15.02.2015

[list][*]Fix skin/unskin button. There should not be ghost icon after skin/unskin button and move. Skinning can now be toggled anytime and no /reload is necessary.
[*]Tooltip now obey standards. If in Interface->Help->Enhanced Tooltips is checked on, then Tooltip is placed in default location. Many addons then can move default tooltip in place where you wish. By default ElvUI can move it as well. If that setting is checked off, then tooltip shows above top right corner of button.
[*]Fix. Sometime new item wasn't placed on button when landed in bags, bacause zone check and lookup for old item on button. I would rather keep item hopping on button than missing new item until zone.[/list]

]]
--[[Revisions: 02.xx
02.32 15.02.2015

[list][*]Localization to Traditionl Chinesee made by a9012456.
[*]Added Expired Receipt, Love in Air event item.[/list]

02.30 14.02.2015

[list][*]Fix. No item placed on button when spell patterns or item patterns are updated.
[*]Code cleanup, I don't using item cooldown anymore, so no need to refer it in code.
[*]Implemented profiles. Now all profiles are individual, to set it back to old, user need pick and create one profile for all characters.
[*]Anchor for tooltip need to be set on new position, now is anchored to bottom left edge of screen and anchor point is top right edge of tooltip.
[*]Skinning now is toggled without need to reload UI, it works only once without relogin or reload. Thats best what I can do.[/list]

02.28 08.02.2015

[list][*]Added tailoring patterns.[/list]

02.26 25.01.2015

[list][*]Added profiling. If you are curious about NOP actions use "/nop profile" to see some stats.
[*]Change in logic, I'm not testing item cooldown. It had bad side effect, some global action put on cooldown all items in bags, that leads to temporar button remove. I think it is better to let item stay on button. Is not possible to use item until global cooldown  or cooldown on item  wear off.[/list]

02.24 23.01.2015

[list][*]Fix. Toys and pets are now language independent. I found good solution and not need localization for it.[/list]

02.22 23.01.2015

[list][*]Fix. After leveling up, items wasn't rechecked. Level locked items didn't show up on button, until zoning.[/list]

02.20 23.01.2015

[list][*]Fix scan bag optimalization did removed zone restricted items out of zone with option "Zone unrestricted". As well items in stacks was bugged.[/list]

02.18 23.01.2015

[list][*]Added Jewelcrafting designs.
[*]Pets and toys, but only in enUS and enGB, because I don't have translation for "Use: Teaches you how to summon" and "Use: Adds this toy to your" patterns in other languages.
[*]Scanning bags now is done only once per slot until item in slot is not changed. There was report about slowing down UI with certain bags addons.[/list]

02.16 16.01.2015

[list][*]Fix. Personal bank and Guild banks are closed on click before macro, because item need to be used not moved into guild bank, pesonal bank or void storage. I'm now listening to events for Personal bank and Guild bank.[/list]

02.14 10.01.2015

[list][*]Changed macro on inactive button from /say to /stopcasting, by request.
[*]Moved click variable from macro to postclick to have clean protected function.[/list]

02.12 06.01.2015

[list][*]Fix. Engineering schematics.
[*]Session skip in AddOn config dialog didn't work. It was always session wide skip.
[*]Fix. Item usable by tooltip wasn't checked for items by itemID and open by spell items.
[*]Fix. Added missing raw beast hide scrap.[/list]

02.10 05.01.2015

[list][*]Card of Omens.
[*]Enchanting formulas.[/list]

02.08 04.01.2015

[list][*]Zone restricted item with open function will be placed on button even out of zone, but only when there is no other unrestricted item to use.
Tooltip can be anchored to WorldFrame and anchor place can be configured.[/list]

02.06 03.01.2015

[list][*]Final-Fix. IsUsableItem(itemID) not always detect usability of items. Especially fails on recipes and plans. As 2nd level check tooltip is scanned for red text, that was broken.
[*]Finalized all level 700 professions scrolls[/list]

02.04 02.01.2015

[list][*]Item drop for level 700 professions not tied to quest. I would recommend Quest Item Bar for quest items.
[*]Fix. IsUsableItem(itemID) not always detect usability of items. Especially fails on recipes and plans. As 2nd level check tooltip is scanned for red text.[/list]

02.02 02.01.2015

[list][*]Translations deDE, esES, esMX, frFR, itIT, ruRU, ptBR, koKR, zhCN and zhTW at least for zone-maps.[/list]

02.00 02.01.2015

[list][*]New release has feature zone and aura depended items.
[*]Items usable only in zone, are placed on button only in that zone, plus is possible to check player missing AURAS to conditionally put item on button.
[*]From now it will need implement localization, because zone names are language dependant.
[*]Priority items, placed by zone can have "Glow" effect, it is configurable by slash "/nop glow" or in Game Menu -> Interface -> AddOns.
[*]Actually only enUS and enGB are implemented. please I need volunteers who will translate few texts and I will place localization.[/list]
]]
--[[Revisions: 01.xx
01.44 01.01.2015

[list][*]Fix-feature. Binding key is now placed on button top right corner. ALT, SHIFT and CTRL are abbreviated to A,S and C prefix.[/list]

01.44 31.12.2014

[list][*]Added Scribe's Research Notes.
[*]Added Abrogator Stone Cluster.[/list]

01.42 30.12.2014

[list][*]Temporary blacklist can be now session wide, so setting skip item will be reset after relogin or /reload. It is controlled by "/nop skip" or AddOns config.[/list]

01.40 29.12.2014

[list][*]CTRL-Right Click add item to permanent blacklist. Permanent blacklist can be reset by slash command /nop clear or from UI configuration dialogue.
[*]Verbose output to default chat when temporary or permanently blacklisting item.[/list]

01.38 27.12.2014

[list][*]Added another pet bag into.[/list]

01.36 26.12.2014

[list][*]Fix for missing button after game load even in bags are openable items. In 1.34 still not fixed. Sometime game refuse update tool tip for item even have it in cache. Trying workaround this bug.[/list]

01.34 26.12.2014

[list][*]New - WoD cooking recipes.
[*]Fix. After loot specialization switch again items tied to actual loot are ignored.
[*]Fix. Sometime game has not cached items with spellIDs to test. All items are now cached.[/list]

01.32 24.12.2014

[list][*]Fix. Scan tool tip is created earlier to prevent loading bug.
[*]Now same items are keep together on button, bags are look-ahead for same item.[/list]

01.30 23.12.2014

[list][*]Fix. After spec-switch all items with open spell "Use: create soul bound item appropriate to your loot specialization" won't work. If your loot specialization is set according to primary specialization then open string doesn't match after spec-switch.
[*]Items with garrison resources on use[/list]

01.28 23.12.2014

[list][*]New check IsUsableItem(itemID) could hide button after cast any of spell - fixed[/list]

01.26 23.12.2014

[list][*]Version info is displayed only once when version change.
[*]Check every item via IsUsableItem(itemID) if can be used, mostly level restriction.[/list]

01.24 22.12.2014

[list][*]/nop reset, will reset position, size and unlock button
[*]UI config for button size from 16 pixel up to 64 pixels, default is 35
[*]Relaxed all delayed updates, button now changes state faster. Hope de-sync on count is fixed as well.[/list]

01.22 21.12.2014

[list][*]Is possible temporary blacklist item via right-click. Item will be shown back when no other items are placed on button.[/list]

01.20 21.12.2014

[list][*]Option header to say X and Y is from CENTER of screen.
[*]/nop show help if there is not valid argument.
[*]All learn-able recipes and plans.
[*]Fixed problem when not all bags were searched.[/list]

01.18 21.12.2014

[list][*]Button can be ALT-drag with left or right button.
[*]Lock button in place option in UI config and slash command /nop lock.
[*]Position for button in UI config.[/list]

01.16 21.12.2014

[list][*]More excessive check if functions exists when skinning button.[/list]

01.14 20.12.2014

[list][*]Fixed use of all items where is tool tip <Right Click to Open>.[/list]

01.12 20.12.2014

[list][*]If last item has cool down and was only one item to add into button, then postpone update until cool down expire.
[*]New items added Fractured Temporal Crystal and Ravenmother Offering.
[*]Most of WoD fishing catches added.
[*]Invader's Forgotten Treasure, Invader's Damaged Cache, Invader's Abandoned Sack.
[*]Silkworm Cocoon.[/list]

01.10 20.12.2014

[list][*]Button skinning is by default off
[*]UI Interface > AddOns options dialogue toggle for button skinning, still need relog or /reload to apply
[*]Slash command "/nop skin" toggle button skin and UI reload
[*]Button update is delayed only in combat[/list]

01.08 20.12.2014

[list][*]Old distributed ZIP files didn't contained base add-on directory[/list]

01.06 19.12.2014

[list][*]Button styling aka ElvUI, removed border and black background[/list]

01.04 19.12.2014

[list][*]Hide button after move if initially was forced to show. It allows initial position of button even there is no item in bags to show.[/list]

01.02 19.12.2014

[list][*]Support for items where to use is need to have more than one item in bags. Like Motes of Harmony.[/list]

01.00 18.12.2014

[list][*]Back-ported original Add-on openables Author: Driizt@BB_EU Version: 2.3. 
[*]Initial design.[/list]
]]
--[[Description:
<p style="padding-left: 30px;">Add-on scan bags for items to use, open, learn etc. When find new proper item it create click-able button like action bars. If there is more than one item only one of them is placed on button, when button is clicked then another item is placed on button etc. Button then can be clicked again to use that another item. Take it as some sort of alert "Hey you have new stuff to use!".</p>
<p style="padding-left: 30px;">This is now extended to "Quest Items" it could complement click-able button in "Quest watch frame" with two advantages, buttons are always at same place, are bigger and what else can have hot-key assigned. What more, some items starts "Quest" and then you get alert "Hey there is item starting quest in your bags!" in form of button with big yellow "!", just click that new button to accept quest.</p>
<p><strong>Features:</strong></p>
<ul>
<li>Create single button to click on to combine/open/use/lockpick item in bags.</li>
<li>Create button bar to click on quest items if any.</li>
<li>Button can have assigned hot-key to be able use keyboard short-cut, via Game Menu Key Bindings.</li>
<li>When click to use item add-on will continue to scan bags and change to next usable item in your inventory.</li>
<li>Add-on take care if you have enough items to combine if not then item is not assigned to button.</li>
<li>If there is no usable item known by add-on it will hide button. Except when is configured to show fake button (good for repositioning)</li>
<li>Is possible skip item (remove from button) by right-click, when no other items are found then all skipped items are placed back on button. Skip can be configured to last whole session until relog. It is configurable via slash command <b>/nop skip</b> or from Game Menu, Interface, AddOns.</li>
<li>Is possible permanently blacklist item (remove from button) by CTRL right-click, this permanent blacklist can be cleared via slash command "/nop clear" or from Game Menu, Interface, AddOns.</li>
<li>Is possible remove permanently blacklisted item just one with <b>/nop unlist itemID</b>. ItemID come from query via <b>/nop list</b>.</li>
<li>Few items can be used only in proper zone. Two items are designed only for garrison mine. Some items can be used only in "Salvage yard".</li>
<li>Quest items. For each quest item in bags is added separate button. Direction and number buttons per row can be configured in Game Menu, Interface, AddOns. This part is taken from Quest Item Bar made by Nickenyfiken and ZidayaXis. I loved that add-on and original authors have no plans to maintain it. I did adopted core functionality from that add-on.</li>
<li>Auto-accept and auto-turnin quests from new Quest Tracker.</li>
</ul>
]]
--[[Supported items:
<p><strong>Supported items:</strong></p>
<ul>
<li>All items used with standard "Open" spell</li>
<li>Archaeology artifacts</li>
<li>Leather-working scraps (Ruined, Knothide, Borean, Savage, Raw Beast)</li>
<li>Salvage bags, armor and weapons boost from follower&rsquo;s missions</li>
<li>Pet Supplies</li>
<li>Items where is possible combine lesser one items into something else</li>
<li>Fishing catches where fishes are sliced into meat.</li>
<li>Crafting plans,recipes,designs etc. in fact all learnable profession items</li>
<li>Looted items generating garrison resources on use</li>
<li>Scribe's Research Notes and Abrogator Stone Cluster</li>
<li>Miner's Coffee (number of stacks can be configured in options) and Preserved Mining Pick in Garrison mine</li>
<li>Pets and toys.</li>
<li>Rogues now have placed locked lock-boxes on button, according to level of lock-picking skill. 1st click lock-pick and second click open. Can be configured in options, is enabled by default</li>
<li>Artifact power, Ancient Mana, Order hall mission rewards</li>
<li>Items used for standing gain, be warned addon deosn't check actual standing so if item is consumed on exalted staning it become void.</li>
</ul>
<p>Let me know item names to add to wish list. I will grow list as I find items suitable to add. Please I need people who will send me translations for nop-locale-enUS.lua to other languages. Localized SubZones are in for deDE, esES, esMX, frFR, itIT, koKR, ptBR, ruRU, zhCN and zhTW.</p>
<p>Actually all buttons can be skinned (see screen shots), by default skin is disabled. Addon has build-in <strong>Masquee</strong> support for skinning or use build-in own ElvUI like skin. Skinning can be toggled via Game Menu, Interface, AddOns or via slash command <strong>/nop skin</strong>. If you move button to place where you can't see him, or move, then it can be reset to middle of screen via slash command <strong>/nop reset</strong>. Is possible lock in place button via Game Menu, Interface, AddOns or slash command <strong>/nop lock</strong>.</p>
<p>Original idea behind this add-on come from Driizt@BB_EU who did make single button for all items containing description "Use: Open ....", I did extend it into all usable items.</p>
]]
--[[Known issues:
<ul>
<strong>Known issues:</strong>
<li>Lockpick on item sometime won't work on 1st click, new method of use item doesn't always update and apply proper spell on proper item.</li>
</ul>
]]
--[[To-Do:

<li>Separate size and position for Usable Item and Quest Button bar is done, now need separate movers.</li>

http://www.wowhead.com/item=130899/striding-with-the-sunwalkers a http://www.wowhead.com/item=130898/light-in-the-darkness
1007 	Broken Isles
1015 	Aszuna
1021 	Broken Shore
1014 	Dalaran
1098 	Eye of Azshara
1024 	Highmountain
1017 	Stormheim
1033 	Suramar
1018 	Val'sharah
Sanctum of Light
]]
