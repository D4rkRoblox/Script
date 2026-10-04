local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AutoFarming = {}

local UpgradeRemote = ReplicatedStorage
	:WaitForChild("CatCatNetworkEvents_v1")
	:WaitForChild("Cats_Upgrade")

local Cats = {
	"Domo Cat",
	"VIP",
	"Orange",
}

local AutoUpgradeConnection

function AutoFarming.Create(Tab)
	local Box = Tab:AddLeftGroupbox("Cat Upgrader")

	Box:AddDropdown("SelectedCat", {
		Values = Cats,
		Default = Cats[1],
		Multi = false,
		Text = "Select Cat",
	})

	Box:AddButton("Upgrade Selected Cat", function()
		local selectedCat = Options.SelectedCat.Value

		if not selectedCat then
			return
		end

		UpgradeRemote:InvokeServer("Cats_Upgrade", selectedCat)
	end)

	Box:AddToggle("AutoUpgrade", {
		Text = "Auto Upgrade",
		Default = false,

		Callback = function(enabled)
			if AutoUpgradeConnection then
				task.cancel(AutoUpgradeConnection)
				AutoUpgradeConnection = nil
			end

			if not enabled then
				return
			end

			AutoUpgradeConnection = task.spawn(function()
				while true do
					local selectedCat = Options.SelectedCat.Value

					if selectedCat then
						UpgradeRemote:InvokeServer(
							"Cats_Upgrade",
							selectedCat
						)
					end

					task.wait(1)
				end
			end)
		end,
	})
end

return AutoFarming
