--Dont steal anything from here pls and also my name is me_kevin3050ti and dc - humanoid#5242
--note that its not that hard to find the objects so if you want change the deletepos to different (DONT REMOVE THE CFrame.new AND THE BRACKETS)
--if you have some anti void on, disable it otherwise its really ez to find it
local deletepos = CFrame.new(-800000,-783321,-951223)
-- do not edit anything below unless you know what you're doing
function ivory()
	game:GetService("Players"):Chat("gear me 0000000000000108158379")
end
local lp = game:GetService("Players").LocalPlayer
function equipivory()
	if lp.Backpack:FindFirstChild("IvoryPeriastron") then
		lp.Backpack.IvoryPeriastron.Parent = lp.Character
	end
end
function move(target)
	if lp.Character:FindFirstChild("IvoryPeriastron") then
		local cf = lp.Character.HumanoidRootPart
		cf.CFrame = deletepos
		wait(0.2)
		lp.Character.IvoryPeriastron.Remote:FireServer(Enum.KeyCode.E)
		local looping = true
		spawn(function()
			while true do
				game:GetService('RunService').Heartbeat:Wait()
				game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
				target.RotVelocity = Vector3.new(0,0,0)
		                target.Velocity = Vector3.new(0,0,0)
				cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(lp.Character['Torso'].Size.X/2), 0, 0)
				if not looping then break end
			end
		end)
		spawn(function() while looping do wait(.1) game:GetService("Players"):Chat('unpunish me') end end) -- Do not change the command otherwise it won't attach
		wait(0.3)
		looping = false
		lp.Character.IvoryPeriastron.Remote:FireServer(Enum.KeyCode.E)
		wait(0.3)
		game:GetService("Players"):Chat("respawn me")
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
		wait(0.2)
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
		wait(0.2)
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
						wait(0.3)
						equipivory()
						if m.Target and m.Target:IsA("BasePart") and not m.Target:IsDescendantOf(lp.Character) then
							move(m.Target)
						end
						wait(0.2)
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