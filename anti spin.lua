local lp = game:GetService("Players").LocalPlayer
if lp.Character:FindFirstChild("Torso") == nil then warn("No R6 torso found. If you are using R15, please switch to R6. If you just didn't spawn, then wait until you're spawned. (Anti Spin)") return end
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
	repeat task.wait() until workspace:FindFirstChild(lp.Name) and lp.Character:FindFirstChild("Torso")
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
