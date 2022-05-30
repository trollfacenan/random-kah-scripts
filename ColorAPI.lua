-- 

local colorAPI = {}
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
colorAPI.color = function(prt, clr)
	--from siyamicik's colorapi2.0 (https://raw.githubusercontent.com/Qltxi/scripts/main/Color%20API%202.0) (needed it cuz speed boost)
	local thread = coroutine.create(function()
		local Arguments =
			{
				["Part"] = prt,
				["Color"] = clr
			}
		game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name].PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", Arguments)
	end)
	coroutine.resume(thread)
end
colorAPI.colorHouse = function(Extra)
	for i,v in pairs(house) do
		--this is from my script
		coroutine.wrap(function()
			if v.Name == "SmoothBlockModel103" or v.Name == "SmoothBlockModel105" or v.Name == "SmoothBlockModel106" or v.Name == "SmoothBlockModel108" or v.Name == "SmoothBlockModel11" or v.Name == "SmoothBlockModel113" or v.Name == "SmoothBlockModel114" or v.Name == "SmoothBlockModel115" or v.Name == "SmoothBlockModel116" or v.Name == "SmoothBlockModel118" or v.Name == "SmoothBlockModel122" or v.Name == "SmoothBlockModel126" or v.Name == "SmoothBlockModel129" or v.Name == "SmoothBlockModel13" or v.Name == "SmoothBlockModel130" or v.Name == "SmoothBlockModel131" or v.Name == "SmoothBlockModel132" or v.Name == "SmoothBlockModel134" or v.Name == "SmoothBlockModel135" or v.Name == "SmoothBlockModel14" or v.Name == "SmoothBlockModel140" or v.Name == "SmoothBlockModel142" or v.Name == "SmoothBlockModel147" or v.Name == "SmoothBlockModel15" or v.Name == "SmoothBlockModel154" or v.Name == "SmoothBlockModel155" or v.Name == "SmoothBlockModel164" or v.Name == "SmoothBlockModel166" or v.Name == "SmoothBlockModel173" or v.Name == "SmoothBlockModel176" or v.Name == "SmoothBlockModel179" or v.Name == "SmoothBlockModel185" or v.Name == "SmoothBlockModel186" or v.Name == "SmoothBlockModel190" or v.Name == "SmoothBlockModel191" or v.Name == "SmoothBlockModel196" or v.Name == "SmoothBlockModel197" or v.Name == "SmoothBlockModel198" or v.Name == "SmoothBlockModel20" or v.Name == "SmoothBlockModel201" or v.Name == "SmoothBlockModel203" or v.Name == "SmoothBlockModel205" or v.Name == "SmoothBlockModel207" or v.Name == "SmoothBlockModel208" or v.Name == "SmoothBlockModel209" or v.Name == "SmoothBlockModel210" or v.Name == "SmoothBlockModel211" or v.Name == "SmoothBlockModel213" or v.Name == "SmoothBlockModel218" or v.Name == "SmoothBlockModel22" or v.Name == "SmoothBlockModel223" or v.Name == "SmoothBlockModel224" or v.Name == "SmoothBlockModel226" or v.Name == "SmoothBlockModel26" or v.Name == "SmoothBlockModel29" or v.Name == "SmoothBlockModel30" or v.Name == "SmoothBlockModel31" or v.Name == "SmoothBlockModel36" or v.Name == "SmoothBlockModel37" or v.Name == "SmoothBlockModel38" or v.Name == "SmoothBlockModel39" or v.Name == "SmoothBlockModel41" or v.Name == "SmoothBlockModel48" or v.Name == "SmoothBlockModel49" or v.Name == "SmoothBlockModel51" or v.Name == "SmoothBlockModel56" or v.Name == "SmoothBlockModel67" or v.Name == "SmoothBlockModel68" or v.Name == "SmoothBlockModel69" or v.Name == "SmoothBlockModel70" or v.Name == "SmoothBlockModel72" or v.Name == "SmoothBlockModel75" or v.Name == "SmoothBlockModel8" or v.Name == "SmoothBlockModel81" or v.Name == "SmoothBlockModel85" or v.Name == "SmoothBlockModel93" or v.Name == "SmoothBlockModel98" then
				spawn(function()
					local clr = Extra.wallsC
					colorAPI.color(v, clr)
				end)
			end
			if v.Name == "SmoothBlockModel10" or v.Name == "SmoothBlockModel101" or v.Name == "SmoothBlockModel117" or v.Name == "SmoothBlockModel121" or v.Name == "SmoothBlockModel144" or v.Name == "SmoothBlockModel145" or v.Name == "SmoothBlockModel146" or v.Name == "SmoothBlockModel148" or v.Name == "SmoothBlockModel150" or v.Name == "SmoothBlockModel159" or v.Name == "SmoothBlockModel161" or v.Name == "SmoothBlockModel171" or v.Name == "SmoothBlockModel174" or v.Name == "SmoothBlockModel175" or v.Name == "SmoothBlockModel181" or v.Name == "SmoothBlockModel182" or v.Name == "SmoothBlockModel183" or v.Name == "SmoothBlockModel192" or v.Name == "SmoothBlockModel194" or v.Name == "SmoothBlockModel195" or v.Name == "SmoothBlockModel199" or v.Name == "SmoothBlockModel204" or v.Name == "SmoothBlockModel206" or v.Name == "SmoothBlockModel212" or v.Name == "SmoothBlockModel217" or v.Name == "SmoothBlockModel228" or v.Name == "SmoothBlockModel24" or v.Name == "SmoothBlockModel27" or v.Name == "SmoothBlockModel35" or v.Name == "SmoothBlockModel4" or v.Name == "SmoothBlockModel43" or v.Name == "SmoothBlockModel45" or v.Name == "SmoothBlockModel46" or v.Name == "SmoothBlockModel50" or v.Name == "SmoothBlockModel53" or v.Name == "SmoothBlockModel57" or v.Name == "SmoothBlockModel60" or v.Name == "SmoothBlockModel64" or v.Name == "SmoothBlockModel65" or v.Name == "SmoothBlockModel66" or v.Name == "SmoothBlockModel7" or v.Name == "SmoothBlockModel71" or v.Name == "SmoothBlockModel73" or v.Name == "SmoothBlockModel82" or v.Name == "SmoothBlockModel83" or v.Name == "SmoothBlockModel89" or v.Name == "SmoothBlockModel99" then
				spawn(function()
					local clr = Extra.WANDDC
					colorAPI.color(v, clr)
				end)
			end
			if v.Name == "SmoothBlockModel100" or v.Name == "SmoothBlockModel102" or v.Name == "SmoothBlockModel104" or v.Name == "SmoothBlockModel107" or v.Name == "SmoothBlockModel109" or v.Name == "SmoothBlockModel110" or v.Name == "SmoothBlockModel111" or v.Name == "SmoothBlockModel119" or v.Name == "SmoothBlockModel12" or v.Name == "SmoothBlockModel120" or v.Name == "SmoothBlockModel123" or v.Name == "SmoothBlockModel124" or v.Name == "SmoothBlockModel125" or v.Name == "SmoothBlockModel127" or v.Name == "SmoothBlockModel128" or v.Name == "SmoothBlockModel133" or v.Name == "SmoothBlockModel136" or v.Name == "SmoothBlockModel137" or v.Name == "SmoothBlockModel138" or v.Name == "SmoothBlockModel139" or v.Name == "SmoothBlockModel141" or v.Name == "SmoothBlockModel143" or v.Name == "SmoothBlockModel149" or v.Name == "SmoothBlockModel151" or v.Name == "SmoothBlockModel152" or v.Name == "SmoothBlockModel153" or v.Name == "SmoothBlockModel156" or v.Name == "SmoothBlockModel157" or v.Name == "SmoothBlockModel158" or v.Name == "SmoothBlockModel16" or v.Name == "SmoothBlockModel163" or v.Name == "SmoothBlockModel167" or v.Name == "SmoothBlockModel168" or v.Name == "SmoothBlockModel169" or v.Name == "SmoothBlockModel17" or v.Name == "SmoothBlockModel170" or v.Name == "SmoothBlockModel172" or v.Name == "SmoothBlockModel177" or v.Name == "SmoothBlockModel18" or v.Name == "SmoothBlockModel180" or v.Name == "SmoothBlockModel184" or v.Name == "SmoothBlockModel187" or v.Name == "SmoothBlockModel188" or v.Name == "SmoothBlockModel189" or v.Name == "SmoothBlockModel19" or v.Name == "SmoothBlockModel193" or v.Name == "SmoothBlockModel2" or v.Name == "SmoothBlockModel200" or v.Name == "SmoothBlockModel202" or v.Name == "SmoothBlockModel21" or v.Name == "SmoothBlockModel214" or v.Name == "SmoothBlockModel215" or v.Name == "SmoothBlockModel216" or v.Name == "SmoothBlockModel219" or v.Name == "SmoothBlockModel220" or v.Name == "SmoothBlockModel221" or v.Name == "SmoothBlockModel222" or v.Name == "SmoothBlockModel225" or v.Name == "SmoothBlockModel227" or v.Name == "SmoothBlockModel229" or v.Name == "SmoothBlockModel23" or v.Name == "SmoothBlockModel230" or v.Name == "SmoothBlockModel231" or v.Name == "SmoothBlockModel25" or v.Name == "SmoothBlockModel28" or v.Name == "SmoothBlockModel32" or v.Name == "SmoothBlockModel33" or v.Name == "SmoothBlockModel34" or v.Name == "SmoothBlockModel42" or v.Name == "SmoothBlockModel44" or v.Name == "SmoothBlockModel47" or v.Name == "SmoothBlockModel54" or v.Name == "SmoothBlockModel55" or v.Name == "SmoothBlockModel58" or v.Name == "SmoothBlockModel59" or v.Name == "SmoothBlockModel6" or v.Name == "SmoothBlockModel61" or v.Name == "SmoothBlockModel62" or v.Name == "SmoothBlockModel63" or v.Name == "SmoothBlockModel74" or v.Name == "SmoothBlockModel76" or v.Name == "SmoothBlockModel77" or v.Name == "SmoothBlockModel78" or v.Name == "SmoothBlockModel79" or v.Name == "SmoothBlockModel80" or v.Name == "SmoothBlockModel84" or v.Name == "SmoothBlockModel86" or v.Name == "SmoothBlockModel87" or v.Name == "SmoothBlockModel88" or v.Name == "SmoothBlockModel90" or v.Name == "SmoothBlockModel91" or v.Name == "SmoothBlockModel92" or v.Name == "SmoothBlockModel94" or v.Name == "SmoothBlockModel95" or v.Name == "SmoothBlockModel96" then
				spawn(function()
					local clr = Extra.roofC
					colorAPI.color(v, clr)
				end)
			end
		end)()
	end
	colorAPI.color(workspace.Terrain["_Game"].Workspace["Basic House"].SmoothBlockModel40,Extra.baseC)
	coroutine.wrap(function()
		for i,v in pairs(house) do
			if v.Name == "SmoothBlockModel1" or v.Name == "SmoothBlockModel5" or v.Name == "SmoothBlockModel3" or v.Name == "SmoothBlockModel9" then
				spawn(function()
					colorAPI.color(v,Extra.stairsC)
				end)
			end
			if v.Name == "SmoothBlockModel97" or v.Name == "SmoothBlockModel52" then
				spawn(function()
					colorAPI.color(v,Extra.rooftsC)
				end)
			end
		end
		coroutine.resume(coroutine.create(function()
			colorAPI.color(workspace.Terrain._Game.Workspace["Basic House"].SmoothBlockModel112,Extra.floorC)
		end))
	end)()
end
colorAPI.colorBuildingBricks = function(Extra)
	spawn(function()
		for i,v in pairs(bricks) do
			spawn(function()
				if v.Name == "Part31" or v.Name == "Part29" or v.Name == "Part55" then
					spawn(function()
						colorAPI.color(v,Extra.DarkStoneGrey)
					end)
				elseif v.Name == "Part43" or v.Name == "Part3" or v.Name == "Part25" or v.Name == "Part18" or v.Name == "Part11" then
					spawn(function()
						colorAPI.color(v,Extra.DeepBlue)
					end)
				elseif v.Name == "Part44" or v.Name == "Part6" or v.Name == "Part24" or v.Name == "Part15" or v.Name == "Part12" then
					spawn(function()
						colorAPI.color(v,Extra.NY)
					end)
				elseif v.Name == "Part7" or v.Name == "Part13" or v.Name == "Part21" or v.Name == "Part23" then
					spawn(function()
						colorAPI.color(v,Extra.IW)
					end)
				elseif v.Name == "Part5" or v.Name == "Part9" or v.Name == "Part17" or v.Name == "Part26" or v.Name == "Part38" then
					spawn(function()
						colorAPI.color(v,Extra.LimeGreen)
					end)
				elseif v.Name == "Part2" or v.Name == "Part14" or v.Name == "Part19" or v.Name == "Part27" then
					spawn(function()
						colorAPI.color(v,Extra.RB)
					end)
				elseif v.Name == "Part1" or v.Name == "Part10" or v.Name == "Part16" or v.Name == "Part22" or v.Name == "Part37" then
					spawn(function()
						colorAPI.color(v,Extra.RR)
					end)
				elseif v.Name == "Part45" or v.Name == "Part4" or v.Name == "Part8" or v.Name == "Part20" or v.Name == "Part28" then
					spawn(function()
						colorAPI.color(v,Extra.TP)
					end)
				else
					spawn(function()
						colorAPI.color(v,Extra.MSG)
					end)
				end
			end)
		end
	end)
end
colorAPI.colorObbyBox = function(clr)
	coroutine.wrap(function()
		local obbyBox = workspace.Terrain._Game.Workspace["Obby Box"]:GetChildren()
		for i, v in pairs(obbyBox) do
			spawn(function()
				colorAPI.color(v,clr)
			end)
		end
	end)()
end
colorAPI.colorObbyBricks = function(clr)
	coroutine.wrap(function()
		for i, brick in pairs(obbyBricks) do
			coroutine.wrap(function()
				colorAPI.color(brick, clr)
			end)()
		end
	end)()
end
colorAPI.colorAdminDivs = function(clr)
	for i, div in pairs(adminDivs) do
		spawn(function()
			colorAPI.color(div, clr)
		end)
	end
end
colorAPI.colorPads = function(clr)
	for i, pad in pairs(adminPads) do
		spawn(function()
			colorAPI.color(pad.Head, clr)
		end)
	end
end
transformToColor3 = colorAPI.transformToColor3
colorAPI.colorallOriginal = function()
	game:GetService("Players"):Chat("gear me 00000000000000000018474459")
	wait(1)
	game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
	wait(0.50)
	coroutine.wrap(function()
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
	end)()
	spawn(function()
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
	end)
	colorAPI.color(game.Workspace.Terrain["_Game"].Workspace["Baseplate"], colorAPI.transformToColor3(BrickColor.new("Bright green")))
	spawn(function()
		colorAPI.colorObbyBox(colorAPI.transformToColor3(BrickColor.new("Teal")))
	end)
	spawn(function()
		colorAPI.colorObbyBricks(colorAPI.transformToColor3(BrickColor.new("Really red")))
	end)
	spawn(function()
		colorAPI.colorAdminDivs(colorAPI.transformToColor3(BrickColor.new("Dark stone grey")))
	end)
	spawn(function()
		colorAPI.colorPads(colorAPI.transformToColor3(BrickColor.new("Bright green")))
	end)
	wait(0.6)
	game.Players:Chat("ungear 000000000000000000000000000000000000000000000000000000000 me "..math.random(99999))
end

--colorAPI.colorallOriginal()
colorallOriginal = colorAPI.colorallOriginal
colorAllOriginal = colorAPI.colorallOriginal

colorAPI.colorallRandom = function()
	game:GetService("Players"):Chat("gear me 00000000000000000018474459")
	wait(1)
	game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
	wait(0.50)
	for i, prt in pairs(workspace:GetDescendants()) do
		spawn(function()
			colorAPI.color(prt, Color3.new(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
		end)
	end
end
colorAllRandom = colorAPI.colorallRandom
colorallRandom = colorAPI.colorallRandom
--colorallRandom()
