--regen attach thingy
plrys = game.Players
local target = workspace.Terrain._Game.Admin.Regen
				local looping = true
				spawn(function()
			while true do
				game:GetService('RunService').Heartbeat:wait()
				game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
				target.RotVelocity = Vector3.new(0,0,0)
		                target.Velocity = Vector3.new(0,0,0)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(p.LocalPlayer.Character['Torso'].Size.X/2), 0, 0)
				if not looping then break end
			end
		end)
		spawn(function() while looping do game:GetService('RunService').Heartbeat:wait() game:GetService("Players"):Chat('unpunish me') end end)
				wait(1)
				looping = false
