-- bbm.lua - النسخة النهائية المتكاملة

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "D7H_GUI_Final"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 380)
Frame.Position = UDim2.new(0.35,0,0.25,0)
Frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
Frame.Active = true
Frame.Draggable = true -- قابلة للتحريك
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🌱 D7H - Spawn Pet"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.Parent = Frame

-- Dropdown لاختيار الحيوان
local PetDropdown = Instance.new("TextButton")
PetDropdown.Size = UDim2.new(0.8,0,0,35)
PetDropdown.Position = UDim2.new(0.1,0,0.2,0)
PetDropdown.Text = "اختر الحيوان ▼"
PetDropdown.Parent = Frame

local PetList = Instance.new("ScrollingFrame")
PetList.Size = UDim2.new(0.8,0,0.2,0)
PetList.Position = UDim2.new(0.1,0,0.3,0)
PetList.CanvasSize = UDim2.new(0,0,0,0)
PetList.Visible = false
PetList.BackgroundColor3 = Color3.fromRGB(60,60,60)
PetList.Parent = Frame

-- مربعات الوزن والعمر
local PetWeightInput = Instance.new("TextBox")
PetWeightInput.Size = UDim2.new(0.8,0,0,35)
PetWeightInput.Position = UDim2.new(0.1,0,0.55,0)
PetWeightInput.PlaceholderText = "⚖️ الوزن (رقم)"
PetWeightInput.Parent = Frame

local PetAgeInput = Instance.new("TextBox")
PetAgeInput.Size = UDim2.new(0.8,0,0,35)
PetAgeInput.Position = UDim2.new(0.1,0,0.65,0)
PetAgeInput.PlaceholderText = "📅 العمر (رقم)"
PetAgeInput.Parent = Frame

-- زر Spawn Pet
local SpawnPet = Instance.new("TextButton")
SpawnPet.Size = UDim2.new(0.8,0,0,40)
SpawnPet.Position = UDim2.new(0.1,0,0.78,0)
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

-- جلب الحيوانات من ReplicatedStorage.Pets
local function GetAvailablePets()
    local pets = {}
    local petsFolder = ReplicatedStorage:FindFirstChild("Pets")
    if petsFolder then
        for _,v in ipairs(petsFolder:GetChildren()) do
            if v:IsA("Model") then
                table.insert(pets, v.Name)
            end
        end
    end
    return pets
end

-- ملأ قائمة Dropdown
local function PopulateDropdown()
    PetList:ClearAllChildren()
    local pets = GetAvailablePets()
    local y = 0
    for _,name in ipairs(pets) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,0,0,30)
        btn.Position = UDim2.new(0,0,0,y)
        btn.Text = name
        btn.Parent = PetList
        y = y + 30
        btn.MouseButton1Click:Connect(function()
            PetDropdown.Text = name .. " ▼"
            PetList.Visible = false
        end)
    end
    PetList.CanvasSize = UDim2.new(0,0,0,y)
end

PetDropdown.MouseButton1Click:Connect(function()
    PetList.Visible = not PetList.Visible
    PopulateDropdown()
end)

-- زر Spawn Pet
SpawnPet.MouseButton1Click:Connect(function()
    local petName = PetDropdown.Text:gsub(" ▼","")
    local weight = tonumber(PetWeightInput.Text)
    local age = tonumber(PetAgeInput.Text)

    if petName == "" then warn("✋ اختر الحيوان") return end
    if not weight then warn("⚠️ الوزن لازم رقم") return end
    if not age then warn("⚠️ العمر لازم رقم") return end

    local petsFolder = ReplicatedStorage:FindFirstChild("Pets")
    if not petsFolder then warn("❌ لا يوجد مجلد Pets في ReplicatedStorage") return end

    local petModel = petsFolder:FindFirstChild(petName)
    if not petModel then warn("❌ الحيوان غير موجود") return end

    local clone = petModel:Clone()
    clone.Parent = workspace
    if clone.PrimaryPart then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            clone:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0,0,-5))
        end
    end
    clone:SetAttribute("Weight", weight)
    clone:SetAttribute("Age", age)
    print("✅ تم رسبن الحيوان:", petName, "وزنه:", weight, "عمره:", age)
end)
