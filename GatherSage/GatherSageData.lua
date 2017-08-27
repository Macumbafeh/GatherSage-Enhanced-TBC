-- File in which we build the data structures
-- BC Data and updates courtesy of Dri

gsMine = {
  [gsCopper] = { ["baseskill"]=1, ["medium"]=25, ["easy"]=50, ["trivial"]=100 },
  [gsTin] = { ["baseskill"]=65, ["medium"]=90, ["easy"]=115, ["trivial"]=165 },
  [gsIncendicite] = { ["baseskill"]=65, ["medium"]=90, ["easy"]=115, ["trivial"]=165 },
  [gsSilver] = { ["baseskill"]=75, ["medium"]=100, ["easy"]=125, ["trivial"]=175 },
  [gsSilverOz] = { ["baseskill"]=75, ["medium"]=100, ["easy"]=125, ["trivial"]=175 },
  [gsLesserBloodstone] = { ["baseskill"]=75, ["medium"]=100, ["easy"]=125, ["trivial"]=175 },
  [gsIron] = { ["baseskill"]=125, ["medium"]=150, ["easy"]=175, ["trivial"]=225 },
  [gsIndurium] = { ["baseskill"]=150, ["medium"]=175, ["easy"]=200, ["trivial"]=250 },
  [gsGold] = { ["baseskill"]=155, ["medium"]=175, ["easy"]=205, ["trivial"]=255 },
  [gsGoldOz] = { ["baseskill"]=155, ["medium"]=175, ["easy"]=205, ["trivial"]=255 },
  [gsMithril] = { ["baseskill"]=175, ["medium"]=200, ["easy"]=225, ["trivial"]=275 },
  [gsMithrilOz] = { ["baseskill"]=175, ["medium"]=200, ["easy"]=225, ["trivial"]=275 },
  [gsTruesilver] = { ["baseskill"]=205, ["medium"]=255, ["easy"]=280, ["trivial"]=330 },
  [gsTruesilverOz] = { ["baseskill"]=205, ["medium"]=255, ["easy"]=280, ["trivial"]=330 },
  [gsDarkIron] = { ["baseskill"]=230, ["medium"]=255, ["easy"]=280, ["trivial"]=330 },
  [gsSmallThorium] = { ["baseskill"]=230, ["medium"]=270, ["easy"]=280, ["trivial"]=345 },
  [gsThoriumOz] = { ["baseskill"]=230, ["medium"]=270, ["easy"]=280, ["trivial"]=345 },
  [gsRichThorium] = { ["baseskill"]=255, ["medium"]=300, ["easy"]=325, ["trivial"]=350 },
  [gsRichThoriumOz] = { ["baseskill"]=255, ["medium"]=300, ["easy"]=325, ["trivial"]=350 },
  [gsHakkariThorium] = { ["baseskill"]=255, ["medium"]=300, ["easy"]=325, ["trivial"]=350 },
  [gsFelIron] = { ["baseskill"]=300, ["medium"]=325, ["easy"]=350, ["trivial"]=400 },
  [gsSmallObsidianChunk] = { ["baseskill"]=305, ["medium"]=330, ["easy"]=355, ["trivial"]=405 },
  [gsObsidianChunk] = { ["baseskill"]=305, ["medium"]=330, ["easy"]=355, ["trivial"]=405 },
  [gsAdamantite] = { ["baseskill"]=325, ["medium"]=350, ["easy"]=400, ["trivial"]=450 },
  [gsRichAdamantite] = { ["baseskill"]=350, ["medium"]=375, ["easy"]=400, ["trivial"]=450 },
  [gsKhorium] = { ["baseskill"]=375, ["medium"]=400, ["easy"]=425, ["trivial"]=475 },
};

gsOre = {
	[gsCopperOre] = { ["baseskill"]=1, ["medium"]=25, ["easy"]=47, ["trivial"]=70 },
	[gsTinOre] = { ["baseskill"]=65, ["medium"]=65, ["easy"]=70, ["trivial"]=75 },
	[gsSilverOre] = { ["baseskill"]=75, ["medium"]=115, ["easy"]=122, ["trivial"]=130 },
	[gsIronOre] = { ["baseskill"]=125, ["medium"]=130, ["easy"]=145, ["trivial"]=160 },
	[gsGoldOre] = { ["baseskill"]=155, ["medium"]=170, ["easy"]=177, ["trivial"]=185 },
	[gsMithrilOre] = { ["baseskill"]=175, ["medium"]=175, ["easy"]=202, ["trivial"]=230 },
	[gsTruesilverOre] = { ["baseskill"]=230, ["medium"]=235, ["easy"]=242, ["trivial"]=250 },
	[gsThoriumOre] = { ["baseskill"]=250, ["medium"]=250, ["easy"]=270, ["trivial"]=290 },
	[gsDarkIronOre] = { ["baseskill"]=230, ["medium"]=300, ["easy"]=305, ["trivial"]=310 },
	[gsElementiumOre] = { ["baseskill"]=1, ["medium"]=999, ["easy"]=999, ["trivial"]=100 },
	[gsFelIronOre] = { ["baseskill"]=300, ["medium"]=300, ["easy"]=307, ["trivial"]=315 },
	[gsAdamantiteOre] = { ["baseskill"]=325, ["medium"]=325, ["easy"]=332, ["trivial"]=340 },
	[gsEterniumOre] = { ["baseskill"]=350, ["medium"]=350, ["easy"]=357, ["trivial"]=365 },
	[gsKhoriumOre] = { ["baseskill"]=375, ["medium"]=999, ["easy"]=999, ["trivial"]=999 },
};

gsGem = {
	[gsTigerseye] = gsCopper.."/"..gsTin,
};

gsStone = {
	[gsRoughStone] = gsCopper,
	[gsCoarseStone] = gsTin,
	[gsHeavy] = gsIron,
	[gsSolid] = {gsMithril,gsMithrilOz},
	[gsDense] = {gsSmallThorium,gsRichThorium,gsThoriumOz,gsRichThoriumOz,gsHakkariThorium},
	[gsMoteEarth] = {gsFelIron,gsAdamantite,gsRichAdamantite,gsKhorium},
	[gsMoteFire] = gsFelIron,
};

gsMineHasStone = {
	[gsCopper] = gsRoughStone,
	[gsTin] = gsCoarseStone,
	[gsIron] = gsHeavy,
	[gsMithril] = gsSolid,
	[gsMithrilOz] = gsSolid,
	[gsSmallThorium] = gsDense,
	[gsRichThorium] = gsDense,
	[gsThoriumOz] = gsDense,
	[gsRichThoriumOz] = gsDense,
	[gsHakkariThorium] = gsDense,
	[gsFelIron] = gsMoteEarth,
	[gsAdamantite] = gsMoteEarth,
	[gsRichAdamantite] = gsMoteEarth,
	[gsKhorium] = gsMoteEarth,
};

gsMineHasGem = {
	[gsCopper] = {[1]=gsTigerseye,[2]=gsMalachite,[3]=gsShadowgem},
	[gsTin] = {[1]=gsMossAgate,[2]=gsShadowgem,[3]=gsLesserMoonstone,[4]=gsJade},
	[gsSilver] = {[1]=gsMossAgate,[2]=gsShadowgem,[3]=gsLesserMoonstone},
	[gsIron] = {[1]=gsJade,[2]=gsLesserMoonstone,[3]=gsCitrine,[4]=gsAquamarine},
	[gsGold] = {[1]=gsJade,[2]=gsCitrine,[3]=gsLesserMoonstone},
	[gsMithril] = {[1]=gsBlackVitriol,[2]=gsAquamarine,[3]=gsCitrine,[4]=gsStarRuby},
	[gsTruesilver] = {[1]=gsAquamarine,[2]=gsStarRuby,[3]=gsCitrine},
	[gsSmallThorium] = {[1]=gsBlackVitriol,[2]=gsStarRuby,[3]=gsLargeOpal,[4]=gsBlueSapphire,[5]=gsHugeEmerald,[6]=gsAzerothianDiamond},
	[gsRichThorium] = {[1]=gsArcaneCrystal,[2]=gsBlueSapphire,[3]=gsStarRuby,[4]=gsAzerothianDiamond,[5]=gsHugeEmerald,[6]=gsLargeOpal},
	[gsDarkIron] = {[1]=gsBlackVitriol,[2]=gsBloodoftheMountain,[3]=gsBlackDiamond},
	[gsObsidianChunk] = {[1]=gsHugeEmerald,[2]=gsAzerothianDiamond,[3]=gsArcaneCrystal},
	[gsSmallObsidianChunk] = {[1]=gsHugeEmerald,[2]=gsAzerothianDiamond,[3]=gsArcaneCrystal},
	[gsSilverOz] = {[1]=gsMossAgate,[2]=gsShadowgem,[3]=gsLesserMoonstone},
	[gsGoldOz] = {[1]=gsJade,[2]=gsCitrine,[3]=gsLesserMoonstone},
	[gsMithrilOz] = {[1]=gsBlackVitriol,[2]=gsAquamarine,[3]=gsCitrine,[4]=gsStarRuby},
	[gsTruesilverOz] = {[1]=gsAquamarine,[2]=gsStarRuby,[3]=gsCitrine},
	[gsThoriumOz] = {[1]=gsBlackVitriol,[2]=gsStarRuby,[3]=gsLargeOpal,[4]=gsBlueSapphire,[5]=gsHugeEmerald,[6]=gsAzerothianDiamond},
	[gsRichThoriumOz] = {[1]=gsArcaneCrystal,[2]=gsBlueSapphire,[3]=gsStarRuby,[4]=gsAzerothianDiamond,[5]=gsHugeEmerald,[6]=gsLargeOpal},
	[gsHakkariThorium] = {[1]=gsSouldarite,[2]=gsArcaneCrystal,[3]=gsHugeEmerald,[4]=gsAzerothianDiamond,[5]=gsStarRuby,[6]=gsBlueSapphire,[7]=gsLargeOpal},
	[gsFelIron] = {[1]=gsShadowDraenite,[2]=gsDeepPeridot,[3]=gsFlameSpessarite,[4]=gsBloodGarnet,[5]=gsGoldenDraenite,[6]=gsAzureMoonstone,[7]=gsLivingRuby},
	[gsAdamantite] = {[1]=gsArcaneCrystal,[2]=gsBloodGarnet,[3]=gsGoldenDraenite,[4]=gsAzureMoonstone,[5]=gsLivingRuby,[6]=gsTalasite,[7]=gsNightseye},
	[gsRichAdamantite] = {[1]=gsArcaneCrystal,[2]=gsAzureMoonstone,[3]=gsGoldenDraenite,[4]=gsBloodGarnet,[5]=gsShadowDraenite,[6]=gsFlameSpessarite,[7]=gsDeepPeridot,[8]=gsNobleTopaz,[9]=gsLivingRuby},
	[gsKhorium] = {[1]=gsArcaneCrystal,[2]=gsAzureMoonstone,[3]=gsGoldenDraenite,[4]=gsBloodGarnet,[5]=gsShadowDraenite,[6]=gsFlameSpessarite,[7]=gsDeepPeridot,[8]=gsNobleTopaz,[9]=gsLivingRuby},
};

gsHerbHasHerb = {
	[gsMageroyal] = gsSwiftThistle,
	[gsBriarthorn] = gsSwiftThistle,
	[gsPurpleLotus] = gsWildvine,
	[gsFelweed] = gsFelBlossom,
	[gsDreamingGlory] = gsUnPlantParts,
	[gsRagveil] = gsUnPlantParts,
	[gsNightmareVine] = gsNightmareSeed,
};

gsHerb = {
	[gsPeacebloom] = { ["baseskill"]=1, ["medium"]=25, ["easy"]=50, ["trivial"]=100 },
	[gsSilverleaf] = { ["baseskill"]=1, ["medium"]=25, ["easy"]=50, ["trivial"]=100 },
  [gsBloodthistle] = { ["baseskill"]=1, ["medium"]=25, ["easy"]=50, ["trivial"]=100 },
	[gsEarthroot] = { ["baseskill"]=15, ["medium"]=40, ["easy"]=65, ["trivial"]=115 },
	[gsMageroyal] = { ["baseskill"]=50, ["medium"]=75, ["easy"]=100, ["trivial"]=150 },
	[gsBriarthorn] = { ["baseskill"]=70, ["medium"]=95, ["easy"]=120, ["trivial"]=170 },
	[gsStranglekelp] = { ["baseskill"]=85, ["medium"]=110, ["easy"]=135, ["trivial"]=185 },
	[gsBruiseweed] = { ["baseskill"]=100, ["medium"]=125, ["easy"]=150, ["trivial"]=200 },
	[gsWildSteelbloom] = { ["baseskill"]=115, ["medium"]=140, ["easy"]=165, ["trivial"]=215 },
	[gsGraveMoss] = { ["baseskill"]=120, ["medium"]=150, ["easy"]=170, ["trivial"]=220 },
	[gsKingsblood] = { ["baseskill"]=125, ["medium"]=155, ["easy"]=175, ["trivial"]=225 },
	[gsLiferoot] = { ["baseskill"]=150, ["medium"]=175, ["easy"]=200, ["trivial"]=250 },
	[gsFadeleaf] = { ["baseskill"]=160, ["medium"]=185, ["easy"]=210, ["trivial"]=260 },
	[gsGoldthorn] = { ["baseskill"]=170, ["medium"]=195, ["easy"]=220, ["trivial"]=270 },
	[gsKhadgar] = { ["baseskill"]=185, ["medium"]=210, ["easy"]=230, ["trivial"]=285 },
	[gsWintersbite] = { ["baseskill"]=195, ["medium"]=225, ["easy"]=245, ["trivial"]=295 },
	[gsFirebloom] = { ["baseskill"]=205, ["medium"]=235, ["easy"]=255, ["trivial"]=305 },
	[gsPurpleLotus] = { ["baseskill"]=210, ["medium"]=235, ["easy"]=260, ["trivial"]=310 },
	[gsArthas] = { ["baseskill"]=220, ["medium"]=250, ["easy"]=270, ["trivial"]=320 },
	[gsSungrass] = { ["baseskill"]=230, ["medium"]=255, ["easy"]=280, ["trivial"]=330 },
	[gsBlindweed] = { ["baseskill"]=235, ["medium"]=260, ["easy"]=285, ["trivial"]=335 },
	[gsGhostMushroom] = { ["baseskill"]=245, ["medium"]=270, ["easy"]=295, ["trivial"]=345 },
	[gsGromsblood] = { ["baseskill"]=250, ["medium"]=275, ["easy"]=300, ["trivial"]=350 },
	[gsGoldenSansam] = { ["baseskill"]=260, ["medium"]=280, ["easy"]=310, ["trivial"]=360 },
	[gsDreamfoil] = { ["baseskill"]=270, ["medium"]=295, ["easy"]=320, ["trivial"]=370 },
	[gsMountainSilversage] = { ["baseskill"]=280, ["medium"]=310, ["easy"]=330, ["trivial"]=380 },
	[gsPlaguebloom] = { ["baseskill"]=285, ["medium"]=315, ["easy"]=335, ["trivial"]=385 }, -- we need exact values here!
	[gsIcecap] = { ["baseskill"]=290, ["medium"]=315, ["easy"]=340, ["trivial"]=390 },
	[gsBlackLotus] = { ["baseskill"]=300, ["medium"]=345, ["easy"]=370, ["trivial"]=400 }, -- we need exact values here!
	[gsFelweed] = { ["baseskill"]=300, ["medium"]=325, ["easy"]=350, ["trivial"]=400 },
	[gsDreamingGlory] = { ["baseskill"]=315, ["medium"]=340, ["easy"]=365, ["trivial"]=415 },
	[gsRagveil] = { ["baseskill"]=325, ["medium"]=350, ["easy"]=375, ["trivial"]=425 }, -- we need exact values here!
	[gsFlameCap] = { ["baseskill"]=335, ["medium"]=352, ["easy"]=375, ["trivial"]=435 }, -- we need exact values here!
	[gsTerocone] = { ["baseskill"]=325, ["medium"]=350, ["easy"]=419, ["trivial"]=425 }, -- we need exact values here!
	[gsAncientLichen] = { ["baseskill"]=340, ["medium"]=365, ["easy"]=390, ["trivial"]=440 }, -- we need exact values here!
  [gsNetherbloom] = { ["baseskill"]=350, ["medium"]=375, ["easy"]=400, ["trivial"]=450 }, -- we need exact values here!
	[gsNightmareVine] = { ["baseskill"]=365, ["medium"]=390, ["easy"]=419, ["trivial"]=465 }, -- we need exact values here!
	[gsManaThistle] = { ["baseskill"]=375, ["medium"]=415, ["easy"]=440, ["trivial"]=475 }, -- we need exact values here!
};
