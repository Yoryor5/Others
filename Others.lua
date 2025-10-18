# 99 Nights in the Forest - Movement and Speed GUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local speed = 16
local flying = false
local jumpCount = 0
local maxJumps = 3

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local SpeedSlider = Instance.new("Slider")
local FlyButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.5, -100, 0.5, -150)

SpeedSlider.Parent = Frame
SpeedSlider.Size = UDim2.new(1, 0, 0, 50)
SpeedSlider.MinValue = 16
SpeedSlider.MaxValue = 100
SpeedSlider.ValueChanged:Connect(function(value)
    speed = value
end)

FlyButton.Parent = Frame
FlyButton.Size = UDim2.new(1, 0, 0, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 60)
FlyButton.Text = "Toggle Fly"
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        player.Character.Humanoid.PlatformStand = true
        while flying do
            player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + (mouse.Hit.p - player.Character.HumanoidRootPart.Position).unit * speed
            wait()
        end
        player.Character.Humanoid.PlatformStand = false
    end
end)

JumpButton.Parent = Frame
JumpButton.Size = UDim2.new(1, 0, 0, 50)
JumpButton.Position = UDim2.new(0, 0, 0, 120)
JumpButton.Text = "Jump"
JumpButton.MouseButton1Click:Connect(function()
    if jumpCount < maxJumps then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        jumpCount = jumpCount + 1
    end
end)

CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(1, 0, 0, 50)
CloseButton.Position = UDim2.new(0, 0, 0, 180)
CloseButton.Text = "Close"
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sync with teammates
game.Players.PlayerAdded:Connect(function(teammate)
    teammate.CharacterAdded:Connect(function()
        teammate.Character.Humanoid.WalkSpeed = speed
    end)
end)

player.CharacterAdded:Connect(function(character)
    character.Humanoid.WalkSpeed = speed
end)
