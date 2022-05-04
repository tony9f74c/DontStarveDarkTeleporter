name = "Dark Teleporter"
description = "A teleporter for your adventures."
author = "https://steamcommunity.com/profiles/76561198002269576"
version = "1.7"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"dark", "teleporter"}

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function setTab(k)
    local name = {"Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function setTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local crsDamage = {} for k=1,7,1 do crsDamage[k] = setCount(k*10) end
local crsRange = {} for k=1,10,1 do crsRange[k] = setCount(k*10) end for k=11,19,1 do crsRange[k] = setCount((k%10+1)*100) end
local crsIngredient = {} for k=1,20,1 do crsIngredient[k] = setCount(k) end
local crsDuration = {} for k=1,12,1 do crsDuration[k] = setCount(k*5) end
local crsRadius = {} for k=1,4,1 do crsRadius[k] = setCount(k/2) end
local crsTab = {} for k=1,7,1 do crsTab[k] = setTab(k) end
local crsTech = {} for k=1,7,1 do crsTech[k] = setTech(k) end

configuration_options = {
    {name = "cfgRecipeTab", label = "Recipe Tab", options = crsTab, default = 1, hover = "The crafting tab on which the recipe is found."},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = crsTech, default = 5, hover = "The research building required to see/craft the recipe."},
    {name = "cfgMarble", label = "Marble", options = crsIngredient, default = 3, hover = "The amount of Marble required to craft the Dark Teleporter."},
    {name = "cfgGems", label = "Purple Gems", options = crsIngredient, default = 1, hover = "The amount of Purple Gems required to craft the Dark Teleporter."},
    {name = "cfgFuel", label = "Nightmare Fuel", options = crsIngredient, default = 5, hover = "The amount of Nightmare Fuel required to craft the Dark Teleporter."},
    {name = "cfgDTHealthCost", label = "Max Damage On Use", options = crsDamage, default = 30, hover = "The maximum damage taken when using the Dark Teleporter. Set to 0 for no damage."},
    {name = "cfgDTCooldown", label = "On Use Disable For", options = crsDuration, default = 20, hover = "The time is seconds that the Dark Teleporter will be disabled for, immediately after using it."},
    {name = "cfgDTRange", label = "Teleport Range", options = crsRange, default = 20, hover = "The maximum range of Dark Teleporter links. Units are roughly equivalent to steps taken by your character."},
    {name = "cfgDTRadius", label = "Activation Radius", options = crsRadius, default = .5, hover = "The minimum range at which the Dark Teleporter is activated. By default you have to actually step on it."},
}
