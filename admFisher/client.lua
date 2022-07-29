vRPcPescar = {}
Tunnel.bindInterface("vRP_constructor",vRPcPescar)
Proxy.addInterface("vRP_constructor",vRPcPescar)
vRP = Proxy.getInterface("vRP")
vRPPescar = Tunnel.getInterface("vRP_constructor","vRP_constructor")


local POS_PESCUIT = vector3(-2542.6030273438,-1610.5140380859,1.9281224012375)
local TAKE_JOB = vector3(-1845.0471191406,-1195.5836181641,19.184310913086)
local VEH_SPAWN = vector3(-1877.4549560547,-1330.0520019531,2.2230505943298)
local isJob = false

-- GPED def
CreateThread(function() while true do _GPED = PlayerPedId() _PLAYERCOORDS = GetEntityCoords(_GPED) Wait(600)end end)
--PlayAnimo def
function PlayAnim(ped,base,sub,nr,time)Citizen.CreateThread(function()RequestAnimDict(base)while not HasAnimDictLoaded(base) do Citizen.Wait(1000)end if IsEntityPlayingAnim(_GPED, base, sub, 3) then thenClearPedSecondaryTask(_GPED) else for i = 1,nr do TaskPlayAnim(_GPED, base, sub, 8.0, -8, -1, 1, 0, 0, 0, 0) Citizen.Wait(time) end end end) end
--AttachEntityToPed def
local function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)BoneID = GetPedBoneIndex(_GPED, bone_ID)obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)vX,vY,vZ = table.unpack(GetEntityCoords(_GPED))xRot, yRot, zRot = table.unpack(GetEntityRotation(_GPED,2))AttachEntityToEntity(obj,  _GPED,  BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)return obj end
-- VehSpawn def
RegisterNetEvent("adam:vehicalspawn")
AddEventHandler("adam:vehicalspawn", function(k, v, plate) RequestModel('tug') while not HasModelLoaded('tug') do Wait(1000) end
local vehicle = CreateVehicle('tug', VEH_SPAWN[1],  VEH_SPAWN[2], VEH_SPAWN[3],true, false)Vehicle = vehicle SetVehicleOnGroundProperly(vehicle) SetEntityInvincible(vehicle, false)  SetPedIntoVehicle(_GPED,vehicle,-1) SetVehicleHasBeenOwnedByPlayer(_GPED,true) end)

CreateThread(function(source)
    while true do
        Wait(1500)
          
                   while # (_PLAYERCOORDS - POS_PESCUIT) >= 30.0 do
                    Wait(0)
                    while isJob == true do 
                        Wait(0)
                    SetTextFont(4)
                    SetTextProportional(0)
                    SetTextScale(0.6, 0.6)
                    SetTextColour(255, 255, 255, 255)
                    SetTextDropShadow(0, 0, 0, 0, 255)
                    SetTextEdge(1, 0, 0, 0, 255)
                    SetTextDropShadow()
                    SetTextOutline()
                    SetTextCentre(1)
                    SetTextEntry("STRING")
                    AddTextComponentString('TI-AM SETAT UN ~r~CHECKPOINT~w~ UNDE TREBUIE SA PESCUESTI \n INDREAPTA-TE SPRE EL PENTRU A ~r~PESCUII~w~')
                    DrawText(0.5, 0.100)
                    SetNewWaypoint(POS_PESCUIT[1],POS_PESCUIT[2],POS_PESCUIT[3])   
                   while # (_PLAYERCOORDS - POS_PESCUIT) <= 80.0 do
                    Wait(0)
                    SetTextFont(4)
                    SetTextProportional(0)
                    SetTextScale(0.6, 0.6)
                    SetTextColour(255, 255, 255, 255)
                    SetTextDropShadow(0, 0, 0, 0, 255)
                    SetTextEdge(1, 0, 0, 0, 255)
                    SetTextDropShadow()
                    SetTextOutline()
                    SetTextCentre(1)
                    SetTextEntry("STRING")
                    AddTextComponentString('APASA ~r~E~w~ PENTRU A PESCUI')
                    DrawText(0.5, 0.825)
                    if IsControlJustPressed(0, 38) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                        vRPPescar.checkroud({}, function(are)
                            if are then
                        local undita = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
                        vRP.notify({"Info: Asteapta pana ai sa prinzi un peste!"})
                        PlayAnim(_GPED,'amb@world_human_stand_fishing@base','base',4,2500000)
                        FreezeEntityPosition(_GPED,true)
                        Citizen.SetTimeout(9000, function()
                        vRP.stopAnim({false})
                        DetachEntity(undita, 1, 1)
                        DeleteObject(undita)
                        ExecuteCommand("e jpickup")
                        Citizen.SetTimeout(4000, function()
                        ExecuteCommand("e c")
                        vRPPescar.givefish()
                        FreezeEntityPosition(_GPED,false)
                        SetNewWaypoint(-1224.0495605469,-907.77606201172,12.326364517212)
                        
                            end)
                         end)
                      end
                    end)
                  end
               end
             end
            end 
           end 
       end)



CreateThread(function()
    while true do
        Wait(1500)
            while # (_PLAYERCOORDS - TAKE_JOB) <= 4.0 do
                DrawMarker(0, TAKE_JOB[1], TAKE_JOB[2], TAKE_JOB[3], 0, 0, 0, 0, 0, 0, 0.3, 0.4 ,0.4, 161, 66, 245, 230, 0, 0, 0, 1)
                Citizen.Wait(1)
                SetTextFont(4)
                SetTextProportional(0)
                SetTextScale(0.6, 0.6)
                SetTextColour(255, 255, 255, 255)
                SetTextDropShadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(1)
                SetTextEntry("STRING")
                AddTextComponentString('APASA ~r~E~w~ PENTRU A INCEPE JOB-UL DE\n ~r~PESCAR')
                DrawText(0.5, 0.825)
                if IsControlJustPressed(0, 38) then
                    isJob = true
                    TriggerEvent('adam:vehicalspawn')
                else
                    SetTextFont(4)
                    SetTextProportional(0)
                    SetTextScale(0.6, 0.6)
                    SetTextColour(255, 255, 255, 255)
                    SetTextDropShadow(0, 0, 0, 0, 255)
                    SetTextEdge(1, 0, 0, 0, 255)
                    SetTextDropShadow()
                    SetTextOutline()
                    SetTextCentre(1)
                    SetTextEntry("STRING")
                    AddTextComponentString('APASA ~r~G~w~ PENTRU A OPRI JOB-UL DE\n ~r~PESCAR')
                    DrawText(0.5, 0.900)
                if IsControlJustPressed(0, 47) then 
           isJob = false
                end
            end
        end
    end
end)