local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.Name = "FakeChatGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Fake REAL Chat Bubble"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local nameBox = Instance.new("TextBox")
nameBox.Parent = frame
nameBox.Size = UDim2.new(0.8, 0, 0, 40)
nameBox.Position = UDim2.new(0.1, 0, 0.3, 0)
nameBox.PlaceholderText = "Player Name"
nameBox.Text = ""
nameBox.Font = Enum.Font.SourceSans
nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
nameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nameBox.TextScaled = true

local msgBox = Instance.new("TextBox")
msgBox.Parent = frame
msgBox.Size = UDim2.new(0.8, 0, 0, 40)
msgBox.Position = UDim2.new(0.1, 0, 0.5, 0)
msgBox.PlaceholderText = "Message"
msgBox.Text = ""
msgBox.Font = Enum.Font.SourceSans
msgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
msgBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
msgBox.TextScaled = true

local sendBtn = Instance.new("TextButton")
sendBtn.Parent = frame
sendBtn.Size = UDim2.new(0.8, 0, 0, 40)
sendBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
sendBtn.Text = "Send Fake Bubble"
sendBtn.Font = Enum.Font.SourceSansBold
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendBtn.TextScaled = true

-- Real Bubble Trigger
local function CreateRealBubble(playerName, message)
    local target = Players:FindFirstChild(playerName)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local BubbleChat = require(ReplicatedStorage:WaitForChild("ChatModules").ClientChatModules.BubbleChat) -- BubbleChat system (client side)
        if BubbleChat then
            BubbleChat.CreateBubble(target.Character.Head, message, Enum.ChatColor.White)
        end
    end
end

-- Fallback (safer way)
local function fallbackChat(target, message)
    local ChatService = game:GetService("Chat")
    ChatService:Chat(target.Character.Head, message, Enum.ChatColor.White)
end

-- When button clicked
sendBtn.MouseButton1Click:Connect(function()
    local name = nameBox.Text
    local msg = msgBox.Text

    local target = Players:FindFirstChild(name)
    if target and target.Character and target.Character:FindFirstChild("Head") then
        fallbackChat(target, msg)
    else
        warn("Player not found or no character")
    end
end)

-- Optional RGB frame
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        local color = Color3.fromHSV(hue, 1, 1)
        frame.BackgroundColor3 = color
        sendBtn.BackgroundColor3 = color
        title.BackgroundColor3 = color
    end
end)
