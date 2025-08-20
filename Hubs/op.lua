-- op.lua - نسختك النهائية
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local LocalPlayer = Players.LocalPlayer

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OP_GUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 400)
Frame.Position = UDim2.new(0.3,0,0.25,0)
Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🌟 OP Pet Spawner"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.Parent = Frame

-- Dropdown لاختيار الحيوان
local PetDropdown = Instance.new("TextButton")
PetDropdown.Size = UDim2.new(0.8,0,0,35)
PetDropdown.Position = UDim2.new(0.1,0,0.15,0)
PetDropdown.Text = "اختر الحيوان ▼"
PetDropdown.Parent = Frame

local PetList = Instance.new("ScrollingFrame")
PetList.Size = UDim2.new(0.8,0,0.25,0)
PetList.Position = UDim2.new(0.1,0,0.25,0)
PetList.CanvasSize = UDim2.new(0,0,0,0)
PetList.Visible = false
PetList.BackgroundColor3 = Color3.fromRGB(60,60,60)
PetList.Parent = Frame

-- مربعات الوزن والعمر
local PetWeightInput = Instance.new("TextBox")
PetWeightInput.Size = UDim2.new(0.35,0,0,30)
PetWeightInput.Position = UDim2.new(0.1,0,0.55,0)
PetWeightInput.PlaceholderText = "⚖️ الوزن"
PetWeightInput.Parent = Frame

local PetAgeInput = Instance.new("TextBox")
PetAgeInput.Size = UDim2.new(0.35,0,0,30)
PetAgeInput.Position = UDim2.new(0.55,0,0.55,0)
PetAgeInput.PlaceholderText = "📅 العمر"
PetAgeInput.Parent = Frame

-- زر Spawn Pet
local SpawnPet = Instance.new("TextButton")
SpawnPet.Size = UDim2.new(0.8,0,0,40)
SpawnPet.Position = UDim2.new(0.1,0,0.68,0)
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

-- جلب كل الحيوانات من ReplicatedStorage + ServerStorage
local function GetAllPets()
    local pets = {}
    local folders = {ReplicatedStorage, ServerStorage}
    for _,folder in pairs(folders) do
        for _,v in pairs(folder:GetChildren()) do
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
    local pets = GetAllPets()
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

    -- البحث عن الحيوان في أي مجلد
    local petModel = ReplicatedStorage:FindFirstChild(petName) or ServerStorage:FindFirstChild(petName)
    if not petModel then warn("❌ الحيوان غير موجود") return end

    local clone = petModel:Clone()
    clone.Parent = workspace
    if clone.PrimaryPart and LocalPlayer.Character then
        clone:SetPrimaryPartCFrame(LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5))
    end
    clone:SetAttribute("Weight", weight)
    clone:SetAttribute("Age", age)
    print("✅ تم رسبن الحيوان:", petName, "وزنه:", weight, "عمره:", age)
end)
