local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","admFisher")
vRPcPescar = Tunnel.getInterface("admFisher","admFisher")

vRPPescar = {}
Tunnel.bindInterface("admFisher",vRPPescar)
Proxy.addInterface("admFisher",vRPPescar)

local selfish = {
    {item = "peste",nume = "Peste",reward = 230000}
}


function vRPPescar.givefish()
    local user_id = vRP.getUserId({source})
        new_weightCodMic = vRP.getInventoryWeight({user_id})+vRP.getItemWeight({"peste"})*1
        if new_weightCodMic <= vRP.getInventoryMaxWeight({user_id}) then
            vRP.giveInventoryItem({user_id, "peste", 1, true})
            vRPclient.notify(source,{'Succes: Ai prins un peste, felicitari,pescueste pana poti si dupa vinde pestele la magazin ti-am setat un waypoint unde sa vinzi pestele/pesti!'})
        else
            vRPclient.notify(source, {"Eroare: ~w~Nu ai spatiu in inventar"})
        end
end

function vRPPescar.checkroud()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local check = vRP.getInventoryItemAmount{user_id, "undita"}
        if check >=1 then
        return true
    else
        vRPclient.notify(player,{"Eroare: Trebuie sa iti cumperi ~r~o undita ~w~de la magazin",2500,2})
    end
end


function build_fish(source,menudef)
    local _shop =  {name="PIATA",css = {top="75px",header_color="rgba(255, 255,0,0.8)"}}
    _shop['VINDE PESTE'] = {function (source,choise)
        local user_id = vRP.getUserId({source})
        local suma = 0
        for i,v in pairs(selfish) do
            if(vRP.getInventoryItemAmount({user_id,v.item})*v.reward ~= 0) then
                local sallmane = vRP.getInventoryItemAmount({user_id,v.item})*v.reward
                vRP.giveMoney({user_id,sallmane})
                suma = suma + sallmane
                vRP.tryGetInventoryItem({user_id, v.item, vRP.getInventoryItemAmount({user_id,v.item}), true})
            else
                vRPclient.notify(source, {"Eroare: ~w~Nu ai nici un peste dute si pescueste si reintoarece-te si vindel"})
            end
        end
        if(suma > 0) then
            vRPclient.notify(source,{"Succes: ~w~Ai vandut peste/pestii pentru suma de ~y~"..suma.."$","true"})
        end

end,'Pret: <font color = "red">x1 <font color = "white">= <font color="green"> 5.000.000$</font>'}
    vRP.openMenu({source,_shop})
    vRP.setArea({source,"Meniu PIATA",-1224.0495605469,-907.77606201172,12.326364517212,1,1.5,vacar_enter,vacar_leave})
    vRPclient.addMarker(source,{-1224.0495605469,-907.77606201172,12.326364517212-1,0.7,0.7,0.5,0,255,125,125,150})
end


AddEventHandler('vRP:playerSpawn', function(user_id,source,first_spawn)
	if first_spawn then 
		build_fish(source)
	end
end)



