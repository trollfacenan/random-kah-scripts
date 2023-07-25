shared.loopgrabbing = false
local c1
local c2
local c3
local pads = workspace.Terrain._Game.Admin.Pads:GetChildren()
c1 = game:GetService("RunService").RenderStepped:Connect(function()
	if shared.loopgrabbing == false then
		c1:Disconnect()
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
c2 = game:GetService("RunService").Stepped:Connect(function()
	if shared.loopgrabbing == false then
		c2:Disconnect()
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
c3 = game:GetService("RunService").Heartbeat:Connect(function()
	if shared.loopgrabbing == false then
		c3:Disconnect()
	end
	for i, pad in pairs(pads) do
		task.spawn(function()
				repeat task.wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
			end)
	end
end)
