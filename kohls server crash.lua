while task.wait(.2) do
    for i = 1,3 do 
	game:GetService("Players"):Chat("size all 0.3")
    end
    game:GetService("Players"):Chat("freeze all "..math.random(240000,300000))
    for i = 1,3 do
	game:GetService("Players"):Chat("size all 10")
    end
    game:GetService("Players"):Chat("clone all")
end
