local Interface = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/refs/heads/main/UI/Interface.luau"
))()

local Library = Interface.Library
local SaveManager = Interface.SaveManager
local ThemeManager = Interface.ThemeManager

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Window = Library:CreateWindow({
	Title = "Catploit",
	Footer = "Catploit",
	NotifySide = "Right",
	ShowCustomCursor = false,
	AutoShow = true,
	Center = true,
	TabPadding = 3,
	MenuFadeTime = 0,
	CornerRadius = 2
})

local InfoTab = Window:AddTab("Info", "user")
local AutoFarmingTab = Window:AddTab("Auto/Farming", "refresh-cw")

Interface.ApplySettingsTab(Window)

local function GetExecutorInfo()
	local Name = "Unknown"
	local Version = "N/A"

	if type(identifyexecutor) == "function" then
		local Success, ExecutorName, ExecutorVersion = pcall(identifyexecutor)

		if Success then
			Name = ExecutorName or "Unknown"
			Version = ExecutorVersion or "N/A"
		end
	elseif type(getexecutorname) == "function" then
		local Success, ExecutorName = pcall(getexecutorname)

		if Success then
			Name = ExecutorName or "Unknown"
		end
	end

	return Name, Version
end

local function GetEnvironmentResults()
	local Results = {}

	local Checks = {
		{"request", type(request) == "function"},
		{"httpget", type(game.HttpGet) == "function"},
		{"loadstring", type(loadstring) == "function"},
		{"toclipboard", type(toclipboard) == "function" or type(setclipboard) == "function"},
		{"identifyexecutor", type(identifyexecutor) == "function" or type(getexecutorname) == "function"}
	}

	for _, Check in ipairs(Checks) do
		table.insert(
			Results,
			Check[1] .. ": " .. (Check[2] and "Supported" or "Unsupported")
		)
	end

	return Results
end

local User = InfoTab:AddLeftGroupbox("User Info")

local ImageSize = Enum.ThumbnailSize.Size420x420
local ImageType = Enum.ThumbnailType.HeadShot

local ThumbnailSuccess, Content = pcall(function()
	return Players:GetUserThumbnailAsync(
		LocalPlayer.UserId,
		ImageType,
		ImageSize
	)
end)

if ThumbnailSuccess and Content then
	User:AddImage("UserIcon", {
		Image = Content
	})
end

User:AddLabel("ID: " .. LocalPlayer.Name, true)
User:AddLabel("User ID: " .. tostring(LocalPlayer.UserId), true)

local Credits = InfoTab:AddRightGroupbox("Credits")

Credits:AddLabel(
	"<font color='rgb(0, 255, 255)'>Catploit — Main Script</font>",
	true
)

Credits:AddLabel(
	"<font color='rgb(255, 165, 0)'>Catploit — UI / Settings Structure</font>",
	true
)

Credits:AddLabel(
	"<font color='rgb(50, 205, 50)'>" .. LocalPlayer.Name .. " — For Using This Script</font>",
	true
)

local LatestChangelog = {
	"10/4/2026",
	"<font color='rgb(0, 255, 0)'>+ Added Cat Upgrader</font>",
	"<font color='rgb(0, 255, 0)'>+ Added Domo Cat, VIP, Orange, White, Black, Grey & Robo</font>",
	"<font color='rgb(255, 255, 0)'>~ Updated Catploit interface</font>"
}

local Changelog = InfoTab:AddRightGroupbox("Changelog")

for _, Change in ipairs(LatestChangelog) do
	Changelog:AddLabel(Change, true)
end

local ExecutorName, ExecutorVersion = GetExecutorInfo()

local Executor = InfoTab:AddRightGroupbox("Executor Info")

Executor:AddLabel("Name: " .. tostring(ExecutorName), true)
Executor:AddLabel("Version: " .. tostring(ExecutorVersion), true)
Executor:AddDivider()
Executor:AddLabel("Test Result:", true)

for _, Result in ipairs(GetEnvironmentResults()) do
	Executor:AddLabel(Result, true)
end

local Scripts = InfoTab:AddLeftGroupbox("Scripts")

Scripts:AddButton("Infinite Yield", {
	Text = "Infinite Yield",
	Default = false,
	Tooltip = "Runs Infinite Yield.",
	Func = function()
		local Success, Error = pcall(function()
			loadstring(game:HttpGet(
				"https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
			))()
		end)

		if not Success then
			warn("Infinite Yield failed:", Error)
		end
	end
})

local Community = InfoTab:AddLeftGroupbox("Community")

Community:AddButton("Copy Discord Invite", function()
	local CopyFunction = toclipboard or setclipboard

	if CopyFunction then
		CopyFunction("https://dsc.gg/abysallhubcontinued")
		Library:Notify("Discord invite copied.")
	else
		Library:Notify("Clipboard is not supported by your executor.")
	end
end)

local AutoFarming = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/refs/heads/main/Features/AutoFarming.luau"
))()

AutoFarming.Create(AutoFarmingTab)
