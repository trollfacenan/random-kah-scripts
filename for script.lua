-- fixed the second time runner xd
local lplr = game:GetService("Players").LocalPlayer
local char = workspace[lplr.Name]
local tor = char.Torso
local oldvel = tor.Velocity
tor.Changed:Connect(function()
	if tor.Velocity == Vector3.new(0,0,0) then
		tor.Velocity = oldvel
	end
end)
tor.ChildAdded:Connect(function(v)
  if AntiFling == false then return end
	if v:IsA("BodyForce") then
		v.Force = Vector3.new(0,0,0)
		wait()
		game:GetService("Debris"):AddItem(v,0)
		repeat
			wait()
		until not v
	end
end)
lplr.CharacterAppearanceLoaded:Connect(function()
     if AntiFling == false then return end
     tor = lplr.Character.Torso
     oldvel = tor.Velocity
     tor.ChildAdded:Connect(function(v)
	if v:IsA("BodyForce") then
		v.Force = Vector3.new(0,0,0)
		wait()
		game:GetService("Debris"):AddItem(v,0)
		repeat
			wait()
		until not v
	    end
      end)
      tor.Changed:Connect(function()
	if tor.Velocity == Vector3.new(0,0,0) then
		tor.Velocity = oldvel
	    end
      end)
end)		
