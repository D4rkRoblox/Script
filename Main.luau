local Interface = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/UI/Interface.luau"
))()

local Library = Interface
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
		table.insert(Results, Check[1] .. ": " .. (Check[2] and "Supported" or "Unsupported"))
	end

	return Results
end

local InfoTab = Window:AddTab("Info", "user")
local AutoFarmingTab = Window:AddTab("Auto/Farming", "refresh-cw")
local SettingsTab = Window:AddTab("Settings", "settings")

local User = InfoTab:AddLeftGroupbox("User Info")

local ThumbnailSuccess, Content = pcall(function()
	return Players:GetUserThumbnailAsync(
		LocalPlayer.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size420x420
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

local CreditsList = {
	"<font color='rgb(0, 255, 255)'>Catploit — Main Script</font>",
	"<font color='rgb(255, 165, 0)'>Original Info Tab Structure</font>",
	"<font color='rgb(50, 205, 50)'>" .. LocalPlayer.Name .. " — For Using This Script</font>"
}

for _, Credit in ipairs(CreditsList) do
	Credits:AddLabel(Credit, true)
end

local Changelog = InfoTab:AddRightGroupbox("Changelog")

local LatestChangelog = {
	"10/4/2026",
	"<font color='rgb(0, 255, 0)'>+ Added Cat Upgrader</font>",
	"<font color='rgb(0, 255, 0)'>+ Added Domo Cat, VIP, Orange, White, Black, Grey & Robo</font>",
	"<font color='rgb(255, 255, 0)'>~ Updated Catploit interface</font>"
}

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
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/Features/AutoFarming.luau"
))()

if AutoFarming and AutoFarming.Create then
	AutoFarming.Create(AutoFarmingTab)
end

local SettingsModule = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/UI/SettingsTab.luau"
))()

if type(SettingsModule) == "table" then
	if SettingsModule.Create then
		SettingsModule.Create(SettingsTab, Library, Window)
	elseif SettingsModule.Init then
		SettingsModule.Init(SettingsTab, Library, Window)
	end
elseif type(SettingsModule) == "function" then
	SettingsModule(SettingsTab, Library, Window)
end
