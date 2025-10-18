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

JumpButton.Parent = Frame
JumpButton.Size = UDim2.new(1, 0, 0, 50)
JumpButton.Position = UDim2.new(0, 0, 0, 100)
JumpButton.Text = "Jump"
JumpButton.MouseButton1Click:Connect(function()
    if jumpCount < maxJumps then
        character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        jumpCount = jumpCount + 1
    end
end)

CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(1, 0, 0, 50)
CloseButton.Position = UDim2.new(0, 0, 0, 150)
CloseButton.Text = "Close"
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Space then
            JumpButton:MouseButton1Click()
        end
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        local direction = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        character:Move(direction * speed)
    else
        character.Humanoid.WalkSpeed = speed
    end
end)

character.Humanoid.Jumping:Connect(function()
    if character.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        jumpCount = 0
    end
end)
