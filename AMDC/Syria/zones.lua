BASE:TraceAll(true)

--[[                                                
                                                   
▄▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄▄   ▄▄    ▄▄ ▄▄  ▄▄▄  
  ▄█▀ ██▀██ ███▄██ ██▄▄  ███▄▄   ██    ██ ██ ██▀██ 
▄██▄▄ ▀███▀ ██ ▀██ ██▄▄▄ ▄▄██▀ ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                                   
--]]

-------------------------------------------------
-- Zones.lua variables
-------------------------------------------------

-------------------------------------------------
--- SPAWN AMOUNT FOR AIRPORTS
-------------------------------------------------

-- RPG Airport

Rpg_airport_min = 1
Rpg_airport_max = 3

-- SA15 Airport

Sa15_airport_min = 1
Sa15_airport_max = 2

-- Infantry Airport

Inf_airport_min = 2
Inf_airport_max = 4

-- MANPADS Airport

Mnpds_airport_min = 1
Mnpds_airport_max = 3

-- T72 Airport

T72_airport_min = 2
T72_airport_max = 4

-- T90 Airport

T90_airport_min = 1
T90_airport_max = 3

-------------------------------------------------
--- SPAWN AMOUNT FOR NORMAL ZONES
-------------------------------------------------

-- RPG Zone

Rpg_zone_min = 1
Rpg_zone_max = 2

-- SA15 Zone

Sa15_zone_min = 0
Sa15_zone_max = 1



Inf_zone_min = 1
Inf_zone_max = 4



Mnpds_zone_min = 1
Mnpds_zone_max = 2



T72_zone_min = 1
T72_zone_max = 2



T90_zone_min = 0
T90_zone_max = 2


Infantry_template = GROUP:FindByName("infantry_template")
Manpad_template = GROUP:FindByName("manpad_template")
Rpg_template = GROUP:FindByName("rpg_template")
Sa15_template = GROUP:FindByName("sa15_template")
Sa15m2_template = GROUP:FindByName("sa15m2_template")
Sa2_template = GROUP:FindByName("sa2_template")
Sa5_template = GROUP:FindByName("sa5_template")
Sa6_template = GROUP:FindByName("sa6_template")
Sa3_template = GROUP:FindByName("sa3_template")
Sa10_template = GROUP:FindByName("sa10_template")
Sa11_template = GROUP:FindByName("sa11_template")
Ewr_template = GROUP:FindByName("ewr_template")
Tank_templatet72 = GROUP:FindByName("tank_templatet72")
Tank_templatet90 = GROUP:FindByName("tank_templatet90")
Capture_b_tank = GROUP:FindByName("capture_b_tank")
Capture_b_infantry = GROUP:FindByName("capture_b_infantry")
Capture_r_tank = GROUP:FindByName("capture_r_tank")
Capture_r_infantry = GROUP:FindByName("capture_r_infantry")

Opszones = { Reneopszone, Beirutopszone, Basselopszone, Hatayopszone, Wujahopszone, Latakiaopszone }
Friendlyzones = {}
Enemyzones = {}
Samzones = {
  ZONE:FindByName("sam_zone_easy-1"),
  ZONE:FindByName("sam_zone_easy-2"),
  ZONE:FindByName("sam_zone_easy-3"),
  ZONE:FindByName("sam_zone_easy-4"),
  ZONE:FindByName("sam_zone_easy-5"),
  ZONE:FindByName("sam_zone_easy-6"),
  ZONE:FindByName("sam_zone_easy-7")
}

--[[                                                   
                                                         
▄▄   ▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄▄ ▄▄  ▄▄▄▄
██▀▄▀██ ██▀██ ███▄██   ██   ██ ███▄▄
██   ██ ██▀██ ██ ▀██   ██   ██ ▄▄██▀
                                                         
--]]

Redmantis = MANTIS:New("Red Mantis", "Red SAM", "Red EWR", nil, "red", true)
Redmantis.autorelocate = true
Redmantis:Start()

-------------------------------------------------
-- Zones.lua functions
-------------------------------------------------


-- Get all friendly zones
function GetFriendlyZones(zones)
    local friendlyzones = {}
    for _, Opszones in ipairs(zones) do
        if Opszones:GetOwner() == coalition.side.BLUE then
            table.insert(friendlyzones, Opszones)
            table.insert(Friendlyzones, Opszones)
        end
    end
    env.info("Friendly zones found: " .. #friendlyzones)
    for i, zone in ipairs(friendlyzones) do
        -- Assuming the Opszone object has a GetName() method
        env.info("Friendly Zone Name #" .. i .. ": " .. zone:GetName())
    end
    return friendlyzones
end

function GetEnemyZones(zones)
    local enemyzones = {}
    for _, Opszones in ipairs(zones) do
        if Opszones:GetOwner() == coalition.side.RED then
            table.insert(enemyzones, Opszones)
            table.insert(Enemyzones, Opszones)
        end
    end
    env.info("Enemy zones found: " .. #enemyzones)
    for i, zone in ipairs(enemyzones) do
        -- Assuming the Opszone object has a GetName() method
        env.info("Enemy Zone Name #" .. i .. ": " .. zone:GetName())
    end
    return enemyzones
end


-- Convert meters to nautical miles
function CalculateMetersToNM(meters)
    local nm = meters / 1852
    return nm
end


-- Get closest friendly zones within 50 NM
function GetClosestFriendlyZone(initialpoint, friendlyzones)
    local distance = nil
    local alldistances = {}
    local closezones = {}

    for _, zone in ipairs(friendlyzones) do
        local friendlyzonecoordinate = zone:GetCoordinate()
        local distance = initialpoint:Get2DDistance(friendlyzonecoordinate)
        local converteddistance = CalculateMetersToNM(distance)
        if converteddistance < 80 and converteddistance > 1 then
            table.insert(alldistances, distance)
            table.insert(closezones, zone)
            env.info("Friendly zone within 80 NM: " .. zone:GetName())
        end
    end
    return closezones
end

function GetClosestEnemyZone(initialpoint, enemyzones)
    local distance = nil
    local alldistances = {}
    local closezones = {}

    for _, zone in ipairs(enemyzones) do
        local enemyzonecoordinate = zone:GetCoordinate()
        local distance = initialpoint:Get2DDistance(enemyzonecoordinate)
        local converteddistance = CalculateMetersToNM(distance)
        if converteddistance < 80 and converteddistance > 1 then
            table.insert(alldistances, distance)
            table.insert(closezones, zone)
            env.info("Enemy zone within 80 NM: " .. zone:GetName())
        end
    end
    return closezones
end

function TriggerCounterAttack(BaseZone, BaseOpsZone, BaseAlias, Coalition)
    local isBlue = (Coalition == coalition.side.BLUE)
    local targetCoalition = isBlue and coalition.side.RED or coalition.side.BLUE
    local caAlias = isBlue and " Red Counter Attack Unit" or " Blue Counter Attack Unit"
    local caTemplate = isBlue and "red_ca_unit" or "blue_ca_unit"

    -- Find nearby zones belonging to the "losing" side
    local candidateZones = isBlue and GetEnemyZones(Opszones) or GetFriendlyZones(Opszones)
    local closeZones = isBlue and GetClosestEnemyZone(BaseZone, candidateZones) or GetClosestFriendlyZone(BaseZone, candidateZones)

    if #closeZones > 0 then
        local selectedZone = closeZones[math.random(1, #closeZones)]
        local spawnZoneName = selectedZone:GetName() .. "_spawn_ca"
        
        -- Verification: Ensure the spawn zone actually exists
        local spawnZoneObj = ZONE:FindByName(spawnZoneName)
        if spawnZoneObj then
            local ca_spawn = SPAWN:NewWithAlias(caTemplate, BaseAlias .. caAlias)
                :OnSpawnGroup(function(spawned_group)
                    local capture_task = AUFTRAG:NewCAPTUREZONE(BaseOpsZone, targetCoalition, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New(spawned_group)
                    if opsgrp then opsgrp:AddMission(capture_task) end
                end)
                :InitValidateAndRepositionGroundUnits(true)

            ca_spawn:SpawnFromPointVec3(spawnZoneObj:GetPointVec3())
            env.info(BaseAlias .. " CA launched from " .. spawnZoneName)
        end
    else
        BASE:E("No valid zones found to launch CA for " .. BaseAlias)
    end
end

--[[                                                     
                                                       
█████▄  ▄▄▄▄▄ ▄▄  ▄▄ ▄▄▄▄▄   ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██▄▄██▄ ██▄▄  ███▄██ ██▄▄     ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
██   ██ ██▄▄▄ ██ ▀██ ██▄▄▄   ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                       
--]]

-- Rene variables

local rene_spawn_zones = {
  ZONE:FindByName("rene_spawn-1"),
  ZONE:FindByName("rene_spawn-2"),
  ZONE:FindByName("rene_spawn-3"),
  ZONE:FindByName("rene_spawn-4"),
  ZONE:FindByName("rene_spawn-5"),
  ZONE:FindByName("rene_spawn-6")
}
Rene = ZONE:FindByName("rene")
local renespawnca = ZONE:FindByName("rene_spawn_ca")
Reneopszone = OPSZONE:New(ZONE:FindByName("rene"), coalition.side.RED)
if Reneopszone == nil then
  BASE:Trace("Rene Opsgrp is nil!")
end
Reneopszone:Start()
local rene_level = 0

-- Draw Rene zone on map

-- trigger.action.circleToAll(-1, 1, rene:GetPointVec3(), 4600, {1, 0, 0, 1}, {1, 0, 0, 0.3}, 1, true, "Rene")
-- trigger.action.textToAll(-1, 2, rene:GetPointVec3(), {1, 0, 0, 1}, {1, 0, 0, 0.3}, 27, true, "Rene")

-- Rene OnCaptured logic

function Reneopszone:OnAfterCaptured(From, Event, To, Coalition)
    -- Handle CTLD
    if Coalition == coalition.side.BLUE then
        Ctld:AddCTLDZone("rene", CTLD.CargoZoneType.UNLOAD, nil, true, false)
        Ctld:ActivateZone("rene", CTLD.CargoZoneType.UNLOAD)
    else
        Ctld:DeactivateZone("rene", CTLD.CargoZoneType.UNLOAD)
        local enemyzones = GetEnemyZones(Opszones)
        local closezones = GetClosestEnemyZone(Rene, enemyzones)
        if #closezones > 0 then
          local rene_level = rene_level + 1

          local renebluecapture = TIMER:New( function()
            local randomindex = math.random(1, #closezones)
            local selectedzone = closezones[randomindex]
            local variablename = selectedzone:GetName() .. "_spawn_ca"

            local rene_blue_capture = SPAWN:NewWithAlias("capture_b_tank", "Rene Blue Capture")
              :OnSpawnGroup(
                function( spawned_group )
                  local supply_task = AUFTRAG:NewONGUARD(ZONE:FindByName(variablename):GetCoordinate())
                  local armgrp = ARMYGROUP:New( spawned_group )

                  if armgrp == nil then return end
                  armgrp:AddMission( supply_task )
                end)
              :InitValidateAndRepositionGroundUnits(true)

              rene_blue_capture:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end)

          renebluecapture:Start(1, nil, math.random(900, 1200))
        end
    end

    -- Trigger CA with random delay
    TIMER:New(function()
        TriggerCounterAttack(Rene, Reneopszone, "Rene", Coalition)
    end):Start(math.random(1400, 2600))
end


--[[                                                        
                                                               
█████▄ ▄▄▄▄▄ ▄▄ ▄▄▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄   ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██▄▄██ ██▄▄  ██ ██▄█▄ ██ ██   ██      ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
██▄▄█▀ ██▄▄▄ ██ ██ ██ ▀███▀   ██     ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                               
--]]

-- Beirut variables

local beirut_spawn_zones = {
  ZONE:FindByName("beirut_spawn-1"),
  ZONE:FindByName("beirut_spawn-2"),
  ZONE:FindByName("beirut_spawn-3"),
  ZONE:FindByName("beirut_spawn-4"),
  ZONE:FindByName("beirut_spawn-5"),
  ZONE:FindByName("beirut_spawn-6"),
  ZONE:FindByName("beirut_spawn-7"),
  ZONE:FindByName("beirut_spawn-8"),
  ZONE:FindByName("beirut_spawn-9"),
  ZONE:FindByName("beirut_spawn-10"),
  ZONE:FindByName("beirut_spawn-11"),
  ZONE:FindByName("beirut_spawn-12"),
  ZONE:FindByName("beirut_spawn-13"),
  ZONE:FindByName("beirut_spawn-14"),
  ZONE:FindByName("beirut_spawn-15")
}

local beirutspawnca = ZONE:FindByName("beirut_spawn_ca")

Beirut = ZONE:FindByName("beirut")
Beirutopszone = OPSZONE:New(ZONE:FindByName("beirut"), coalition.side.RED)
Beirutopszone:Start()
function Beirutopszone:OnAfterCaptured(From, Event, To, Coalition)
    TIMER:New(function()
        TriggerCounterAttack(Beirut, Beirutopszone, "Beirut", Coalition)
    end):Start(math.random(1400, 2600))
end

--[[                                                    
                                                          
██  ██  ▄▄▄ ▄▄▄▄▄▄ ▄▄▄  ▄▄ ▄▄   ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██████ ██▀██  ██  ██▀██ ▀███▀    ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
██  ██ ██▀██  ██  ██▀██   █     ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                          
--]]

-- Hatay variables

local hatay_spawn_zones = {
  ZONE:FindByName("hatay_spawn-1"),
  ZONE:FindByName("hatay_spawn-2"),
  ZONE:FindByName("hatay_spawn-3")
}

local hatayspawnca = ZONE:FindByName("hatay_spawn_ca")

Hatay = ZONE:FindByName("hatay")
Hatayopszone = OPSZONE:New(ZONE:FindByName("hatay"), coalition.side.RED)
Hatayopszone:Start()

-- Hatay OnCaptured logic
function Hatayopszone:OnAfterCaptured(From, Event, To, Coalition)
    TIMER:New(function()
        TriggerCounterAttack(Hatay, Hatayopszone, "Hatay", Coalition)
    end):Start(math.random(1400, 2600))
end

--[[                                                             
                                                                 
█████▄  ▄▄▄   ▄▄▄▄  ▄▄▄▄ ▄▄▄▄▄ ▄▄      ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██▄▄██ ██▀██ ███▄▄ ███▄▄ ██▄▄  ██       ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
██▄▄█▀ ██▀██ ▄▄██▀ ▄▄██▀ ██▄▄▄ ██▄▄▄   ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                                 
--]]

-- Bassel variables

local bassel_spawn_zones = {
  ZONE:FindByName("bassel_spawn-1"),
  ZONE:FindByName("bassel_spawn-2"),
  ZONE:FindByName("bassel_spawn-3"),
  ZONE:FindByName("bassel_spawn-4"),
  ZONE:FindByName("bassel_spawn-5"),
  ZONE:FindByName("bassel_spawn-6"),
  ZONE:FindByName("bassel_spawn-7"),
  ZONE:FindByName("bassel_spawn-8")
}

local basselcaspawn = ZONE:FindByName("bassel_ca_spawn")

Bassel = ZONE:FindByName("bassel")
Basselopszone = OPSZONE:New(ZONE:FindByName("bassel"), coalition.side.RED)
Basselopszone:Start()

-- Bassel OnCaptured logic
function Basselopszone:OnAfterCaptured(From, Event, To, Coalition)
    TIMER:New(function()
        TriggerCounterAttack(Hatay, Hatayopszone, "Hatay", Coalition)
    end):Start(math.random(1400, 2600))
end

--[[                                                      
                                                             
██     ██ ▄▄ ▄▄   ▄▄  ▄▄▄  ▄▄ ▄▄   ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██ ▄█▄ ██ ██ ██   ██ ██▀██ ██▄██    ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
 ▀██▀██▀  ▀███▀ ▄▄█▀ ██▀██ ██ ██   ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                             
--]]

local wujah_spawn_zones = {
  ZONE:FindByName("wujah_spawn-1"),
  ZONE:FindByName("wujah_spawn-2"),
  ZONE:FindByName("wujah_spawn-3"),
  ZONE:FindByName("wujah_spawn-4")
}

Wujah = ZONE:FindByName("wujah")
Wujahopszone = OPSZONE:New(ZONE:FindByName("wujah"), coalition.side.RED)
Wujahopszone:Start()

--[[                                                        
                                                                   
██      ▄▄▄ ▄▄▄▄▄▄ ▄▄▄  ▄▄ ▄▄ ▄▄  ▄▄▄    ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄ 
██     ██▀██  ██  ██▀██ ██▄█▀ ██ ██▀██    ▄▄▀▀  ██▀██ ███▄██ ██▄▄  
██████ ██▀██  ██  ██▀██ ██ ██ ██ ██▀██   ██████ ▀███▀ ██ ▀██ ██▄▄▄ 
                                                                   
--]]

local latakia_spawn_zones = {
  ZONE:FindByName("latakia_spawn-1"),
  ZONE:FindByName("latakia_spawn-2"),
  ZONE:FindByName("latakia_spawn-3"),
  ZONE:FindByName("latakia_spawn-4"),
  ZONE:FindByName("latakia_spawn-5")
}

Latakia = ZONE:FindByName("latakia")
Latakiaopszone = OPSZONE:New(ZONE:FindByName("latakia"), coalition.side.RED)
Latakiaopszone:Start()

--[[                                                   
                                                       
▄█████  ▄▄▄  ▄▄   ▄▄   ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄▄ 
▀▀▀▄▄▄ ██▀██ ██▀▄▀██    ▄▄▀▀  ██▀██ ███▄██ ██▄▄  ███▄▄ 
█████▀ ██▀██ ██   ██   ██████ ▀███▀ ██ ▀██ ██▄▄▄ ▄▄██▀ 
                                                       
--]]

-- Spawn SAM's

local EasyZoneSet = SET_ZONE:New():FilterPrefixes("sam_zone_easy"):FilterStart()

  EasyZoneSet:ForEachZone(function(samzone)
    local samzonename = samzone:GetName()
    
    local samtypeeasy = math.random(1, 2)
    local template = (samtypeeasy == 1) and "sa3_template" or "sa6_template"
    local alias = (samtypeeasy == 1) and "Red SAM SA-3 " or "Red SAM SA-6 "

    SPAWN:NewWithAlias(template, alias .. samzonename)
        :InitCleanUp(600)
        :InitValidateAndRepositionGroundUnits(true)
        :SpawnFromPointVec3(samzone:GetRandomPointVec3())
        
    env.info("Successfully spawned SAM in: " .. samzonename)
  end)

--[[ 
                                                           
██████ ██     ██ █████▄    ██████  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄▄ 
██▄▄   ██ ▄█▄ ██ ██▄▄██▄    ▄▄▀▀  ██▀██ ███▄██ ██▄▄  ███▄▄ 
██▄▄▄▄  ▀██▀██▀  ██   ██   ██████ ▀███▀ ██ ▀██ ██▄▄▄ ▄▄██▀ 
                                                           
--]]

Ewrzones = {
  ZONE:FindByName("ewr_zone-1"),
  ZONE:FindByName("ewr_zone-2"),
  ZONE:FindByName("ewr_zone-3"),
  ZONE:FindByName("ewr_zone-4"),
  ZONE:FindByName("ewr_zone-5")
}

local redewr = SPAWN:NewWithAlias("ewr_template", "Red EWR")
  :InitCleanUp(600)

for i=1, 5 do
  local selected_zone = Ewrzones[i]
  redewr:SpawnFromPointVec3(selected_zone:GetRandomPointVec3())
end

local function SpawnBaseUnits(zoneTable, template, aliasPrefix, min, max)
    local spawner = SPAWN:NewWithAlias(template, aliasPrefix)
        :InitRandomizeZones(zoneTable)
        :InitCleanUp(300)
        :InitValidateAndRepositionGroundUnits(true)
    
    local count = math.random(min, max)
    for i = 1, count do
        spawner:Spawn()
    end
end

local function PopulateAirbase(zoneTable, baseName, isAirport)
    local mn = isAirport and "_airport_min" or "_zone_min"
    local mx = isAirport and "_airport_max" or "_zone_max"

    SpawnBaseUnits(zoneTable, "infantry_template", baseName .. " Infantry", _G["Inf" .. mn], _G["Inf" .. mx])
    SpawnBaseUnits(zoneTable, "manpad_template",   baseName .. " Manpads",  _G["Mnpds" .. mn], _G["Mnpds" .. mx])
    SpawnBaseUnits(zoneTable, "tank_templatet72",  baseName .. " T-72",     _G["T72" .. mn], _G["T72" .. mx])
    SpawnBaseUnits(zoneTable, "tank_templatet90",  baseName .. " T-90",     _G["T90" .. mn], _G["T90" .. mx])
    SpawnBaseUnits(zoneTable, "rpg_template",      baseName .. " RPGs",     _G["Rpg" .. mn], _G["Rpg" .. mx])
    
    local sa15_tmplt = (baseName == "Beirut") and "sa15m2_template" or "sa15_template"
    SpawnBaseUnits(zoneTable, sa15_tmplt, baseName .. " SA-15", _G["Sa15" .. mn], _G["Sa15" .. mx])
end

PopulateAirbase(rene_spawn_zones,   "Rene",   true)
PopulateAirbase(beirut_spawn_zones, "Beirut", true)
PopulateAirbase(hatay_spawn_zones,  "Hatay",  true)
PopulateAirbase(bassel_spawn_zones, "Bassel", true)
PopulateAirbase(wujah_spawn_zones,  "Wujah",  true)
PopulateAirbase(latakia_spawn_zones, "Latakia", false)


Opszones = { Reneopszone, Beirutopszone, Basselopszone, Hatayopszone, Wujahopszone, Latakiaopszone }