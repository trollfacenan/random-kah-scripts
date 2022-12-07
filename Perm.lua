if not fireclickdetector or not firetouchinterest then
    return warn"unsupported on ur exec L"
end
shared.perm = true
local lp = game:GetService("Players").LocalPlayer
local store = workspace.Terrain._Game
local pads = store.Admin.Pads
local regen
pcall(function()
	regen = store.Admin:FindFirstChild("Regen")
end)
local pad = pads:FindFirstChild("Touch to get admin")
if pad == nil then
	fireclickdetector(regen.ClickDetector, 0)
	repeat task.wait() until pads:FindFirstChild("Touch to get admin")
	pad = pads:FindFirstChild("Touch to get admin")
end
local fakepad = pad:Clone()
fakepad.Parent = workspace
fakepad.Head.CFrame = pad.Head.CFrame
fakepad.Head.Transparency = 1
pad.Head:GetPropertyChangedSignal("Color"):Connect(function()
    fakepad:FindFirstChild("Head").Color = pad:FindFirstChild("Head").Color
end)
pad:GetPropertyChangedSignal("Name"):Connect(function()
    fakepad.Name = pad.Name
end)
while true do
	task.wait()
	if shared.perm then
		if pad == nil then
			fireclickdetector(regen.ClickDetector, 0)
			repeat task.wait() until pads:FindFirstChild("Touch to get admin")
			pad = pads:FindFirstChild("Touch to get admin")
		end
		pad.Head.CanCollide = false
        task.spawn(function()
            pad.Head.CFrame = lp.Character.Head.CFrame
		    task.wait()
		    pad.Head.CFrame = lp.Character.HumanoidRootPart.CFrame
        end)
    else
        break
    end
end
