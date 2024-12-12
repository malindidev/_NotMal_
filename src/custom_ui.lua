-- Custom UI script to add a button to the screen
local screenGui = Instance.new("ScreenGui")
local button = Instance.new("TextButton")

-- Set up the ScreenGui
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "EnhancementUI"

-- Set up the button
button.Size = UDim2.new(0.2, 0, 0.1, 0)
button.Position = UDim2.new(0.4, 0, 0.8, 0)
button.Text = "Click Me"
button.Parent = screenGui

-- Button functionality
button.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)
