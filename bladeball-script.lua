-- Blade Ball Advanced Script with UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Configuration
local config = {
    autoParry = true,
    autoParryDelay = 0.05,
    autoParryDistance = 15,
    showUI = true,
    notifications = true,
    antiDetections = true,
    performanceMode = false,
    autoTarget = true,
    predictionEnabled = true
}

-- Anti-Detection Variables
local randomSeed = HttpService:GenerateGUID(false)
local function random(min, max)
    return math.random(min * 1000, max * 1000) / 1000
end

-- Notification System
local function notify(text, duration)
    if config.notifications then
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "[Blade Ball Pro] " .. text,
            Color = Color3.fromRGB(0, 255, 100),
            Font = Enum.Font.GothamBold,
            FontSize = Enum.FontSize.Size18
        })
    end
end

-- UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = randomSeed
screenGui.Parent = game:GetService("CoreGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.ClipsDescendants = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
titleLabel.BorderSizePixel = 0
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Blade Ball Pro"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Main Toggles
local parryToggle = Instance.new("TextButton")
parryToggle.Name = "ParryToggle"
parryToggle.Parent = mainFrame
parryToggle.BackgroundColor3 = config.autoParry and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
parryToggle.BorderSizePixel = 0
parryToggle.Position = UDim2.new(0, 20, 0, 60)
parryToggle.Size = UDim2.new(0, 150, 0, 40)
parryToggle.Font = Enum.Font.Gotham
parryToggle.Text = "Auto Parry: ON"
parryToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
parryToggle.TextSize = 14

local parryCorner = Instance.new("UICorner")
parryCorner.CornerRadius = UDim.new(0, 5)
parryCorner.Parent = parryToggle

local antiDetectToggle = Instance.new("TextButton")
antiDetectToggle.Name = "AntiDetectToggle"
antiDetectToggle.Parent = mainFrame
antiDetectToggle.BackgroundColor3 = config.antiDetections and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
antiDetectToggle.BorderSizePixel = 0
antiDetectToggle.Position = UDim2.new(0, 190, 0, 60)
antiDetectToggle.Size = UDim2.new(0, 150, 0, 40)
antiDetectToggle.Font = Enum.Font.Gotham
antiDetectToggle.Text = "Anti-Detect: ON"
antiDetectToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
antiDetectToggle.TextSize = 14

local antiDetectCorner = Instance.new("UICorner")
antiDetectCorner.CornerRadius = UDim.new(0, 5)
antiDetectCorner.Parent = antiDetectToggle

local targetToggle = Instance.new("TextButton")
targetToggle.Name = "TargetToggle"
targetToggle.Parent = mainFrame
targetToggle.BackgroundColor3 = config.autoTarget and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
targetToggle.BorderSizePixel = 0
targetToggle.Position = UDim2.new(0, 20, 0, 110)
targetToggle.Size = UDim2.new(0, 150, 0, 40)
targetToggle.Font = Enum.Font.Gotham
targetToggle.Text = "Auto Target: ON"
targetToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
targetToggle.TextSize = 14

local targetCorner = Instance.new("UICorner")
targetCorner.CornerRadius = UDim.new(0, 5)
targetCorner.Parent = targetToggle

local predictionToggle = Instance.new("TextButton")
predictionToggle.Name = "PredictionToggle"
predictionToggle.Parent = mainFrame
predictionToggle.BackgroundColor3 = config.predictionEnabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
predictionToggle.BorderSizePixel = 0
predictionToggle.Position = UDim2.new(0, 190, 0, 110)
predictionToggle.Size = UDim2.new(0, 150, 0, 40)
predictionToggle.Font = Enum.Font.Gotham
predictionToggle.Text = "Prediction: ON"
predictionToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
predictionToggle.TextSize = 14

local predictionCorner = Instance.new("UICorner")
predictionCorner.CornerRadius = UDim.new(0, 5)
predictionCorner.Parent = predictionToggle

-- Settings Frame
local settingsFrame = Instance.new("Frame")
settingsFrame.Name = "SettingsFrame"
settingsFrame.Parent = mainFrame
settingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
settingsFrame.BorderSizePixel = 0
settingsFrame.Position = UDim2.new(0, 20, 0, 170)
settingsFrame.Size = UDim2.new(0, 360, 0, 110)

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 5)
settingsCorner.Parent = settingsFrame

-- Delay Slider
local delayLabel = Instance.new("TextLabel")
delayLabel.Name = "DelayLabel"
delayLabel.Parent = settingsFrame
delayLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
delayLabel.BackgroundTransparency = 1
delayLabel.BorderSizePixel = 0
delayLabel.Position = UDim2.new(0, 10, 0, 10)
delayLabel.Size = UDim2.new(0, 100, 0, 20)
delayLabel.Font = Enum.Font.Gotham
delayLabel.Text = "Parry Delay: " .. config.autoParryDelay
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.TextSize = 12
delayLabel.TextXAlignment = Enum.TextXAlignment.Left

local delaySlider = Instance.new("TextBox")
delaySlider.Name = "DelaySlider"
delaySlider.Parent = settingsFrame
delaySlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
delaySlider.BorderSizePixel = 0
delaySlider.Position = UDim2.new(0, 10, 0, 35)
delaySlider.Size = UDim2.new(0, 100, 0, 25)
delaySlider.Font = Enum.Font.Gotham
delaySlider.Text = tostring(config.autoParryDelay)
delaySlider.TextColor3 = Color3.fromRGB(255, 255, 255)
delaySlider.TextSize = 12

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 3)
sliderCorner.Parent = delaySlider

-- Distance Slider
local distanceLabel = Instance.new("TextLabel")
distanceLabel.Name = "DistanceLabel"
distanceLabel.Parent = settingsFrame
distanceLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
distanceLabel.BackgroundTransparency = 1
distanceLabel.BorderSizePixel = 0
distanceLabel.Position = UDim2.new(0, 120, 0, 10)
distanceLabel.Size = UDim2.new(0, 100, 0, 20)
distanceLabel.Font = Enum.Font.Gotham
distance
