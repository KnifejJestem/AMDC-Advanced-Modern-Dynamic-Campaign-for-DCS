Opszones = { Reneopszone, Beirutopszone, Basselopszone, Hatayopszone, Wujahopszone, Latakiaopszone }

Platoon1 = PLATOON:New("capture_b_tank", 10, "M1A2 SEPv3 Abrams Platoon")
Platoon1:AddMissionCapability({AUFTRAG.Type.GROUNDATTACK, AUFTRAG.Type.CAPTUREZONE}, 90)
local warehouse = STATIC:FindByName("Warehouse Incirlik-1")
if warehouse == nil then
end
env.info(warehouse:GetName())

BrigadeIncirlik = BRIGADE:New(STATIC:FindByName("Warehouse Incirlik-1"):GetName(), "Incirlik Brigade")

if BrigadeIncirlik == nil then
end
BrigadeIncirlik:AddPlatoon(Platoon1)

Agents = SET_GROUP:New():FilterPrefixes({"Blue EWR", "Blue", "Aerial"}):FilterStart()

Chief = CHIEF:New(coalition.side.BLUE, Agents)

Chief:SetTacticalOverviewOn()
Chief:AddBrigade(BrigadeIncirlik)
Chief:__Start(1)
Chief:AddStrategicZone(Hatayopszone, 50, 1)
function Chief:OnAfterNewContact(From, Event, To, Contact)

    -- Gather info of contact.
    local ContactName = Chief:GetContactName(Contact)
    local ContactType = Chief:GetContactTypeName(Contact)
    local ContactThreat = Chief:GetContactThreatlevel(Contact)

    -- Text message.
    local text = string.format("Detected NEW contact: Name=%s, Type=%s, Threat Level=%d", ContactName, ContactType,
        ContactThreat)
    -- Show message in log file.
    env.info(text)
end

