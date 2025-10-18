local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5

local walkSpeedSlider = Instance.new("TextBox", frame)
walkSpeedSlider.Size = UDim2.new(1, 0, 0, 30)
walkSpeedSlider.Position = UDim2.new(0, 0, 0, 10)
walkSpeedSlider.Text = "Walk Speed (default 16)"
walkSpeedSlider.TextColor3 = Color3.new(1, 1, 1)

local flyToggle = Instance.new("TextButton", frame)
flyToggle.Size = UDim2.new(1, 0, 0, 30)
flyToggle.Position = UDim2.new(0, 0, 0, 50)
flyToggle.Text = "Toggle Fly"
flyToggle.TextColor3 = Color3.new(1, 1, 1)

local jumpToggle = Instance.new("TextButton", frame)
jumpToggle.Size = UDim2.new(1, 0, 0, 30)
jumpToggle.Position = UDim2.new(0, 0, 0, 90)
jumpToggle.Text = "Toggle Infinite Jump"
jumpToggle.TextColor3 = Color3.new(1, 1, 1)

local flying = false
local infiniteJump = false

function setWalkSpeed(speed)
    player.Character.Humanoid.WalkSpeed = speed
end

walkSpeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(walkSpeedSlider.Text)
        if speed then
            setWalkSpeed(speed)
        end
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
