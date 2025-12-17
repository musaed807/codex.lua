--// CODEX ALL-IN-ONE LICENSE SYSTEM (ROBLOX)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local player = Players.LocalPlayer
local FILE = "codex_license.json"

-- 🔑 مفاتيح Codex (عدلها براحتك)
local KEYS = {
    ["CODEX-A9Q2-ZX8M-7KLP"] = true,
    ["CODEX-AAAA-BBBB-CCCC"] = true
}

-- 🧠 HWID (أفضل المتاح في Roblox)
local function HWID()
    return RbxAnalyticsService:GetClientId()
end

-- 🔐 حفظ
local function save(key)
    if writefile then
        writefile(FILE, HttpService:JSONEncode({
            k = key,
            u = player.UserId,
            h = HWID()
        }))
    end
end

-- 📂 تحميل
local function load()
    if readfile and isfile and isfile(FILE) then
        return HttpService:JSONDecode(readfile(FILE))
    end
end

-- ✅ تحقق
local function verify(data)
    return data
        and data.k
        and KEYS[data.k]
        and data.u == player.UserId
        and data.h == HWID()
end

-- ⚡ تحقق تلقائي
local saved = load()
if not verify(saved) then

    -- 🖥️ GUI Codex
    local gui = Instance.new("ScreenGui", game.CoreGui)
    gui.Name = "CodexUI"

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.fromScale(0.35,0.25)
    frame.Position = UDim2.fromScale(0.325,0.35)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.fromScale(1,0.25)
    title.Text = "CODEX LICENSE"
    title.TextColor3 = Color3.fromRGB(255,220,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.fromScale(0.9,0.25)
    box.Position = UDim2.fromScale(0.05,0.35)
    box.PlaceholderText = "Enter Codex Key"
    box.BackgroundColor3 = Color3.fromRGB(30,30,30)
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.Gotham
    box.TextScaled = true
    Instance.new("UICorner", box)

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.fromScale(0.5,0.2)
    btn.Position = UDim2.fromScale(0.25,0.7)
    btn.Text = "ACTIVATE"
    btn.BackgroundColor3 = Color3.fromRGB(255,220,0)
    btn.TextColor3 = Color3.fromRGB(0,0,0)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        local key = box.Text
        if KEYS[key] then
            save(key)
            gui:Destroy()
            print("✅ CODEX ACTIVATED")
        else
            btn.Text = "INVALID KEY"
            task.wait(1)
            btn.Text = "ACTIVATE"
        end
    end)

    return -- ❌ يوقف السكربت لين يتفعل
end

-- 🚀 هنا يبدأ سكربتك الأصلي
print("🔥 CODEX VERIFIED | SCRIPT RUNNING")

-- مثال:
 loadstring(game:HttpGet("loadstring(game:HttpGet("https://raw.githubusercontent.com/musaed807/codex.lua/refs/heads/main/codexb.lua"))()
"))()

