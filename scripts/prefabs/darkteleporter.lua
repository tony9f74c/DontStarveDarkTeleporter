local assets = {
    Asset("ANIM", "anim/darkteleporter.zip")
}

local getConfig = GetModConfigData
local radius = getConfig("cfgDTRadius", "workshop-2709407987")
local range = getConfig("cfgDTRange", "workshop-2709407987")
local healthCost = getConfig("cfgDTHealthCost", "workshop-2709407987")
local cooldown = getConfig("cfgDTCooldown", "workshop-2709407987")
-- local radius = getConfig("cfgDTRadius", "DontStarveDarkTeleporter")
-- local range = getConfig("cfgDTRange", "DontStarveDarkTeleporter")
-- local healthCost = getConfig("cfgDTHealthCost", "DontStarveDarkTeleporter")
-- local cooldown = getConfig("cfgDTCooldown", "DontStarveDarkTeleporter")

local function onHammered(inst, worker)
    if inst.components.workable then
        inst:RemoveComponent("workable")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst.AnimState:PlayAnimation("destroyed")
    inst:DoTaskInTime(0.5, function()
        inst:Remove()
    end)
end

local function darkTeleporterFn (col)
    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddNetwork()
        inst.AnimState:SetBank("darkteleporter")
        inst.AnimState:SetBuild("darkteleporter")
        inst.AnimState:PlayAnimation(col, true)
        inst.entity:AddSoundEmitter()
        inst.AnimState:SetLayer(LAYER_BACKGROUND)
        inst.AnimState:SetSortOrder(3)
        
        inst:AddTag("DarkTeleporter_"..col)

        local minimap = inst.entity:AddMiniMapEntity()
        minimap:SetIcon("darkteleporter_"..col..".tex")

        inst.entity:SetPristine()
        if not TheWorld.ismastersim then return inst end
        
        inst:AddComponent("inspectable")
        inst:AddComponent("lootdropper")
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(6)
        inst.components.workable:SetOnFinishCallback(onHammered)
        inst:AddComponent("playerprox")
        inst.components.playerprox:SetDist(radius, 1)
        inst.components.playerprox.onnear = function()
            local target = FindEntity(inst, range, function(DT)
                return DT:HasTag("DarkTeleporter_"..col)
            end)
            local x, y, z = inst.Transform:GetWorldPosition()
            local player = FindClosestPlayerInRange(x, y, z, radius)
            local equippedItem = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local hammerEquipped = (equippedItem and equippedItem.name == "Hammer")
            if target and target ~= inst and not target:HasTag("dtJustUsed") and not inst:HasTag("dtJustUsed") then
                if not hammerEquipped then 
                    inst:AddTag("dtJustUsed")
                    target:AddTag("dtJustUsed")
                    local destination = target:GetPosition()
                    local fx = SpawnPrefab("small_puff")
                    local penalty = math.random(healthCost)
                    player.Transform:SetPosition(destination.x, destination.y, destination.z)
                    target.SoundEmitter:PlaySound("dontstarve/common/staffteleport")
                    fx.Transform:SetPosition(destination.x, destination.y, destination.z)
                    player.components.health:DoDelta(-penalty) -- does damage when used
                    inst:DoTaskInTime(cooldown, function()
                        inst:RemoveTag("dtJustUsed")
                        target:RemoveTag("dtJustUsed")
                    end)
                end 
            end
        end

        return inst
    end

    return Prefab("common/objects/darkteleporter_"..col, fn, assets)
end

return darkTeleporterFn("red"),
    darkTeleporterFn("green"),
    darkTeleporterFn("blue"),
    darkTeleporterFn("yellow"),
    MakePlacer("common/darkteleporter_placer", "darkteleporter", "darkteleporter", "red")