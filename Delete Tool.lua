local chatbox = Instance.new("TextBox", workspace)
local function chat(msg)
    chatbox:SetTextFromInput(msg)
    game.Players:Chat(msg)
end
local random = true -- set this to false if you want to use custom delete position
local customdeletepos = CFrame.new(-491323,783321,54662)
local function ivory()
	chat("gear me 0000000000000108158379")
end
local lp = game:GetService("Players").LocalPlayer
local function equipivory()
	if lp.Backpack:FindFirstChild("IvoryPeriastron") then
		lp.Backpack.IvoryPeriastron.Parent = lp.Character
	end
end
local function move(target)
	if lp.Character:FindFirstChild("IvoryPeriastron") then
		local cf = lp.Character.HumanoidRootPart
		if not random == true then cf.CFrame = customdeletepos else cf.CFrame = CFrame.new(math.random(-800000,-100000),math.random(-980053,-123387),math.random(-768319,-492917)) end
		task.wait(0.2)
		lp.Character.IvoryPeriastron.Remote:FireServer(Enum.KeyCode.E)
		local looping = true
		coroutine.wrap(function()
			while true do
				game:GetService('RunService').RenderStepped:Wait()
				game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
				target.RotVelocity = Vector3.new(0,0,0)
		                target.Velocity = Vector3.new(0,0,0)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(p.LocalPlayer.Character['Torso'].Size.X/2), 0, 0)
				if not looping then break end
			end
		end)()
		coroutine.wrap(function() while looping do game:GetService('RunService').Heartbeat:wait() game:GetService("Players"):Chat('unpunish me') end end)()
		task.wait(0.3)
		looping = false
		lp.Character.IvoryPeriastron.Remote:FireServer(Enum.KeyCode.E)
		task.wait(0.1)
		chat("respawn me")
	end
end
local del = Instance.new("Tool")
del.Name = "Delete"
del.TextureId = "rbxasset://Textures/Hammer.png"
local m = lp:GetMouse()
local con = {}
local sb = Instance.new("SelectionBox")
local spl = Instance.new("SelectionPartLasso")
local b1p
local mov
del.Equipped:Connect(function()
	sb.Parent = workspace
	spl.Parent = workspace
	sb.Color = BrickColor.new("Bright red")
	spl.Color = BrickColor.new("Bright red")
	mov = m.Move:Connect(function()
		if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
			sb.Adornee = m.Target
			spl.Part = m.Target
		end
	end)
	b1p = m.Button1Up:Connect(function()
		workspace.FallenPartsDestroyHeight = "nan"
		local old = lp.Character.HumanoidRootPart.CFrame
		ivory()
		repeat wait() until lp.Backpack:FindFirstChild("IvoryPeriastron")
		equipivory()
		if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
			move(m.Target)
		end
		task.wait(0.2)
		lp.Character.HumanoidRootPart.CFrame = old
		local del = Instance.new("Tool")
del.Name = "Delete"
del.TextureId = "rbxasset://Textures/Hammer.png"
local m = lp:GetMouse()
local con = {}
local sb = Instance.new("SelectionBox")
local spl = Instance.new("SelectionPartLasso")
local b1p
local mov
del.Equipped:Connect(function()
	sb.Parent = workspace
	spl.Parent = workspace
	sb.Color = BrickColor.new("Bright red")
	spl.Color = BrickColor.new("Bright red")
	mov = m.Move:Connect(function()
		if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
			sb.Adornee = m.Target
			spl.Part = m.Target
		end
	end)
	b1p = m.Button1Up:Connect(function()
		local old = lp.Character.HumanoidRootPart.CFrame
		ivory()
		repeat wait() until lp.Backpack:FindFirstChild("IvoryPeriastron")
		equipivory()
		if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
			move(m.Target)
		end
		task.wait(0.2)
		lp.Character.HumanoidRootPart.CFrame = old
				local del = Instance.new("Tool")
				del.Name = "Delete"
				del.TextureId = "rbxasset://Textures/Hammer.png"
				local m = lp:GetMouse()
				local con = {}
				local sb = Instance.new("SelectionBox")
				local spl = Instance.new("SelectionPartLasso")
				local b1p
				local mov
				del.Equipped:Connect(function()
					sb.Parent = workspace
					spl.Parent = workspace
					sb.Color = BrickColor.new("Bright red")
					spl.Color = BrickColor.new("Bright red")
					mov = m.Move:Connect(function()
						if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
							sb.Adornee = m.Target
							spl.Part = m.Target
						end
					end)
					b1p = m.Button1Up:Connect(function()
						local old = lp.Character.HumanoidRootPart.CFrame
						ivory()
						task.wait(0.3)
						equipivory()
						if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
							move(m.Target)
						end
						task.wait(0.2)
						lp.Character.HumanoidRootPart.CFrame = old
					end)
				end)
				del.Unequipped:Connect(function()
					sb.Parent = nil
					spl.Parent = nil
					sb.Adornee = nil
					spl.Part = nil
					b1p:Disconnect()
					mov:Disconnect()
				end)
				del.RequiresHandle = false
				del.Parent = lp.Backpack
	end)
end)
del.Unequipped:Connect(function()
	sb.Parent = nil
	spl.Parent = nil
	sb.Adornee = nil
	spl.Part = nil
	b1p:Disconnect()
	mov:Disconnect()
end)
del.RequiresHandle = false
del.Parent = lp.Backpack
	end)
end)
del.Unequipped:Connect(function()
	sb.Parent = nil
	spl.Parent = nil
	sb.Adornee = nil
	spl.Part = nil
	b1p:Disconnect()
	mov:Disconnect()
end)
del.RequiresHandle = false
del.Parent = lp.Backpack
