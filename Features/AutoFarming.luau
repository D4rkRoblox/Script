local AutoFarming = {}

AutoFarming.Cats = {
	"Domo Cat",
	"VIP",
	"Orange",
}

function AutoFarming.Create(Tab)
	local Box = Tab:AddLeftGroupbox("Cat Upgrader")

	Box:AddDropdown("SelectedCat", {
		Values = AutoFarming.Cats,
		Default = AutoFarming.Cats[1],
		Multi = false,
		Text = "Katze auswählen",
	})

	Box:AddButton("Upgrade ausgewählte Katze", function()
		local selectedCat = Options.SelectedCat.Value

		if not selectedCat then
			return
		end

		print("Ausgewählte Katze:", selectedCat)
	end)

	return Box
end

return AutoFarming
