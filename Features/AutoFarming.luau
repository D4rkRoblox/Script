local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AutoFarming = {}

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

function AutoFarming.Create(Tab)
	local CatUpgrader = Tab:AddLeftGroupbox("Cat Upgrader")

	CatUpgrader:AddDropdown("SelectedCat", {
		Values = Cats,
		Default = Cats[1],
		Multi = false,
		Text = "Select Cat"
	})

	CatUpgrader:AddButton("Upgrade Selected Cat", function()
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
	end)

	CatUpgrader:AddToggle("AutoUpgrade", {
		Text = "Auto Upgrade",
		Default = false,

		Callback = function(Value)
			if AutoUpgradeThread then
				task.cancel(AutoUpgradeThread)
				AutoUpgradeThread = nil
			end

			if not Value then
				return
			end

			AutoUpgradeThread = task.spawn(function()
				while true do
					if not Options.SelectedCat then
						break
					end

					local SelectedCat = Options.SelectedCat.Value

					if SelectedCat then
						local Success, Result = pcall(function()
							return UpgradeRemote:InvokeServer(
								"Cats_Upgrade",
								SelectedCat
							)
						end)

						if not Success then
							warn("Auto upgrade failed:", Result)
						end
					end

					task.wait(1)
				end

				AutoUpgradeThread = nil
			end)
		end
	})
end

return AutoFarming
