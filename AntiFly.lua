local antifly = true
local lp = game:GetService("Players").LocalPlayer
game:GetService("RunService").RenderStepped:Connect(function()
	for i,s in pairs(lp:GetDescendants()) do
		if s.Name == "Unfly" then
			if antifly == true then s.Parent:Destroy() lp.Character.Humanoid.PlatformStand = false for i,v in pairs(lp.Character.Torso:GetChildren()) do if v.Name:find("Body") then v:Destroy() end end end
		end
	end
end)
