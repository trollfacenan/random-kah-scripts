--messy regen attach thingy
plrys = game.Players
				local looping = true
				while true do game.RunService.Heartbeat:wait()
					local jkfv = workspace.Terrain._Game.Admin.Regen
					local cf = plrys.LocalPlayer.Character.HumanoidRootPart
					spawn(function()
						while true do
							game:GetService("RunService").Heartbeat:Wait()
							game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
							cf.CFrame = jkfv.CFrame * CFrame.new(-1 * (jkfv.Size.X / 2) - (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),0,0)
							if not looping then break end
						end
					end)
					spawn(function()
						while true do wait(0.1)
							game.Players:Chat("unpunish me")
							game.Players:Chat("unpunish me")
							if not looping then break end
						end
					end)
				end	
				wait(1)
				looping = false
