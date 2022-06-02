shared.antiattach = true
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local ws = workspace
game:GetService("RunService").Stepped:Connect(function()
	if shared.antiattach == false then wait(20e20*20e20*20696969696969) end
	for a,plr in pairs(plrs:GetPlayers()) do
		if plr.Name ~= lp.Name then
			repeat game:GetService("RunService").Heartbeat:Wait() until workspace:FindFirstChild(plr.Name)
			for b,dsd in pairs(plr.Character:GetDescendants()) do
				if dsd.Name == "Weld" or dsd.Name == "Snap" then
					plrs:Chat(":refresh "..dsd.Parent.Parent.Name)
				end
			end
		end
	end
end)
