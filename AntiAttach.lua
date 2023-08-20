shared.antiattach = true
local plrs = game:GetService("Players")
local function chat(msg)
    plrs:Chat(msg)
end
local lp = plrs.LocalPlayer
local ws = workspace
local hi
hi = game:GetService("RunService").RenderStepped:Connect(function()
	if shared.antiattach == false then hi:Disconnect() end
	for a,plr in pairs(plrs:GetPlayers()) do
		if plr.Name ~= lp.Name then
			repeat game:GetService("RunService").RenderStepped:Wait() until ws:FindFirstChild(plr.Name)
			for i,i2 in pairs(plr.Character:GetDescendants()) do
				if i2:IsA"Weld" and not i2.Name:lower():find"left" and not i2.Name:lower():find"right" and not i2.Name == "Neck" or i2:IsA"Snap" then
					chat(":refresh "..dsd.Parent.Parent.Name)
				end
				task.wait()
			end
		end
	end
end)
