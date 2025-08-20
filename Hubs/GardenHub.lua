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
