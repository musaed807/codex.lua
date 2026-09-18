-- ======================== Visual UI Library betöltése ========================
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/VisualRoblox/Roblox/main/UI-Libraries/Visual%20UI%20Library/Source.lua'))()

local Window = Library:CreateWindow('scrap.hook', 'Universal', 'scrap.hook', 'rbxassetid://107929497431351', false, 'VisualUIConfigs', 'Default')

-- ======================== Fő fülek ========================
-- Main fül (eredeti tartalom)
--[[local MainTab = Window:CreateTab('Main', true, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local Section = MainTab:CreateSection('Section')
local Label = Section:CreateLabel('Label')
local Paragraph = Section:CreateParagraph('Paragraph', 'Content')
local Button = Section:CreateButton('Button', function()
    print('Button Pressed')
end)
local Slider = Section:CreateSlider('Slider', 1, 100, 50, Color3.fromRGB(0, 125, 255), function(Value)
    print(Value)
end)
local Textbox = Section:CreateTextbox('Textbox', 'Input', function(Value)
    print(Value)
end)
local Keybind = Section:CreateKeybind('Keybind', 'F', function()
    print('Key Pressed')
end)
local Toggle = Section:CreateToggle('Toggle', true, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    print(Value)
end)
local Dropdown = Section:CreateDropdown('Dropdown', {'1', '2', '3', '4', '5'}, '1', 0.25, function(Value)
    print(Value)
end)
local Colorpicker = Section:CreateColorpicker('Colorpicker', Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    print(Value)
end)
local Image = Section:CreateImage('Image', 'rbxassetid://10618928818', UDim2.new(0, 200, 0, 200))

local UpdateSection = MainTab:CreateSection('Update Functions')
local LabelBox = UpdateSection:CreateTextbox('Update Label', 'New Text', function(Value)
    Label:UpdateLabel(Value, true)
end)
local ParagraphBox = UpdateSection:CreateTextbox('Update Paragraph', 'New Text', function(Value)
    Paragraph:UpdateParagraph('Paragraph', Value)
end)
local UpdateDropdown1 = UpdateSection:CreateButton('Update Dropdown 1', function()
    Dropdown:UpdateDropdown({'1', '2', '3'})
end)
local UpdateDropdown2 = UpdateSection:CreateButton('Update Dropdown 2', function()
    Dropdown:UpdateDropdown({'1', '2', '3', '4', '5', '6'})
end)
local UpdateImage = UpdateSection:CreateButton('Update Image', function()
    Image:UpdateImage('rbxassetid://10580575081', UDim2.new(0, 200, 0, 200))
end)]]

-- Library Functions fül (UI vezérlők, config)
local LibraryFunctions = Window:CreateTab('UI Functions', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local UIFunctions = LibraryFunctions:CreateSection('UI Functions')
local DestroyButton = UIFunctions:CreateButton('Destroy UI', function()
    Library:DestroyUI()
end)
local ToggleKeybind = UIFunctions:CreateKeybind('Toggle UI', 'E', function()
    Library:ToggleUI()
end)
--[[local TextboxKeybind = UIFunctions:CreateTextbox('Notification', 'Text', function(Value)
    Library:CreateNotification('Notification', Value, 5)
end)
local TransparencySlider = UIFunctions:CreateSlider('Transparency', 0, 100, 0, Color3.fromRGB(0, 125, 255), function(Value)
    Library:SetTransparency(Value / 100, true)
end)
local TextPromptButton = UIFunctions:CreateButton('Create Text Prompt', function()
    Library:CreatePrompt('Text', 'Prompt Title', 'Prompt Text', 'Alright')
end)
local OneButtonPromptButton = UIFunctions:CreateButton('Create One Button Prompt', function()
    Library:CreatePrompt('OneButton', 'Prompt Title', 'Prompt Text', {
        'Alright',
        function()
            print('Prompt Button Pressed')
        end
    })
end)
local TwoButtonPromptButton = UIFunctions:CreateButton('Create Two Button Prompt', function()
    Library:CreatePrompt('TwoButton', 'Prompt Title', 'Prompt Text', {
        'Button 1',
        function()
            print('Button 1')
        end,
        'Button 2',
        function()
            print('Button 2')
        end
    })
end)]]

-- Config szekció (a Library saját configjaihoz)
local ConfigSection = LibraryFunctions:CreateSection('Config')
local ConfigNameString = ''
local ConfigName = ConfigSection:CreateTextbox('Config Name', 'Input', function(Value)
    ConfigNameString = Value
end)
local SaveConfigButton = ConfigSection:CreateButton('Save Config', function()
    Library:SaveConfig(ConfigNameString)
end)
local SelectedConfig = ''
local ConfigsDropdown = ConfigSection:CreateDropdown('Configs', Library:GetConfigs(), nil, 0.25, function(Value)
    SelectedConfig = Value
end)
local DeleteConfigButton = ConfigSection:CreateButton('Delete Config', function()
    Library:DeleteConfig(SelectedConfig)
end)
local LoadConfigButton = ConfigSection:CreateButton('Load Config', function()
    Library:LoadConfig(SelectedConfig)
end)
local RefreshConfigsButton = ConfigSection:CreateButton('Refresh', function()
    ConfigsDropdown:UpdateDropdown(Library:GetConfigs())
end)

local ThemesSection = LibraryFunctions:CreateSection('Themes')
local ThemesDropdown = ThemesSection:CreateDropdown('Themes', Library:GetThemes(), nil, 0.25, function(Value)
    Library:ChangeTheme(Value)
end)

local ColorSection = LibraryFunctions:CreateSection('Custom Colors')
for Index, CurrentColor in next, Library:ReturnTheme() do
    ColorSection:CreateColorpicker(Index, CurrentColor, 0.25, function(Color)
        Library:ChangeColor(Index, Color)
    end, {true})
end

-- ======================== SILENT AIM FÜL ========================
local SilentAimTab = Window:CreateTab('Silent Aim', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local SilentAimSettings = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    HitChance = 100,
    FOVVisible = false,
    FOVRadius = 130,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165
}
getgenv().SilentAimSettings = SilentAimSettings

-- ======================== SILENT AIM FUNKCIONALITÁS (pcall-ben) ========================
local SilentAimLoaded = false

pcall(function()
    print("Silent Aim betöltése...")
    local g = getinfo or debug.getinfo
    local d = false
    local h = {}
    local x, y
    setthreadidentity(2)

    for i, v in getgc(true) do
        if typeof(v) == "table" then
            local a = rawget(v, "Detected")
            local b = rawget(v, "Kill")
            if typeof(a) == "function" and not x then
                x = a
                local o; o = hookfunction(x, function(c, f, n)
                    if c ~= "_" then
                        if d then
                            warn("Adonis ac")
                        end
                    end
                    return true
                end)
                table.insert(h, x)
            end
            if rawget(v, "Variables") and rawget(v, "Process") and typeof(b) == "function" and not y then
                y = b
                local o; o = hookfunction(y, function(f)
                    if d then
                        warn("Adonis idk")
                    end
                end)
                table.insert(h, y)
            end
        end
    end

    local o; o = hookfunction(getrenv().debug.info, newcclosure(function(...)
        local a, f = ...
        if x and a == x then
            if d then
                warn("adonis bypassed")
            end
            return coroutine.yield(coroutine.running())
        end
        return o(...)
    end))
    setthreadidentity(7)

    if not game:IsLoaded() then game.Loaded:Wait() end
    if not syn or not protectgui then
        getgenv().protectgui = function() end
    end

    local Camera = workspace.CurrentCamera
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local HttpService = game:GetService("HttpService")

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()

    local GetPlayers = Players.GetPlayers
    local WorldToScreen = Camera.WorldToScreenPoint
    local WorldToViewportPoint = Camera.WorldToViewportPoint
    local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
    local FindFirstChild = game.FindFirstChild
    local RenderStepped = RunService.RenderStepped
    local GetMouseLocation = UserInputService.GetMouseLocation

    local resume = coroutine.resume 
    local create = coroutine.create

    local ValidTargetParts = {"Head", "HumanoidRootPart"}

    -- Drawing objektumok (csak akkor hozzuk létre, ha létezik a Drawing)
    local mouse_box, fov_circle
    if Drawing then
        mouse_box = Drawing.new("Square")
        mouse_box.Visible = true 
        mouse_box.ZIndex = 999 
        mouse_box.Color = Color3.fromRGB(54, 57, 241)
        mouse_box.Thickness = 20 
        mouse_box.Size = Vector2.new(20, 20)
        mouse_box.Filled = true 

        fov_circle = Drawing.new("Circle")
        fov_circle.Thickness = 1
        fov_circle.NumSides = 100
        fov_circle.Radius = 180
        fov_circle.Filled = false
        fov_circle.Visible = false
        fov_circle.ZIndex = 999
        fov_circle.Transparency = 1
        fov_circle.Color = Color3.fromRGB(54, 57, 241)
    end

    local ExpectedArguments = {
        FindPartOnRayWithIgnoreList = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean", "boolean" } },
        FindPartOnRayWithWhitelist = { ArgCountRequired = 3, Args = { "Instance", "Ray", "table", "boolean" } },
        FindPartOnRay = { ArgCountRequired = 2, Args = { "Instance", "Ray", "Instance", "boolean", "boolean" } },
        Raycast = { ArgCountRequired = 3, Args = { "Instance", "Vector3", "Vector3", "RaycastParams" } }
    }

    function CalculateChance(Percentage)
        Percentage = math.floor(Percentage)
        local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
        return chance <= Percentage / 100
    end

    -- Fájlkezelés
    local MainFileName = "UniversalSilentAim"
    if not isfolder(MainFileName) then makefolder(MainFileName) end
    if not isfolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId))) then
        makefolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId)))
    end

    local function GetFiles()
        local Files = listfiles(string.format("%s/%s", MainFileName, tostring(game.PlaceId)))
        local out = {}
        for i = 1, #Files do
            local file = Files[i]
            if file:sub(-4) == '.lua' then
                local pos = file:find('.lua', 1, true)
                local start = pos
                local char = file:sub(pos, pos)
                while char ~= '/' and char ~= '\\' and char ~= '' do
                    pos = pos - 1
                    char = file:sub(pos, pos)
                end
                if char == '/' or char == '\\' then
                    table.insert(out, file:sub(pos + 1, start - 1))
                end
            end
        end
        return out
    end

    local function UpdateFile(FileName)
        assert(FileName and type(FileName) == "string", "oopsies")
        writefile(string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName), HttpService:JSONEncode(SilentAimSettings))
    end

    local function LoadFile(FileName)
        assert(FileName and type(FileName) == "string", "oopsies")
        local File = string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName)
        local ConfigData = HttpService:JSONDecode(readfile(File))
        for Index, Value in next, ConfigData do
            SilentAimSettings[Index] = Value
        end
    end

    local function getPositionOnScreen(Vector)
        local Vec3, OnScreen = WorldToScreen(Camera, Vector)
        return Vector2.new(Vec3.X, Vec3.Y), OnScreen
    end

    local function ValidateArguments(Args, RayMethod)
        local Matches = 0
        if #Args < RayMethod.ArgCountRequired then return false end
        for Pos, Argument in next, Args do
            if typeof(Argument) == RayMethod.Args[Pos] then
                Matches = Matches + 1
            end
        end
        return Matches >= RayMethod.ArgCountRequired
    end

    local function getDirection(Origin, Position)
        return (Position - Origin).Unit * 1000
    end

    local function getMousePosition()
        return GetMouseLocation(UserInputService)
    end

    local function IsPlayerVisible(Player)
        local PlayerCharacter = Player.Character
        local LocalPlayerCharacter = LocalPlayer.Character
        if not (PlayerCharacter or LocalPlayerCharacter) then return end
        local PlayerRoot = FindFirstChild(PlayerCharacter, SilentAimSettings.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
        if not PlayerRoot then return end
        local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
        local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
        return ObscuringObjects == 0
    end

    local function getClosestPlayer()
        if not SilentAimSettings.TargetPart then return end
        local Closest, DistanceToMouse
        for _, Player in next, GetPlayers(Players) do
            if Player == LocalPlayer then continue end
            if SilentAimSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end

            local Character = Player.Character
            if not Character then continue end
            
            if SilentAimSettings.VisibleCheck and not IsPlayerVisible(Player) then continue end

            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")
            if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then continue end

            local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
            if not OnScreen then continue end

            local Distance = (getMousePosition() - ScreenPosition).Magnitude
            if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius or 2000) then
                local targetPart = SilentAimSettings.TargetPart
                if targetPart == "Random" then
                    Closest = Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]
                else
                    Closest = Character[targetPart]
                end
                DistanceToMouse = Distance
            end
        end
        return Closest
    end

    -- Silent Aim render loop (rajzolás) – csak ha van Drawing
    if Drawing then
        resume(create(function()
            RenderStepped:Connect(function()
                if SilentAimSettings.ShowSilentAimTarget and SilentAimSettings.Enabled and mouse_box then
                    local target = getClosestPlayer()
                    if target then
                        local Root = target.Parent.PrimaryPart or target
                        local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position)
                        mouse_box.Visible = IsOnScreen
                        mouse_box.Position = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
                    else
                        mouse_box.Visible = false
                    end
                elseif mouse_box then
                    mouse_box.Visible = false
                end

                if SilentAimSettings.FOVVisible and fov_circle then
                    fov_circle.Visible = true
                    fov_circle.Position = getMousePosition()
                    fov_circle.Radius = SilentAimSettings.FOVRadius
                elseif fov_circle then
                    fov_circle.Visible = false
                end
            end)
        end))
    end

    -- Silent Aim hookok
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local Method = getnamecallmethod()
        local Arguments = {...}
        local self = Arguments[1]
        local chance = CalculateChance(SilentAimSettings.HitChance)
        if SilentAimSettings.Enabled and self == workspace and not checkcaller() and chance == true then
            if Method == "FindPartOnRayWithIgnoreList" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                    local A_Ray = Arguments[2]
                    local HitPart = getClosestPlayer()
                    if HitPart then
                        local Origin = A_Ray.Origin
                        local Direction = getDirection(Origin, HitPart.Position)
                        Arguments[2] = Ray.new(Origin, Direction)
                        return oldNamecall(unpack(Arguments))
                    end
                end
            elseif Method == "FindPartOnRayWithWhitelist" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRayWithWhitelist) then
                    local A_Ray = Arguments[2]
                    local HitPart = getClosestPlayer()
                    if HitPart then
                        local Origin = A_Ray.Origin
                        local Direction = getDirection(Origin, HitPart.Position)
                        Arguments[2] = Ray.new(Origin, Direction)
                        return oldNamecall(unpack(Arguments))
                    end
                end
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and SilentAimSettings.SilentAimMethod:lower() == Method:lower() then
                if ValidateArguments(Arguments, ExpectedArguments.FindPartOnRay) then
                    local A_Ray = Arguments[2]
                    local HitPart = getClosestPlayer()
                    if HitPart then
                        local Origin = A_Ray.Origin
                        local Direction = getDirection(Origin, HitPart.Position)
                        Arguments[2] = Ray.new(Origin, Direction)
                        return oldNamecall(unpack(Arguments))
                    end
                end
            elseif Method == "Raycast" and SilentAimSettings.SilentAimMethod == Method then
                if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
                    local A_Origin = Arguments[2]
                    local HitPart = getClosestPlayer()
                    if HitPart then
                        Arguments[3] = getDirection(A_Origin, HitPart.Position)
                        return oldNamecall(unpack(Arguments))
                    end
                end
            end
        end
        return oldNamecall(...)
    end))

    local oldIndex = nil 
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
        if self == Mouse and not checkcaller() and SilentAimSettings.Enabled and SilentAimSettings.SilentAimMethod == "Mouse.Hit/Target" and getClosestPlayer() then
            local HitPart = getClosestPlayer()
            if Index == "Target" or Index == "target" then 
                return HitPart
            elseif Index == "Hit" or Index == "hit" then 
                if SilentAimSettings.MouseHitPrediction then
                    return HitPart.CFrame + (HitPart.Velocity * SilentAimSettings.MouseHitPredictionAmount)
                else
                    return HitPart.CFrame
                end
            elseif Index == "X" or Index == "x" then 
                return self.X 
            elseif Index == "Y" or Index == "y" then 
                return self.Y 
            elseif Index == "UnitRay" then 
                return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
            end
        end
        return oldIndex(self, Index)
    end))

    SilentAimLoaded = true
    print("Silent Aim sikeresen betöltve")
end)

if not SilentAimLoaded then
    print("Silent Aim nem tölthető be (a környezet nem támogatja) – a többi funkció működik")
    Library:CreateNotification('Figyelmeztetés', 'Silent Aim nem támogatott ezen az executoron', 5)
end

-- ======================== SILENT AIM UI (Visual UI) ========================
local GeneralSection = SilentAimTab:CreateSection('General')
local ToggleEnabled = GeneralSection:CreateToggle('Enabled', SilentAimSettings.Enabled, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.Enabled = Value
end)
local ToggleTeamCheck = GeneralSection:CreateToggle('Team Check', SilentAimSettings.TeamCheck, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.TeamCheck = Value
end)
local ToggleVisibleCheck = GeneralSection:CreateToggle('Visible Check', SilentAimSettings.VisibleCheck, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.VisibleCheck = Value
end)
local TargetPartDropdown = GeneralSection:CreateDropdown('Target Part', {'Head', 'HumanoidRootPart', 'Random'}, SilentAimSettings.TargetPart, 0.25, function(Value)
    SilentAimSettings.TargetPart = Value
end)
local MethodDropdown = GeneralSection:CreateDropdown('Silent Aim Method', {
    'Raycast', 'FindPartOnRay', 'FindPartOnRayWithWhitelist',
    'FindPartOnRayWithIgnoreList', 'Mouse.Hit/Target'
}, SilentAimSettings.SilentAimMethod, 0.25, function(Value)
    SilentAimSettings.SilentAimMethod = Value
end)
local HitChanceSlider = GeneralSection:CreateSlider('Hit Chance', 1, 100, SilentAimSettings.HitChance, Color3.fromRGB(0, 125, 255), function(Value)
    SilentAimSettings.HitChance = Value
end)

local PredictionSection = SilentAimTab:CreateSection('Prediction')
local TogglePrediction = PredictionSection:CreateToggle('Mouse.Hit/Target Prediction', SilentAimSettings.MouseHitPrediction, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.MouseHitPrediction = Value
end)
local PredictionAmountSlider = PredictionSection:CreateSlider('Prediction Amount', 165, 1000, math.floor(SilentAimSettings.MouseHitPredictionAmount * 1000), Color3.fromRGB(0, 125, 255), function(Value)
    SilentAimSettings.MouseHitPredictionAmount = Value / 1000
end)

local VisualsSection = SilentAimTab:CreateSection('Visuals')
local ToggleFOV = VisualsSection:CreateToggle('Show FOV Circle', SilentAimSettings.FOVVisible, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.FOVVisible = Value
end)
local FOVRadiusSlider = VisualsSection:CreateSlider('FOV Radius', 1, 360, SilentAimSettings.FOVRadius, Color3.fromRGB(0, 125, 255), function(Value)
    SilentAimSettings.FOVRadius = Value
end)
local ToggleShowTarget = VisualsSection:CreateToggle('Show Silent Aim Target', SilentAimSettings.ShowSilentAimTarget, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    SilentAimSettings.ShowSilentAimTarget = Value
end)

-- Silent Aim konfiguráció


-- ======================== PLAYER FÜL (Walkspeed, FOV, Fly, Noclip) ========================
local PlayerTab = Window:CreateTab('Player', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local WalkspeedEnabled = false
local WalkspeedValue = 16
local FOVEnabled = false
local FOVValue = 70
local FlyEnabled = false
local NoClipEnabled = false
local FlySpeed = 50

-- Walkspeed
local MovementSection = PlayerTab:CreateSection('Movement')
local WalkspeedToggle = MovementSection:CreateToggle('Enable Walkspeed Mod', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    WalkspeedEnabled = Value
end)
local WalkspeedSlider = MovementSection:CreateSlider('Walkspeed', 1, 1000, 16, Color3.fromRGB(0, 125, 255), function(Value)
    WalkspeedValue = Value
end)



-- FOV
local CameraSection = PlayerTab:CreateSection('Camera')
local FOVToggle = CameraSection:CreateToggle('Enable FOV Mod', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    FOVEnabled = Value
end)
local FOVSlider = CameraSection:CreateSlider('FOV', 1, 120, 70, Color3.fromRGB(0, 125, 255), function(Value)
    FOVValue = Value
end)


-- Fly
local FlySection = PlayerTab:CreateSection('Fly')
local FlyToggle = FlySection:CreateToggle('Enable Fly', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    FlyEnabled = Value
    if not Value then
        local char = game.Players.LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = hrp:FindFirstChild("FlyVelocity")
                if bv then bv:Destroy() end
                local gyro = hrp:FindFirstChild("FlyGyro")
                if gyro then gyro:Destroy() end
            end
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.PlatformStand = false
                hum.AutoRotate = true
                hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            end
        end
        workspace.Gravity = 196.2
    end
end)

local FlySpeedSlider = FlySection:CreateSlider('Fly Speed', 1, 500, 50, Color3.fromRGB(0, 125, 255), function(Value)
    FlySpeed = Value
end)

local LocalPlayer = game.Players.LocalPlayer
-- Noclip
-- ======================== NOCLIP (0.1s ismétlés) ========================
local NoClipSection = PlayerTab:CreateSection('Noclip')
local NoClipEnabled = false

local NoClipToggle = NoClipSection:CreateToggle('Enable Noclip', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    NoClipEnabled = Value
    if Value then
        Library:CreateNotification('Noclip', '✅ Noclip enabled', 4)
    else
        Library:CreateNotification('Noclip', '❌ Noclip disabled', 4)
    end
end)

-- Noclip funkció
local function ApplyNoclip()
    local char = LocalPlayer.Character
    if not char then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- 0.1 másodperces ismétlés
spawn(function()
    while true do
        if NoClipEnabled then
            ApplyNoclip()
        end
        task.wait(0.1)
    end
end)

-- Respawn esetén is működjön
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if NoClipEnabled then
        ApplyNoclip()
    end
end)

-- Frissítő ciklus a Player funkciókhoz
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
    -- Walkspeed
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if WalkspeedEnabled then
                hum.WalkSpeed = WalkspeedValue
            else
                if hum.WalkSpeed == WalkspeedValue then
                    hum.WalkSpeed = 16
                end
            end
        end
    end

    -- FOV
    if FOVEnabled then
        Camera.FieldOfView = FOVValue
    else
        if Camera.FieldOfView == FOVValue then
            Camera.FieldOfView = 70
        end
    end

    -- Fly – Q = fel, R = le
    if FlyEnabled then
        char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")
            if hrp and hum then
                hum.PlatformStand = true
                hum.AutoRotate = false
                workspace.Gravity = 0

                local bv = hrp:FindFirstChild("FlyVelocity")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "FlyVelocity"
                    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.Parent = hrp
                end

                local gyro = hrp:FindFirstChild("FlyGyro")
                if not gyro then
                    gyro = Instance.new("BodyGyro")
                    gyro.Name = "FlyGyro"
                    gyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                    gyro.P = 10000
                    gyro.D = 1000
                    gyro.Parent = hrp
                end

                local lookDir = Camera.CFrame.LookVector
                local upVec = Vector3.new(0, 1, 0)
                if math.abs(lookDir:Dot(upVec)) > 0.999 then
                    upVec = Camera.CFrame.RightVector
                end
                local targetCF = CFrame.lookAt(hrp.Position, hrp.Position + lookDir, upVec)
                gyro.CFrame = targetCF

                local moveDir = Vector3.new()
                local forward = Camera.CFrame.LookVector
                local right = Camera.CFrame.RightVector
                local up = Camera.CFrame.UpVector

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + forward end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - forward end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - right end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + right end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveDir = moveDir + up end
                if UserInputService:IsKeyDown(Enum.KeyCode.R) then moveDir = moveDir - up end

if moveDir.Magnitude > 0 then
    moveDir = moveDir.Unit * FlySpeed
end

                bv.Velocity = moveDir
            end
        end
    end
end)

-- ======================== ESP FÜL (Box nélkül) ========================
local ESPTab = Window:CreateTab('ESP', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

-- ESP beállítások
local ESPEnabled = false
local ESPName = true
local ESPHealth = true
local ESPDistance = true
local ESPChams = true

-- Univerzális szín
local UniversalColor = Color3.fromRGB(0, 200, 255)

-- ESP objektumok tároló
local ESPObjects = {}

-- ESP szekció
local ESPSection = ESPTab:CreateSection('ESP Settings')

-- Enable ESP toggle
local ESPToggle = ESPSection:CreateToggle('Enable ESP', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    ESPEnabled = Value
    if not Value then
        for player, obj in pairs(ESPObjects) do
            if obj.text then obj.text:Remove() end
            if obj.highlight then obj.highlight:Destroy() end
        end
        table.clear(ESPObjects)
    end
end)

-- Toggle-ek
local NameToggle = ESPSection:CreateToggle('Name', true, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    ESPName = Value
end)

local HealthToggle = ESPSection:CreateToggle('Health', true, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    ESPHealth = Value
end)

local DistanceToggle = ESPSection:CreateToggle('Distance', true, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    ESPDistance = Value
end)

local ChamsToggle = ESPSection:CreateToggle('Chams', true, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    ESPChams = Value
    if not Value then
        for player, obj in pairs(ESPObjects) do
            if obj.highlight then
                obj.highlight:Destroy()
                obj.highlight = nil
            end
        end
    end
end)

-- Univerzális színválasztó
local UniversalColorPicker = ESPSection:CreateColorpicker('Universal ESP Color', UniversalColor, 0.25, function(Color)
    UniversalColor = Color
    for player, obj in pairs(ESPObjects) do
        if obj.text then
            obj.text.Color = Color
        end
        if obj.highlight then
            obj.highlight.FillColor = Color
            obj.highlight.OutlineColor = Color
        end
    end
end)

-- Különálló színválasztó a Chams-hoz
local ChamsColorPicker = ESPSection:CreateColorpicker('Chams Color (optional)', UniversalColor, 0.25, function(Color)
    for player, obj in pairs(ESPObjects) do
        if obj.highlight then
            obj.highlight.FillColor = Color
            obj.highlight.OutlineColor = Color
        end
    end
end)

-- ======================== ESP FUNKCIONALITÁS ========================
local function CreateESPObjects(player)
    if not ESPEnabled then return end
    if player == LocalPlayer then return end
    if ESPObjects[player] then return end

    local objects = {}

    -- Szöveg (Drawing.Text)
    if Drawing then
        local text = Drawing.new("Text")
        text.Visible = false
        text.ZIndex = 1000
        text.Color = UniversalColor
        text.Size = 11
        text.Center = true
        text.Outline = true
        text.OutlineColor = Color3.fromRGB(0, 0, 0)
        objects.text = text
    end

    -- Chams (Highlight)
    local function setupHighlight(char)
        if not char then return end
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.FillColor = UniversalColor
        highlight.OutlineColor = UniversalColor
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Adornee = char
        highlight.Parent = char
        objects.highlight = highlight
    end

    if player.Character then
        setupHighlight(player.Character)
    end

    local charConn
    charConn = player.CharacterAdded:Connect(function(char)
        if ESPObjects[player] and ESPObjects[player].highlight then
            ESPObjects[player].highlight:Destroy()
        end
        if ESPObjects[player] then
            setupHighlight(char)
        end
    end)
    objects.CharacterAddedConnection = charConn

    ESPObjects[player] = objects
end

local function RemoveESPObjects(player)
    local obj = ESPObjects[player]
    if obj then
        if obj.text then obj.text:Remove() end
        if obj.highlight then obj.highlight:Destroy() end
        if obj.CharacterAddedConnection then
            obj.CharacterAddedConnection:Disconnect()
        end
        ESPObjects[player] = nil
    end
end

-- Játékosok kezelése
local function OnPlayerAdded(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        if ESPEnabled then
            CreateESPObjects(player)
        end
    end)
    if ESPEnabled then
        CreateESPObjects(player)
    end
end

local function OnPlayerRemoving(player)
    RemoveESPObjects(player)
end

-- Események
Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- Szöveg tartalom és objektumok frissítése (0.1 másodperc)
local function UpdateESPContent()
    while task.wait(0.1) do
        if not ESPEnabled then
            for player, obj in pairs(ESPObjects) do
                if obj.text then obj.text.Visible = false end
                if obj.highlight then obj.highlight.Enabled = false end
            end
            continue
        end

        -- Ellenőrizzük, hogy minden játékoshoz léteznek-e az objektumok
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not ESPObjects[player] then
                CreateESPObjects(player)
            end
        end

        local localChar = LocalPlayer.Character
        if not localChar then continue end
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then continue end

        for player, obj in pairs(ESPObjects) do
            if not player then
                RemoveESPObjects(player)
                continue
            end

            local char = player.Character
            if not char then
                if obj.text then obj.text.Visible = false end
                if obj.highlight then obj.highlight.Enabled = false end
                continue
            end

            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChild("Humanoid")

            if not hrp or not hum then
                if obj.text then obj.text.Visible = false end
                if obj.highlight then obj.highlight.Enabled = false end
                continue
            end

            -- Szöveg tartalmának összeállítása
            local textParts = {}
            if ESPName then
                table.insert(textParts, player.DisplayName .. " @" .. player.Name)
            end
            if ESPHealth then
                local healthPercent = math.floor((hum.Health / hum.MaxHealth) * 100)
                table.insert(textParts, healthPercent .. "/100%")
            end
            if ESPDistance then
                local distance = (localRoot.Position - hrp.Position).Magnitude
                table.insert(textParts, math.floor(distance) .. " studs")
            end

            local fullText = table.concat(textParts, " | ")
            if obj.text then
                if #textParts > 0 and ESPEnabled then
                    obj.text.Text = fullText
                    obj.text.Visible = true
                else
                    obj.text.Visible = false
                end
            end

            if obj.highlight then
                obj.highlight.Enabled = ESPChams and ESPEnabled
            end
        end
    end
end

-- Pozíció frissítés (minden frame – smooth követés)
local function UpdateESPPosition()
    RunService.RenderStepped:Connect(function()
        if not ESPEnabled then
            return
        end

        for player, obj in pairs(ESPObjects) do
            if not player or not player.Character then
                continue
            end

            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local head = char:FindFirstChild("Head")

            if not hrp or not head then
                if obj.text then obj.text.Visible = false end
                continue
            end

            local hrpPos, hrpOnScreen = Camera:WorldToViewportPoint(hrp.Position)
            local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position)

            if not hrpOnScreen or not headOnScreen then
                if obj.text then obj.text.Visible = false end
                continue
            end

            if obj.text and obj.text.Visible then
                obj.text.Position = Vector2.new(hrpPos.X, headPos.Y - 18)
            end
        end
    end)
end

coroutine.wrap(UpdateESPContent)()
UpdateESPPosition()

-- ======================== AIMBOT FÜL ========================
-- ======================== AIMBOT FÜL ========================
local AimbotTab = Window:CreateTab('Aimbot', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local AimbotSettings = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    FOVRadius = 150,
    Smoothness = 6,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    ShowTargetBox = true,
    HoldKey = Enum.KeyCode.X,
    ShowFOV = true
}
getgenv().AimbotSettings = AimbotSettings

-- ==================== UI ====================
local AimbotGeneralSection = AimbotTab:CreateSection('General')

local AimbotToggle = AimbotGeneralSection:CreateToggle('Aimbot Enabled', AimbotSettings.Enabled, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.Enabled = Value
end)

-- Hold Key (stabil verzió)
local AimbotHoldKey = AimbotGeneralSection:CreateKeybind('Hold Key (you cant change it)', 'X', function(Key)
    if Key and Enum.KeyCode[Key] then
        AimbotSettings.HoldKey = Enum.KeyCode[Key]
        print("[Aimbot] Hold Key changed to: " .. Key)
    end
end)

local AimbotTeamCheck = AimbotGeneralSection:CreateToggle('Team Check', AimbotSettings.TeamCheck, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.TeamCheck = Value
end)

local AimbotVisibleCheck = AimbotGeneralSection:CreateToggle('Visible Check', AimbotSettings.VisibleCheck, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.VisibleCheck = Value
end)

local AimbotTargetPart = AimbotGeneralSection:CreateDropdown('Target Part', {'Head', 'HumanoidRootPart', 'Random'}, AimbotSettings.TargetPart, 0.25, function(Value)
    AimbotSettings.TargetPart = Value
end)

-- FOV Settings
local AimbotFOVSection = AimbotTab:CreateSection('FOV Settings')

local AimbotFOVToggle = AimbotFOVSection:CreateToggle('Show FOV Circle', AimbotSettings.ShowFOV, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.ShowFOV = Value
end)

local AimbotFOVRadius = AimbotFOVSection:CreateSlider('FOV Radius', 50, 400, AimbotSettings.FOVRadius, Color3.fromRGB(0, 125, 255), function(Value)
    AimbotSettings.FOVRadius = Value
end)

-- Prediction & Visuals
local AimbotPredictionSection = AimbotTab:CreateSection('Prediction & Visuals')

local AimbotPredToggle = AimbotPredictionSection:CreateToggle('Prediction', AimbotSettings.MouseHitPrediction, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.MouseHitPrediction = Value
end)

local AimbotPredAmount = AimbotPredictionSection:CreateSlider('Prediction Amount', 0, 500, math.floor(AimbotSettings.MouseHitPredictionAmount * 1000), Color3.fromRGB(0, 125, 255), function(Value)
    AimbotSettings.MouseHitPredictionAmount = Value / 1000
end)

local AimbotSmoothness = AimbotPredictionSection:CreateSlider('Smoothness', 1, 20, AimbotSettings.Smoothness, Color3.fromRGB(0, 125, 255), function(Value)
    AimbotSettings.Smoothness = Value
end)

local AimbotShowTarget = AimbotPredictionSection:CreateToggle('Show Target Box', AimbotSettings.ShowTargetBox, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AimbotSettings.ShowTargetBox = Value
end)

print("Aimbot UI betöltve")

-- ==================== DRAWING ====================
local aimbot_fov_circle, aimbot_target_box

if Drawing then
    aimbot_fov_circle = Drawing.new("Circle")
    aimbot_fov_circle.Thickness = 2
    aimbot_fov_circle.NumSides = 64
    aimbot_fov_circle.Color = Color3.fromRGB(0, 180, 255)
    aimbot_fov_circle.Transparency = 0.75
    aimbot_fov_circle.Filled = false
    aimbot_fov_circle.Visible = false

    aimbot_target_box = Drawing.new("Square")
    aimbot_target_box.Thickness = 2
    aimbot_target_box.Color = Color3.fromRGB(255, 50, 50)
    aimbot_target_box.Filled = false
    aimbot_target_box.Visible = false
end

-- ==================== AIMBOT LOGIKA ====================
local CurrentLockedTarget = nil

local function GetClosestPlayerInFOV()
    local Closest, ShortestDist = nil, AimbotSettings.FOVRadius
    for _, Player in next, Players:GetPlayers() do
        if Player == LocalPlayer then continue end
        if AimbotSettings.TeamCheck and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end

        local Humanoid = Character:FindFirstChild("Humanoid")
        local Part = Character:FindFirstChild(AimbotSettings.TargetPart)
        if not Humanoid or not Part or Humanoid.Health <= 0 then continue end

        if AimbotSettings.VisibleCheck then
            local Obscuring = #Camera:GetPartsObscuringTarget({Part.Position}, {LocalPlayer.Character, Character})
            if Obscuring > 0 then continue end
        end

        local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Part.Position)
        if not OnScreen then continue end

        local MousePos = UserInputService:GetMouseLocation()
        local Dist = (MousePos - Vector2.new(ScreenPos.X, ScreenPos.Y)).Magnitude

        if Dist <= ShortestDist then
            Closest = Part
            ShortestDist = Dist
        end
    end
    return Closest
end

RunService.RenderStepped:Connect(function()
    if aimbot_fov_circle then
        aimbot_fov_circle.Visible = AimbotSettings.Enabled and AimbotSettings.ShowFOV
        if aimbot_fov_circle.Visible then
            aimbot_fov_circle.Position = UserInputService:GetMouseLocation()
            aimbot_fov_circle.Radius = AimbotSettings.FOVRadius
        end
    end

    if not AimbotSettings.Enabled then
        CurrentLockedTarget = nil
        if aimbot_target_box then aimbot_target_box.Visible = false end
        return
    end

    if not UserInputService:IsKeyDown(AimbotSettings.HoldKey) then
        CurrentLockedTarget = nil
        if aimbot_target_box then aimbot_target_box.Visible = false end
        return
    end

    local targetPart = nil
    if CurrentLockedTarget and CurrentLockedTarget.Parent then
        local hum = CurrentLockedTarget.Parent:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            targetPart = CurrentLockedTarget
        else
            CurrentLockedTarget = nil
        end
    end

    if not targetPart then
        targetPart = GetClosestPlayerInFOV()
        if targetPart then CurrentLockedTarget = targetPart end
    end

    if not targetPart then
        if aimbot_target_box then aimbot_target_box.Visible = false end
        return
    end

    local targetPos = targetPart.Position
    if AimbotSettings.MouseHitPrediction and targetPart.Velocity then
        targetPos += targetPart.Velocity * AimbotSettings.MouseHitPredictionAmount
    end

    local cameraPos = Camera.CFrame.Position
    local targetCF = CFrame.lookAt(cameraPos, targetPos)

    local smooth = math.clamp(AimbotSettings.Smoothness / 12, 0.08, 1)
    Camera.CFrame = Camera.CFrame:Lerp(targetCF, smooth)

    if AimbotSettings.ShowTargetBox and aimbot_target_box then
        local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        if onScreen then
            aimbot_target_box.Visible = true
            aimbot_target_box.Position = Vector2.new(pos.X - 18, pos.Y - 18)
            aimbot_target_box.Size = Vector2.new(36, 36)
        else
            aimbot_target_box.Visible = false
        end
    end
end)

-- ======================== HITBOX EXPANDER ========================
local HitboxEnabled = false
local HitboxSize = 10
local HitboxTeamCheck = false

-- ======================== HITBOX EXPANDER FÜL ========================
-- ======================== HITBOX EXPANDER FÜL ========================
-- ======================== HITBOX EXPANDER FÜL ========================
-- ======================== HITBOX EXPANDER FÜL ========================
local HitboxTab = Window:CreateTab('Hitbox', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

local HitboxSection = HitboxTab:CreateSection('Hitbox Expander')

local HitboxToggle = HitboxSection:CreateToggle('Enable Hitbox Expander', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    HitboxEnabled = Value
    if not Value then
        ResetHitboxes()
    end
end)

local HitboxSizeSlider = HitboxSection:CreateSlider('Hitbox Size', 1, 50, 10, Color3.fromRGB(0, 125, 255), function(Value)
    HitboxSize = Value
    if HitboxEnabled then
        ResizeAllHitboxes()
    end
end)

local HitboxTeamToggle = HitboxSection:CreateToggle('Team Check', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    HitboxTeamCheck = Value
    if HitboxEnabled then
        ResizeAllHitboxes()
    end
end)

local ResetHitboxButton = HitboxSection:CreateButton('Reset All Hitboxes', function()
    ResetHitboxes()
end)

-- ======================== HITBOX FUNKCIÓK ========================
local OriginalSizes = {}

local function SaveOriginalSize(hrp)
    if hrp and not OriginalSizes[hrp] then
        OriginalSizes[hrp] = hrp.Size
    end
end

local function RemoveVisualizer(hrp)
    if hrp then
        local visualizer = hrp:FindFirstChild("HitboxVisualizer")
        if visualizer then
            visualizer:Destroy()
        end
    end
end

local function ResizeHitbox(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    SaveOriginalSize(hrp)

    if not HitboxEnabled then
        -- Teljes visszaállítás
        if OriginalSizes[hrp] then
            hrp.Size = OriginalSizes[hrp]
        else
            hrp.Size = Vector3.new(2, 2, 2)
        end
        hrp.Transparency = 0
        hrp.CanCollide = true
        hrp.Massless = false
        
        RemoveVisualizer(hrp)   -- ← Biztosan eltávolítja a piros keretet
        return
    end

    if HitboxTeamCheck and player.Team == LocalPlayer.Team then
        RemoveVisualizer(hrp)
        return
    end

    local desiredSize = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
    hrp.Size = desiredSize
    hrp.Transparency = 0.75
    hrp.CanCollide = false
    hrp.Massless = true

    if not hrp:FindFirstChild("HitboxVisualizer") then
        local visualizer = Instance.new("SelectionBox")
        visualizer.Name = "HitboxVisualizer"
        visualizer.Adornee = hrp
        visualizer.LineThickness = 0.05
        visualizer.Color3 = Color3.fromRGB(255, 50, 50)
        visualizer.Transparency = 0.5
        visualizer.Parent = hrp
    end
end

local function ResizeAllHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        ResizeHitbox(player)
    end
end

local function ResetHitboxes()
    HitboxEnabled = false
    if HitboxToggle then 
        HitboxToggle:UpdateToggle(false, true) 
    end
    
    OriginalSizes = {} -- Cache törlése
    
    for _, player in ipairs(Players:GetPlayers()) do
        ResizeHitbox(player)
    end
end

-- Render loop
RunService.RenderStepped:Connect(function()
    if HitboxEnabled then
        ResizeAllHitboxes()
    else
        -- Extra biztosítás: ha ki van kapcsolva, folyamatosan takarítson
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    RemoveVisualizer(hrp)
                end
            end
        end
    end
end)

-- Játékos kezelők
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        ResizeHitbox(player)
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        task.spawn(function()
            task.wait(1)
            ResizeHitbox(player)
        end)
    end
    player.CharacterAdded:Connect(function()
        task.wait(1)
        ResizeHitbox(player)
    end)
end

local OtherTab = Window:CreateTab('Other', false, 'rbxassetid://3926305904', Vector2.new(524, 44), Vector2.new(36, 36))

-- ======================== CLIENT ANTI-KICK ========================
local AntiKickEnabled = false
local oldKickFunction
local oldIndexHook
local oldNamecallHook

local function EnableAntiKick()
    if AntiKickEnabled then return end

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    if hookfunction then
        oldKickFunction = hookfunction(LocalPlayer.Kick, function() end)
    end

    oldIndexHook = hookmetamethod(game, "__index", function(self, method)
        if self == LocalPlayer and typeof(method) == "string" and method:lower() == "kick" then
            return error("Expected ':' not '.' calling member function Kick", 2)
        end
        return oldIndexHook(self, method)
    end)

    oldNamecallHook = hookmetamethod(game, "__namecall", function(self, ...)
        if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
            return
        end
        return oldNamecallHook(self, ...)
    end)

    AntiKickEnabled = true
    print("[Anti-Kick] activated")
end



-- Anti-Kick UI
local AntiKickSection = OtherTab:CreateSection('Other')


local AntiKickToggle = AntiKickSection:CreateToggle('Enable Client Anti-Kick', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    AntiKickEnabled = Value
    if Value then
        EnableAntiKick()
        Library:CreateNotification('Anti-Kick', '🟢 Client Anti-kick enabled', 5)
    else
        Library:CreateNotification('Anti-Kick', '🔴 Client Anti-kick disabled', 5)
    end
end)

local AntiKickInfo = AntiKickSection:CreateLabel('Protects you aganist kicks from localscripts')
-- cobalt
local cobalt = AntiKickSection:CreateButton('Cobalt', function()
    Library:CreateNotification('Cobalt', '⌛ Loading Cobalt.', 5)
    loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
end)

local CobaltInfo = AntiKickSection:CreateLabel('Allows you to see in- and outcoming network traffic')

-- fullbright


-- Fullbright funkciók
local function ApplyFullbright()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.FogEnd = 1000000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1

    for _, v in pairs(Lighting:GetDescendants()) do
        if v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then
            v:Destroy()
        end
    end
end

local function EnableFullbright()
    FullbrightEnabled = true
    ApplyFullbright()

    -- Folyamatos loop
    if FullbrightLoop then FullbrightLoop:Disconnect() end

    FullbrightLoop = game:GetService("RunService").RenderStepped:Connect(function()
        if FullbrightEnabled then
            ApplyFullbright()
        else
            if FullbrightLoop then 
                FullbrightLoop:Disconnect() 
            end
        end
    end)
end

local function DisableFullbright()
    FullbrightEnabled = false
    if FullbrightLoop then
        FullbrightLoop:Disconnect()
        FullbrightLoop = nil
    end

    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    Lighting.Ambient = Color3.fromRGB(128, 128, 128)
end

local FullbrightToggle = AntiKickSection:CreateToggle('Enable Fullbright', false, Color3.fromRGB(0, 125, 255), 0.25, function(Value)
    FullbrightEnabled = Value
    if Value then
        EnableFullbright()
        Library:CreateNotification('Fullbright', '🟢 Fullbright enabled', 5)
    else
        DisableFullbright()
        Library:CreateNotification('Fullbright', '🔴 Fullbright disabled', 5)
    end
end)

local cobalt = AntiKickSection:CreateButton('Explorer', function()
    Library:CreateNotification('Explorer', '⌛ Loading Explorer.', 5)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)

local ExplorerInfo = AntiKickSection:CreateLabel('Open a Roblox Studio like Client Sided explorer')

-- ======================== TELEPORT TO PLAYER ========================
local TeleportSection = PlayerTab:CreateSection('Teleport')

local TeleportPlayerName = ""  -- ide mentjük a beírt nevet

local TeleportTextbox = TeleportSection:CreateTextbox('Player Username', 'Type in a players name...', function(Value)
    TeleportPlayerName = Value
end)

local TeleportButton = TeleportSection:CreateButton('Teleport to Player', function()
    local targetName = TeleportPlayerName
    
    if targetName and targetName ~= "" then
        local targetPlayer = nil
        
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Name:lower() == targetName:lower() or 
               (plr.DisplayName and plr.DisplayName:lower() == targetName:lower()) then
                targetPlayer = plr
                break
            end
        end

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local LocalChar = LocalPlayer.Character
            if LocalChar and LocalChar:FindFirstChild("HumanoidRootPart") then
                LocalChar.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                Library:CreateNotification('Teleport', '✅ Teleported to: ' .. targetPlayer.Name, 5)
            else
                Library:CreateNotification('Teleport', '❌ You dont have a character', 5)
            end
        else
            Library:CreateNotification('Teleport', '❌ Couldnt find: ' .. targetName, 5)
        end
    else
        Library:CreateNotification('Teleport', '❌ Put in a players name', 5)
    end
end)

local TeleportInfo = TeleportSection:CreateLabel('Write display, or username here')

-- ======================== JUMPPOWER ========================
local JumpPowerSection = PlayerTab:CreateSection('JumpPower')

local DefaultJumpPower = 50
local JumpPowerValue = 50

-- Alapérték lekérése a jelenlegi karakterből
local function GetCurrentJumpPower()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            DefaultJumpPower = hum.JumpPower
            JumpPowerValue = hum.JumpPower
            return hum.JumpPower
        end
    end
    return 50
end

-- Inicializálás
GetCurrentJumpPower()

local JumpPowerTextbox = JumpPowerSection:CreateTextbox('JumpPower', 'Type JumpPower value (number)', function(Value)
    local num = tonumber(Value)
    if num then
        JumpPowerValue = num
    end
end)

local SetJumpPowerButton = JumpPowerSection:CreateButton('Set JumpPower', function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = JumpPowerValue
            Library:CreateNotification('JumpPower', '✅ Set JumpPower: ' .. JumpPowerValue, 5)
        end
    else
        Library:CreateNotification('JumpPower', '❌ You dont have a character', 5)
    end
end)

local ResetJumpPowerButton = JumpPowerSection:CreateButton('Reset to Default', function()
    JumpPowerValue = DefaultJumpPower
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = DefaultJumpPower
        end
    end
    Library:CreateNotification('JumpPower', '✅ Reseted to default: ' .. DefaultJumpPower, 5)
end)

local JumpPowerInfo = JumpPowerSection:CreateLabel('Default JumpPower: ' .. DefaultJumpPower)

-- ======================== WEAK EXECUTOR DETECTION ========================
local Executor = (identifyexecutor and identifyexecutor()) or "Unknown"
local LowerExec = Executor:lower()

print("[scrap.hook] Executor: " .. Executor)

-- Weak executor lista (itt tudod bővíteni)
local WeakExecutors = {
    ["xeno"] = true,
    ["solara"] = true,
    ["JJSploit"] = true
}

local IsWeak = false

for name, _ in pairs(WeakExecutors) do
    if LowerExec:find(name) then
        IsWeak = true
        break
    end
end

if IsWeak then
    Library:CreateNotification(
        '⚠️ Weak Executor Detected', 
        'Executor: ' .. Executor .. '\nSome features (Silent Aim, Cobalt, etc.) may not work properly.', 
        10
    )
    warn("[scrap.hook] Weak executor detected: " .. Executor)
elseif LowerExec == "unknown" then
    Library:CreateNotification(
        '⚠️ Unknown Executor', 
        'Some advanced features may not work.', 
        8
    )
end

-- ======================== VÉGE ========================
print("scrap.hook v0.1")
