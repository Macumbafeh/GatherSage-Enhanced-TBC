--[[
GatherSage by Dsanai of Whisperwind
Adds skill-level and other information to gathering item tooltips.
Thanks go to EasyUnlock for portions of code that were borrowed and modified to work with Herbalism and Mining. For chests and lockboxes, get EasyUnlock! The code for notifying on skill changes was borrowed from TrainerSkills; again, a mod worth getting.


PATCH NOTES


v1.0 for TBC by fuba
-- Added Skinning support
-- Fixed Minimap Bug


v20100-2
-- Added German translation (courtesy VincentGdG)


v20100-1
-- Updated for The Burning Crusade.


v20003-2
-- Fixed Debug error.
-- Fixed Ace loading order (courtesy of Dri)


v20003-1

-- Burning Crusade ores and gems added (courtesy of Dri)
-- Burning Crusade herbs added, and gem code written.
-- Added tooltips for ores (showing the skill required to smelt them)
-- Changed tooltip display/coloring to better support other addons that manage herbs and ores.
-- Updated to include secure tooltip hooking methods.
-- Broke out all of the remaining unlocalized strings (we need translations!)
-- Added rudimentary Ace2 support.


v20000-1
-- Updated for Patch 2.0.
-- French translation added (courtesy Abysse from Kael'thas)


v11100-2
-- Tells you what things you can mine/pick as your skill increases.
-- Split the localization files so translations can be provided more easily.


v11100-1
-- Initial Release.


]]--

-- Version Info
local MAJOR_VERSION = "20100-2"

local _G = getfenv(0)
local initdone = nil;
local character = "";
local realmName = "";

GatherSage = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0", "AceEvent-2.0");
GatherSage.title = "GatherSage";
GatherSage.version = MAJOR_VERSION;

function GatherSage:OnInitialize()
  self:HookTooltipMethods()
end

function GatherSage:OnEnable()
  self:RegisterEvent("VARIABLES_LOADED");
  self:RegisterEvent("CHAT_MSG_SKILL");
end

function GatherSage:OnDisable()
end

function GatherSage.SetItem(tooltip)
  if not tooltip.GetItem then return end
  local _, link = tooltip:GetItem()
  GatherSage.ProcessWithLink(tooltip, link)
end

function GatherSage:HookTooltipMethods()
  for _, tooltip in ipairs(self.TooltipList) do
    if tooltip then
      for _, methodName in ipairs(self.MethodList) do
        hooksecurefunc(tooltip, methodName, GatherSage.SetItem)
      end
    end
  end
end

function GatherSage:VARIABLES_LOADED()
  character = UnitName("player");
  realmName = GetCVar("realmName");
  if (not GatherSageDB) then
    GatherSageDB = {};
  end
  if (not GatherSageDB[realmName]) then
    GatherSageDB[realmName] = {};
  end
  if (not GatherSageDB[realmName][character]) then
    GatherSageDB[realmName][character] = {
      [gsMINING] = 0,
      [gsHERBING] = 0
    };
  end
  initDone = true;
end

function GatherSage:CHAT_MSG_SKILL()
  if ( initDone ) then
    GatherSage_UpdateSkills();
  end
end

function GatherSage_UpdateSkills()
  local numSkills = GetNumSkillLines();
  local myCraftSkills = {};

  for i = 1, numSkills, 1 do
    local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);

    if ( not header and skillName ) then
      myCraftSkills[skillName] = skillRank;
    end

  end

  if (myCraftSkills[gsMINING]) then
    for mineType in pairs(gsMine) do
      if (gsMine[mineType]["baseskill"]==myCraftSkills[gsMINING]) then
        if (GatherSageDB[realmName][character][gsMINING] < myCraftSkills[gsMINING]) then -- Only do it once per skill level shift
          GatherSage_Print(gspCanMine..mineType..".");
        end
      end
    end
    for mineType in pairs(gsOre) do
      if (gsOre[mineType]["baseskill"]==myCraftSkills[gsMINING]) then
        if (GatherSageDB[realmName][character][gsMINING] < myCraftSkills[gsMINING]) then -- Only do it once per skill level shift
          GatherSage_Print(gspCanSmelt..mineType..".");
        end
      end
    end
    GatherSageDB[realmName][character][gsMINING] = myCraftSkills[gsMINING];
  end
  if (myCraftSkills[gsHERBING]) then
    for herbType in pairs(gsHerb) do
      if (gsHerb[herbType]["baseskill"]==myCraftSkills[gsHERBING]) then
        if (GatherSageDB[realmName][character][gsHERBING] < myCraftSkills[gsHERBING]) then -- Only do it once per skill level shift
          GatherSage_Print(gspCanPick..herbType..".");
        end
      end
    end
    GatherSageDB[realmName][character][gsHERBING] = myCraftSkills[gsHERBING];
  end

end

function GatherSage.ProcessWithLink(tooltip, link)
  if (not link) then return; end
  local linkstart = string.find(link,"|H")
  local _,lastfound,type,id = string.find(link,"(%a+):(%d+):",linkstart and linkstart + 2)
  local _,_,name = string.find(link,"%[([^%[%]]*)%]",lastfound)
  
  if (not ttLine2) or (string.find(ttLine2,gsMINING)) or (string.find(ttLine2,gsHERBING)) then -- Only do for minimap and viewport tooltips
    GatherSage.ProcessTooltip(tooltip, name);
  end
end

function GatherSage.ProcessWithName(tooltip, itemname)
  local ttLine1 = getglobal(tooltip:GetName().."TextLeft1"):GetText()
  local ttLine2 = getglobal(tooltip:GetName().."TextLeft2"):GetText()
  local ttLine3 = getglobal(tooltip:GetName().."TextLeft3"):GetText()

  -- add skinning feature - by fuba
  --if ( (ttLine3) and (string.find(string.lower(ttLine3), string.lower(gsSKINNABLE))) ) then
  if ( (ttLine3) and (string.find(string.lower(ttLine3), string.lower(UNIT_SKINNABLE_LEATHER))) ) then
    local lvl = tonumber(UnitLevel("mouseover"));
    local needlvlskin = 0;
    if (lvl-10)*10 >= 100 then
      needlvlskin = lvl*5;
    else
      if (lvl-10)*10 > 0 then needlvlskin = (lvl-10)*10 else needlvlskin = 1 end;
    end
    --getglobal(tooltip:GetName().."TextLeft3"):SetText(gsSKINNABLE.." ("..(needlvlskin)..")");
    getglobal(tooltip:GetName().."TextLeft3"):SetText(UNIT_SKINNABLE_LEATHER.." ("..(needlvlskin)..")");
  end

  if (not itemname) then return; end
  if (not ttLine2) or (string.find(ttLine2,gsMINING)) or (string.find(ttLine2,gsHERBING)) then -- Only do for minimap and viewport tooltips
    GatherSage.ProcessTooltip(tooltip, itemname);
  end
end

function GatherSage.ProcessTooltip(frame, itemname)
  if not frame then return end;
  if (gsMine[itemname]) then
    tText = getglobal(frame:GetName().."TextLeft2");
    if not tText then return end;
    local levelreq, lvlmedium, lvleasy, lvltrivial;
    if(gsMine[itemname]["baseskill"] == 0) then
      levelreq = "?";
      lvlmedium = 999;
      lvleasy = 999;
      lvltrivial = 999;
    else
      levelreq = gsMine[itemname]["baseskill"];
      lvlmedium = gsMine[itemname]["medium"];
      lvleasy = gsMine[itemname]["easy"];
      lvltrivial = gsMine[itemname]["trivial"];
    end
    
    -- UNIT_SKINNABLE_HERB = "Requires Herbalism"; -- The unit is a dead creature which can be skinned for its herb
    -- UNIT_SKINNABLE_LEATHER = "Skinnable"; -- The unit is a dead creature which can be skinned for its pelt
    -- UNIT_SKINNABLE_ROCK = "Requires Mining"; -- The unit is a dead creature which can be skinned for its rock
    
    local reqmsg = " ("..levelreq..")";    
    if tText:GetText() and string.find(string.lower(tText:GetText()), string.lower(UNIT_SKINNABLE_ROCK)) then
      tText:SetText(tText:GetText()..reqmsg);
    else
      local myskilllevel = GatherSage_GetLevel("mining");
      if myskilllevel >= lvltrivial then
        frame:AddLine(UNIT_SKINNABLE_ROCK..reqmsg, 0.50, 0.50, 0.50, 1.00); -- gray (trivial)
      elseif (myskilllevel >= lvleasy) and (myskilllevel < lvltrivial) then
        frame:AddLine(UNIT_SKINNABLE_ROCK..reqmsg, 0.25, 0.75, 0.25, 1.00); -- green (easy)
      elseif (myskilllevel >= lvlmedium) and (myskilllevel < lvleasy) then
        frame:AddLine(UNIT_SKINNABLE_ROCK..reqmsg, 1.00, 1.00, 0.00, 1.00); -- yellow (optimal)
      elseif (myskilllevel >= levelreq) and (myskilllevel < lvlmedium) then
        frame:AddLine(UNIT_SKINNABLE_ROCK..reqmsg, 1.00, 0.50, 0.25, 1.00); -- orange (medium)
      else
        frame:AddLine(UNIT_SKINNABLE_ROCK..reqmsg, 1.00, 0.10, 0.10, 1.00); -- red (impossible)
      end
      frame:SetHeight(frame:GetHeight() + 14);
    end

    if (gsMineHasStone[itemname])  and IsAltKeyDown() then
      local myminehasstone = gsLight..gspChanceOf..gsTail..gsWhite..gsMineHasStone[itemname]..gsTail;
      frame:AddLine(myminehasstone);
      frame:SetHeight(frame:GetHeight() + 14);
      local setwidno = ceil((strlen(myminehasstone)-11)*7.5);
      if (frame:GetWidth() < setwidno) then frame:SetWidth(setwidno); end
    end

    if (gsMineHasGem[itemname]) and IsAltKeyDown() then
      for key, gemtype in pairs(gsMineHasGem[itemname]) do
        local myminehasgem = gsLight..gspChanceOf..gsTail..gemtype;
        frame:AddLine(myminehasgem);
        frame:SetHeight(frame:GetHeight() + 14);
      end
    end

  elseif (gsHerb[itemname]) then
    tText = getglobal(frame:GetName().."TextLeft2");
    if not tText then return end;
    local levelreq;
    if(gsHerb[itemname]["baseskill"] == 0) then
      levelreq = "?";
      lvlmedium = 999;
      lvleasy = 999;
      lvltrivial = 999;
    else
      levelreq = gsHerb[itemname]["baseskill"];
      lvlmedium = gsHerb[itemname]["medium"];
      lvleasy = gsHerb[itemname]["easy"];
      lvltrivial = gsHerb[itemname]["trivial"];
    end
    
    local reqmsg = " ("..levelreq..")";
    if tText:GetText() and string.find(string.lower(tText:GetText()), string.lower(UNIT_SKINNABLE_HERB))  then
       tText:SetText(tText:GetText()..reqmsg);
      frame:SetHeight(frame:GetHeight() + 14);
    else
      local myskilllevel = GatherSage_GetLevel("herbing");
      if myskilllevel >= lvltrivial and IsAltKeyDown() then
        frame:AddLine(UNIT_SKINNABLE_HERB..reqmsg, 0.50, 0.50, 0.50, 1.00); -- gray (trivial)
      elseif (myskilllevel >= lvleasy) and (myskilllevel < lvltrivial) and IsAltKeyDown() then
        frame:AddLine(UNIT_SKINNABLE_HERB..reqmsg, 0.25, 0.75, 0.25, 1.00); -- green (easy)
      elseif (myskilllevel >= lvlmedium) and (myskilllevel < lvleasy) and IsAltKeyDown() then
        frame:AddLine(UNIT_SKINNABLE_HERB..reqmsg, 1.00, 1.00, 0.00, 1.00); -- yellow (optimal)
      elseif (myskilllevel >= levelreq) and (myskilllevel < lvlmedium) and IsAltKeyDown() then
        frame:AddLine(UNIT_SKINNABLE_HERB..reqmsg, 1.00, 0.50, 0.25, 1.00); -- orange (medium)
      elseif (myskilllevel < levelreq) and IsAltKeyDown() then
        frame:AddLine(UNIT_SKINNABLE_HERB..reqmsg, 1.00, 0.10, 0.10, 1.00); -- red (impossible)
      end
      frame:SetHeight(frame:GetHeight() + 14);
    end

    if (gsHerbHasHerb[itemname]) and IsAltKeyDown() then
      local myherbhasherb = gsLight..gspChanceOf..gsTail..gsWhite..gsHerbHasHerb[itemname]..gsTail;
      frame:AddLine(myherbhasherb);
      frame:SetHeight(frame:GetHeight() + 14);
      local setwidno = ceil(strlen(myherbhasherb)*7.5);
      if (frame:GetWidth() < setwidno) then frame:SetWidth(setwidno); end
    end

  elseif (gsOre[itemname]) and IsAltKeyDown() then
    local levelreq;
    if(gsOre[itemname]["baseskill"] == 0) then
      levelreq = "?";
      lvlmedium = 999;
      lvleasy = 999;
      lvltrivial = 999;
    else
      levelreq = gsOre[itemname]["baseskill"];
      lvlmedium = gsOre[itemname]["medium"];
      lvleasy = gsOre[itemname]["easy"];
      lvltrivial = gsOre[itemname]["trivial"];
    end

    local reqmsg = " ("..levelreq..")";
    local myskilllevel = GatherSage_GetLevel("mining");
    if myskilllevel >= lvltrivial then
      frame:AddLine(gspRequires..gsMINING..reqmsg..gspSkillToSmelt, 0.50, 0.50, 0.50, 1.00); -- gray (trivial)
    elseif (myskilllevel >= lvleasy) and (myskilllevel < lvltrivial) then
      frame:AddLine(gspRequires..gsMINING..reqmsg..gspSkillToSmelt, 0.25, 0.75, 0.25, 1.00); -- green (easy)
    elseif (myskilllevel >= lvlmedium) and (myskilllevel < lvleasy) then
      frame:AddLine(gspRequires..gsMINING..reqmsg..gspSkillToSmelt, 1.00, 1.00, 0.00, 1.00); -- yellow (optimal)
    elseif (myskilllevel >= levelreq) and (myskilllevel < lvlmedium) then
      frame:AddLine(gspRequires..gsMINING..reqmsg..gspSkillToSmelt, 1.00, 0.50, 0.25, 1.00); -- orange (medium)
    else
      frame:AddLine(gspRequires..gsMINING..reqmsg..gspSkillToSmelt, 1.00, 0.10, 0.10, 1.00); -- red (impossible)
    end
    frame:SetHeight(frame:GetHeight() + 14);
  end
  frame:Show()
end

function GatherSage_Tooltip_OnShow()
  local parentFrame = this:GetParent();
  local parentFrameName = parentFrame:GetName();
  local itemName = getglobal(parentFrameName.."TextLeft1"):GetText()
  GatherSage.ProcessWithName(parentFrame, itemName);
end

function GatherSage_GetLevel(skilltype)
  if (skilltype=="mining" or skilltype=="herbing" or skilltype=="skinning") then
    local numskills = GetNumSkillLines();
    for i=1,numskills do
      local skillname, _, _, skillrank = GetSkillLineInfo(i);
      if (skillname == gsMINING and skilltype=="mining") then
        return skillrank;
      elseif (skillname == gsHERBING and skilltype=="herbing") then
        return skillrank;
      elseif (skillname == gsSKINNING and skilltype=="skinning") then
        return skillrank;
      end
    end
    return 0;  -- Return 0 if no mining skill was found
  else
    return 0;
  end
end

function GatherSage_Print(text)
  if (text) then DEFAULT_CHAT_FRAME:AddMessage("|cff5e9ae4GatherSage"..FONT_COLOR_CODE_CLOSE..": "..text); end
end

-------------------------------
-- Hook Tooltip SetX Methods --
-------------------------------
GatherSage.TooltipList = {
  ItemRefTooltip,
  GameTooltip,
  ShoppingTooltip1,
  ShoppingTooltip2,
  --EquipCompare support
  ComparisonTooltip1,
  ComparisonTooltip2,
  --EQCompare support
  EQCompareTooltip1,
  EQCompareTooltip2,
  -- socketing interface
  --ItemSocketingDescription, -- commented out cause can't get it to work
  -- LinkWrangler support
  IRR_ItemRefTooltip1,
  IRR_ItemCompTooltip1,
  IRR_ItemCompTool11,
  IRR_ItemRefTooltip2,
  IRR_ItemCompTooltip2,
  IRR_ItemCompTool12,
  IRR_ItemRefTooltip3,
  IRR_ItemCompTooltip3,
  IRR_ItemCompTool13,
  IRR_ItemRefTooltip4,
  IRR_ItemCompTooltip4,
  IRR_ItemCompTool14,
  IRR_ItemRefTooltip5,
  IRR_ItemCompTooltip5,
  IRR_ItemCompTool15,
  -- MultiTips support
  ItemRefTooltip2,
  ItemRefTooltip3,
  ItemRefTooltip4,
  ItemRefTooltip5,
  -- Gatherer support ?
  GatherNoteTemplate,
}

GatherSage.MethodList = {
  "SetHyperlink",
  "SetBagItem",
  "SetInventoryItem",
  -- auction
  "SetAuctionItem",
  "SetAuctionSellItem",
  -- loot
  "SetLootItem",
  "SetLootRollItem",
  -- crafting
  "SetCraftSpell",
  "SetCraftItem",
  "SetTradeSkillItem",
  "SetTrainerService",
  -- mail
  "SetInboxItem",
  "SetSendMailItem",
  -- buffs
  "SetPlayerBuff",
  -- quest log
  "SetQuestItem",
  "SetQuestLogItem",
  -- trade
  "SetTradePlayerItem",
  "SetTradeTargetItem",
  -- vendor tooltip
  "SetMerchantItem",
  "SetBuybackItem",
}