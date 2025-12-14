--[[                                     
                                        
▄▄ ▄▄  ▄▄ ▄▄ ▄▄▄▄▄▄   ▄▄    ▄▄ ▄▄  ▄▄▄  
██ ███▄██ ██   ██     ██    ██ ██ ██▀██ 
██ ██ ▀██ ██   ██   ▄ ██▄▄▄ ▀███▀ ██▀██ 
                                        
--]]

-- Change these variables to point to your files (THIS IS TO FIX LATER)

local zones = [[C:\Users\knife\Desktop\AMDC for DCS\AMDC-for-DCS\zones.lua]]


--[[                                                                                               
                                                                                                
▄▄     ▄▄▄   ▄▄▄  ▄▄▄▄     ▄▄▄▄  ▄▄▄  ▄▄▄▄  ▄▄▄▄▄   ▄▄   ▄▄  ▄▄▄  ▄▄▄▄  ▄▄ ▄▄ ▄▄    ▄▄▄▄▄  ▄▄▄▄ 
██    ██▀██ ██▀██ ██▀██   ██▀▀▀ ██▀██ ██▄█▄ ██▄▄    ██▀▄▀██ ██▀██ ██▀██ ██ ██ ██    ██▄▄  ███▄▄ 
██▄▄▄ ▀███▀ ██▀██ ████▀   ▀████ ▀███▀ ██ ██ ██▄▄▄   ██   ██ ▀███▀ ████▀ ▀███▀ ██▄▄▄ ██▄▄▄ ▄▄██▀ 
                                                                                                
--]]
--dofile(zones)
assert(loadfile(zones))()
