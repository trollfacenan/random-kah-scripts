--kinda fast now
shared.loopgrabbing = false -- value

local pads = workspace.Terrain._Game.Admin.Pads:GetChildren("Head")
game:GetService("RunService").RenderStepped:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		spawn(
			function()
				repeat wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
			end)
	end
end)
game:GetService("RunService").Stepped:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		spawn(
			function()
				repeat wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
			end)
	end
end)
game:GetService("RunService").Heartbeat:Connect(function()
	if shared.loopgrabbing == false then
		wait(9e9)
	end
	for i, pad in pairs(pads) do
		spawn(
			function()
				repeat wait() until workspace:FindFirstChild(game.Players.LocalPlayer.Name)
				repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
				firetouchinterest(pad.Head, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
			end)
	end
end)
