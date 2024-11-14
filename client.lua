local invisibleBots = {}
local maxHealth = 500000

function muteBot(bot)
  StopPedSpeaking(bot,true)
  DisablePedPainAudio(bot, true)
  SetAmbientVoiceName(bot, "kerry")
end


function spawnInvisibleBotsAroundPlayer(player)
    local playerPed = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(playerPed)
    
    local positions = {
        vector3(playerCoords.x + math.random(3, 7), playerCoords.y + math.random(-5, 5), playerCoords.z + math.random(3, 5)),
        vector3(playerCoords.x - math.random(3, 7), playerCoords.y + math.random(-5, 5), playerCoords.z + math.random(3, 5)),
        vector3(playerCoords.x + math.random(-3, 3), playerCoords.y + math.random(-7, 7), playerCoords.z + math.random(3, 6)),
        vector3(playerCoords.x + math.random(1, 4), playerCoords.y + math.random(-4, 4), playerCoords.z + math.random(3, 6)),
        vector3(playerCoords.x - math.random(1, 4), playerCoords.y + math.random(-4, 4), playerCoords.z + math.random(3, 6)),
        vector3(playerCoords.x + math.random(-4, 4), playerCoords.y + math.random(-6, 6), playerCoords.z + math.random(3, 6)),
        vector3(playerCoords.x + math.random(2, 5), playerCoords.y + math.random(-5, 5), playerCoords.z + math.random(3, 5)),
        vector3(playerCoords.x - math.random(2, 6), playerCoords.y + math.random(-5, 5), playerCoords.z + math.random(3, 6)),
        vector3(playerCoords.x + math.random(1, 3), playerCoords.y + math.random(-4, 4), playerCoords.z + math.random(3, 7)),
        vector3(playerCoords.x + math.random(-3, 5), playerCoords.y + math.random(-3, 7), playerCoords.z + math.random(3, 5))
    }
    
    for index, pos in ipairs(positions) do
        local botModel = GetHashKey("a_m_y_stbla_02")
        
        RequestModel(botModel)
        while not HasModelLoaded(botModel) do
            Citizen.Wait(10)
        end

        local bot = CreatePed(4, botModel, pos.x, pos.y, pos.z, 0.0, true, true)
        if bot and DoesEntityExist(bot) then

            muteBot(bot)
            
            SetEntityVisible(bot, true)   
            SetBlockingOfNonTemporaryEvents(bot, true) 
            SetEntityCollision(bot, false, false)
            FreezeEntityPosition(bot, true)
            SetEntityHealth(bot, maxHealth)
            table.insert(invisibleBots, {bot = bot, health = maxHealth})
        end
    end
end

function checkBotHits()
    for _, botData in pairs(invisibleBots) do
        local bot = botData.bot

        if HasEntityBeenDamagedByAnyPed(bot) then
            SetEntityHealth(bot, maxHealth)
            print("Bot getroffen! Leben wurde aufgefüllt.")
            ClearEntityLastDamageEntity(bot)
        end
    end
end

function deleteBots()
    if #invisibleBots > 0 then
        for _, botData in pairs(invisibleBots) do
            if DoesEntityExist(botData.bot) then
                    Citizen.Wait(5000)
                            for _, botData in pairs(invisibleBots) do
                DeleteEntity(botData.bot)
            end
            end
        end
        invisibleBots = {}
    end
end


local HitCheck = false

local function HitChecker()
    if HitCheck then
        return
    end

    HitCheck = true 

    taskThread = Citizen.CreateThread(function()
        while HitCheck do
            Citizen.Wait(1) 
             checkBotHits()
           
        end
    end)
end

local function stopHitCheck()
    if HitCheck then
        HitCheck = false 
        if taskThread then
            taskThread = nil
         end
    end
end


local isTaskActive = false 

local function TaskShootCheck()
    if isTaskActive then
        return
    end

    isTaskActive = true 

    taskThread = Citizen.CreateThread(function()
        while isTaskActive do
            Citizen.Wait(1) 
  local playerPed = PlayerPedId()

    if IsPedShooting(playerPed) then
       if #invisibleBots == 0 then  
            spawnInvisibleBotsAroundPlayer(PlayerId())
             HitChecker()
             end
              else
                deleteBots()  
                stopHitCheck()
             end
           
        end
    end)
end


local function stopTask()
    if isTaskActive then
        isTaskActive = false 
        if taskThread then
            taskThread = nil
         end
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)  

    local playerPed = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(playerPed)


    if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
          TaskShootCheck()
     else 
          stopTask()
          end
      end
end)
