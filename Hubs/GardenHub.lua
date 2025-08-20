--🌱 GardenHub — Script كامل + زر يرسبن الحيوانات
do
    if getgenv and getgenv()._GARDEN_HUB_LOADED then return end
    if getgenv then getgenv()._GARDEN_HUB_LOADED = true end

    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local RunService = game:GetService("RunService")

    local Config = {
        Flags = {AutoHarvest=false, AutoReplant=false, AutoSell=false},
        UIKey=Enum.KeyCode.RightShift
    }

    local function notify(msg)
        pcall(function()
            game.StarterGui:SetCore("SendNotification", {Title="GardenHub", Text=tostring(msg), Duration=3})
        end)
        print("[GardenHub] "..msg)
    end

    -- واجهة بسيطة
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 300, 0, 260)
    Main.Position = UDim2.new(0.5, -150, 0.5, -130)
    Main.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Main.Active = true; Main.Draggable = true

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1,0,0,30); Title.Text="🌱 GardenHub"; Title.TextColor3=Color3.new(1,1,1)
    Title.Font=Enum.Font.GothamBold; Title.TextSize=18; Title.BackgroundTransparency=1

    local y = 40
    local function makeToggle(label, flagKey)
        local btn = Instance.new("TextButton", Main)
        btn.Size = UDim2.new(1,-20,0,30); btn.Position = UDim2.new(0,10,0,y); y=y+40
        btn.BackgroundColor3=Color3.fromRGB(60,60,60); btn.Text=label.." [OFF]"; btn.TextColor3=Color3.new(1,1,1)
        btn.Font=Enum.Font.Gotham; btn.TextSize=16
        btn.MouseButton1Click:Connect(function()
            Config.Flags[flagKey]=not Config.Flags[flagKey]
            btn.Text=label.." ["..(Config.Flags[flagKey] and "ON" or "OFF").."]"
            notify(label.." => "..(Config.Flags[flagKey] and "Enabled" or "Disabled"))
        end)
    end

    makeToggle("Auto Harvest","AutoHarvest")
    makeToggle("Auto Replant","AutoReplant")
    makeToggle("Auto Sell","AutoSell")

    -- زر يرسبن أي حيوان
    local spawnBtn = Instance.new("TextButton", Main)
    spawnBtn.Size = UDim2.new(1,-20,0,30); spawnBtn.Position = UDim2.new(0,10,0,y)
    spawnBtn.BackgroundColor3=Color3.fromRGB(100,60,60); spawnBtn.Text="Spawn Pet"; spawnBtn.TextColor3=Color3.new(1,1,1)
    spawnBtn.Font=Enum.Font.GothamBold; spawnBtn.TextSize=16
    spawnBtn.MouseButton1Click:Connect(function()
        local petName = "Cow" -- 👈 غيّر الاسم لأي حيوان موجود في اللعبة
        local storage = game:GetService("ReplicatedStorage")
        local petModel = storage:FindFirstChild(petName)
        if petModel and petModel:IsA("Model") then
            local clone = petModel:Clone()
            clone.Parent = workspace
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and clone.PrimaryPart then clone:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0,0,-5)) end
            notify("Spawned pet: "..petName)
        else
            notify("Pet not found: "..petName)
        end
    end)

    notify("GardenHub Loaded! Press "..Config.UIKey.Name.." to toggle UI.")
end
-- GardenHub Script (نسخة فيها اسم + وزن + عمر للحيوان)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

local PetNameInput = Instance.new("TextBox")
local PetWeightInput = Instance.new("TextBox")
local PetAgeInput = Instance.new("TextBox")
local SpawnPet = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- الإطار
Frame.Size = UDim2.new(0, 280, 0, 320)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Parent = ScreenGui

-- العنوان
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "GardenHub - Spawn Pet"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Parent = Frame

-- إدخال اسم الحيوان
PetNameInput.Size = UDim2.new(0.8, 0, 0, 35)
PetNameInput.Position = UDim2.new(0.1, 0, 0.2, 0)
PetNameInput.PlaceholderText = "✍️ اكتب اسم الحيوان"
PetNameInput.Text = ""
PetNameInput.Parent = Frame

-- إدخال الوزن
PetWeightInput.Size = UDim2.new(0.8, 0, 0, 35)
PetWeightInput.Position = UDim2.new(0.1, 0, 0.35, 0)
PetWeightInput.PlaceholderText = "⚖️ اكتب وزن الحيوان"
PetWeightInput.Text = ""
PetWeightInput.Parent = Frame

-- إدخال العمر
PetAgeInput.Size = UDim2.new(0.8, 0, 0, 35)
PetAgeInput.Position = UDim2.new(0.1, 0, 0.5, 0)
PetAgeInput.PlaceholderText = "📅 اكتب عمر الحيوان"
PetAgeInput.Text = ""
PetAgeInput.Parent = Frame

-- زر Spawn Pet
SpawnPet.Size = UDim2.new(0.8, 0, 0, 40)
SpawnPet.Position = UDim2.new(0.1, 0, 0.7, 0)
SpawnPet.Text = "Spawn Pet 🐾"
SpawnPet.Parent = Frame

-- الوظيفة عند الضغط
SpawnPet.MouseButton1Click:Connect(function()
    local name = PetNameInput.Text
    local weight = PetWeightInput.Text
    local age = PetAgeInput.Text

    if name ~= "" and weight ~= "" and age ~= "" then
        game.ReplicatedStorage.Remotes.SpawnPet:FireServer({
            Name = name,
            Weight = weight,
            Age = age
        })
    else
        warn("رجاءً اكتب (الاسم + الوزن + العمر) قبل الضغط")
    end
end)
