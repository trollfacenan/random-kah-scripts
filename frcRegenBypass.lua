--messy regen attach thingy
plrys = game.Players
				local looping = true
				while true do game:GetService("RunService").Heartbeat:wait()
					local jkfv = workspace.Terrain._Game.Admin.Regen
					local cf = plrys.LocalPlayer.Character.HumanoidRootPart
					spawn(function()
						while true do
							game:GetService("RunService").Heartbeat:Wait()
							plrys.LocalPlayer.Character.Humanoid:ChangeState(11)
							cf.CFrame = jkfv.CFrame * CFrame.new(-1 * (jkfv.Size.X / 2) - (plrys.LocalPlayer.Character.Torso.Size.X / 2),0,0)
							if not looping then break end
						end
					end)
					spawn(function()
						while looping do wait()
							plrys:Chat("unpunish me "..math.random(200))
							plrys:Chat("unpunish me "..math.random(200))
						end
					end)
				end	
				wait(1)
				looping = false
