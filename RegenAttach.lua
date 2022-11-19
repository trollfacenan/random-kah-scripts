-- Script that attaches to the admin reset (regen) part.
p = game.Players
lplr = p.LocalPlayer
local part = workspace.Terrain._Game.Admin.Regen
local looping = true
local cf = p.LocalPlayer.Character.HumanoidRootPart
task.spawn(function()
	while true do
		game:GetService("RunService").RenderStepped:Wait()
		lplr.Character:FindFirstChildOfClass("Humanoid"):ChangeState(11)
		part.RotVelocity = Vector3.new(0,0,0)
		part.Velocity = Vector3.new(0,0,0)
		cf.CFrame = part.CFrame * CFrame.new(-1*(part.Size.X/2)-(lplr.Character.Torso.Size.X/2), 0, 0)
		if not looping then break end
	end
end)
spawn(function() while looping do game:GetService('RunService').RenderStepped:Wait() game:GetService("Players"):Chat('unpunish me') end end)
task.wait(1)
looping = false
