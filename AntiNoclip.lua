local v = game:GetService("Players").LocalPlayer
local c = v.Character
c:WaitForChild("Torso").Changed:Connect(function()
    if c.Torso.Anchored == true then
        c.Torso.Anchored = false
    end
end)
c:WaitForChild("Humanoid").Changed:Connect(function()
    if c.Humanoid.PlatformStand == true then
        c.Humanoid.PlatformStand = false
    end
end)
if c.Humanoid.PlatformStand == true then
     c.Humanoid.PlatformStand = false
end
if c.Torso.Anchored == true then
     c.Torso.Anchored = false
end
v.PlayerGui.ChildAdded:Connect(function()
    if v.Name == "NoClip" then
        v.Disabled = true
        v:GetPropertyChangedSignal("Disabled"):Connect(function()
            v.Disabled = true
        end)    
        task.wait()
        v:Destroy()
        repeat wait() until not v
    end
end)  
while true do
    game:GetService("RunService").RenderStepped:Wait()
    if v.PlayerGui:FindFirstChild("NoClip") then
        v.PlayerGui.NoClip.Disabled = true
        v.PlayerGui.NoClip:Destroy()
    end
end    
