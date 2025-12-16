--[[

 ▄▄▄▄  ▄▄▄  ▄▄▄▄   ▄▄▄▄  ▄▄▄    ▄▄    ▄▄ ▄▄  ▄▄▄  
██▀▀▀ ██▀██ ██▄█▄ ██ ▄▄ ██▀██   ██    ██ ██ ██▀██ 
▀████ ██▀██ ██ ██ ▀███▀ ▀███▀ ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                                  
--]]

_SETTINGS:SetPlayerMenuOff()

Ctld = CTLD:New(coalition.side.BLUE,{"Helicargo","CH.47", "CH%-47"}, "Helicargo Transport")
Ctld.useprefix = true
Ctld.dropcratesanywhere = true
Ctld.forcehoverload = false -- Chinook must-have option
Ctld.enableHercules = false
Ctld.allowcratepickupagain = true
Ctld.nobuildinloadzones = true -- Chinook must-have option
Ctld.movecratesbeforebuild = true -- Chinook must-have option
Ctld.movetroopstowpzone = true
Ctld.enableChinhookGCLoading = true -- Chinook must-have option
Ctld.hoverautoloading = false -- Chinook must-have option
Ctld.enableslingload = true -- Chinook must-have option
Ctld.pilotmustopendoors = true
Ctld.ChinookTroopCircleRadius = 5 -- Radius for troops dropping in a nice circle. Adjust to your planned squad size for the Chinook.
Ctld:__Start(5)

Ctld:AddTroopsCargo("Capture Squad", {"capture_squad"}, 5)