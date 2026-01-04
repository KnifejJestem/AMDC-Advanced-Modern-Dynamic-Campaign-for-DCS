--[[                                     
                                        
▄▄ ▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄   ▄▄    ▄▄ ▄▄  ▄▄▄  
██ ███▄██ ██   ██     ██    ██ ██ ██▀██ 
██ ██ ▀██ ██   ██   ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                        
--]]

-- Change these variables to point to your files (THIS IS TO FIX LATER)

local zones = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\AMDC\Syria\zones.lua]]
local cargo = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\AMDC\Syria\cargo.lua]]
local redair = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\AMDC\Syria\redair.lua]]
local chief = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\AMDC\Syria\chief.lua]]


--[[                                                                                               
                                                                                                
▄▄     ▄▄▄   ▄▄▄  ▄▄▄▄     ▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄▄▄▄   ▄▄   ▄▄  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄ ▄▄    ▄▄▄▄▄  ▄▄▄▄ 
██    ██▀██ ██▀██ ██▀██   ██▀▀▀ ██▀██ ██▄█▄ ██▄▄    ██▀▄▀██ ██▀██ ██▀██ ██ ██ ██    ██▄▄  ███▄▄ 
██▄▄▄ ▀███▀ ██▀██ ████▀   ▀████ ▀███▀ ██ ██ ██▄▄▄   ██   ██ ▀███▀ ████▀ ▀███▀ ██▄▄▄ ██▄▄▄ ▄▄██▀ 
                                                                                                
--]]
--dofile(zones)
assert(loadfile(zones))()
-- assert(loadfile(cargo))()
assert(loadfile(redair))()
assert(loadfile(chief))()
