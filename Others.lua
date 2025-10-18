local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local UIS = game:GetService("UserInputService")
local speed = 16
local flying = false
local jumpCount = 0
local maxJumps = 3

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local SpeedSlider = Instance.new("TextBox")
local FlyButton = Instance.new("TextButton")
local JumpButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 200)
Frame.Position = UDim2.new(0.5, -100, 0.5, -100)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)

SpeedSlider.Parent = Frame
SpeedSlider.Size = UDim2.new(1, 0, 0, 50)
SpeedSlider.Text = "Speed: " .. speed
SpeedSlider.FocusLost:Connect(function()
    speed = tonumber(SpeedSlider.Text) or speed
    SpeedSlider.Text = "Speed: " .. speed
end)

FlyButton.Parent = Frame
FlyButton.Size = UDim2.new(1, 0, 0, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 50)
FlyButton.Text = "Toggle Fly"
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        character.Humanoid.PlatformStand = true
    else
        character.Humanoid.PlatformStand = false
    end
end)

flyToggle.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)

        while flying do
            bodyVelocity.Velocity = Vector3.new(mouse.Hit.LookVector.X * 50, 50, mouse.Hit.LookVector.Z * 50)
            wait()
        end
        bodyVelocity:Destroy()
    end
end)

jumpToggle.MouseButton1Click:Connect(function()
    infiniteJump = not infiniteJump
    if infiniteJump then
        player.Character.Humanoid.JumpPower = 50
        player.Character.Humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Freefall then
                player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        player.Character.Humanoid.JumpPower = 50
    end
end)
