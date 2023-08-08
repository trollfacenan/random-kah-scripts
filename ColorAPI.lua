-- original was deleted, so this is just a remake
-- original by yeemi

local chatbox = Instance.new("TextBox", workspace)
local function chat(msg)
    game:GetService("Players"):Chat(msg)
end
task.wait()
local Chat = chat
colorAPI = {}
local v1 = "PaintPart"
local obbyBricks = workspace.Terrain._Game.Workspace.Obby:GetChildren()
local adminPads = workspace.Terrain._Game.Admin.Pads:GetChildren()
local house = workspace.Terrain._Game.Workspace["Basic House"]:GetChildren()
local adminDivs = workspace.Terrain._Game.Workspace["Admin Dividers"]:GetChildren()
local bricks = workspace.Terrain._Game.Workspace["Building Bricks"]:GetChildren()
local plrys = game:GetService("Players")

colorAPI.transformToColor3 = function(BrickClr)
	if typeof(BrickClr) == "BrickColor" then
		return BrickClr.Color
	end
end
transformToColor3 = colorAPI.transformToColor3
colorAPI.color = function(prt, clr)
	coroutine.resume(coroutine.create(function()
		local Arguments =
			{
				["Part"] = prt,
				["Color"] = clr
			}
		plrys.LocalPlayer.Character.PaintBucket:WaitForChild("Remotes",15).ServerControls:InvokeServer("PaintPart", Arguments)
	end))
end
colorAPI.colorHouse = function(Extra)
	local OutlinesAndWDWS = Extra.WANDDC
	local Walls = Extra.wallsC
	local Roof = Extra.roofC
	local ChimneyTopParts = Extra.chiC
	for i,v in pairs(house) do
		coroutine.resume(coroutine.create(function()
			if v.Name == "SmoothBlockModel103" or v.Name == "SmoothBlockModel105" or v.Name == "SmoothBlockModel106" or v.Name == "SmoothBlockModel108" or v.Name == "SmoothBlockModel11" or v.Name == "SmoothBlockModel113" or v.Name == "SmoothBlockModel114" or v.Name == "SmoothBlockModel115" or v.Name == "SmoothBlockModel116" or v.Name == "SmoothBlockModel118" or v.Name == "SmoothBlockModel122" or v.Name == "SmoothBlockModel126" or v.Name == "SmoothBlockModel129" or v.Name == "SmoothBlockModel13" or v.Name == "SmoothBlockModel130" or v.Name == "SmoothBlockModel131" or v.Name == "SmoothBlockModel132" or v.Name == "SmoothBlockModel134" or v.Name == "SmoothBlockModel135" or v.Name == "SmoothBlockModel14" or v.Name == "SmoothBlockModel140" or v.Name == "SmoothBlockModel142" or v.Name == "SmoothBlockModel147" or v.Name == "SmoothBlockModel15" or v.Name == "SmoothBlockModel154" or v.Name == "SmoothBlockModel155" or v.Name == "SmoothBlockModel164" or v.Name == "SmoothBlockModel166" or v.Name == "SmoothBlockModel173" or v.Name == "SmoothBlockModel176" or v.Name == "SmoothBlockModel179" or v.Name == "SmoothBlockModel185" or v.Name == "SmoothBlockModel186" or v.Name == "SmoothBlockModel190" or v.Name == "SmoothBlockModel191" or v.Name == "SmoothBlockModel196" or v.Name == "SmoothBlockModel197" or v.Name == "SmoothBlockModel198" or v.Name == "SmoothBlockModel20" or v.Name == "SmoothBlockModel201" or v.Name == "SmoothBlockModel203" or v.Name == "SmoothBlockModel205" or v.Name == "SmoothBlockModel207" or v.Name == "SmoothBlockModel208" or v.Name == "SmoothBlockModel209" or v.Name == "SmoothBlockModel210" or v.Name == "SmoothBlockModel211" or v.Name == "SmoothBlockModel213" or v.Name == "SmoothBlockModel218" or v.Name == "SmoothBlockModel22" or v.Name == "SmoothBlockModel223" or v.Name == "SmoothBlockModel224" or v.Name == "SmoothBlockModel226" or v.Name == "SmoothBlockModel26" or v.Name == "SmoothBlockModel29" or v.Name == "SmoothBlockModel30" or v.Name == "SmoothBlockModel31" or v.Name == "SmoothBlockModel36" or v.Name == "SmoothBlockModel37" or v.Name == "SmoothBlockModel38" or v.Name == "SmoothBlockModel39" or v.Name == "SmoothBlockModel41" or v.Name == "SmoothBlockModel48" or v.Name == "SmoothBlockModel49" or v.Name == "SmoothBlockModel51" or v.Name == "SmoothBlockModel56" or v.Name == "SmoothBlockModel67" or v.Name == "SmoothBlockModel68" or v.Name == "SmoothBlockModel69" or v.Name == "SmoothBlockModel70" or v.Name == "SmoothBlockModel72" or v.Name == "SmoothBlockModel75" or v.Name == "SmoothBlockModel8" or v.Name == "SmoothBlockModel81" or v.Name == "SmoothBlockModel85" or v.Name == "SmoothBlockModel93" or v.Name == "SmoothBlockModel98" then
				colorAPI.color(v,Walls)
			end
			if v.Name == "SmoothBlockModel10" or v.Name == "SmoothBlockModel101" or v.Name == "SmoothBlockModel117" or v.Name == "SmoothBlockModel121" or v.Name == "SmoothBlockModel144" or v.Name == "SmoothBlockModel145" or v.Name == "SmoothBlockModel146" or v.Name == "SmoothBlockModel148" or v.Name == "SmoothBlockModel150" or v.Name == "SmoothBlockModel159" or v.Name == "SmoothBlockModel161" or v.Name == "SmoothBlockModel171" or v.Name == "SmoothBlockModel174" or v.Name == "SmoothBlockModel175" or v.Name == "SmoothBlockModel181" or v.Name == "SmoothBlockModel182" or v.Name == "SmoothBlockModel183" or v.Name == "SmoothBlockModel192" or v.Name == "SmoothBlockModel194" or v.Name == "SmoothBlockModel195" or v.Name == "SmoothBlockModel199" or v.Name == "SmoothBlockModel204" or v.Name == "SmoothBlockModel206" or v.Name == "SmoothBlockModel212" or v.Name == "SmoothBlockModel217" or v.Name == "SmoothBlockModel228" or v.Name == "SmoothBlockModel24" or v.Name == "SmoothBlockModel27" or v.Name == "SmoothBlockModel35" or v.Name == "SmoothBlockModel4" or v.Name == "SmoothBlockModel43" or v.Name == "SmoothBlockModel45" or v.Name == "SmoothBlockModel46" or v.Name == "SmoothBlockModel50" or v.Name == "SmoothBlockModel53" or v.Name == "SmoothBlockModel57" or v.Name == "SmoothBlockModel60" or v.Name == "SmoothBlockModel64" or v.Name == "SmoothBlockModel65" or v.Name == "SmoothBlockModel66" or v.Name == "SmoothBlockModel7" or v.Name == "SmoothBlockModel71" or v.Name == "SmoothBlockModel73" or v.Name == "SmoothBlockModel82" or v.Name == "SmoothBlockModel83" or v.Name == "SmoothBlockModel89" or v.Name == "SmoothBlockModel99" then
				colorAPI.color(v,OutlinesAndWDWS)
			end
			if v.Name == "SmoothBlockModel100" or v.Name == "SmoothBlockModel102" or v.Name == "SmoothBlockModel104" or v.Name == "SmoothBlockModel107" or v.Name == "SmoothBlockModel109" or v.Name == "SmoothBlockModel110" or v.Name == "SmoothBlockModel111" or v.Name == "SmoothBlockModel119" or v.Name == "SmoothBlockModel12" or v.Name == "SmoothBlockModel120" or v.Name == "SmoothBlockModel123" or v.Name == "SmoothBlockModel124" or v.Name == "SmoothBlockModel125" or v.Name == "SmoothBlockModel127" or v.Name == "SmoothBlockModel128" or v.Name == "SmoothBlockModel133" or v.Name == "SmoothBlockModel136" or v.Name == "SmoothBlockModel137" or v.Name == "SmoothBlockModel138" or v.Name == "SmoothBlockModel139" or v.Name == "SmoothBlockModel141" or v.Name == "SmoothBlockModel143" or v.Name == "SmoothBlockModel149" or v.Name == "SmoothBlockModel151" or v.Name == "SmoothBlockModel152" or v.Name == "SmoothBlockModel153" or v.Name == "SmoothBlockModel156" or v.Name == "SmoothBlockModel157" or v.Name == "SmoothBlockModel158" or v.Name == "SmoothBlockModel16" or v.Name == "SmoothBlockModel163" or v.Name == "SmoothBlockModel167" or v.Name == "SmoothBlockModel168" or v.Name == "SmoothBlockModel169" or v.Name == "SmoothBlockModel17" or v.Name == "SmoothBlockModel170" or v.Name == "SmoothBlockModel172" or v.Name == "SmoothBlockModel177" or v.Name == "SmoothBlockModel18" or v.Name == "SmoothBlockModel180" or v.Name == "SmoothBlockModel184" or v.Name == "SmoothBlockModel187" or v.Name == "SmoothBlockModel188" or v.Name == "SmoothBlockModel189" or v.Name == "SmoothBlockModel19" or v.Name == "SmoothBlockModel193" or v.Name == "SmoothBlockModel2" or v.Name == "SmoothBlockModel200" or v.Name == "SmoothBlockModel202" or v.Name == "SmoothBlockModel21" or v.Name == "SmoothBlockModel214" or v.Name == "SmoothBlockModel215" or v.Name == "SmoothBlockModel216" or v.Name == "SmoothBlockModel219" or v.Name == "SmoothBlockModel220" or v.Name == "SmoothBlockModel221" or v.Name == "SmoothBlockModel222" or v.Name == "SmoothBlockModel225" or v.Name == "SmoothBlockModel227" or v.Name == "SmoothBlockModel229" or v.Name == "SmoothBlockModel23" or v.Name == "SmoothBlockModel230" or v.Name == "SmoothBlockModel231" or v.Name == "SmoothBlockModel25" or v.Name == "SmoothBlockModel28" or v.Name == "SmoothBlockModel32" or v.Name == "SmoothBlockModel33" or v.Name == "SmoothBlockModel34" or v.Name == "SmoothBlockModel42" or v.Name == "SmoothBlockModel44" or v.Name == "SmoothBlockModel47" or v.Name == "SmoothBlockModel54" or v.Name == "SmoothBlockModel55" or v.Name == "SmoothBlockModel58" or v.Name == "SmoothBlockModel59" or v.Name == "SmoothBlockModel6" or v.Name == "SmoothBlockModel61" or v.Name == "SmoothBlockModel62" or v.Name == "SmoothBlockModel63" or v.Name == "SmoothBlockModel74" or v.Name == "SmoothBlockModel76" or v.Name == "SmoothBlockModel77" or v.Name == "SmoothBlockModel78" or v.Name == "SmoothBlockModel79" or v.Name == "SmoothBlockModel80" or v.Name == "SmoothBlockModel84" or v.Name == "SmoothBlockModel86" or v.Name == "SmoothBlockModel87" or v.Name == "SmoothBlockModel88" or v.Name == "SmoothBlockModel90" or v.Name == "SmoothBlockModel91" or v.Name == "SmoothBlockModel92" or v.Name == "SmoothBlockModel94" or v.Name == "SmoothBlockModel95" or v.Name == "SmoothBlockModel96" then
				colorAPI.color(v,Roof)
			end
			if v.Name == "SmoothBlockModel160" or v.Name == "SmoothBlockModel165" or v.Name == "SmoothBlockModel178" or v.Name == "SmoothBlockModel162" then
				colorAPI.color(v,ChimneyTopParts)
			end
			if v.Name == "SmoothBlockModel1" or v.Name == "SmoothBlockModel5" or v.Name == "SmoothBlockModel3" or v.Name == "SmoothBlockModel9" then
				colorAPI.color(v,Extra.stairsC)
			end
			if v.Name == "SmoothBlockModel97" or v.Name == "SmoothBlockModel52" then
				colorAPI.color(v,Extra.rooftsC)
			end
		end))
	end
	colorAPI.color(workspace.Terrain._Game.Workspace["Basic House"].SmoothBlockModel40,Extra.baseC)
	colorAPI.color(workspace.Terrain._Game.Workspace["Basic House"].SmoothBlockModel112,Extra.floorC)
end
colorAPI.colorBuildingBricks = function(Extra)
	for i,v in pairs(bricks) do
		coroutine.resume(coroutine.create(function()
			if v.Name == "Part31" or v.Name == "Part29" or v.Name == "Part55" then
				colorAPI.color(v,Extra.DarkStoneGrey)
			elseif v.Name == "Part43" or v.Name == "Part3" or v.Name == "Part25" or v.Name == "Part18" or v.Name == "Part11" then
				colorAPI.color(v,Extra.DeepBlue)
			elseif v.Name == "Part44" or v.Name == "Part6" or v.Name == "Part24" or v.Name == "Part15" or v.Name == "Part12" then
				colorAPI.color(v,Extra.NY)
			elseif v.Name == "Part7" or v.Name == "Part13" or v.Name == "Part21" or v.Name == "Part23" then
				colorAPI.color(v,Extra.IW)
			elseif v.Name == "Part5" or v.Name == "Part9" or v.Name == "Part17" or v.Name == "Part26" or v.Name == "Part38" then
				colorAPI.color(v,Extra.LimeGreen)
			elseif v.Name == "Part2" or v.Name == "Part14" or v.Name == "Part19" or v.Name == "Part27" then
				colorAPI.color(v,Extra.RB)
			elseif v.Name == "Part1" or v.Name == "Part10" or v.Name == "Part16" or v.Name == "Part22" or v.Name == "Part37" then
				colorAPI.color(v,Extra.RR)
			elseif v.Name == "Part45" or v.Name == "Part4" or v.Name == "Part8" or v.Name == "Part20" or v.Name == "Part28" then
				colorAPI.color(v,Extra.TP)
			else
				colorAPI.color(v,Extra.MSG)
			end
		end))
	end
end
colorAPI.colorObbyBox = function(clr)
	for i,v in pairs(workspace.Terrain._Game.Workspace["Obby Box"]:GetChildren()) do
		coroutine.resume(coroutine.create(function()
			colorAPI.color(v,clr)
		end))
	end
end
colorAPI.colorObbyBricks = function(clr)
	for i,brick in pairs(obbyBricks) do
		coroutine.resume(coroutine.create(function()
			colorAPI.color(brick,clr)
		end))
	end
end
colorAPI.colorAdminDivs = function(clr)
	for i,div in pairs(adminDivs) do
		coroutine.resume(coroutine.create(function()
			colorAPI.color(div,clr)
		end))
	end
end
colorAPI.colorPads = function(clr)
	for i,pad in pairs(adminPads) do
		coroutine.resume(coroutine.create(function()
			colorAPI.color(pad.Head,clr)
		end))
	end
end
colorAPI.colorRegen = function(clr)
	if workspace.Terrain._Game.Admin:FindFirstChild("Regen") then
		colorAPI.color(workspace.Terrain._Game.Admin.Regen,clr)
	end    
end    
colorAPI.colorPad = function(pad,clr)
	if pad ~= nil and typeof(pad) == "Instance" then
		coroutine.resume(coroutine.create(function()
			colorAPI.color(pad,clr)
		end))    
	end
end
transformToColor3 = colorAPI.transformToColor3
colorAPI.colorallOriginal = function()
	Chat("gear me 00000000000000000018474459")
	repeat task.wait(.1) until plrys.LocalPlayer.Backpack:FindFirstChild("PaintBucket")
	plrys.LocalPlayer.Character.Humanoid:EquipTool(plrys.LocalPlayer.Backpack.PaintBucket)
	task.wait(.28)
	coroutine.resume(coroutine.create(function()
		colorAPI.colorHouse({
			wallsC = colorAPI.transformToColor3(BrickColor.new("Brick yellow")),
			baseC = colorAPI.transformToColor3(BrickColor.new("Bright green")),
			roofC = colorAPI.transformToColor3(BrickColor.new("Bright red")),
			WANDDC = colorAPI.transformToColor3(BrickColor.new("Dark orange")),
			stairsC = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
			floorC = colorAPI.transformToColor3(BrickColor.new("Medium blue")),
			rooftsC = colorAPI.transformToColor3(BrickColor.new("Reddish brown")),
			chiC = colorAPI.transformToColor3(BrickColor.new("Sand red"))
		})
	end))
	coroutine.resume(coroutine.create(function()
		colorAPI.colorBuildingBricks({
			DarkStoneGrey = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
			DeepBlue = colorAPI.transformToColor3(BrickColor.new("Deep blue")),
			NY = colorAPI.transformToColor3(BrickColor.new("New Yeller")),
			IW = colorAPI.transformToColor3(BrickColor.new("Institutional white")),
			LimeGreen = colorAPI.transformToColor3(BrickColor.new("Lime green")),
			MSG = colorAPI.transformToColor3(BrickColor.new("Medium Stone grey")),
			RB = colorAPI.transformToColor3(BrickColor.new("Really black")),
			TP = colorAPI.transformToColor3(BrickColor.new("Toothpaste")),
			RR = colorAPI.transformToColor3(BrickColor.new("Really red"))
		})
	end))
	colorAPI.color(workspace.Terrain._Game.Workspace.Baseplate,colorAPI.transformToColor3(BrickColor.new("Bright green")))
	coroutine.resume(coroutine.create(function()
		colorAPI.colorObbyBox(colorAPI.transformToColor3(BrickColor.new("Teal")))
	end))
	coroutine.resume(coroutine.create(function()
		colorAPI.colorObbyBricks(colorAPI.transformToColor3(BrickColor.new("Really red")))
	end))
	coroutine.resume(coroutine.create(function()
		colorAPI.colorAdminDivs(colorAPI.transformToColor3(BrickColor.new("Dark stone grey")))
	end))
	coroutine.resume(coroutine.create(function()
		for i,pad in pairs(adminPads) do
			if pad.Name ~= "Touch to get admin" then
				colorAPI.color(pad.Head,colorAPI.transformToColor3(BrickColor.new("Bright red"))) 
			else
				colorAPI.color(pad.Head,colorAPI.transformToColor3(BrickColor.new("Bright green")))
			end      
		end 
	end))
	colorAPI.colorRegen(colorAPI.transformToColor3(BrickColor.new("Bright violet")))
	task.wait(.6)
	Chat("ungear me "..math.random(2069))
end
colorAPI.colorallOriginal = colorAPI.colorallOriginal
colorAPI.colorAllOriginal = colorAPI.colorallOriginal
colorAPI.colorallRandom = function()
	game:GetService("Players"):Chat("gear me 00000000000000000018474459")
	repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("PaintBucket")
	repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack.PaintBucket:FindFirstChild("Handle")
	game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
	task.wait(.25)
	for i,v in pairs(workspace:GetDescendants()) do
		coroutine.wrap(function()
			if v:IsA("Part") then
				colorAPI.color(v,Color3.new(math.random(0,255),math.random(0,255),math.random(0,255)))
			end
		end)()
	end
	task.wait(.4)
	Chat("ungear me")
	game:GetService("RunService").Heartbeat:Wait()
	Chat("unpaint me")
end
colorAPI.colorAllRandom = colorAPI.colorallRandom
colorAPI.colorallRandom = colorAPI.colorallRandom
