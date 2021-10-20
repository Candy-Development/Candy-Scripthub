getgenv().settings = {
    Internal = Color3.fromRGB(255, 0, 0),
    External = Color3.fromRGB(43, 255, 241)
    InternalTransparency = 0.75
    ExternalTransparency = 0.1
}

local esp = {}
local chams = {}
getgenv().enabled = true

function esp:new(type,props)
    local instance = Instance.new(type)
    for _,v in next, props do
        instance[_] = v
    end
    return instance
end

function esp:addchams(plr)
    if game:FindFirstChild(plr) then
        for _,v in next, plr.Character:GetChildren() do
            if v.Name == "Head" then
                local external = esp:new("CylinderHandleAdornment",
                    {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.External,ZIndex = 10,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),SizeRelativeOffset = Vector3.new(0, 0.20000000298023, 0),Height = 1.3,Radius = 0.75,Adornee = v,Parent =  v}
                )
                local internal  = esp:new("CylinderHandleAdornment",
                    {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.Internal,ZIndex = 9,CFrame = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, -1, -1, 0, 0),AlwaysOnTop = true,SizeRelativeOffset = Vector3.new(0, 0.10000000149012, 0),Height = 1.1,Radius = 0.61,Adornee = v,Parent = v}
                )
                table.insert(chams,external)
                table.insert(chams,internal)
            elseif v.Name ~= "HumanoidRootPart" and v:IsA("Part") or v:IsA("MeshPart") then
                local internal2 = esp:new("BoxHandleAdornment",
                    {Name = "InternalCham",Transparency = settings.InternalTransparency,Color3 = settings.Internal,ZIndex = 9,AlwaysOnTop = true,Size = v.Size,Adornee = v,Parent = v}
                )
                local external2 = esp:new("BoxHandleAdornment",
                    {Name = "ExternalCham",Transparency = settings.ExternalTransparency,Color3 = settings.External,ZIndex = 10,Size = v.Size*1.05,Adornee = v,Parent = v}
                )
                table.insert(chams,external2)
                table.insert(chams,internal2)
            end
        end
    end
end

local plrs = game:GetService("Players")

for _,plr in pairs(plrs:GetPlayers()) do
    if plr.Character and plr.Name ~= plrs.LocalPlayer.Name then
        repeat wait() until plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        esp:addchams(plr)
    end
end

plrs.PlayerAdded:connect(function(plr)
if plr.Name ~= plrs.LocalPlayer.Name then
    plr.CharacterAdded:connect(function()
        repeat wait() until plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        esp:addchams(plr)
    end)
end
end)

game:GetService("UserInputService").InputBegan:connect(function(key)
    if key.KeyCode == Enum.KeyCode.End then
        if enabled == true then
            enabled = false
        else
            enabled = true
        end
    end
    for _,v in next, chams do
        if game:FindFirstChild(v) and enabled == false then
            v.Visible = false
        elseif game:FindFirstChild(v) and enabled == true then
            v.Visible = true
        end
    end
end)
