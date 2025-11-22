local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
   
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 180)
mainFrame.Position = UDim2.new(0, 10, 0, 150)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
 
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 80, 0, 40)
miniFrame.Position = UDim2.new(0, 10, 0, 150)
miniFrame.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = screenGui

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(1, 0, 1, 0)
openButton.Position = UDim2.new(0, 0, 0, 0)
openButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
openButton.Text = "OPEN"
openButton.TextColor3 = Color3.fromRGB(255, 255, 0)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14
openButton.Parent = miniFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(200, 80, 0)
title.Text = "MAFIOZI NOCLIP"
title.TextColor3 = Color3.fromRGB(255, 255, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

local creator = Instance.new("TextLabel")
creator.Size = UDim2.new(1, 0, 0, 20)
creator.Position = UDim2.new(0, 0, 0, 30)
creator.BackgroundTransparency = 1
creator.Text = "By: Mafiozi Scripts"
creator.TextColor3 = Color3.fromRGB(255, 255, 0)
creator.Font = Enum.Font.Gotham
creator.TextSize = 12
creator.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 40)
status.Position = UDim2.new(0, 0, 0, 50)
status.BackgroundTransparency = 1
status.Text = "Status: OFF"
status.TextColor3 = Color3.fromRGB(255, 50, 50)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
toggleButton.Position = UDim2.new(0.1, 0, 0, 90)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
toggleButton.Text = "TOGGLE NOCLIP"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.Parent = mainFrame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0.2, 0, 0, 25)
minimizeButton.Position = UDim2.new(0.8, 0, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 0)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 16
minimizeButton.Parent = mainFrame

local noclip = false
local originalCollision = {}

local function toggleMinimize()
    if mainFrame.Visible then
       
        mainFrame.Visible = false
        miniFrame.Visible = true
        miniFrame.Position = mainFrame.Position
    else
        
        mainFrame.Visible = true
        miniFrame.Visible = false
        mainFrame.Position = miniFrame.Position
    end
end


local function toggleNoClip()
    noclip = not noclip
    
    if noclip then
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                originalCollision[part] = true
                part.CanCollide = false
            end
        end
        status.Text = "Status: ON"
        status.TextColor3 = Color3.fromRGB(50, 255, 50)
        toggleButton.Text = "DISABLE NOCLIP"
        print("NoClip: ON - You can walk through walls!")
    else
        
        for part, canCollide in pairs(originalCollision) do
            if part and part.Parent then
                part.CanCollide = canCollide
            end
        end
        originalCollision = {}
        status.Text = "Status: OFF"
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        toggleButton.Text = "ENABLE NOCLIP"
    end
end


toggleButton.MouseButton1Click:Connect(function()
    toggleNoClip()
end)

minimizeButton.MouseButton1Click:Connect(function()
    toggleMinimize()
end)

openButton.MouseButton1Click:Connect(function()
    toggleMinimize()
end)


game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)


player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    noclip = false
    originalCollision = {}
    status.Text = "Status: OFF"
    status.TextColor3 = Color3.fromRGB(255, 50, 50)
    toggleButton.Text = "ENABLE NOCLIP"
end)


game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
        toggleNoClip()
    end
end)

print("Mafiozi NoClip Script LOADED!")
print("Press N to toggle or use the button")
print("Press - to minimize")
