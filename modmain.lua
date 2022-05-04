PrefabFiles = {
    "darkteleporter"
}

local dtColors = {
    "red",
    "green",
    "blue",
    "yellow"
}

Assets = {}
for k=1, #dtColors, 1 do 
	table.insert(Assets, Asset("ATLAS", "images/inventoryimages/darkteleporter_"..dtColors[k]..".xml"))
	table.insert(Assets, Asset("ATLAS", "minimap/darkteleporter_"..dtColors[k]..".xml"))
end

local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local getConfig = GetModConfigData

-- MAP ICONS --

for k=1, #dtColors, 1 do
	AddMinimapAtlas("minimap/darkteleporter_"..dtColors[k]..".xml")
end

-- STRINGS --

STRINGS.NAMES.DARKTELEPORTER_RED = "Red Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_RED = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_RED = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_GREEN = "Green Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_GREEN = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_GREEN = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_BLUE = "Blue Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_BLUE = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_BLUE = "Teleportation is awesome!"
STRINGS.NAMES.DARKTELEPORTER_YELLOW = "Yellow Dark Teleporter"
STRINGS.RECIPE_DESC.DARKTELEPORTER_YELLOW = "Teleports you close by."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DARKTELEPORTER_YELLOW = "Teleportation is awesome!"

-- RECIPES --

local recipeTabs = {RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
}
local recipeTab = recipeTabs[getConfig("cfgRecipeTab")]

local recipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
    TECH.OBSIDIAN_TWO, -- Obsidian Workbench
}
local recipeTech = recipeTechs[getConfig("cfgRecipeTech")]

local mats = {Ingredient("marble", getConfig("cfgMarble")), Ingredient("purplegem", getConfig("cfgGems")), Ingredient("nightmarefuel", getConfig("cfgFuel"))}
local function addRecipe(col)
    return AddRecipe("darkteleporter_"..col, mats, recipeTab, recipeTech, "darkteleporter_placer", nil, nil, nil, nil, "images/inventoryimages/darkteleporter_"..col..".xml")
end
-- add recipes
addRecipe("red") addRecipe("green") addRecipe("blue") addRecipe("yellow")
