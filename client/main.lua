QBCore = exports['qb-core']:GetCoreObject()

local EnemyData = {}
local Active = false
local number = nil
local vehicle = nil
local Mark = false
local attemt = 1 
local cooldown = false
local timeLeft = 0
local xpreward = 0
local moneyreward = 0
local DoingMission = false
local Dealer = nil
local missionBlip = nil

local function setupClient()
	if Config.CentralBlip then
        Dealer = AddBlipForCoord(Config.TargetPedLoc)
        SetBlipSprite (Dealer, 802)
        SetBlipDisplay(Dealer, 4)
        SetBlipScale  (Dealer, 0.75)
        SetBlipAsShortRange(Dealer, true)
        SetBlipColour(Dealer, 3)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Contractor")
        EndTextCommandSetBlipName(Dealer)
	end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    setupClient()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    setupClient()
end)

local randomLocations = {
    vector3(-2480.9, -212.0, 17.4),
    vector3(-2723.4, 13.2, 15.1),
    vector3(-3169.6, 976.2, 15.0),
    vector3(-3139.8, 1078.7, 20.2),
    vector3(-1656.9, -246.2, 54.5),
    vector3(-1586.7, -647.6, 29.4),
    vector3(-1036.1, -491.1, 36.2),
    vector3(-1029.2, -475.5, 36.4),
    vector3(75.2, 164.9, 104.7),
    vector3(-534.6, -756.7, 31.6),
    vector3(487.2, -30.8, 88.9),
    vector3(-772.2, -1281.8, 4.6),
    vector3(-663.8, -1207.0, 10.2),
    vector3(719.1, -767.8, 24.9),
    vector3(-971.0, -2410.4, 13.3),
    vector3(-1067.5, -2571.4, 13.2),
    vector3(-619.2, -2207.3, 5.6),
    vector3(1192.1, -1336.9, 35.1),
    vector3(-432.8, -2166.1, 9.9),
    vector3(-451.8, -2269.3, 7.2),
    vector3(939.3, -2197.5, 30.5),
    vector3(-556.1, -1794.7, 22.0),
    vector3(591.7, -2628.2, 5.6),
    vector3(1654.5, -2535.8, 74.5),
    vector3(1642.6, -2413.3, 93.1),
    vector3(1371.3, -2549.5, 47.6),
    vector3(383.8, -1652.9, 37.3),
    vector3(27.2, -1030.9, 29.4),
    vector3(229.3, -365.9, 43.8),
    vector3(-85.8, -51.7, 61.1),
    vector3(-4.6, -670.3, 31.9),
    vector3(-111.9, 92.0, 71.1),
    vector3(-314.3, -698.2, 32.5),
    vector3(-366.9, 115.5, 65.6),
    vector3(-592.1, 138.2, 60.1),
    vector3(-1613.9, 18.8, 61.8),
    vector3(-1709.8, 55.1, 65.7),
    vector3(-521.9, -266.8, 34.9),
    vector3(-451.1, -333.5, 34.0),
    vector3(322.4, -1900.5, 25.8)
}

function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Wait(1)
		end
	end
end

CreateThread(function()
    RequestModel(GetHashKey(Config.TargetPed))
    while not HasModelLoaded(GetHashKey(Config.TargetPed)) do
        Wait(1)
    end

    NPC = CreatePed(5, GetHashKey(Config.TargetPed), Config.TargetPedLoc.x, Config.TargetPedLoc.y, Config.TargetPedLoc.z-1, Config.TargetPedLoc.w, false, false)
    FreezeEntityPosition(NPC, true)
    SetEntityInvincible(NPC, true)
    SetBlockingOfNonTemporaryEvents(NPC, true)
    SetModelAsNoLongerNeeded(hash)
    TaskStartScenarioInPlace(NPC,'WORLD_HUMAN_HANG_OUT_STREET')
    if Config.Target ~= 'ox_target' then
        local option = { 
            {
                type = "client",
                action = function(entity)
                    CarThiefOrder()
                end,
                icon = "fas fa-circle",
                label = 'Търси контракт',
				item = 'lionboost', -- change this item
                canInteract = function()
                    if not DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                action = function()
                    CancelMission()
                end,
                icon = "fas fa-circle",
                label = 'Откажи контракт',
				item = 'lionboost', -- change this item
                canInteract = function()
                    if DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                action = function()
                    CompleteOrder()
                end,
                icon = "fas fa-circle",
                label = 'Завърши Контракт',
				item = 'lionboost', -- change this item
                canInteract = function()
                    if DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                action = function()
                    CheckLevel()
                end,
                icon = "fas fa-circle",
                label = 'Виж Репутация',
				item = 'lionboost', -- change this item
            },
            {
                type = "client",
                action = function()
                    ChangeLevel()
                end,
                icon = "fas fa-circle",
                label = 'Смени Ниво',
				item = 'lionboost', -- change this item
            },
            {
                type = "client",
                event = "ls-carboostshop",
                icon = "fas fa-circle",
                label = 'Магазин LioneL ЕООД',
				item = 'lionboost', -- change this item
            },
        }
        exports[Config.Target]:AddEntityZone('Boost'..NPC, NPC, {
            name="Boost"..NPC,
            debugPoly=false,
            useZ = true
        }, {
            options = option,
            distance = 2.5
        })
    elseif Config.Target == 'ox_target' then
        local option = { 
            {
                type = "client",
                onSelect = function(entity)
                    CarThiefOrder()
                end,
                icon = "fas fa-circle",
                label = 'Vehicle Order',
                canInteract = function()
                    if not DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                onSelect = function()
                    CancelMission()
                end,
                icon = "fas fa-circle",
                label = 'Cancel Order',
                canInteract = function()
                    if DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                onSelect = function()
                    CompleteOrder()
                end,
                icon = "fas fa-circle",
                label = 'Complete Order',
                canInteract = function()
                    if DoingMission then 
                        return true
                    end
                    return false
                end
            },
            {
                type = "client",
                onSelect = function()
                    CheckLevel()
                end,
                icon = "fas fa-circle",
                label = 'Check Your Reputation'
            },
            {
                type = "client",
                onSelect = function()
                    ChangeLevel()
                end,
                icon = "fas fa-circle",
                label = 'Change Level'
            },
            {
                type = "client",
                event = "ls-carboostshop",
                icon = "fas fa-circle",
                label = 'Exclusive Contractor Shop'
            },
        }
        exports[Config.Target]:addLocalEntity(NPC, option)
    end
end)

function MailNotify(msg)
	local phoneNr = 'Car Thief'
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
	TriggerServerEvent('qb-phone:server:sendNewMail', {
		sender = phoneNr,
		subject = "Details",
		message = msg,
		button = {}
	})	
end     

function CarThiefOrder()
    if not cooldown then
        QBCore.Functions.TriggerCallback("ls-carboosting:boost:checklevel",function(cbdata, pro, PName)
            level = tonumber(cbdata)
            local carTable = Config.List[tostring(level)]
            local car = carTable[math.random(1, #carTable)]
            xpreward = car.reps
            moneyreward = car.price 
            PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
            if Config.notifyType == 'phone' then 
                MailNotify('До, '..PName..'<br /><br /><strong>Твоята репутация: '..cbdata..'</strong><br />Твоето XP: '..pro..'/100<br />(100XP = 1 Репутация)<br /><br />\n Кола за кражба : '..car.name..'<br />\n Репутация за да я откриеш: '..level..'<br /><br />Награди: <br />\nXP: '..car.reps..', Lionels: '..car.price..'<br />\n<br />Забележка: По-висока репутация, по-мощни коли, по-големи награди\n<br />')
            elseif Config.notifyType == 'chat' then 	
                TriggerEvent('chat:addMessage', {
                    template = '<div class="chat-message warning"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>Your Reputation = </strong> {1} <br><strong> Your XP = </strong> {2} (100XP = 1 Reputation)<br><strong> Delivery Vehicle = </strong> {3} <strong><br>  Reputation for Vehicle Search = </strong> {4} <strong><br> Rewards = XP: </strong> {5} <strong>, Money: </strong> {5} <strong><br>Note: Higher Reputation, Higher Vehicles, Higher Rewards</div></div>',
                    args = {'Car Thief', cbdata, pro, car.name, level, xpreward, moneyreward}
                })
            else
                Notify("Намери МПС "..car.name..'. Маркирана е на ГПС!')
            end
            if Config.EnableCooldown then
                TriggerServerEvent('ls-carboosting:carthief:server:cooldown', true)
            end
            SpawnCar(car.model)
        end)
    else
        Notify("В момента съм зает, моля изчакай "..round(timeLeft/60, 1)..' минути', 'error')
    end
end

function SpawnCar(veh) 
    DoingMission = true
    Active = true
    randomLoc = randomLocations[math.random(1, #randomLocations)]
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
        local vehicle = NetToVeh(netId)
        SetVehicleEngineOn(vehicle, false, true)
        exports['LegacyFuel']:SetFuel(vehicle, 100.0)
        SetVehicleFixed(vehicle)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleDoorsLocked(vehicle, 3)
        number = GetVehicleNumberPlateText(vehicle)
        Notify("Провери ГПС", 'success')
		if missionBlip then RemoveBlip(missionBlip) end
        addBlip(randomLoc.x, randomLoc.y, randomLoc.z)
        if Config.EnemyPed then
            SpawnEnemyPed(randomLoc)
        end
    end, veh, vector4(randomLoc.x, randomLoc.y, randomLoc.z, 90), false)
end

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

function addBlip(x,y,z)
	missionBlip = AddBlipForRadius(x, y, z, 800.0)
	SetBlipAlpha(missionBlip, 150)
	SetBlipHighDetail(missionBlip, true)
	SetBlipColour(missionBlip, 1)
	SetBlipAsShortRange(missionBlip, true)
end

function clearmission()
    Active = false
    if missionBlip then
        RemoveBlip(missionBlip)
        missionBlip = nil
    end
    for a = 1, #EnemyData do
        if DoesEntityExist(EnemyData[a]) then
            DeleteEntity(EnemyData[a])
        end
    end
end

function SpawnEnemyPed(randomLoc)
    local hashKey = GetHashKey(Config.EnemyPeds)
    local wep = GetHashKey(Config.EnemyWeapon)
    local rnum = math.random(-10,10)
    for i=1, Config.EnemyAmount do
		RequestModel(hashKey)
		while not HasModelLoaded(hashKey) do
			Wait(1)
		end
        local rnum = math.random(-10,10)
		guard = CreatePed(4, hashKey, randomLoc.x+rnum, randomLoc.y+rnum, randomLoc.z, 100.0, false, true)
		NetworkRegisterEntityAsNetworked(guard)
		SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(guard), true)
		SetPedCombatAttributes(guard, 46, true)
		SetPedCombatAbility(guard, 100)
		SetPedCombatMovement(guard, 2)
		SetPedCombatRange(guard, 2)
		SetEntityMaxHealth(guard, 500)
		SetEntityHealth(guard, 500)
		SetPedAlertness(guard, 3)
		SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(guard), true)
		SetPedCanSwitchWeapon(guard, true)
		SetPedArmour(guard, 100)
		SetPedAccuracy(guard, 100)
		SetEntityInvincible(guard, false)
		SetEntityVisible(guard, true)
		SetEntityAsMissionEntity(guard)
		GiveWeaponToPed(guard, wep, 255, false, false)
		SetPedDropsWeaponsWhenDead(guard, false)
		SetPedFleeAttributes(guard, 0, false)	
		SetPedRelationshipGroupHash(guard, GetHashKey("Guardias"))	
		TaskGuardCurrentPosition(guard, 5.0, 5.0, 1)
		SetPlayerWeaponDamageModifier(guard, 4000)
		TaskCombatPed(guard, PlayerPedId(), 0, 16)
        EnemyData[#EnemyData+1] = guard
    end
end

RegisterNetEvent('ls-carboosting:hack:carthief', function(hackplate)
    if hackplate then
        if GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)) == hackplate then
            if attemt < 3 then
				exports['ps-ui']:VarHack(function(success)
					if success then
						SetNewWaypoint(Config.TargetPedLoc.x, Config.TargetPedLoc.y)
						TriggerServerEvent('ls-carboosting:stopeve:carthief', false)
						Notify('Ти премахна проследяващото устройство!', 'success')
						TriggerEvent('mhacking:hide')
					else
						attemt = attemt + 1
						if attemt == 1 then
							Notify('Провали се! Опитай пак.', 'error')
						elseif attemt == 2 then
							SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false), 0)
							Notify('Провали се! Номера е скапан..', 'error')
							TriggerServerEvent('ls-carboosting:stopeve:carthief', true)
						end
					end
				 end, 5, 5) -- Number of Blocks, Time (seconds)
            else
                Notify('За жалост не успя и номера е изтрит', 'error')
            end
        end
    end
end)

RegisterNetEvent('ls-carboosting:carthief:client:cooldown', function(value)
    cooldown = value
    if cooldown then
        timeLeft = 60 * Config.Cooldown
    else
        timeLeft = 0
    end
end)

RegisterNetEvent('ls-carboosting:stopeve:carthief:client', function(state)
    if state then
        Mark = false
        attemt = 0
        hackplate = nil
        plate = nil
        number = nil
    else
        Mark = false
        attemt = 0
        hackplate = nil
        plate = nil
        if QBCore.Functions.GetPlayerData().job.name == 'police' then
            Notify("Проследяващото устройство е било премахнато от МПС-то.", 'error', 10000)
        end
    end
end)

RegisterNetEvent('ls-carboosting:tracker:carthief:client', function(loc)
    Mark = true
    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        Notify("Кражба на МПС! Проследяващо устройство активирано на ГПС.", 'error', 10000)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        local blip = AddBlipForCoord(loc.x, loc.y, loc.z)
        SetBlipSprite(blip, 458)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, 250)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Крадено МПС")
        EndTextCommandSetBlipName(blip)
        Wait(1000)
        SetBlipSprite(blip, 2)
        RemoveBlip(blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        if Active then
			if QBCore.Functions.GetPlayerData().metadata["isdead"] or QBCore.Functions.GetPlayerData().metadata["inlaststand"] then 
				clearmission()
			end
            if IsPedInAnyVehicle(ped, false) then
                if GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)) == number then
                    --print("WORK")
                    TriggerServerEvent('ls-carboosting:tracker:carthief', number)
                    Notify("Полицаите могат да те проследят")
                    Wait(3000) 
                    Notify("Вече може да хакнеш ГПС-а", 'success', 10000)
                    SetNewWaypoint(Config.TargetPedLoc.x, Config.TargetPedLoc.y)
                    clearmission()
                end
            end
        end
        if Mark then
            if IsPedInAnyVehicle(ped, false) then
                if GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)) == number then
                    Wait(3000)
                    TriggerServerEvent('ls-carboosting:tracker:carthief', number)
                end
            end
        end
        if cooldown then
            timeLeft = timeLeft-1
            if timeLeft == 0 then 
                TriggerServerEvent('ls-carboosting:carthief:server:cooldown', false)   
            end
        end
    end
end)

function CompleteOrder()
    if number then
        local pcoords = GetEntityCoords(PlayerPedId())
        local veh = GetClosestVehicle(pcoords.x, pcoords.y, pcoords.z, 15.000, 0, 70)
        if DoesEntityExist(veh) then
            if number == GetVehicleNumberPlateText(veh) then
                DoingMission = false
                DeleteEntity(veh)
                Notify("Готово!", 'success')  
                TriggerServerEvent('ls-carboosting:carthief:server:reward', xpreward, moneyreward)    
                number = nil  
                xpreward = 0
                moneyreward = 0
            else
                Notify("Това не е колата която търся", 'error')     
            end
        else
            Notify("Не виждам да си ми докарал МПС", 'error')     
        end
    else
        Notify("Свърши си работата братле", 'error')
    end
end

function CheckLevel()
    QBCore.Functions.TriggerCallback("ls-carboosting:boost:checklevel",function(cbdata, pro)
		local Menu = {}
		Menu[#Menu + 1] = { isMenuHeader = true, header = "Репутация", txt = "Бууст Прогрес"}
		Menu[#Menu + 1] = { isMenuHeader = true, header = "Ниво", txt = 'Ниво: '..cbdata}
		Menu[#Menu + 1] = { isMenuHeader = true, header = "XP", txt = 'XP: '..pro.."/100"}
		Menu[#Menu + 1] = { header = "", txt = "❌ Затвори", params = { event = "qb-menu:client:closeMenu" } }
		exports['qb-menu']:openMenu(Menu)
    end)
end

function ChangeLevel()
    if not level then
        QBCore.Functions.TriggerCallback("ls-carboosting:boost:checklevel",function(cbdata, pro)
            level = tonumber(cbdata)
        end)
    end
    while not level do
        Wait(0)
    end

	local Menu = {}
	Menu[#Menu + 1] = { isMenuHeader = true, header = "Смени Ниво", txt = "Мисии на други нива", }
	for i = 1, level do
		Menu[#Menu + 1] = { header = 'Ниво на контракт', txt = 'Смени ниво на:  '..i, params = {event = 'ls-carboosting:carthief:changelvl', args = {name = i} } }
	end
	Menu[#Menu + 1] = { header = "", txt = "❌ Затвори", params = { event = "qb-menu:client:closeMenu" } }
	exports['qb-menu']:openMenu(Menu)
end

function CancelMission()
    clearmission()
    DoingMission = false
    DeleteEntity(vehicle)
    Notify("Мисията е отказана!", 'success')  
    number = nil  
    xpreward = 0
    moneyreward = 0
end

RegisterNetEvent('ls-carboosting:carthief:changelvl', function(data)
    level = data.name
    Notify("Ти смени нивото на контракта си към "..data.name, 'success')
end)

RegisterNetEvent('ls-carboostshop:shop', function()  
	local Menu = {}
	Menu[#Menu + 1] = { isMenuHeader = true, header = "Lionel ЕООД", txt = "Избери предмет", }
	for k, v in pairs(Config.items) do
		Menu[#Menu + 1] = { icon = v.name, header = v.label, txt = v.price..' Lionels', params = {event = 'ls-carboosting:carthief:shop', args = {name = v.name, price = v.price, label = v.label} } }
	end
	Menu[#Menu + 1] = { header = "", txt = "❌ Затвори", params = { event = "qb-menu:client:closeMenu" } }
	exports['qb-menu']:openMenu(Menu)
end)

RegisterNetEvent('ls-carboosting:carthief:shop', function(data)
    local keyboard = exports["qb-input"]:ShowInput({
        header = "Въведи Стойност",
        submitText = "Потвърди",
        inputs = {
            {
                isRequired = true,
                type = 'number',
                text = "Въведи Стойност",
                name = 'amount'
            },
        }
    })
    if keyboard then
        TriggerServerEvent('ls-carboosting:carthief:shop:buy', data.name, keyboard.amount, data.price, data.label)
    end
end)

RegisterNetEvent('cs:carthief:notify', function(msg, state)
    Notify(msg, state)
end)

function Notify(msg, state)
	QBCore.Functions.Notify(msg, state)
end

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        setupClient()
        clearmission()
    end
end)