local lp = game:GetService("Players").LocalPlayer
local plrs = lp.Parent
game:GetService("RunService").Heartbeat:Connect(function()
	local char = lp.Character or lp.CharacterAdded:Wait()
	repeat game:GetService("RunService").Heartbeat:Wait() until lp.Character:FindFirstChild("Humanoid")
	if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health == 0 then
		plrs:Chat(":refresh me")
	end
end)
