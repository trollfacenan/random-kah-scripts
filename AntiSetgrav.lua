local plr = game:GetService("Players")
local lplr = plr.LocalPlayer
local char = lplr.Character
local connections
lplr.CharacterAdded:Connect(function(it)
    for i,v in pairs(connections) do
        if v and v.Disconnect then
            v:Disconnect()
        end
    end        
    char = it
     --skid my own code speedrun
    table.insert(connections, char.DescendantAdded:Connect(function(v)
    if v:IsA("BodyForce") then
        v.Force = Vector3.new(0,0,0)
        v:GetPropertyChangedSignal("Force"):Connect(function()
            if v.Force ~= Vector3.new(0,0,0) then
                v.Force = Vector3.new(0,0,0)
            end
        end)
        game:GetService("RunService").RenderStepped:Wait()
        game:GetService("Debris"):AddItem(v,0)
        repeat
            task.wait()
        until not v 
    end
end))
end) 
table.insert(connections, char.DescendantAdded:Connect(function(v)
    if v:IsA("BodyForce") then
        v.Force = Vector3.new(0,0,0)
        v:GetPropertyChangedSignal("Force"):Connect(function()
            if v.Force ~= Vector3.new(0,0,0) then
                v.Force = Vector3.new(0,0,0)
            end
        end)
        game:GetService("RunService").RenderStepped:Wait()
        game:GetService("Debris"):AddItem(v,0)
        repeat
            task.wait()
        until not v 
    end
end))
