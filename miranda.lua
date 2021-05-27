local display = false
local pName = GetPlayerName(PlayerId())
local pId = GetPlayerServerId(PlayerId())


------------------------
--   Miranda Command  --
------------------------

--Shows Miranda Screen (You could change this to a Keybind if you really want...)
RegisterCommand("miranda", function(source, args)
    TriggerEvent('anima', true)
    SetDisplay(not display)
    Notify('~g~ Press ESC to put Miranda Card away!')
end)


------------------------
--    NUI Callbacks   --
------------------------

--Exit Callback (When user exits the Miranda Screen without Pressing "Agree")
RegisterNUICallback("exit", function(data)
    ClearPedTasks(GetPlayerPed(-1));
    SetDisplay(false)
end)

--Ok Callback (When user exits the Miranda Screen and has Pressed "Agree")
RegisterNUICallback("main", function(data)
    ClearPedTasks(GetPlayerPed(-1));
    SetDisplay(false)
end)


------------------------
--  Display Function  --
------------------------
function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


------------------------
--  Disable Controls  --
------------------------
Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display)
    end
end)


------------------------
-- Animation Function --
------------------------
RegisterNetEvent("anima")
AddEventHandler("anima", function(inputText) 
  RequestAnimDict("amb@code_human_wander_clipboard@male@base")
  TaskPlayAnim(GetPlayerPed(-1),"amb@code_human_wander_clipboard@male@base", "static", 5.0, -1, -1, 50, 0, false, false, false)
  local IsInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
	if not IsInVehicle then
		TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
	end
end)


------------------------
--   Notify Function  --
------------------------
function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end