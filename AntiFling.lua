-- ⚠️this is not meant for use outside of scripts that provide custom commands for KAH.
shared.antifling = false
local lplr = game:GetService("Players").LocalPlayer
local char = lplr.Character
local tor = char:WaitForChild("Torso")
local oldvel = tor.Velocity
tor.Changed:Connect(function()
	if tor.Velocity == Vector3.new(0,0,0) then
		tor.Velocity = oldvel
	end
end)
tor.ChildAdded:Connect(function(v)
	if v:IsA("BodyForce") and shared.antifling then
		v.Force = Vector3.new(0,0,0)
		char:FindFirstChildOfClass("Humanoid").Sit = false
		task.wait()
		char:FindFirstChildOfClass("Humanoid").Sit = false
		game:GetService("Debris"):AddItem(v,0)
		repeat
			game:GetService("RunService").RenderStepped:Wait()
		until not v
	end
end)
lplr.CharacterAdded:Connect(function()
     tor = lplr.Character:WaitForChild("Torso")
     oldvel = tor.Velocity
     tor.ChildAdded:Connect(function(v)
	if v:IsA("BodyForce") and shared.antifling then
		v.Force = Vector3.new(0, 0, 0)
		char:FindFirstChildOfClass("Humanoid").Sit = false
		task.wait()
		char:FindFirstChildOfClass("Humanoid").Sit = false
		game:GetService("Debris"):AddItem(v,0)
		repeat
			game:GetService("RunService").RenderStepped:Wait()
		until not v
	    end
      end)
      tor.Changed:Connect(function()
	if tor.Velocity == Vector3.new(0,0,0) then
		tor.Velocity = oldvel
	    end
      end)
end)		
