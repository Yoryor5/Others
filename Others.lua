# 99 Nights in the Forest Storage System

local player = game.Players.LocalPlayer
local storage = player:WaitForChild("Storage")

local function onItemClicked(item)
    local itemClone = item:Clone()
    itemClone.Parent = storage
    item:Destroy()
end

for _, item in pairs(workspace.Items:GetChildren()) do
    item.MouseButton1Click:Connect(function()
        onItemClicked(item)
    end)
end
