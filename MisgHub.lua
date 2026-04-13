local HttpService = game:GetService("HttpService")
local RbxAnalytics = game:GetService("RbxAnalyticsService")
local Player = game:GetService("Players").LocalPlayer

local MyHWID = RbxAnalytics:GetClientId()
local MyUser = Player.Name

-- YOUR LINKS
local GoogleWebApp = "https://script.google.com/macros/s/AKfycbxyGpyNSN2TTkglNBUJUYR0RMK_IGK5atqRwnBVvOFjq9wTatO7kLtQTJWr-FbVPO264w/exec"
local GitHubScript = "https://github.com/manuisgod-1231/add-LIST/raw/refs/heads/main/3/1.lua"

-- 1. Stealth GUI (Only for Access Denied)
local function showAccessGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MisgHub_Auth"
    ScreenGui.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainFrame.Size = UDim2.new(0, 300, 0, 200)
    Instance.new("UICorner", MainFrame)

    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.Text = "ACCESS DENIED"
    Title.TextColor3 = Color3.fromRGB(255, 70, 70)
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18

    local Info = Instance.new("TextLabel")
    Info.Parent = MainFrame
    Info.Text = "Please send your info to the owner.\nStatus: 0 (Not Allowed)"
    Info.TextColor3 = Color3.fromRGB(160, 160, 160)
    Info.Position = UDim2.new(0, 15, 0, 50)
    Info.Size = UDim2.new(1, -30, 0, 70)
    Info.BackgroundTransparency = 1
    Info.TextWrapped = true
    Info.Font = Enum.Font.Gotham
    Info.TextSize = 14

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Parent = MainFrame
    CopyBtn.Text = "Copy HWID:Username"
    CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CopyBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
    CopyBtn.Size = UDim2.new(0.8, 0, 0, 35)
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", CopyBtn)

    CopyBtn.MouseButton1Click:Connect(function()
        setclipboard(MyHWID .. ":" .. MyUser)
        CopyBtn.Text = "COPIED!"
        task.wait(2)
        CopyBtn.Text = "Copy HWID:Username"
    end)
end

-- 2. Check the Google Sheet (via Web App)
local function isWhitelisted()
    local success, response = pcall(function()
        return game:HttpGet(GoogleWebApp)
    end)

    if success then
        local data = HttpService:JSONDecode(response)
        -- Checks Column A (HWID) and looks at Column C (Value)
        if data[MyHWID] and (tostring(data[MyHWID]) == "1") then
            return true
        end
    end
    return false
end

-- 3. Execution
if isWhitelisted() then
    -- If Column C is 1, run your GitHub script
    loadstring(game:HttpGet(GitHubScript))()
else
    -- If Column C is 0 or HWID not found, show the GUI
    showAccessGui()
end
