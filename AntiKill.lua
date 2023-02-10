local lp = game:GetService("Players").LocalPlayer
local plrs = lp.Parent
local function chat(msg)
    plrs:Chat(msg)
end
game:GetService("RunService").RenderStepped:Connect(function()
	local char = lp.Character or lp.CharacterAdded:Wait()
	repeat game:GetService("RunService").RenderStepped:Wait() until lp.Character:FindFirstChild("Humanoid")
	if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health == 0 then
		chat(":refresh me")
	end
end)
