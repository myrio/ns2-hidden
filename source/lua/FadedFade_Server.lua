// ===================== Faded Mod =====================
//
// lua\FadedFade_Server.lua
//
//    Created by: Rio (rio@myrio.de)
//
// =====================================================

function Fade:InitWeapons()
    Alien.InitWeapons(self)
    
    self:GiveItem(SwipeBlink.kMapName) // SwipeLeap
    self:SetActiveWeapon(SwipeBlink.kMapName)    
end

function Fade:GetTierTwoTechId()
    return kTechId.BileBomb //Stab
end

function Fade:GetTierThreeTechId()
    return kTechId.None
end