print("Don't use this")
local c1
local c2
local c3
local pads = "Don't use this"
c1 = game:GetService("RunService").RenderStepped:Connect(function()
	print("Don't use this")
end)
c2 = game:GetService("RunService").Stepped:Connect(function()
	print("Don't use this")
end)
c3 = game:GetService("RunService").Heartbeat:Connect(function()
	print("Don't use this")
end)
