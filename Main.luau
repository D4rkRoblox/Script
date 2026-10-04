local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"
))()

local Window = Library:CreateWindow({
    Title = "DEIN NAME",
    Footer = "DEIN FOOTER",
    NotifySide = "Right",
    ShowCustomCursor = false,
    AutoShow = true,
    Center = true,
    TabPadding = 3,
    MenuFadeTime = 0,
    CornerRadius = 2
})

local Tabs = {
    AutoFarming = Window:AddTab("Auto/Farming", "refresh-cw"),
    Settings = Window:AddTab("Settings", "settings")
}

local AutoFarming = Tabs.AutoFarming:AddLeftGroupbox("Auto Farming")

AutoFarming:AddToggle("AutoUpgrade", {
    Text = "Auto Upgrade",
    Default = false
})
