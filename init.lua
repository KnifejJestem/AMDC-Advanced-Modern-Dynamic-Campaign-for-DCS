--[[                                     
                                        
▄▄ ▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄   ▄▄    ▄▄ ▄▄  ▄▄▄  
██ ███▄██ ██   ██     ██    ██ ██ ██▀██ 
██ ██ ▀██ ██   ██   ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                        
--]]

-- Change these variables to point to your files (THIS IS TO FIX LATER)

local zones = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\zones.lua]]
local cargo = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\cargo.lua]]
local ai = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\ai.lua]]


--[[                                                                                               
                                                                                                
▄▄     ▄▄▄   ▄▄▄  ▄▄▄▄     ▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄▄▄▄   ▄▄   ▄▄  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄ ▄▄    ▄▄▄▄▄  ▄▄▄▄ 
██    ██▀██ ██▀██ ██▀██   ██▀▀▀ ██▀██ ██▄█▄ ██▄▄    ██▀▄▀██ ██▀██ ██▀██ ██ ██ ██    ██▄▄  ███▄▄ 
██▄▄▄ ▀███▀ ██▀██ ████▀   ▀████ ▀███▀ ██ ██ ██▄▄▄   ██   ██ ▀███▀ ████▀ ▀███▀ ██▄▄▄ ██▄▄▄ ▄▄██▀ 
                                                                                                
--]]
--dofile(zones)
assert(loadfile(zones))()
assert(loadfile(cargo))()
assert(loadfile(ai))()
