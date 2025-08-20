-- GardenHub Script (Spawn Pet: اسم + وزن + عمر)

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
