-- GardenHub Script - Spawn Pet مع GUI مخفي/ظاهر

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GardenHubGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.35, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🌱 GardenHub - Spawn Pet"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.Parent = Frame

-- إدخال اسم الحيوان
local PetNameInput = Instance.new("TextBox")
PetNameInput.Size = UDim2.new(0.8,0,0,35)
PetNameInput.Position = UDim2.new(0.1,0,0.2,0)
PetNameInput.PlaceholderText = "✍️ اكتب اسم الحيوان"
PetNameInput.Parent = Frame

-- إدخال الوزن
local PetWeightInput = Instance.new("TextBox")
PetWeightInput.Size = UDim2.new(0.8,0,0,35)
PetWeightInput.Position = UDim2.new(0.1,0,0.35,0)
PetWeightInput.PlaceholderText = "⚖️ الوزن (رقم)"
PetWeightInput.Parent = Frame

-- إدخال العمر
local PetAgeInput = Instance.new("TextBox")
PetAgeInput.Size = UDim2.new(0.8,0,0,35)
PetAgeInput.Position = UDim2.new(0.1,0,0.5,0)
PetAgeInput.PlaceholderText = "📅 العمر (رقم)"
PetAgeInput.Parent = Frame

-- زر Spawn Pet
local SpawnPet = Instance.new("TextButton")
SpawnPet.Size = UDim2.new(0.8,0,0,40)
SpawnPet.Position = UDim2.new(0.1,0,0.7,0)
SpawnPet.Text = "Spawn Pet 🐾"
SpawnPet.Parent = Frame

-- زر إخفاء / إظهار GUI
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.15,0,0,30)
ToggleButton.Position = UDim2.new(0.85,0,0,0)
ToggleButton.Text = "👁️"
ToggleButton.Parent = Frame

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- وظيفة زر Spawn Pet
SpawnPet.MouseButton1Click:Connect(function()
    local name = PetNameInput.Text
    local weight = tonumber(PetWeightInput.Text)
    local age = tonumber(PetAgeInput.Text)

    if name == "" then
        warn("✋ اكتب اسم الحيوان")
        return
    end
    if not weight then
        warn("⚠️ الوزن لازم يكون رقم")
        return
    end
    if not age then
        warn("⚠️ العمر لازم يكون رقم")
        return
    end

    -- البحث عن الحيوان في workspace أو ReplicatedStorage
    local petModel = workspace:FindFirstChild(name) or ReplicatedStorage:FindFirstChild(name)
    if not petModel then
        warn("❌ الحيوان غير موجود في ملفات اللعبة")
        return
    end

    local clone = petModel:Clone()
    clone.Parent = workspace

    if clone.PrimaryPart then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            clone:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0,0,-5))
        end
    end

    -- إضافة Attributes
    clone:SetAttribute("Weight", weight)
    clone:SetAttribute("Age", age)

    print("✅ تم رسبن الحيوان:", name, "وزنه:", weight, "عمره:", age)
end)
