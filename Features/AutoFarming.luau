local Interface = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/D4rkRoblox/Script/main/UI/Interface.luau"
))()

local Library = Interface

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

local AutoFarmingTab = Window:AddTab("Auto/Farming", "refresh-cw")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NetworkFolder = ReplicatedStorage:WaitForChild("CatCatNetworkEvents_v1")
local UpgradeRemote = NetworkFolder:WaitForChild("RemoteFunction")

local Cats = {
	"Domo Cat",
	"VIP",
	"Orange",
	"White",
	"Black",
	"Grey",
	"Robo"
}

local AutoUpgradeThread = nil
local AutoUpgradeEnabled = false

local CatUpgrader = AutoFarmingTab:AddLeftGroupbox("Cat Upgrader")

CatUpgrader:AddDropdown("SelectedCat", {
	Values = Cats,
	Default = Cats[1],
	Multi = false,
	Text = "Select Cat"
})

local function UpgradeSelectedCat()
	local SelectedCat = Options.SelectedCat.Value

	if not SelectedCat then
		return
	end

	local Success, Result = pcall(function()
		return UpgradeRemote:InvokeServer(
			"Cats_Upgrade",
			SelectedCat
		)
	end)

	if not Success then
		warn("Upgrade failed:", Result)
	end
end

CatUpgrader:AddButton("Upgrade Selected Cat", function()
	UpgradeSelectedCat()
end)

CatUpgrader:AddToggle("AutoUpgrade", {
	Text = "Auto Upgrade",
	Default = false,

	Callback = function(Value)
		AutoUpgradeEnabled = Value

		if AutoUpgradeThread then
			task.cancel(AutoUpgradeThread)
			AutoUpgradeThread = nil
		end

		if not Value then
			return
		end

		AutoUpgradeThread = task.spawn(function()
			while AutoUpgradeEnabled do
				UpgradeSelectedCat()
				task.wait(1)
			end
		end)
	end
})
