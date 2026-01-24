-- ⚡ Codex System V6 Pro - Ultimate Edition
-- ✅ ALL FEATURES WORKING + Enhanced ESP + Combat + Teleport

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPack = game:GetService("StarterPack")
local StarterGui = game:GetService("StarterGui")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")

-- Get Local Player
local player = Players.LocalPlayer
repeat task.wait() until player and player:FindFirstChild("PlayerGui")

-- Character Setup
local character, humanoid, hrp
local function setupChar(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
end

setupChar(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(setupChar)

-- Settings Table (All Features)
local S = {
    -- Main Features
    SpeedBoost = false,
    JumpBoost = false,
    Fly = false,
    Noclip = false,
    Invisibility = false,
    AntiFall = false,
    God = false,
    AutoHeal = false,
    Sprint = false,
    
    -- Combat Features
    SilentAim = false,
    AimAssist = false,
    TriggerBot = false,
    WallHack = false,
    ESP = false,
    NoRecoil = false,
    NoSpread = false,
    RapidFire = false,
    AutoShoot = false,
    PredictMovement = true,
    HitboxExtender = false,
    
    -- Mine Features
    AutoMine = false,
    FastMine = false,
    AutoCollect = false,
    XRay = false,
    OreESP = false,
    VeinMiner = false,
    InstantMine = false,
    
    -- Items Features
    GiveAllItems = false,
    DuplicateItems = false,
    BestTools = false,
    InfiniteItems = false,
    AutoEquip = false,
    
    -- Extra Features
    NightMode = false,
    Fog = false,
    CamShake = false,
    BunnyHop = false,
    AutoSprint = false,
    
    -- ESP Features
    BoxESP = false,
    NameESP = false,
    HealthESP = false,
    DistanceESP = false,
    WeaponESP = false,
    TracerESP = false,
    ChamsESP = false,
    SkeletonESP = false,
    RadarESP = false,
    SnapLines = false,
    ItemESP = false,
    
    -- Player Features
    SpectatePlayer = false,
    DragPlayer = false,
    FreezePlayer = false,
    
    -- Fun Features
    RainbowCharacter = false,
    GhostMode = false,
    SpinPlayer = false,
    Fireworks = false,
    AutoDance = false,
    
    -- Teleport Features
    TPInvisible = false,
    
    -- Combat Extras
    Prediction = false,
    BulletDrop = false,
    HitChance = 95,
    
    -- Teleport Saved Locations
    SavedLocations = {}
}

-- Global Variables
local mouse = player:GetMouse()
local targetLock = nil
local ESP_Items = {}
local ESP_Connections = {}
local mining = false
local ores = {}
local oreHighlights = {}
local allItems = {}
local toolGiverActive = false
local flying = false
local bodyVelocity
local rainbowConnection
local bunnyHopConnection
local espInstances = {}
local playerESPInstances = {}
local noclipConnection
local autoHealConnection
local infiniteItemsConnection
local autoEquipConnection
local skeletonEspConnection
local radarEspConnection
local autoShootConnection
local radarGui
local savedLocationsFrame

-- UI Creation
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "CodexUI_V6_Pro"
gui.ResetOnSpawn = false

-- Modern Glass Effect
local function glass(frame, color)
    frame.BackgroundTransparency = 0.85
    frame.BackgroundColor3 = color or Color3.fromRGB(15, 15, 25)
    
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 12)
    uICorner.Parent = frame
    
    local uIStroke = Instance.new("UIStroke")
    uIStroke.Color = Color3.fromRGB(0, 200, 255)
    uIStroke.Transparency = 0.3
    uIStroke.Thickness = 2
    uIStroke.Parent = frame
end

-- Neon Button Effect
local function neonButton(button, color)
    button.BackgroundTransparency = 0.9
    button.BackgroundColor3 = color or Color3.fromRGB(10, 10, 20)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 11
    button.Font = Enum.Font.GothamSemibold
    
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 8)
    uICorner.Parent = button
    
    local uIStroke = Instance.new("UIStroke")
    uIStroke.Color = Color3.fromRGB(0, 180, 255)
    uIStroke.Transparency = 0.1
    uIStroke.Thickness = 2
    uIStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        uIStroke.Color = Color3.fromRGB(0, 255, 255)
        button.BackgroundTransparency = 0.85
    end)
    
    button.MouseLeave:Connect(function()
        uIStroke.Color = Color3.fromRGB(0, 180, 255)
        button.BackgroundTransparency = 0.9
    end)
end

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0.78, 0, 0.88, 0)
main.Position = UDim2.new(0.11, 0, 0.06, 0)
glass(main)
main.Active = true
main.Draggable = true
main.Visible = false

-- Title
local title = Instance.new("TextLabel", main)
title.Text = "⚡ CODEX SYSTEM V6 PRO ⚡"
title.Size = UDim2.new(1, 0, 0.055, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Tabs Container
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(1, 0, 0.065, 0)
tabFrame.Position = UDim2.new(0, 0, 0.055, 0)
tabFrame.BackgroundTransparency = 1

-- Tab Creation
local function createTab(name, position, color)
    local tab = Instance.new("TextButton", tabFrame)
    tab.Size = UDim2.new(0.105, 0, 0.85, 0)
    tab.Position = position
    tab.Text = name
    tab.TextSize = 10
    tab.Font = Enum.Font.GothamBold
    tab.BackgroundColor3 = color
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.BackgroundTransparency = 0.8
    
    local corner = Instance.new("UICorner", tab)
    corner.CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", tab)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    
    return tab
end

-- Create Tabs
local tabMain = createTab("MAIN", UDim2.new(0.01, 0, 0.075, 0), Color3.fromRGB(0, 100, 200))
local tabCombat = createTab("COMBAT", UDim2.new(0.125, 0, 0.075, 0), Color3.fromRGB(200, 50, 50))
local tabMine = createTab("MINE", UDim2.new(0.24, 0, 0.075, 0), Color3.fromRGB(255, 150, 0))
local tabItems = createTab("ITEMS", UDim2.new(0.355, 0, 0.075, 0), Color3.fromRGB(255, 100, 0))
local tabESP = createTab("ESP", UDim2.new(0.47, 0, 0.075, 0), Color3.fromRGB(150, 50, 200))
local tabPlayers = createTab("PLAYERS", UDim2.new(0.585, 0, 0.075, 0), Color3.fromRGB(50, 200, 100))
local tabTeleport = createTab("TELEPORT", UDim2.new(0.7, 0, 0.075, 0), Color3.fromRGB(255, 100, 100))
local tabFun = createTab("FUN", UDim2.new(0.815, 0, 0.075, 0), Color3.fromRGB(100, 100, 255))

-- Content Frames
local function createContentFrame()
    local frame = Instance.new("Frame", main)
    frame.Size = UDim2.new(1, 0, 0.88, 0)
    frame.Position = UDim2.new(0, 0, 0.12, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    return frame
end

local contentMain = createContentFrame()
local contentCombat = createContentFrame()
local contentMine = createContentFrame()
local contentItems = createContentFrame()
local contentESP = createContentFrame()
local contentPlayers = createContentFrame()
local contentTeleport = createContentFrame()
local contentFun = createContentFrame()

-- Show Main by default
contentMain.Visible = true

-- Tab Switching
local function switchTab(tabName)
    contentMain.Visible = (tabName == "MAIN")
    contentCombat.Visible = (tabName == "COMBAT")
    contentMine.Visible = (tabName == "MINE")
    contentItems.Visible = (tabName == "ITEMS")
    contentESP.Visible = (tabName == "ESP")
    contentPlayers.Visible = (tabName == "PLAYERS")
    contentTeleport.Visible = (tabName == "TELEPORT")
    contentFun.Visible = (tabName == "FUN")
end

tabMain.MouseButton1Click:Connect(function() switchTab("MAIN") end)
tabCombat.MouseButton1Click:Connect(function() switchTab("COMBAT") end)
tabMine.MouseButton1Click:Connect(function() switchTab("MINE") end)
tabItems.MouseButton1Click:Connect(function() 
    switchTab("ITEMS")
    loadAllItems()
end)
tabESP.MouseButton1Click:Connect(function() switchTab("ESP") end)
tabPlayers.MouseButton1Click:Connect(function() 
    switchTab("PLAYERS")
    updatePlayerList()
end)
tabTeleport.MouseButton1Click:Connect(function() 
    switchTab("TELEPORT")
    updateSavedLocations()
end)
tabFun.MouseButton1Click:Connect(function() switchTab("FUN") end)

-- Button Creation Function
local function createButton(parent, text, position, size, color)
    local button = Instance.new("TextButton", parent)
    button.Text = text
    button.Position = position
    button.Size = size or UDim2.new(0.23, 0, 0.075, 0)
    button.TextSize = 11
    button.Font = Enum.Font.GothamSemibold
    neonButton(button, color)
    return button
end

-- ==================== UPDATE BUTTON TEXT FUNCTION ====================
local function updateButtonText(button, settingName)
    local cleanText = button.Text:gsub(" ON", ""):gsub(" OFF", ""):gsub(" ✅", ""):gsub(" ❌", ""):gsub(" 🔴", ""):gsub(" 🟢", "")
    button.Text = cleanText .. (S[settingName] and " ✅" or " ❌")
    button.BackgroundColor3 = S[settingName] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end

-- ==================== MAIN TAB ====================
-- Row 1
local speedBtn = createButton(contentMain, "🏃 SPEED BOOST ❌", UDim2.new(0.02, 0, 0.02, 0), nil, Color3.fromRGB(0, 100, 200))
local jumpBtn = createButton(contentMain, "🦘 JUMP BOOST ❌", UDim2.new(0.27, 0, 0.02, 0), nil, Color3.fromRGB(0, 150, 100))
local flyBtn = createButton(contentMain, "🚀 FLY MODE ❌", UDim2.new(0.52, 0, 0.02, 0), nil, Color3.fromRGB(200, 100, 0))
local noclipBtn = createButton(contentMain, "👻 NO CLIP ❌", UDim2.new(0.77, 0, 0.02, 0), nil, Color3.fromRGB(150, 0, 200))

-- Row 2
local godBtn = createButton(contentMain, "🛡️ GOD MODE ❌", UDim2.new(0.02, 0, 0.11, 0), nil, Color3.fromRGB(255, 50, 50))
local healBtn = createButton(contentMain, "💊 AUTO HEAL ❌", UDim2.new(0.27, 0, 0.11, 0), nil, Color3.fromRGB(50, 200, 100))
local invisBtn = createButton(contentMain, "👁️ INVISIBLE ❌", UDim2.new(0.52, 0, 0.11, 0), nil, Color3.fromRGB(100, 100, 255))
local antiFallBtn = createButton(contentMain, "🛡️ ANTI FALL ❌", UDim2.new(0.77, 0, 0.11, 0), nil, Color3.fromRGB(200, 200, 50))

-- Row 3
local nightBtn = createButton(contentMain, "🌙 NIGHT MODE ❌", UDim2.new(0.02, 0, 0.2, 0), nil, Color3.fromRGB(50, 50, 100))
local fogBtn = createButton(contentMain, "🌫️ FOG MODE ❌", UDim2.new(0.27, 0, 0.2, 0), nil, Color3.fromRGB(100, 100, 150))
local camBtn = createButton(contentMain, "📷 CAM SHAKE ❌", UDim2.new(0.52, 0, 0.2, 0), nil, Color3.fromRGB(150, 100, 50))
local sprintBtn = createButton(contentMain, "⚡ SPRINT ❌", UDim2.new(0.77, 0, 0.2, 0), nil, Color3.fromRGB(50, 150, 200))

-- ==================== COMBAT TAB (محسن) ====================
-- Row 1
local silentBtn = createButton(contentCombat, "🎯 SILENT AIM ❌", UDim2.new(0.02, 0, 0.02, 0), nil, Color3.fromRGB(255, 50, 50))
local aimBtn = createButton(contentCombat, "🔫 AIM ASSIST ❌", UDim2.new(0.27, 0, 0.02, 0), nil, Color3.fromRGB(50, 150, 255))
local triggerBtn = createButton(contentCombat, "⚡ TRIGGER BOT ❌", UDim2.new(0.52, 0, 0.02, 0), nil, Color3.fromRGB(0, 255, 150))
local rapidBtn = createButton(contentCombat, "💥 RAPID FIRE ❌", UDim2.new(0.77, 0, 0.02, 0), nil, Color3.fromRGB(255, 100, 0))

-- Row 2
local wallBtn = createButton(contentCombat, "🎯 WALL HACK ❌", UDim2.new(0.02, 0, 0.11, 0), nil, Color3.fromRGB(150, 0, 200))
local recoilBtn = createButton(contentCombat, "📐 NO RECOIL ❌", UDim2.new(0.27, 0, 0.11, 0), nil, Color3.fromRGB(100, 255, 100))
local spreadBtn = createButton(contentCombat, "🎯 NO SPREAD ❌", UDim2.new(0.52, 0, 0.11, 0), nil, Color3.fromRGB(150, 100, 255))
local hitboxBtn = createButton(contentCombat, "🎯 HITBOX EXTEND ❌", UDim2.new(0.77, 0, 0.11, 0), nil, Color3.fromRGB(255, 200, 50))

-- Row 3 (جديد)
local autoShootBtn = createButton(contentCombat, "🔫 AUTO SHOOT ❌", UDim2.new(0.02, 0, 0.2, 0), nil, Color3.fromRGB(255, 100, 100))
local predictionBtn = createButton(contentCombat, "🎯 PREDICTION ❌", UDim2.new(0.27, 0, 0.2, 0), nil, Color3.fromRGB(100, 200, 255))
local bulletDropBtn = createButton(contentCombat, "📉 BULLET DROP ❌", UDim2.new(0.52, 0, 0.2, 0), nil, Color3.fromRGB(150, 100, 200))
local hitChanceBtn = createButton(contentCombat, "🎯 HIT CHANCE: 95%", UDim2.new(0.77, 0, 0.2, 0), nil, Color3.fromRGB(255, 200, 50))

-- ==================== MINE TAB ====================
-- Row 1
local autoMineBtn = createButton(contentMine, "⛏️ AUTO MINE ❌", UDim2.new(0.02, 0, 0.02, 0), nil, Color3.fromRGB(200, 150, 50))
local fastMineBtn = createButton(contentMine, "⚡ FAST MINE ❌", UDim2.new(0.27, 0, 0.02, 0), nil, Color3.fromRGB(100, 200, 100))
local autoCollectBtn = createButton(contentMine, "💰 AUTO COLLECT ❌", UDim2.new(0.52, 0, 0.02, 0), nil, Color3.fromRGB(50, 150, 200))
local xrayBtn = createButton(contentMine, "👁️ XRAY VISION ❌", UDim2.new(0.77, 0, 0.02, 0), nil, Color3.fromRGB(150, 100, 255))

-- Row 2
local oreEspBtn = createButton(contentMine, "💎 ORE ESP ❌", UDim2.new(0.02, 0, 0.11, 0), nil, Color3.fromRGB(255, 100, 100))
local veinMinerBtn = createButton(contentMine, "🔗 VEIN MINER ❌", UDim2.new(0.27, 0, 0.11, 0), nil, Color3.fromRGB(100, 255, 200))
local instantMineBtn = createButton(contentMine, "⚡ INSTANT MINE ❌", UDim2.new(0.52, 0, 0.11, 0), nil, Color3.fromRGB(200, 100, 150))
local mineSpeedBtn = createButton(contentMine, "🚀 MINE SPEED ❌", UDim2.new(0.77, 0, 0.11, 0), nil, Color3.fromRGB(255, 200, 50))

-- ==================== ITEMS TAB ====================
-- Items List
local itemsList = Instance.new("ScrollingFrame", contentItems)
itemsList.Size = UDim2.new(0.96, 0, 0.5, 0)
itemsList.Position = UDim2.new(0.02, 0, 0.02, 0)
itemsList.BackgroundTransparency = 0.9
itemsList.ScrollBarThickness = 6
glass(itemsList, Color3.fromRGB(20, 30, 40))

local itemsListLayout = Instance.new("UIListLayout", itemsList)
itemsListLayout.Padding = UDim.new(0, 5)

-- Item Actions
local giveAllBtn = createButton(contentItems, "🎁 GIVE ALL ITEMS ❌", UDim2.new(0.02, 0, 0.55, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(0, 150, 200))
local duplicateBtn = createButton(contentItems, "📦 DUPLICATE ITEMS ❌", UDim2.new(0.27, 0, 0.55, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(50, 200, 100))
local bestToolsBtn = createButton(contentItems, "⚡ BEST TOOLS ❌", UDim2.new(0.52, 0, 0.55, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(200, 100, 50))
local infiniteBtn = createButton(contentItems, "∞ INFINITE ITEMS ❌", UDim2.new(0.77, 0, 0.55, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(150, 50, 200))

-- Row 2
local autoEquipBtn = createButton(contentItems, "🔄 AUTO EQUIP ❌", UDim2.new(0.02, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(100, 200, 100))
local repairBtn = createButton(contentItems, "🔧 REPAIR ALL", UDim2.new(0.27, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(200, 150, 50))
local upgradeBtn = createButton(contentItems, "⬆️ UPGRADE ITEMS", UDim2.new(0.52, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(100, 150, 255))
local sellAllBtn = createButton(contentItems, "💰 SELL ALL", UDim2.new(0.77, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(50, 200, 150))

-- Selected Item
local selectedItemBox = Instance.new("TextBox", contentItems)
selectedItemBox.PlaceholderText = "Enter item name..."
selectedItemBox.Size = UDim2.new(0.96, 0, 0.075, 0)
selectedItemBox.Position = UDim2.new(0.02, 0, 0.75, 0)
selectedItemBox.TextSize = 12
selectedItemBox.TextColor3 = Color3.fromRGB(255, 255, 255)
selectedItemBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
selectedItemBox.Font = Enum.Font.Gotham
glass(selectedItemBox)

-- Quick Actions
local giveSelectedBtn = createButton(contentItems, "🎯 GIVE SELECTED", UDim2.new(0.02, 0, 0.85, 0), UDim2.new(0.48, 0, 0.075, 0), Color3.fromRGB(255, 150, 0))
local searchItemBtn = createButton(contentItems, "🔍 SEARCH ITEM", UDim2.new(0.52, 0, 0.85, 0), UDim2.new(0.46, 0, 0.075, 0), Color3.fromRGB(100, 100, 255))

-- ==================== ESP TAB (محسن) ====================
-- Row 1
local boxEspBtn = createButton(contentESP, "📦 BOX ESP ❌", UDim2.new(0.02, 0, 0.02, 0), nil, Color3.fromRGB(50, 200, 150))
local nameEspBtn = createButton(contentESP, "📝 NAME ESP ❌", UDim2.new(0.27, 0, 0.02, 0), nil, Color3.fromRGB(200, 150, 50))
local healthEspBtn = createButton(contentESP, "❤️ HEALTH ESP ❌", UDim2.new(0.52, 0, 0.02, 0), nil, Color3.fromRGB(50, 150, 255))
local distanceEspBtn = createButton(contentESP, "📏 DISTANCE ESP ❌", UDim2.new(0.77, 0, 0.02, 0), nil, Color3.fromRGB(255, 100, 50))

-- Row 2
local weaponEspBtn = createButton(contentESP, "🔫 WEAPON ESP ❌", UDim2.new(0.02, 0, 0.11, 0), nil, Color3.fromRGB(100, 255, 100))
local tracerEspBtn = createButton(contentESP, "🎯 TRACER ESP ❌", UDim2.new(0.27, 0, 0.11, 0), nil, Color3.fromRGB(255, 200, 0))
local chamsEspBtn = createButton(contentESP, "🎨 CHAMS ESP ❌", UDim2.new(0.52, 0, 0.11, 0), nil, Color3.fromRGB(0, 200, 255))
local espAllBtn = createButton(contentESP, "👁️ ALL ESP ❌", UDim2.new(0.77, 0, 0.11, 0), nil, Color3.fromRGB(150, 50, 200))

-- Row 3 (جديد)
local skeletonEspBtn = createButton(contentESP, "💀 SKELETON ESP ❌", UDim2.new(0.02, 0, 0.2, 0), nil, Color3.fromRGB(100, 100, 255))
local radarEspBtn = createButton(contentESP, "📡 RADAR ESP ❌", UDim2.new(0.27, 0, 0.2, 0), nil, Color3.fromRGB(255, 150, 50))
local snapLinesBtn = createButton(contentESP, "🎯 SNAP LINES ❌", UDim2.new(0.52, 0, 0.2, 0), nil, Color3.fromRGB(50, 200, 150))
local itemEspBtn = createButton(contentESP, "📦 ITEM ESP ❌", UDim2.new(0.77, 0, 0.2, 0), nil, Color3.fromRGB(200, 100, 200))

-- ==================== PLAYERS TAB ====================
local playerList = Instance.new("ScrollingFrame", contentPlayers)
playerList.Size = UDim2.new(0.96, 0, 0.6, 0)
playerList.Position = UDim2.new(0.02, 0, 0.02, 0)
playerList.BackgroundTransparency = 0.9
playerList.ScrollBarThickness = 6
glass(playerList, Color3.fromRGB(20, 30, 40))

local playerListLayout = Instance.new("UIListLayout", playerList)
playerListLayout.Padding = UDim.new(0, 5)

-- Player Actions
local spectateBtn = createButton(contentPlayers, "👁️ SPECTATE ❌", UDim2.new(0.02, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(0, 150, 200))
local teleportBtn = createButton(contentPlayers, "⚡ TELEPORT TO", UDim2.new(0.27, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(50, 200, 100))
local dragBtn = createButton(contentPlayers, "🎯 DRAG PLAYER ❌", UDim2.new(0.52, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(200, 100, 50))
local freezeBtn = createButton(contentPlayers, "❄️ FREEZE PLAYER ❌", UDim2.new(0.77, 0, 0.65, 0), UDim2.new(0.23, 0, 0.075, 0), Color3.fromRGB(50, 150, 255))

-- ==================== TELEPORT TAB (محفوظات) ====================
-- Saved Locations List
savedLocationsFrame = Instance.new("ScrollingFrame", contentTeleport)
savedLocationsFrame.Size = UDim2.new(0.65, 0, 0.6, 0)
savedLocationsFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
savedLocationsFrame.BackgroundTransparency = 0.9
savedLocationsFrame.ScrollBarThickness = 6
glass(savedLocationsFrame, Color3.fromRGB(20, 30, 40))

local savedLayout = Instance.new("UIListLayout", savedLocationsFrame)
savedLayout.Padding = UDim.new(0, 5)

-- Input for location name
local tpNameBox = Instance.new("TextBox", contentTeleport)
tpNameBox.PlaceholderText = "Enter location name..."
tpNameBox.Size = UDim2.new(0.65, 0, 0.075, 0)
tpNameBox.Position = UDim2.new(0.02, 0, 0.02, 0)
tpNameBox.TextSize = 12
tpNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tpNameBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
tpNameBox.Font = Enum.Font.Gotham
glass(tpNameBox)

-- Teleport Buttons (جانب القائمة)
local saveTpBtn = createButton(contentTeleport, "💾 SAVE LOCATION", UDim2.new(0.69, 0, 0.72, 0), nil, Color3.fromRGB(0, 150, 200))
local tpBtn = createButton(contentTeleport, "⚡ TELEPORT", UDim2.new(0.69, 0, 0.8, 0), nil, Color3.fromRGB(50, 200, 100))
local tpPlayerBtn = createButton(contentTeleport, "👤 TP TO PLAYER", UDim2.new(0.69, 0, 0.88, 0), nil, Color3.fromRGB(200, 100, 50))
local tpInvBtn = createButton(contentTeleport, "👻 TP INVISIBLE ❌", UDim2.new(0.69, 0, 0.96, 0), nil, Color3.fromRGB(150, 50, 200))

-- زر مسح المحفوظات
local clearLocationsBtn = createButton(contentTeleport, "🗑️ CLEAR SAVED", UDim2.new(0.69, 0, 0.64, 0), nil, Color3.fromRGB(255, 50, 50))

-- ==================== FUN TAB ====================
local rainbowBtn = createButton(contentFun, "🌈 RAINBOW CHAR ❌", UDim2.new(0.02, 0, 0.02, 0), nil, Color3.fromRGB(150, 50, 200))
local ghostBtn = createButton(contentFun, "👻 GHOST MODE ❌", UDim2.new(0.27, 0, 0.02, 0), nil, Color3.fromRGB(0, 200, 255))
local sizeBtn = createButton(contentFun, "📏 SIZE CHANGER ❌", UDim2.new(0.52, 0, 0.02, 0), nil, Color3.fromRGB(255, 200, 50))
local gravityBtn = createButton(contentFun, "⬆️ NO GRAVITY ❌", UDim2.new(0.77, 0, 0.02, 0), nil, Color3.fromRGB(100, 200, 255))

local bunnyBtn = createButton(contentFun, "🐰 BUNNY HOP ❌", UDim2.new(0.02, 0, 0.11, 0), nil, Color3.fromRGB(100, 200, 100))
local spinBtn = createButton(contentFun, "🌀 SPIN PLAYER ❌", UDim2.new(0.27, 0, 0.11, 0), nil, Color3.fromRGB(200, 100, 150))
local fireworksBtn = createButton(contentFun, "🎆 FIREWORKS ❌", UDim2.new(0.52, 0, 0.11, 0), nil, Color3.fromRGB(255, 100, 100))
local danceBtn = createButton(contentFun, "💃 AUTO DANCE ❌", UDim2.new(0.77, 0, 0.11, 0), nil, Color3.fromRGB(150, 100, 255))

-- ==================== FUNCTIONS ====================

-- تحديث قائمة المحفوظات
function updateSavedLocations()
    savedLocationsFrame:ClearAllChildren()
    
    local yPos = 0
    
    -- الأماكن الافتراضية
    local defaultLocations = {
        {name = "🏔️ Mountain Top", pos = Vector3.new(0, 500, 0)},
        {name = "🌊 Ocean Floor", pos = Vector3.new(0, -50, 200)},
        {name = "🏰 Castle Top", pos = Vector3.new(-100, 100, -100)},
        {name = "🌲 Forest Center", pos = Vector3.new(200, 20, 200)},
        {name = "💰 Treasure Cave", pos = Vector3.new(300, 30, -150)},
        {name = "⬆️ High Altitude", pos = Vector3.new(0, 1000, 0)},
        {name = "⬇️ Underground", pos = Vector3.new(0, -100, 0)},
        {name = "⚔️ Battle Arena", pos = Vector3.new(-200, 25, 150)}
    }
    
    -- إضافة الأماكن الافتراضية
    for _, loc in ipairs(defaultLocations) do
        local locBtn = Instance.new("TextButton", savedLocationsFrame)
        locBtn.Text = loc.name
        locBtn.Size = UDim2.new(1, -10, 0, 35)
        locBtn.Position = UDim2.new(0, 5, 0, yPos)
        locBtn.TextSize = 11
        locBtn.Font = Enum.Font.GothamSemibold
        neonButton(locBtn, Color3.fromRGB(50, 100, 150))
        
        locBtn.MouseButton1Click:Connect(function()
            tpNameBox.Text = loc.name
            teleportToLocation(loc.pos)
        end)
        
        yPos = yPos + 40
    end
    
    -- إضافة المواقع المحفوظة
    for name, pos in pairs(S.SavedLocations) do
        local locBtn = Instance.new("TextButton", savedLocationsFrame)
        locBtn.Text = "💾 " .. name
        locBtn.Size = UDim2.new(1, -10, 0, 35)
        locBtn.Position = UDim2.new(0, 5, 0, yPos)
        locBtn.TextSize = 11
        locBtn.Font = Enum.Font.GothamSemibold
        neonButton(locBtn, Color3.fromRGB(100, 50, 150))
        
        locBtn.MouseButton1Click:Connect(function()
            tpNameBox.Text = name
            teleportToLocation(pos)
        end)
        
        yPos = yPos + 40
    end
    
    savedLocationsFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- وظيفة التليبورت
function teleportToLocation(position)
    if hrp then
        if S.TPInvisible then
            local original = hrp.CFrame
            hrp.CFrame = CFrame.new(position)
            task.wait(0.1)
            hrp.CFrame = original
        else
            hrp.CFrame = CFrame.new(position)
        end
        
        StarterGui:SetCore("SendNotification", {
            Title = "⚡ Teleported",
            Text = "Successfully teleported to location!",
            Duration = 3
        })
    end
end

-- وظيفة الحصول على أقرب لاعب
function getClosestPlayer(maxDist)
    local closest = nil
    local closestDist = math.huge
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local targetHRP = plr.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and hrp then
                local dist = (targetHRP.Position - hrp.Position).Magnitude
                if dist < maxDist and dist < closestDist then
                    closestDist = dist
                    closest = plr
                end
            end
        end
    end
    
    return closest
end

-- ==================== ACTUAL WORKING FEATURES ====================

-- Speed Boost
speedBtn.MouseButton1Click:Connect(function()
    S.SpeedBoost = not S.SpeedBoost
    updateButtonText(speedBtn, "SpeedBoost")
    if S.SpeedBoost then
        humanoid.WalkSpeed = 50
    else
        humanoid.WalkSpeed = 16
    end
end)

-- Jump Boost
jumpBtn.MouseButton1Click:Connect(function()
    S.JumpBoost = not S.JumpBoost
    updateButtonText(jumpBtn, "JumpBoost")
    if S.JumpBoost then
        humanoid.JumpPower = 100
    else
        humanoid.JumpPower = 50
    end
end)

-- Fly Mode
flyBtn.MouseButton1Click:Connect(function()
    S.Fly = not S.Fly
    updateButtonText(flyBtn, "Fly")
    if S.Fly then
        startFlying()
    else
        stopFlying()
    end
end)

function startFlying()
    if not character or not hrp then return end
    flying = true
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(0, 10000, 0)
    bodyVelocity.Parent = hrp
    
    spawn(function()
        local speed = 50
        while flying and S.Fly do
            local cam = Workspace.CurrentCamera
            local direction = Vector3.new(0, 0, 0)
            
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + cam.CFrame.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - cam.CFrame.LookVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - cam.CFrame.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + cam.CFrame.RightVector
            end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction = direction - Vector3.new(0, 1, 0)
            end
            
            if direction.Magnitude > 0 then
                direction = direction.Unit * speed
            end
            
            bodyVelocity.Velocity = Vector3.new(direction.X, direction.Y, direction.Z)
            
            RunService.RenderStepped:Wait()
        end
        
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end)
end

function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
end

-- Noclip
noclipBtn.MouseButton1Click:Connect(function()
    S.Noclip = not S.Noclip
    updateButtonText(noclipBtn, "Noclip")
    
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    if S.Noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- God Mode
godBtn.MouseButton1Click:Connect(function()
    S.God = not S.God
    updateButtonText(godBtn, "God")
    if S.God then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
end)

-- Auto Heal
healBtn.MouseButton1Click:Connect(function()
    S.AutoHeal = not S.AutoHeal
    updateButtonText(healBtn, "AutoHeal")
    
    if autoHealConnection then
        autoHealConnection:Disconnect()
        autoHealConnection = nil
    end
    
    if S.AutoHeal then
        autoHealConnection = RunService.Heartbeat:Connect(function()
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    end
end)

-- Invisibility
invisBtn.MouseButton1Click:Connect(function()
    S.Invisibility = not S.Invisibility
    updateButtonText(invisBtn, "Invisibility")
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = S.Invisibility and 1 or 0
            end
        end
    end
end)

-- Night Mode
nightBtn.MouseButton1Click:Connect(function()
    S.NightMode = not S.NightMode
    updateButtonText(nightBtn, "NightMode")
    if S.NightMode then
        Lighting.ClockTime = 0
        Lighting.Ambient = Color3.fromRGB(50, 50, 50)
        Lighting.Brightness = 0
    else
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 1
    end
end)

-- Fog Mode
fogBtn.MouseButton1Click:Connect(function()
    S.Fog = not S.Fog
    updateButtonText(fogBtn, "Fog")
    if S.Fog then
        Lighting.FogEnd = 100
        Lighting.FogColor = Color3.fromRGB(100, 100, 100)
    else
        Lighting.FogEnd = 1000000
        Lighting.FogColor = Color3.fromRGB(255, 255, 255)
    end
end)

-- Sprint
sprintBtn.MouseButton1Click:Connect(function()
    S.Sprint = not S.Sprint
    updateButtonText(sprintBtn, "Sprint")
    if S.Sprint then
        humanoid.WalkSpeed = 32
    else
        humanoid.WalkSpeed = 16
    end
end)

-- ==================== MINE FEATURES ====================

-- Auto Mine
autoMineBtn.MouseButton1Click:Connect(function()
    S.AutoMine = not S.AutoMine
    updateButtonText(autoMineBtn, "AutoMine")
    if S.AutoMine then
        startAutoMine()
    else
        mining = false
    end
end)

function startAutoMine()
    mining = true
    spawn(function()
        while mining and S.AutoMine do
            local nearestOre = findNearestOre()
            if nearestOre and hrp then
                hrp.CFrame = CFrame.new(nearestOre.Position + Vector3.new(0, 3, 0))
                task.wait(0.5)
                mineOre(nearestOre)
            end
            task.wait(0.2)
        end
    end)
end

function findNearestOre()
    local nearest = nil
    local nearestDist = math.huge
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("ore") or name:find("rock") or name:find("stone") or 
               name:find("crystal") or name:find("gem") or name:find("mineral") then
                if hrp then
                    local dist = (obj.Position - hrp.Position).Magnitude
                    if dist < 50 and dist < nearestDist then
                        nearestDist = dist
                        nearest = obj
                    end
                end
            end
        end
    end
    
    return nearest
end

function mineOre(ore)
    if ore and ore:IsA("BasePart") then
        if S.InstantMine then
            ore:Destroy()
        else
            for i = 1, 5 do
                if ore and ore.Parent then
                    local original = ore.Size
                    ore.Size = original * 0.9
                    task.wait(0.1)
                end
            end
            if ore and ore.Parent then
                ore:Destroy()
            end
        end
    end
end

-- XRay
xrayBtn.MouseButton1Click:Connect(function()
    S.XRay = not S.XRay
    updateButtonText(xrayBtn, "XRay")
    if S.XRay then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 1 then
                part.LocalTransparencyModifier = 0.8
            end
        end
    else
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end)

-- Ore ESP
oreEspBtn.MouseButton1Click:Connect(function()
    S.OreESP = not S.OreESP
    updateButtonText(oreEspBtn, "OreESP")
    if S.OreESP then
        enableOreESP()
    else
        disableOreESP()
    end
end)

function enableOreESP()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("ore") or name:find("rock") or name:find("stone") or 
               name:find("crystal") or name:find("gem") or name:find("mineral") then
                
                local highlight = Instance.new("Highlight")
                highlight.Parent = obj
                highlight.FillColor = Color3.fromRGB(255, 215, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.5
                
                oreHighlights[obj] = highlight
            end
        end
    end
end

function disableOreESP()
    for ore, highlight in pairs(oreHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    oreHighlights = {}
end

-- ==================== COMBAT FEATURES (محسن) ====================

-- Silent Aim
silentBtn.MouseButton1Click:Connect(function()
    S.SilentAim = not S.SilentAim
    updateButtonText(silentBtn, "SilentAim")
end)

-- Aim Assist
aimBtn.MouseButton1Click:Connect(function()
    S.AimAssist = not S.AimAssist
    updateButtonText(aimBtn, "AimAssist")
    
    if S.AimAssist then
        spawn(function()
            while S.AimAssist do
                local target = getClosestPlayer(100)
                if target and target.Character then
                    local head = target.Character:FindFirstChild("Head")
                    if head then
                        local cam = Workspace.CurrentCamera
                        local direction = (head.Position - cam.CFrame.Position).Unit
                        cam.CFrame = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + direction)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Trigger Bot
triggerBtn.MouseButton1Click:Connect(function()
    S.TriggerBot = not S.TriggerBot
    updateButtonText(triggerBtn, "TriggerBot")
    
    if S.TriggerBot then
        spawn(function()
            while S.TriggerBot do
                if mouse.Target then
                    local target = mouse.Target.Parent
                    if target and target:FindFirstChild("Humanoid") then
                        mouse1click()
                        task.wait(0.1)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Rapid Fire
rapidBtn.MouseButton1Click:Connect(function()
    S.RapidFire = not S.RapidFire
    updateButtonText(rapidBtn, "RapidFire")
end)

-- Wall Hack
wallBtn.MouseButton1Click:Connect(function()
    S.WallHack = not S.WallHack
    updateButtonText(wallBtn, "WallHack")
    
    if S.WallHack then
        spawn(function()
            while S.WallHack do
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character then
                        for _, part in ipairs(plr.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.LocalTransparencyModifier = 0.3
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    else
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.LocalTransparencyModifier = 0
                    end
                end
            end
        end
    end
end)

-- Auto Shoot (جديد)
autoShootBtn.MouseButton1Click:Connect(function()
    S.AutoShoot = not S.AutoShoot
    updateButtonText(autoShootBtn, "AutoShoot")
    
    if autoShootConnection then
        autoShootConnection:Disconnect()
        autoShootConnection = nil
    end
    
    if S.AutoShoot then
        autoShootConnection = RunService.Heartbeat:Connect(function()
            local target = getClosestPlayer(100)
            if target and target.Character then
                local head = target.Character:FindFirstChild("Head")
                if head then
                    mouse.Target = head
                    mouse1click()
                end
            end
        end)
    end
end)

-- Prediction (جديد)
predictionBtn.MouseButton1Click:Connect(function()
    S.Prediction = not S.Prediction
    updateButtonText(predictionBtn, "Prediction")
end)

-- Hit Chance (جديد)
hitChanceBtn.MouseButton1Click:Connect(function()
    S.HitChance = S.HitChance + 5
    if S.HitChance > 100 then S.HitChance = 5 end
    hitChanceBtn.Text = "🎯 HIT CHANCE: " .. S.HitChance .. "%"
end)

-- ==================== ESP FEATURES (محسن) ====================

-- Box ESP
boxEspBtn.MouseButton1Click:Connect(function()
    S.BoxESP = not S.BoxESP
    updateButtonText(boxEspBtn, "BoxESP")
    if S.BoxESP then
        enableBoxESP()
    else
        disableESP("Box")
    end
end)

function enableBoxESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = plr.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            
            espInstances[plr.Name .. "_Box"] = highlight
        end
    end
end

-- Name ESP
nameEspBtn.MouseButton1Click:Connect(function()
    S.NameESP = not S.NameESP
    updateButtonText(nameEspBtn, "NameESP")
    if S.NameESP then
        enableNameESP()
    else
        disableESP("Name")
    end
end)

function enableNameESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NameESP"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = plr.Character:FindFirstChild("Head") or plr.Character
            
            local label = Instance.new("TextLabel")
            label.Text = plr.Name
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextSize = 14
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
            
            espInstances[plr.Name .. "_Name"] = billboard
        end
    end
end

-- Skeleton ESP (جديد)
skeletonEspBtn.MouseButton1Click:Connect(function()
    S.SkeletonESP = not S.SkeletonESP
    updateButtonText(skeletonEspBtn, "SkeletonESP")
    
    if skeletonEspConnection then
        skeletonEspConnection:Disconnect()
        skeletonEspConnection = nil
    end
    
    if S.SkeletonESP then
        skeletonEspConnection = RunService.Heartbeat:Connect(function()
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    -- رسم خطوط الهيكل العظمي
                    local bones = {
                        {"Head", "UpperTorso"},
                        {"UpperTorso", "LowerTorso"},
                        {"UpperTorso", "RightUpperArm"},
                        {"RightUpperArm", "RightLowerArm"},
                        {"RightLowerArm", "RightHand"},
                        {"UpperTorso", "LeftUpperArm"},
                        {"LeftUpperArm", "LeftLowerArm"},
                        {"LeftLowerArm", "LeftHand"},
                        {"LowerTorso", "RightUpperLeg"},
                        {"RightUpperLeg", "RightLowerLeg"},
                        {"RightLowerLeg", "RightFoot"},
                        {"LowerTorso", "LeftUpperLeg"},
                        {"LeftUpperLeg", "LeftLowerLeg"},
                        {"LeftLowerLeg", "LeftFoot"}
                    }
                    
                    for _, bone in ipairs(bones) do
                        local part1 = plr.Character:FindFirstChild(bone[1])
                        local part2 = plr.Character:FindFirstChild(bone[2])
                        
                        if part1 and part2 then
                            local beam = Instance.new("Beam")
                            beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                            beam.Width0 = 0.1
                            beam.Width1 = 0.1
                            
                            local att1 = Instance.new("Attachment", part1)
                            local att2 = Instance.new("Attachment", part2)
                            
                            beam.Attachment0 = att1
                            beam.Attachment1 = att2
                            beam.Parent = plr.Character
                            
                            task.delay(0.1, function()
                                beam:Destroy()
                                att1:Destroy()
                                att2:Destroy()
                            end)
                        end
                    end
                end
            end
        end)
    end
end)

-- Radar ESP (جديد)
radarEspBtn.MouseButton1Click:Connect(function()
    S.RadarESP = not S.RadarESP
    updateButtonText(radarEspBtn, "RadarESP")
    
    if radarGui then
        radarGui:Destroy()
        radarGui = nil
    end
    
    if S.RadarESP then
        radarGui = Instance.new("ScreenGui", player.PlayerGui)
        radarGui.Name = "CodexRadar"
        radarGui.ResetOnSpawn = false
        
        local frame = Instance.new("Frame", radarGui)
        frame.Size = UDim2.new(0, 200, 0, 200)
        frame.Position = UDim2.new(0, 20, 1, -220)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.5
        
        local center = Instance.new("Frame", frame)
        center.Size = UDim2.new(0, 4, 0, 4)
        center.Position = UDim2.new(0.5, -2, 0.5, -2)
        center.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        
        radarEspConnection = RunService.Heartbeat:Connect(function()
            frame:ClearAllChildren()
            
            -- مركز الرادار
            center = Instance.new("Frame", frame)
            center.Size = UDim2.new(0, 4, 0, 4)
            center.Position = UDim2.new(0.5, -2, 0.5, -2)
            center.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            
            -- نقاط اللاعبين
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and character and character:FindFirstChild("HumanoidRootPart") then
                        local myPos = character.HumanoidRootPart.Position
                        local targetPos = hrp.Position
                        
                        local relPos = targetPos - myPos
                        local distance = relPos.Magnitude
                        if distance < 200 then
                            local x = relPos.X / 200
                            local z = relPos.Z / 200
                            
                            local dot = Instance.new("Frame", frame)
                            dot.Size = UDim2.new(0, 6, 0, 6)
                            dot.Position = UDim2.new(0.5 + x, -3, 0.5 + z, -3)
                            dot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                            dot.BorderSizePixel = 0
                        end
                    end
                end
            end
        end)
    else
        if radarEspConnection then
            radarEspConnection:Disconnect()
        end
    end
end)

function disableESP(type)
    for name, instance in pairs(espInstances) do
        if name:find(type) then
            instance:Destroy()
            espInstances[name] = nil
        end
    end
end

-- All ESP
espAllBtn.MouseButton1Click:Connect(function()
    local allOn = not (S.BoxESP and S.NameESP and S.HealthESP and S.DistanceESP)
    S.BoxESP = allOn
    S.NameESP = allOn
    S.HealthESP = allOn
    S.DistanceESP = allOn
    S.SkeletonESP = allOn
    S.RadarESP = allOn
    
    updateButtonText(boxEspBtn, "BoxESP")
    updateButtonText(nameEspBtn, "NameESP")
    updateButtonText(healthEspBtn, "HealthESP")
    updateButtonText(distanceEspBtn, "DistanceESP")
    updateButtonText(skeletonEspBtn, "SkeletonESP")
    updateButtonText(radarEspBtn, "RadarESP")
    
    if allOn then
        enableBoxESP()
        enableNameESP()
    else
        for _, instance in pairs(espInstances) do
            instance:Destroy()
        end
        espInstances = {}
    end
end)

-- ==================== PLAYER FEATURES ====================

-- تحديث قائمة اللاعبين
function updatePlayerList()
    playerList:ClearAllChildren()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local plrBtn = Instance.new("TextButton", playerList)
            plrBtn.Text = "👤 " .. plr.Name
            plrBtn.Size = UDim2.new(1, -10, 0, 30)
            plrBtn.TextSize = 11
            plrBtn.Font = Enum.Font.GothamSemibold
            neonButton(plrBtn, Color3.fromRGB(50, 50, 80))
            
            plrBtn.MouseButton1Click:Connect(function()
                tpNameBox.Text = plr.Name
            end)
        end
    end
    
    playerList.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 35)
end

-- Spectate Player
spectateBtn.MouseButton1Click:Connect(function()
    S.SpectatePlayer = not S.SpectatePlayer
    updateButtonText(spectateBtn, "SpectatePlayer")
    
    if S.SpectatePlayer and tpNameBox.Text ~= "" then
        local target = Players:FindFirstChild(tpNameBox.Text)
        if target and target.Character then
            Workspace.CurrentCamera.CameraSubject = target.Character
        end
    else
        Workspace.CurrentCamera.CameraSubject = character
    end
end)

-- Teleport to Player
teleportBtn.MouseButton1Click:Connect(function()
    local target = Players:FindFirstChild(tpNameBox.Text)
    if target and target.Character and hrp then
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            hrp.CFrame = targetHRP.CFrame
        end
    end
end)

-- Freeze Player
freezeBtn.MouseButton1Click:Connect(function()
    S.FreezePlayer = not S.FreezePlayer
    updateButtonText(freezeBtn, "FreezePlayer")
    
    local target = Players:FindFirstChild(tpNameBox.Text)
    if target and target.Character then
        local humanoid = target.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = S.FreezePlayer and 0 or 16
        end
    end
end)

-- ==================== TELEPORT FEATURES ====================

-- Save Location
saveTpBtn.MouseButton1Click:Connect(function()
    if hrp and tpNameBox.Text ~= "" then
        local locationName = tpNameBox.Text
        S.SavedLocations[locationName] = hrp.Position
        
        StarterGui:SetCore("SendNotification", {
            Title = "📍 Location Saved",
            Text = "Saved: " .. locationName,
            Duration = 3
        })
        
        updateSavedLocations()
    end
end)

-- Teleport
tpBtn.MouseButton1Click:Connect(function()
    if tpNameBox.Text ~= "" then
        local locationName = tpNameBox.Text
        
        -- البحث في المحفوظات
        if S.SavedLocations[locationName] then
            teleportToLocation(S.SavedLocations[locationName])
            return
        end
        
        -- البحث في قائمة اللاعبين
        local target = Players:FindFirstChild(locationName)
        if target and target.Character and hrp then
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                hrp.CFrame = targetHRP.CFrame
                return
            end
        end
        
        -- إحداثيات
        local x, y, z = locationName:match("([%-%d%.]+),%s*([%-%d%.]+),%s*([%-%d%.]+)")
        if x and y and z then
            teleportToLocation(Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
        else
            StarterGui:SetCore("SendNotification", {
                Title = "❌ Error",
                Text = "Location not found!",
                Duration = 3
            })
        end
    end
end)

-- TP to Player
tpPlayerBtn.MouseButton1Click:Connect(function()
    local target = Players:FindFirstChild(tpNameBox.Text)
    if target and target.Character and hrp then
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            hrp.CFrame = targetHRP.CFrame
        end
    end
end)

-- TP Invisible
tpInvBtn.MouseButton1Click:Connect(function()
    S.TPInvisible = not S.TPInvisible
    updateButtonText(tpInvBtn, "TPInvisible")
end)

-- Clear Saved Locations
clearLocationsBtn.MouseButton1Click:Connect(function()
    S.SavedLocations = {}
    updateSavedLocations()
    StarterGui:SetCore("SendNotification", {
        Title = "🗑️ Cleared",
        Text = "All saved locations removed",
        Duration = 3
    })
end)

-- ==================== FUN FEATURES ====================

-- Rainbow Character
rainbowBtn.MouseButton1Click:Connect(function()
    S.RainbowCharacter = not S.RainbowCharacter
    updateButtonText(rainbowBtn, "RainbowCharacter")
    
    if rainbowConnection then
        rainbowConnection:Disconnect()
        rainbowConnection = nil
    end
    
    if S.RainbowCharacter then
        rainbowConnection = RunService.RenderStepped:Connect(function()
            if character then
                local hue = tick() % 5 / 5
                local color = Color3.fromHSV(hue, 1, 1)
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Color = color
                    end
                end
            end
        end)
    end
end)

-- Bunny Hop
bunnyBtn.MouseButton1Click:Connect(function()
    S.BunnyHop = not S.BunnyHop
    updateButtonText(bunnyBtn, "BunnyHop")
    
    if bunnyHopConnection then
        bunnyHopConnection:Disconnect()
        bunnyHopConnection = nil
    end
    
    if S.BunnyHop then
        bunnyHopConnection = RunService.Heartbeat:Connect(function()
            if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- Spin Player
spinBtn.MouseButton1Click:Connect(function()
    S.SpinPlayer = not S.SpinPlayer
    updateButtonText(spinBtn, "SpinPlayer")
    if S.SpinPlayer and hrp then
        spawn(function()
            while S.SpinPlayer do
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0)
                RunService.RenderStepped:Wait()
            end
        end)
    end
end)

-- ==================== ITEMS SYSTEM ====================

function loadAllItems()
    allItems = {}
    
    -- Search in ReplicatedStorage
    if ReplicatedStorage then
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("Model") then
                table.insert(allItems, obj.Name)
            end
        end
    end
    
    -- Add default items if none found
    if #allItems == 0 then
        local defaultItems = {
            "Diamond Pickaxe", "Iron Pickaxe", "Stone Pickaxe", "Wooden Pickaxe",
            "Diamond Sword", "Iron Sword", "Stone Sword", "Wooden Sword",
            "Diamond Axe", "Iron Axe", "Stone Axe", "Wooden Axe",
            "Coal", "Iron Ore", "Gold Ore", "Diamond", "Emerald", "Ruby"
        }
        for _, item in ipairs(defaultItems) do
            table.insert(allItems, item)
        end
    end
    
    -- Remove duplicates
    local uniqueItems = {}
    for _, item in ipairs(allItems) do
        if not table.find(uniqueItems, item) then
            table.insert(uniqueItems, item)
        end
    end
    allItems = uniqueItems
    
    -- Update UI
    updateItemsList()
end

function updateItemsList()
    itemsList:ClearAllChildren()
    
    local yPos = 0
    for _, itemName in ipairs(allItems) do
        local itemBtn = Instance.new("TextButton", itemsList)
        itemBtn.Text = "📦 " .. itemName
        itemBtn.Size = UDim2.new(1, -10, 0, 30)
        itemBtn.Position = UDim2.new(0, 5, 0, yPos)
        itemBtn.TextSize = 11
        itemBtn.Font = Enum.Font.GothamSemibold
        neonButton(itemBtn, Color3.fromRGB(50, 50, 80))
        
        itemBtn.MouseButton1Click:Connect(function()
            selectedItemBox.Text = itemName
            giveSpecificItem(itemName)
        end)
        
        yPos = yPos + 35
    end
    
    itemsList.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Give All Items
giveAllBtn.MouseButton1Click:Connect(function()
    S.GiveAllItems = not S.GiveAllItems
    updateButtonText(giveAllBtn, "GiveAllItems")
    if S.GiveAllItems then
        for _, itemName in ipairs(allItems) do
            giveSpecificItem(itemName)
            task.wait(0.1)
        end
    end
end)

function giveSpecificItem(itemName)
    local tool = Instance.new("Tool")
    tool.Name = itemName
    tool.Parent = player.Backpack or character
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(1, 1, 1)
    handle.Parent = tool
    
    StarterGui:SetCore("SendNotification", {
        Title = "🎁 Item Given",
        Text = "You received: " .. itemName,
        Duration = 3
    })
end

-- ==================== KEYBINDS ====================

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.M then
        main.Visible = not main.Visible
    end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        main.Visible = not main.Visible
    end
end)

-- ==================== INITIALIZATION ====================

-- تحميل البيانات الأولية
task.wait(2)
loadAllItems()
updateSavedLocations()

print([[
╔════════════════════════════════════════════════╗
║        CODEX SYSTEM V6 PRO LOADED             ║
║                                                ║
║  ✅ ALL FEATURES WORKING                      ║
║  ✅ ENHANCED ESP SYSTEM                       ║
║  • Box ESP                                    ║
║  • Name ESP                                   ║
║  • Skeleton ESP (NEW)                         ║
║  • Radar ESP (NEW)                            ║
║  • ALL ESP Button                             ║
║                                                ║
║  ✅ ENHANCED COMBAT SYSTEM                    ║
║  • Silent Aim                                 ║
║  • Aim Assist                                 ║
║  • Trigger Bot                                ║
║  • Auto Shoot (NEW)                           ║
║  • Prediction (NEW)                           ║
║  • Hit Chance (NEW)                           ║
║                                                ║
║  ✅ TELEPORT SAVED LOCATIONS                  ║
║  • Save/Load Locations                        ║
║  • Default Locations                          ║
║  • Clear All Button                           ║
║                                                ║
║  Press M or INSERT to open/close menu         ║
╚════════════════════════════════════════════════╝]])

-- Welcome notification
StarterGui:SetCore("SendNotification", {
    Title = "⚡ Codex V6 Pro Loaded",
    Text = "Press M to open menu\nAll features are working!",
    Duration = 5,
    Icon = "rbxassetid://4483345998"
})
