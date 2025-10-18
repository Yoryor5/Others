local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI
local screenGui = Instance.new("ScreenGui", playerGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(1, 0, 0.2, 0)
speedLabel.Text = "Walking Speed: 16"
speedLabel.TextColor3 = Color3.new(1, 1, 1)

local speedSlider = Instance.new("Slider", frame)
speedSlider.Size = UDim2.new(1, 0, 0.2, 0)
speedSlider.Position = UDim2.new(0, 0, 0.2, 0)
speedSlider.MinValue = 16
speedSlider.MaxValue = 100

local flyButton = Instance.new("TextButton", frame)
flyButton.Size = UDim2.new(1, 0, 0.2, 0)
flyButton.Position = UDim2.new(0, 0, 0.4, 0)
flyButton.Text = "Toggle Fly"

local jumpButton = Instance.new("TextButton", frame)
jumpButton.Size = UDim2.new(1, 0, 0.2, 0)
jumpButton.Position = UDim2.new(0, 0, 0.6, 0)
jumpButton.Text = "Jump Multiple Times"

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(1, 0, 0.2, 0)
closeButton.Position = UDim2.new(0, 0, 0.8, 0)
closeButton.Text = "Close"

-- Functionality
local function updateSpeed()
    local speed = speedSlider.Value
    player.Character.Humanoid.WalkSpeed = speed
    speedLabel.Text = "Walking Speed: " .. speed
end

local function toggleFly()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = not humanoid.PlatformStand
        end
    end
end

local function jumpMultipleTimes()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

-- Connect events
speedSlider.Changed:Connect(updateSpeed)
flyButton.MouseButton1Click:Connect(toggleFly)
jumpButton.MouseButton1Click:Connect(jumpMultipleTimes)
closeButton.MouseButton1Click:Connect(function() screenGui:Destroy() end)
