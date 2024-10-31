local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local whitelistUrl = "https://raw.githubusercontent.com/STEVEPVPS69/LunarisBox/main/whitelist.json"

-- Fetch the whitelist
local success, response = pcall(function()
    return HttpService:GetAsync(whitelistUrl)
end)

if success then
    local whitelist = HttpService:JSONDecode(response)
    
    -- Check if the player's Username is whitelisted
    if whitelist[player.Name] then
        -- Run the main script if the player is whitelisted
        loadstring([[

        -- ====== PLACE YOUR SCRIPT BELOW THIS LINE ======
        -- Place this script in StarterPlayer > StarterPlayerScripts or StarterGui for LocalScript

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local startButton = Instance.new("TextButton")
local stopButton = Instance.new("TextButton")

-- Set up the GUI properties
screenGui.Parent = player:WaitForChild("PlayerGui")

frame.Name = "MainFrame"
frame.Parent = screenGui
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.25
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true

-- Title settings
title.Parent = frame
title.Text = "lunaris - box"
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

-- Start Button
startButton.Name = "StartButton"
startButton.Parent = frame
startButton.Text = "Start"
startButton.Size = UDim2.new(0, 80, 0, 40)
startButton.Position = UDim2.new(0, 10, 0, 50)
startButton.BackgroundColor3 = Color3.new(0, 1, 0)
startButton.Font = Enum.Font.SourceSansBold
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextSize = 18
startButton.BorderSizePixel = 0

-- Stop Button
stopButton.Name = "StopButton"
stopButton.Parent = frame
stopButton.Text = "Stop"
stopButton.Size = UDim2.new(0, 80, 0, 40)
stopButton.Position = UDim2.new(0, 110, 0, 50)
stopButton.BackgroundColor3 = Color3.new(1, 0, 0)
stopButton.Font = Enum.Font.SourceSansBold
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.TextSize = 18
stopButton.BorderSizePixel = 0

-- Coordinate definitions
local teleporting = false
local firstCoordinate = Vector3.new(-550.96, 3.54, -84.33)
local secondCoordinate = Vector3.new(-400.89, 3.36, -72.92)
local crateName = "Crate"

-- Teleport function to move exactly to a target
local function teleportToCoordinate(targetPos)
    local rootPart = player.Character:WaitForChild("HumanoidRootPart")
    while (rootPart.Position - targetPos).magnitude > 2 and teleporting do
        -- Calculate direction to move towards the target
        local direction = (targetPos - rootPart.Position).unit
        rootPart.CFrame = rootPart.CFrame + direction * 2  -- Move 2 studs towards the target
        wait(0.1)
    end
end

-- Key press simulation function
local function keyPress(key, holdTime)
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
    wait(holdTime)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
end

-- Main looping sequence
local function teleportSequence()
    teleporting = true
    local rootPart = player.Character:WaitForChild("HumanoidRootPart")
    local originalOrientation = rootPart.CFrame

    while teleporting do
        -- 1. Move to first coordinate
        teleportToCoordinate(firstCoordinate)
        keyPress("E", 1.5)

        -- 2. Move to second coordinate
        teleportToCoordinate(secondCoordinate)

        -- 3. Equip "Crate" item in the backpack
        local crate = player.Backpack:FindFirstChild(crateName)
        if crate then
            crate.Parent = player.Character  -- Equip "Crate"
        end

        -- 4. Flip player 180 degrees
        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.pi, 0)

        -- 5. Hold "E" for 1.5 seconds to trigger interaction
        keyPress("E", 1.5)

        -- 6. Move back to the first coordinate
        teleportToCoordinate(firstCoordinate)

        -- 7. Flip back to original orientation
        rootPart.CFrame = originalOrientation

        -- 8. Hold "E" for 1.5 seconds again
        keyPress("E", 1.5)
    end
end

-- Start button functionality
startButton.MouseButton1Click:Connect(function()
    if not teleporting then
        teleportSequence()
    end
end)

-- Stop button functionality
stopButton.MouseButton1Click:Connect(function()
    teleporting = false
end)

        -- ====== END OF CUSTOM SCRIPT ======
        
        ]])()
    else
        player:Kick("You are not whitelisted to use this script.")
    end
else
    player:Kick("Failed to fetch the whitelist. Please try again later.")
end
