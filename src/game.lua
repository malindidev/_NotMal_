local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local isMobile = game:GetService("UserInputService").TouchEnabled
local isDesktop = game:GetService("UserInputService").MouseEnabled

local backgroundFrame = Instance.new("Frame")
backgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backgroundFrame.BackgroundTransparency = 0.5
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Parent = screenGui

local header = Instance.new("TextLabel")
header.Text = "BedWars PvP Enhancer"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.BackgroundTransparency = 1
header.Font = Enum.Font.GothamBold
header.TextSize = isMobile and 28 or 36
header.Position = UDim2.new(0.5, -header.TextBounds.X / 2, 0.05, 0)
header.Parent = screenGui


local glowHeader = Instance.new("ImageLabel")
glowHeader.Size = UDim2.new(1.1, 0, 1.1, 0)
glowHeader.Position = UDim2.new(0.5, -header.TextBounds.X / 2 - 5, 0.05, -5)
glowHeader.BackgroundTransparency = 1
glowHeader.Image = "rbxassetid://1497223858"  -- Glow texture
glowHeader.Parent = header

-- Add a Health Bar UI with Animations
local healthBarFrame = Instance.new("Frame")
healthBarFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
healthBarFrame.Size = UDim2.new(0.5, 0, 0.03, 0)
healthBarFrame.Position = UDim2.new(0.025, 0, 0.95, 0)
healthBarFrame.Parent = screenGui

local healthBarGlow = Instance.new("ImageLabel")
healthBarGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
healthBarGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
healthBarGlow.BackgroundTransparency = 1
healthBarGlow.Image = "rbxassetid://1497223858"  
healthBarGlow.Parent = healthBarFrame

-- Function to update Health Bar
game:GetService("RunService").Heartbeat:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        local healthPercentage = humanoid.Health / humanoid.MaxHealth
        healthBarFrame.Size = UDim2.new(healthPercentage, 0, 0.03, 0)
    end
end)

local combatStatsFrame = Instance.new("Frame")
combatStatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
combatStatsFrame.BackgroundTransparency = 0.5
combatStatsFrame.Size = UDim2.new(0.25, 0, 0.2, 0)
combatStatsFrame.Position = UDim2.new(0.025, 0, 0.75, 0)
combatStatsFrame.Parent = screenGui

-- Combat Stats Text for Kills
local killsLabel = Instance.new("TextLabel")
killsLabel.Text = "Kills: 0"
killsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
killsLabel.BackgroundTransparency = 1
killsLabel.Font = Enum.Font.GothamBold
killsLabel.TextSize = isMobile and 18 or 20
killsLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
killsLabel.Parent = combatStatsFrame

local hitsLabel = Instance.new("TextLabel")
hitsLabel.Text = "Hits: 0"
hitsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hitsLabel.BackgroundTransparency = 1
hitsLabel.Font = Enum.Font.GothamBold
hitsLabel.TextSize = isMobile and 18 or 20
hitsLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
hitsLabel.Parent = combatStatsFrame

local statsGlow = Instance.new("ImageLabel")
statsGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
statsGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
statsGlow.BackgroundTransparency = 1
statsGlow.Image = "rbxassetid://1497223858"  
statsGlow.Parent = combatStatsFrame

game.ReplicatedStorage.CombatEvents.KillEvent.OnClientEvent:Connect(function(kills)
    killsLabel.Text = "Kills: " .. kills
end)

game.ReplicatedStorage.CombatEvents.HitEvent.OnClientEvent:Connect(function(hits)
    hitsLabel.Text = "Hits: " .. hits
end)

local toggleButton = Instance.new("TextButton")
toggleButton.Text = "Toggle UI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  
toggleButton.Position = UDim2.new(0.85, 0, 0.95, 0)
toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = isMobile and 18 or 20
toggleButton.Parent = screenGui

local uiVisible = true
toggleButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    screenGui.Enabled = uiVisible
end)

local function applyBackgroundAnimation()
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
    local tweenGoal = {BackgroundTransparency = 0.3}
    local backgroundTween = tweenService:Create(backgroundFrame, tweenInfo, tweenGoal)
    backgroundTween:Play()
end

applyBackgroundAnimation()

-- Feature: Add Dynamic Weather Effect (Snow)
local function addSnowEffect()
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Texture = "rbxassetid://1481314182"  -- Snowflake texture
    particleEmitter.Rate = 50
    particleEmitter.Lifetime = NumberRange.new(2, 5)
    particleEmitter.Size = NumberSequence.new(0.2, 1.5)
    particleEmitter.Parent = player.Character:WaitForChild("HumanoidRootPart")
end

-- Apply snow effect dynamically
game:GetService("RunService").Heartbeat:Connect(function()
    addSnowEffect()
end)

-- Feature: Health Regeneration Animation
local regenBar = Instance.new("Frame")
regenBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)  -- Green for regen
regenBar.Size = UDim2.new(0.2, 0, 0.03, 0)
regenBar.Position = UDim2.new(0.025, 0, 0.9, 0)
regenBar.Parent = screenGui

game:GetService("RunService").Heartbeat:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health < humanoid.MaxHealth then
        regenBar.Size = UDim2.new((humanoid.Health + 10) / humanoid.MaxHealth, 0, 0.03, 0)  
    end
end)
