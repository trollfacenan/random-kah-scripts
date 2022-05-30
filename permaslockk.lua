local target = workspace.Terrain._Game.Workspace.Spawn1
	local function movepart()
		workspace.FallenPartsDestroyHeight = "nan"
		plrys:Chat("gear me 000000000000000001085158379")
		wait(.3)
		pcall(function()
			plrys.LocalPlayer.Backpack.IvoryPeriastron.Parent = plrys.LocalPlayer.Character
		end)
		wait(.2)
		plrys.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-40000, -35000), math.random(-180000, -765550), math.random(-433000, -35000))
		wait(.3)
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
		local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
		local looping = true
		spawn(function()
			while true do
				game:GetService('RunService').Heartbeat:Wait()
				plrys.LocalPlayer.Character.Humanoid:ChangeState(11)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(plrys.LocalPlayer.Character.Torso.Size.X/2), 0, 0)
				if not looping then break end
			end
		end)
		spawn(function() while looping do wait(0.1) plrys:Chat('unpunish me') end end)
		wait(0.25)
		looping = false
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
	end
	movepart()
	wait(.1)
	plrys:Chat("respawn me")
	wait(.2)
	local target = workspace.Terrain._Game.Workspace.Spawn2
	local function movepartt()
		workspace.FallenPartsDestroyHeight = "nan"
		plrys:Chat("gear me 000000000000000001085158379")
		wait(.3)
		pcall(function()
			plrys.LocalPlayer.Backpack.IvoryPeriastron.Parent = plrys.LocalPlayer.Character
		end)
		wait(.2)
		plrys.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-40000, -35000), math.random(-180000, -765550), math.random(-433000, -35000))
		wait(.3)
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
		local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
		local looping = true
		spawn(function()
			while true do
				game:GetService('RunService').Heartbeat:Wait()
				plrys.LocalPlayer.Character.Humanoid:ChangeState(11)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(plrys.LocalPlayer.Character.Torso.Size.X/2), 0, 0)
				if not looping then break end
			end
		end)
		spawn(function() while looping do wait(0.1) plrys:Chat('unpunish me') end end)
		wait(0.25)
		looping = false
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
	end
	movepartt()
	wait(.1)
	plrys:Chat("respawn me")
	wait(.2)
	local target = workspace.Terrain._Game.Workspace.Spawn3
	local function moveparttt()
		workspace.FallenPartsDestroyHeight = "nan"
		plrys:Chat("gear me 000000000000000001085158379")
		wait(.3)
		pcall(function()
			plrys.LocalPlayer.Backpack.IvoryPeriastron.Parent = plrys.LocalPlayer.Character
		end)
		wait(.2)
		plrys.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-40000, -35000), math.random(-180000, -765550), math.random(-433000, -35000))
		wait(.3)
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
		local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
		local looping = true
		spawn(function()
			while true do
				game:GetService('RunService').Heartbeat:Wait()
				plrys.LocalPlayer.Character.Humanoid:ChangeState(11)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(plrys.LocalPlayer.Character.Torso.Size.X/2), 0, 0)
				if not looping then break end
			end
		end)
		spawn(function() while looping do wait(0.1) plrys:Chat('unpunish me') end end)
		wait(0.25)
		looping = false
		game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.E,false,game)
	end
	moveparttt()
	wait(.1)
	plrys:Chat("respawn me")
	wait()
