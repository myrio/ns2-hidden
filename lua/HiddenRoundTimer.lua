// ===================== Hidden Mod =====================
//
// lua\HiddenRoundTimer.lua
//
//    Created by: Rio (rio@myrio.de)
//
// ======================================================

local locale = LibLoader:GetLibrary("LibLocales-1.0")

local strformat = string.format
local floor = math.floor

class 'HiddenRoundTimer'

HiddenRoundTimer.AnnounceTimeAt = { 300, 240, 180, 120, 60, 30, 15, 5, 4, 3, 2, 1 }
HiddenRoundTimer.AnnouncedTimeAlready = {}

function HiddenRoundTimer:GetGameStartTime()
    local entityList = Shared.GetEntitiesWithClassname("GameInfo")
    if (entityList:GetSize() > 0) then    
        local gameInfo = entityList:GetEntityAtIndex(0)
        local state = gameInfo:GetState()
        
        if (state == kGameState.Started) then
            return gameInfo:GetStartTime()
        else 
            return -1    
        end        
    end
    
    return 0    
end

function HiddenRoundTimer:GetRoundTime()
    return math.floor(Shared.GetTime() - self:GetGameStartTime())
end

function HiddenRoundTimer:GetIsRoundTimeOver()
    if (self:GetGameStartTime() < 0) then return false end
    return (Shared.GetTime() - self:GetGameStartTime() >= kHiddenModRoundTimerInSecs)
end

function HiddenRoundTimer:UpdateRoundTimer()
    for _, time in pairs(HiddenRoundTimer.AnnounceTimeAt) do
        if (not HiddenRoundTimer.AnnouncedTimeAlready[time] and floor(kHiddenModRoundTimerInSecs - HiddenRoundTimer:GetRoundTime()) == time) then
            Shared:HiddenMessage(strformat(locale:ResolveString("HIDDEN_GAME_ENDS_IN"), time))
            HiddenRoundTimer.AnnouncedTimeAlready[time] = true
        end    
    end
    
    if (not HiddenRoundTimer.AnnouncedTimeAlready["over"] and HiddenRoundTimer:GetIsRoundTimeOver()) then        
        Shared:HiddenMessage(locale:ResolveString("HIDDEN_GAME_ENDS"))
        HiddenRoundTimer.AnnouncedTimeAlready["over"] = true
    end  
end

function HiddenRoundTimer:Reset()
    HiddenRoundTimer.AnnouncedTimeAlready = {}
end