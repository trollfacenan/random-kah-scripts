-- yup it will crash on krnl if ur punished or you are respawning without admin
shared.loopgrabbing = false
local pads = workspace.Terrain._Game.Admin.Pads:GetChildren()
game:GetService("RunService").RenderStepped:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
game:GetService("RunService").Stepped:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
