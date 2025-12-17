BASE:TraceAll(true)

--[[                                                
                                                   
▄▄▄▄▄  ▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄  ▄▄▄▄   ▄▄    ▄▄ ▄▄  ▄▄▄  
  ▄█▀ ██▀██ ███▄██ ██▄▄  ███▄▄   ██    ██ ██ ██▀██ 
▄██▄▄ ▀███▀ ██ ▀██ ██▄▄▄ ▄▄██▀ ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                                   
--]]

-------------------------------------------------
-- Zones.lua variables
-------------------------------------------------

Infantry_template = GROUP:FindByName("infantry_template")
Tank_templatet72 = GROUP:FindByName("tank_templatet72")
Tank_templatet90 = GROUP:FindByName("tank_templatet90")
Capture_b_tank = GROUP:FindByName("capture_b_tank")
Capture_b_infantry = GROUP:FindByName("capture_b_infantry")
Capture_r_tank = GROUP:FindByName("capture_r_tank")
Capture_r_infantry = GROUP:FindByName("capture_r_infantry")

Opszones = {}
Friendlyzones = {}
Enemyzones = {}

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

-- Draw Rene zone on map

-- trigger.action.circleToAll(-1, 1, rene:GetPointVec3(), 4600, {1, 0, 0, 1}, {1, 0, 0, 0.3}, 1, true, "Rene")
-- trigger.action.textToAll(-1, 2, rene:GetPointVec3(), {1, 0, 0, 1}, {1, 0, 0, 0.3}, 27, true, "Rene")

-- Rene Units spawning

local rene_infantry = SPAWN:NewWithAlias("infantry_template", "Rene Infantry")
  :InitRandomizeZones(rene_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, 6 do
    rene_infantry:Spawn()
  end

local rene_tankt72 = SPAWN:NewWithAlias("tank_templatet72", "Rene T-72")
  :InitRandomizeZones(rene_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(3, 5) do
    rene_tankt72:Spawn()
  end

local rene_tankt90 = SPAWN:NewWithAlias("tank_templatet90", "Rene T-90")
  :InitRandomizeZones(rene_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(2, 4) do
    rene_tankt90:Spawn()
  end



-- Rene OnCaptured logic
function Reneopszone:OnAfterCaptured(From, Event, To, Coalition)
  if Coalition == coalition.side.BLUE then
      Ctld:AddCTLDZone("rene", CTLD.CargoZoneType.UNLOAD, nil, true, false)
      Ctld:ActivateZone("rene", CTLD.CargoZoneType.UNLOAD)
      GetEnemyZones(Opszones)
      local reneredcatimer = TIMER:New( function()
          local enemyzones = GetEnemyZones(Opszones)
          local closezones = GetClosestEnemyZone(Rene, enemyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              env.info(variablename)
              env.info(selectedzone:GetName())
              local getvariable = _G[variablename]

              local rene_ca_unit = SPAWN:NewWithAlias("red_ca_unit", "Rene Red Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Reneopszone, coalition.side.RED, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                rene_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end
        end)

        reneredcatimer:Start(1, nil, math.random(1400, 2600))
        -- reneredcatimer:Start(1, nil, 1)
  if Coalition == coalition.side.RED then
      Ctld:DeactivateZone("Rene", CTLD.CargoZoneType.UNLOAD)
      GetFriendlyZones(Opszones)

        local renebluecatimer = TIMER:New( function()
          local friendlyzones = GetFriendlyZones(Opszones)
          local closezones = GetClosestFriendlyZone(Rene, friendlyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              local getvariable = _G[variablename]
              local rene_ca_unit = SPAWN:NewWithAlias("blue_ca_unit", "Rene Blue Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Reneopszone, coalition.side.BLUE, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                rene_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())

              
          else
              BASE:Trace("No friendly zones within 80 NM of Rene.")
          end
        end)

        renebluecatimer:Start(1, nil, math.random(1400, 2600))
        -- renebluecatimer:Start(1, nil, 1)

      end
      end
  end

-- For testing send units to attack Rene (Not needed here gonna be moved to ai.lua)



-- local rene_attack_unit = SPAWN:NewWithAlias("Ground-1", "Rene Attack Infantry")
--   :OnSpawnGroup(
--     function( spawned_group )
--       local attack_task = AUFTRAG:NewCAPTUREZONE(Reneopszone, coalition.side.BLUE, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
--       local opsgrp = ARMYGROUP:New( spawned_group )
--       if opsgrp == nil then
--         BASE:Trace("Opsgrp is nil!")
--         return
--       end
--       opsgrp:AddMission( attack_task )
--     end
--   )
--   :InitCleanUp(300)
--   :InitValidateAndRepositionGroundUnits(true)

-- rene_attack_unit:SpawnFromPointVec3(ZONE:FindByName("rene_attack_spawn"):GetPointVec3())


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

-- Beirut Units spawning

local beirut_infantry = SPAWN:NewWithAlias("infantry_template", "Beirut Infantry")
  :InitRandomizeZones(beirut_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(10, 15) do
    beirut_infantry:Spawn()
  end

local beirut_tankt72 = SPAWN:NewWithAlias("tank_templatet72", "Beirut T-72")
  :InitRandomizeZones(beirut_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)
  for i = 1, math.random(3, 5) do
    beirut_tankt72:Spawn()
  end

local beirut_tankt90 = SPAWN:NewWithAlias("tank_templatet90", "Beirut T-90")
  :InitRandomizeZones(beirut_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)
  for i = 1, math.random(3, 5) do
    beirut_tankt90:Spawn()
  end

  function Beirutopszone:OnAfterCaptured(From, Event, To, Coalition)
  if Coalition == coalition.side.BLUE then
      Ctld:AddCTLDZone("rene", CTLD.CargoZoneType.UNLOAD, nil, true, false)
      Ctld:ActivateZone("rene", CTLD.CargoZoneType.UNLOAD)
      GetEnemyZones(Opszones)
      local beirutredcatimer = TIMER:New( function()
          local enemyzones = GetEnemyZones(Opszones)
          local closezones = GetClosestEnemyZone(Beirut, enemyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              env.info(variablename)
              env.info(selectedzone:GetName())
              local getvariable = _G[variablename]

              local rene_ca_unit = SPAWN:NewWithAlias("red_ca_unit", "Rene Red Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Beirutopszone, coalition.side.RED, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                rene_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end
        end)

        beirutredcatimer:Start(1, nil, math.random(1400, 2600))
        -- beirutredcatimer:Start(1, nil, 1)
  if Coalition == coalition.side.RED then
      Ctld:DeactivateZone("Rene", CTLD.CargoZoneType.UNLOAD)
      GetFriendlyZones(Opszones)

        local beirutbluecatimer = TIMER:New( function()
          local friendlyzones = GetFriendlyZones(Opszones)
          local closezones = GetClosestFriendlyZone(Beirut, friendlyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              local getvariable = _G[variablename]
              local beirut_ca_unit = SPAWN:NewWithAlias("blue_ca_unit", "Beirut Blue Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Beirutopszone, coalition.side.BLUE, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                beirut_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())

              
          else
              BASE:Trace("No friendly zones within 80 NM of Rene.")
          end
        end)

        beirutbluecatimer:Start(1, nil, math.random(1400, 2600))
        -- beirutbluecatimer:Start(1, nil, 1)

      end
      end
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

-- Hatay Units spawning

local hatay_infantry = SPAWN:NewWithAlias("infantry_template", "Hatay Infantry")
  :InitRandomizeZones(hatay_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(5, 8) do
    hatay_infantry:Spawn()
  end

local hatay_tankt72 = SPAWN:NewWithAlias("tank_templatet72", "Hatay T-72")
  :InitRandomizeZones(hatay_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(2, 4) do
    hatay_tankt72:Spawn()
  end

local hatay_tankt90 = SPAWN:NewWithAlias("tank_templatet90", "Hatay T-90")
  :InitRandomizeZones(hatay_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(1, 3) do
    hatay_tankt90:Spawn()
  end

-- Hatay OnCaptured logic
function Hatayopszone:OnAfterCaptured(From, Event, To, Coalition)
  if Coalition == coalition.side.BLUE then
      Ctld:AddCTLDZone("hatay", CTLD.CargoZoneType.UNLOAD, nil, true, false)
      Ctld:ActivateZone("hatay", CTLD.CargoZoneType.UNLOAD)
      GetEnemyZones(Opszones)
      local hatayredcatimer = TIMER:New( function()
          local enemyzones = GetEnemyZones(Opszones)
          local closezones = GetClosestEnemyZone(Hatay, enemyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              env.info(variablename)
              env.info(selectedzone:GetName())
              local getvariable = _G[variablename]

              local hatay_ca_unit = SPAWN:NewWithAlias("red_ca_unit", "Hatay Red Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Hatayopszone, coalition.side.RED, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                hatay_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end
        end)

        hatayredcatimer:Start(1, nil, math.random(1400, 2600))
  end
  if Coalition == coalition.side.RED then
      Ctld:DeactivateZone("hatay", CTLD.CargoZoneType.UNLOAD)
      GetFriendlyZones(Opszones)

        local hataybluecatimer = TIMER:New( function()
          local friendlyzones = GetFriendlyZones(Opszones)
          local closezones = GetClosestFriendlyZone(Hatay, friendlyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              local getvariable = _G[variablename]
              local hatay_ca_unit = SPAWN:NewWithAlias("blue_ca_unit", "Hatay Blue Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Hatayopszone, coalition.side.BLUE, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                hatay_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())

              
          else
              BASE:Trace("No friendly zones within 80 NM of Hatay.")
          end
        end)

        hataybluecatimer:Start(1, nil, math.random(1400, 2600))

      end
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

-- Bassel Units spawning

local bassel_infantry = SPAWN:NewWithAlias("infantry_template", "Bassel Infantry")
  :InitRandomizeZones(bassel_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(8, 12) do
    bassel_infantry:Spawn()
  end

local bassel_tankt72 = SPAWN:NewWithAlias("tank_templatet72", "Bassel T-72")
  :InitRandomizeZones(bassel_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(3, 6) do
    bassel_tankt72:Spawn()
  end

local bassel_tankt90 = SPAWN:NewWithAlias("tank_templatet90", "Bassel T-90")
  :InitRandomizeZones(bassel_spawn_zones)
  :InitCleanUp(300)
  :InitValidateAndRepositionGroundUnits(true)

  for i = 1, math.random(2, 4) do
    bassel_tankt90:Spawn()
  end

-- Bassel OnCaptured logic
function Basselopszone:OnAfterCaptured(From, Event, To, Coalition)
  if Coalition == coalition.side.BLUE then
      Ctld:AddCTLDZone("bassel", CTLD.CargoZoneType.UNLOAD, nil, true, false)
      Ctld:ActivateZone("bassel", CTLD.CargoZoneType.UNLOAD)
      GetEnemyZones(Opszones)
      local basselredcatimer = TIMER:New( function()
          local enemyzones = GetEnemyZones(Opszones)
          local closezones = GetClosestEnemyZone(Bassel, enemyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              env.info(variablename)
              env.info(selectedzone:GetName())
              local getvariable = _G[variablename]

              local bassel_ca_unit = SPAWN:NewWithAlias("red_ca_unit", "Bassel Red Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Basselopszone, coalition.side.RED, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                bassel_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end
        end)

        basselredcatimer:Start(1, nil, math.random(1400, 2600))
  end
  if Coalition == coalition.side.RED then
      Ctld:DeactivateZone("bassel", CTLD.CargoZoneType.UNLOAD)
      GetFriendlyZones(Opszones)

        local basselbluecatimer = TIMER:New( function()
          local friendlyzones = GetFriendlyZones(Opszones)
          local closezones = GetClosestFriendlyZone(Bassel, friendlyzones)

          if #closezones > 0 then
              local randomindex = math.random(1, #closezones)
              local selectedzone = closezones[randomindex]
              local variablename = selectedzone:GetName() .. "_spawn_ca"
              local getvariable = _G[variablename]
              local bassel_ca_unit = SPAWN:NewWithAlias("blue_ca_unit", "Bassel Blue Counter Attack Unit")
                :OnSpawnGroup(
                  function( spawned_group )
                    local capture_task = AUFTRAG:NewCAPTUREZONE(Basselopszone, coalition.side.BLUE, 100, nil, ENUMS.Formation.Vehicle.OnRoad)
                    local opsgrp = ARMYGROUP:New( spawned_group )
                    if opsgrp == nil then
                      return end
                    opsgrp:AddMission( capture_task )
                  end)
                :InitValidateAndRepositionGroundUnits(true)

                bassel_ca_unit:SpawnFromPointVec3(ZONE:FindByName(variablename):GetPointVec3())
          end
        end)
        basselbluecatimer:Start(1, nil, math.random(1400, 2600))
      end
      end

Opszones = { Reneopszone, Beirutopszone, Basselopszone, Hatayopszone }