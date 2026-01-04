--[[                                                 
                                                     
▄▄▄▄  ▄▄▄▄▄ ▄▄▄▄   ▄▄▄  ▄▄ ▄▄▄▄    ▄▄    ▄▄ ▄▄  ▄▄▄  
██▄█▄ ██▄▄  ██▀██ ██▀██ ██ ██▄█▄   ██    ██ ██ ██▀██ 
██ ██ ██▄▄▄ ████▀ ██▀██ ██ ██ ██ ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                                     
--]] 
Reneredair = EASYGCICAP:New("Rene Red Air", AIRBASE.Syria.Rene_Mouawad, "red", "EWR")
Beirutredair = EASYGCICAP:New("Beirut Red Air", AIRBASE.Syria.Beirut_Rafic_Hariri, "red", "EWR")
Hatayredair = EASYGCICAP:New("Hatay Red Air", AIRBASE.Syria.Hatay, "red", "EWR")
Basselredair = EASYGCICAP:New("Bassel Red Air", AIRBASE.Syria.Bassel_Al_Assad, "red", "EWR")

-- Reneredair:AddSquadron("MIG29S Template", "Rene Red Air MIG29S", AIRBASE.Syria.Rene_Mouawad, 20, AI.Skill.HIGH)

local addmoreplanes = TIMER:New(function()
    Reneredair:AddSquadron("MIG29S Template", "Rene Red Air MIG29S", AIRBASE.Syria.Rene_Mouawad, 4, AI.Skill.HIGH)
    Beirutredair:AddSquadron("MIG29S Template", "Beirut Red Air MIG29S", AIRBASE.Syria.Beirut_Rafic_Hariri, 4,
        AI.Skill.HIGH)
    Hatayredair:AddSquadron("MIG29S Template", "Hatay Red Air MIG29S", AIRBASE.Syria.Hatay, 4, AI.Skill.HIGH)
    Basselredair:AddSquadron("MIG29S Template", "Bassel Red Air MIG29S", AIRBASE.Syria.Bassel_Al_Assad, 4, AI.Skill.HIGH)
    env.info("Red Air: Added more MIG-29s to the CAPs")
end)

addmoreplanes:Start(nil, math.random(1800, 2400))
-- addmoreplanes:Start(nil, 15)
