local Interface = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/UI/Interface.luau"
))()

local Library = Interface

local Window = Library:CreateWindow({
	Title = "DEIN NAME",
	Footer = "DEIN FOOTER",
	NotifySide = "Right",
	ShowCustomCursor = false,
	AutoShow = true,
	Center = true,
	TabPadding = 3,
	MenuFadeTime = 0,
	CornerRadius = 2,
})

local Tabs = {
	AutoFarming = Window:AddTab("Auto/Farming", "refresh-cw"),
	Settings = Window:AddTab("Settings", "settings"),
}

local AutoFarming = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/Features/AutoFarming.luau"
))()

AutoFarming.Create(Tabs.AutoFarming)
