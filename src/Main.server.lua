-- group-as-folder

-- dependant services
local Selection = game:GetService("Selection")
local HistoryService = game:GetService("ChangeHistoryService")

local source = script.Parent

-- plugin configuration constants
local Config = require(source:WaitForChild("Config"))

local pluginToolbar = plugin:CreateToolbar(Config.TOOLBAR_NAME)
-- the plugin button :D
local pluginButton = pluginToolbar:CreateButton(
    Config.PLUGIN_NAME,
    Config.PLUGIN_DESC,
    Config.PLUGIN_ICON
)
-- action that allows you to bind this plugin to a hotkey
local pluginAction = plugin:CreatePluginAction(
    Config.PLUGIN_ID.."-action",
    Config.PLUGIN_NAME,
    Config.PLUGIN_DESC,
    Config.PLUGIN_ICON
)

-- group selection under a folder
local function group()
    HistoryService:SetEnabled(true) -- ensure HistoryService is enabled

    local selection = Selection:Get()

    -- set our entry waypoint
    HistoryService:SetWaypoint("Grouping under folder")

    local newFolder = Instance.new("Folder")

    newFolder.Parent = selection[1].Parent
    for _,instance in pairs(selection) do
        instance.Parent = newFolder
    end

    Selection:Set({newFolder})

    -- set our exit waypoint
    HistoryService:SetWaypoint("Grouped under folder")
end

-- bind the main function to events
pluginAction.Triggered:Connect(group)
pluginButton.Click:Connect(group)