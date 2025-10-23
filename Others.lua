-- Define a table to store the click counts for each object
local clickStorage = {}

-- Function to handle the click event
local function onObjectClicked(object)
    -- Check if the object is already in the storage
    if not clickStorage[object.Name] then
        clickStorage[object.Name] = 0
    end
    
    -- Increment the click count for the object
    clickStorage[object.Name] = clickStorage[object.Name] + 1
    
    -- Print the current click count for debugging purposes
    print(object.Name .. " has been clicked " .. clickStorage[object.Name] .. " times.")
end

-- Function to set up the click event for each object
local function setupClickEvents()
    -- Get all objects in the workspace
    local objects = game.Workspace:GetChildren()
    
    for _, object in ipairs(objects) do
        -- Ensure the object is clickable (e.g., a part)
        if object:IsA("Part") then
            -- Connect the click event to the onObjectClicked function
            object.ClickDetector.MouseClick:Connect(function(player)
                onObjectClicked(object)
            end)
        end
    end
end

-- Call the setup function to initialize click events
setupClickEvents()
