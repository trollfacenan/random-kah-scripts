if v:IsA("BodyForce") then
			v.Force = Vector3.new(0,0,0)
			v:GetPropertyChangedSignal("Force"):Connect(function()
				if v.Force ~= Vector3.new(0,0,0) then
					v.Force = Vector3.new(0,0,0)
				end
			end)
			game:GetService("RunService").RenderStepped:Wait()
			game:GetService("Debris"):AddItem(v,0)
			repeat
				wait()
			until not v
		end
