# 99 Nights in the Forest - Roblox Script

local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local sackEquipped = false
local guiEnabled = true

local function toggleGui()
    guiEnabled = not guiEnabled
    -- Code to show/hide GUI
end

local function onItemEquipped(item)
    if sackEquipped and guiEnabled then
        item.Parent = backpack:FindFirstChild("Sack") -- Move item to sack
    end
end

local sack = Instance.new("Tool")
sack.Name = "Sack"
sack.RequiresHandle = false
sack.Equipped:Connect(function()
    sackEquipped = true
end)

sack.Unequipped:Connect(function()
    sackEquipped = false
end)

local guiButton = Instance.new("TextButton")
guiButton.Text = "Toggle GUI"
guiButton.MouseButton1Click:Connect(toggleGui)

-- Add GUI button to player's screen
local playerGui = player:WaitForChild("PlayerGui")
guiButton.Parent = playerGui

-- Connect item pickup
game.Workspace.ChildAdded:Connect(function(item)
    if item:IsA("Tool") then
        item.Activated:Connect(function()
            onItemEquipped(item)
        end)
    end
end)
