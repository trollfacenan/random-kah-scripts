shared.Perm = true
local Admin = workspace.Terrain._Game.Admin
while true do
if not Admin.Pads:FindFirstChild(game:service'Players'.LocalPlayer.Name.."'s admin") then
if Admin.Pads:FindFirstChild("Touch to get admin") then
firetouchinterest(game:service'Players'.LocalPlayer.Character:WaitForChild("Left Leg",1337*10),Admin.Pads["Touch to get admin"].Head,1)
firetouchinterest(game:service'Players'.LocalPlayer.Character:WaitForChild("Left Leg",1337*10),Admin.Pads["Touch to get admin"].Head,0)
else
if Admin:FindFirstChild("Regen") then
fireclickdetector(Admin.Regen.ClickDetector,0)
end
end
end
game:service'RunService'.Heartbeat:Wait()
if shared.Perm == false then break end
end
