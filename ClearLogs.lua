for i = 1,100 do
  game.Players:Chat("ff "..game:GetService("HttpService"):GenerateGUID(true))
  game:GetService("RunService").RenderStepped:Wait()
end
