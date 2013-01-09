// ===================== Hidden Mod =====================
//
// lua\HiddenTeamAttack.lua
//
//    Created by: Rio (rio@myrio.de)
//
// ======================================================

local locale = LibCache:GetLibrary("LibLocales-1.0")

local marineOnTakeDamage = Marine.OnTakeDamage
function Marine:OnTakeDamage(damage, attacker, doer, point)
    marineOnTakeDamage(self, damage, attacker, doer, point)
    
    if (kHiddenModSpawnProtectionEnabled) then     
        if (GetGamerules():GetGameState() == kGameState.Started) then
            if (damage > 0 and attacker:isa("Marine") and attacker:GetTeamNumber() == self:GetTeamNumber()) then        
                local gameStartTime = HiddenRoundTimer:GetGameStartTime()
                
                if (gameStartTime + kHiddenModSpawnProtectionTime >= Shared.GetTime()) then
                    attacker:HiddenMessage(locale:ResolveString("HIDDEN_TEAM_ATTACK"))
                    attacker:Kill()
                end
            end    
        end    
    end
end    

function ViewModel:OnUpdateAnimationInput(modelMixin)

    PROFILE("ViewModel:OnUpdateAnimationInput")
    
    local parent = self:GetParent()
    if (parent) then
        parent:OnUpdateAnimationInput(modelMixin)
    end
end