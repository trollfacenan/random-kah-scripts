local lp = game:GetService("Players").LocalPlayer
local c = lp.Character
c:WaitForChild("Torso",999).ChildAdded:Connect(function(s)
	if s.Name == "SPINNER" then
		s.MaxTorque = Vector3.new(0,0,0)
		s.P = 0
		s.CFrame = CFrame.new(0,9000,0)
		s.Changed:Connect(function()
			s.MaxTorque = Vector3.new(0,0,0)
			s.P = 0
			s.CFrame = CFrame.new(0,9000,0)
		end)
	end
end)
lp.CharacterAdded:Connect(function()
	repeat wait() until workspace:FindFirstChild(lp.Name) and workspace[lp.Name]:FindFirstChild("Torso")
	c = lp.Character
	c:WaitForChild("Torso",999).ChildAdded:Connect(function(s)
		if s.Name == "SPINNER" then
			s.MaxTorque = Vector3.new(0,0,0)
			s.P = 0
			s.CFrame = CFrame.new(0,9000,0)
			s.Changed:Connect(function()
				s.MaxTorque = Vector3.new(0,0,0)
				s.P = 0
				s.CFrame = CFrame.new(0,9000,0)
			end)
		end
	end)
end)
