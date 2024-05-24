-- Discontinued cus this script is bad lol
loadstring(game:HttpGet("https://raw.githubusercontent.com/Amourousity/Conversio/main/source.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Amourousity/Utilitas/main/source.lua"))()

local t = os.time()
local function GetPlayer(text)
	for _,Player in game:GetService("Players"):GetPlayers() do
		if string.sub(string.lower(Player.Name),1,string.len(text)) == string.lower(text) or Player.DisplayName:lower():sub(1, text:len()) == text:lower() then
			return Player
		end
	end
end
local settingsTable = {
	perm = not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserId, 66254), -- this is not the gamepass checker, it's for the pad grabber
	prefix = "-",
	firsttimenotification = true,
	banned = {},
	connections = {},
	no = {"Not_Wojtek"},
	antivg = true, antilogs = false, antigear = false,
	gearwhitelist = {},
	debounce
}
local startupcommands = {
	"nok",
	"iy"
}
if KohlsPlus then
	return
end

if not game:GetService("RunService"):IsStudio() then
	assert(game:GetService("HttpService"):JSONDecode(request({Url = "https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/run.json", Method = "GET"}).Body).works, "Kohls+ is under maintenance, please try again later.")
	getgenv().KohlsPlus = true
	getgenv().syn = nil
end

local function run(message)
	game:GetService("Players"):Chat(message)
end

task.defer(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/trollfacenan/random-kah-scripts/main/AntiFling.lua"))() end)
local isFluxus = identifyexecutor():find("Fluxus")
local recursive_loop
local running = false
recursive_loop = function(func, ...)
	if isFluxus then
		return task.defer(function(...)
			while task.wait() do
				if ... then
					func(...) else
					func()
				end
				task.wait()
			end
		end)
	end
	if running then task.desynchronize()
		task.defer(recursive_loop, func, ...)
		task.synchronize()
		func(...) end
end
local recursive_loop1
recursive_loop1 = function(func, ...)
	if isFluxus then
		return task.defer(function(...)
			while task.wait() do
				if ... then
					func(...) else
					func()
				end
			end
		end)
	end
	task.desynchronize()
	task.defer(recursive_loop1, func, ...)
	task.synchronize()
	func(...)
end
local spamming = ""
local fastspamming = ""
local antipmkickv = true
local commands
commands = {
	["cmds"] = {
		name = "cmds",
		action = function()
			if settingsTable.firsttimenotification then
				settingsTable.firsttimenotification = false
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Commands printed!",
					Text = "Press F9 or type /console in the chat to see the commands."
				})
			end
			print("Kohls+ Commands List")
			for i, v in commands do
				if v.name ~= "cmds" and v.name ~= "test" then
					if v.aliases then
						local function getalia_()
							local aliases = ""
							local exist = #v.aliases
							local done = 0
							for a, b in v.aliases do
								if exist == done then
									done = 0
									aliases = aliases..b.."."
								elseif exist > done then
									done += 1
									aliases = aliases..b..", "
								end
							end
							return aliases
						end
						print(v.name.." - "..v.desc.." - Aliases: "..getalia_())
					else
						print(v.name.." - "..v.desc)
					end
				end
			end
		end,
		desc = "",
		aliases = {"commands"}
	},
	["test"] = {
		name = "test",
		action = function()
			print("test")
		end,
		desc = "Hello :)"
	},
	["ban"] = {
		name = "ban",
		action = function(who: string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if settingsTable.banned[GetPlayer(who)] then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Player is already banned"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer then
				run("pm "..GetPlayer(who).Name.." You have been banned.")
				table.insert(settingsTable.banned, GetPlayer(who).UserId)
			else
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Huh?",
					Text = "Why are you trying to ban yourself?"
				})
			end
		end,
		desc = "Makes the player unable to join the server until unbanned."
	},
	["unban"] = {
		name = "unban",
		action = function(who : string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer and settingsTable.banned[GetPlayer(who)] then
				settingsTable.banned[GetPlayer(who).UserId] = nil
				run("respawn "..GetPlayer(who).Name)
			else
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Cannot unban player",
					Text = "This player isn't banned or she/he is blacklisted by the owner."
				})
			end
		end,
		desc = "Opposite of "..settingsTable.prefix.."ban"
	},
	["kick"] = {
		name = "kick",
		action = function(who : string)
			if not who then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a player"
				})
				return
			end
			if GetPlayer(who) ~= game:GetService("Players").LocalPlayer then
				local plr = GetPlayer(who)
				local name = plr.Name
				run("pm "..who.." You have been locked from this server\nGet Shortcut now")
				settingsTable.connections["Kick"..name] = plr.CharacterAdded:Connect(function()
					settingsTable.connections["_Kick"..name]:Disconnect()
					repeat
						run("refresh "..name)
						run("blind "..name)
						run("kill "..name)
						run("trip "..name)
						run("setgrav "..name.." -100000000000000000000000000")
						run("punish "..name)
						task.wait()
					until not plr or plr.Character.Parent == game:FindService("Lighting") or not plr.Character.Parent
					settingsTable.connections["_Kick"..name] = plr.Character.AncestryChanged:Connect(function(newparent)
						if newparent == workspace then 
							repeat
								run("refresh "..name)
								run("blind "..name)
								run("kill "..name)
								run("trip "..name)
								run("setgrav "..name.." -100000000000000000000000000")
								run("punish "..name)
								task.wait()
							until not plr or game:GetService("Lighting"):FindFirstChild(plr.Name) or not plr.Character.Parent
						end
					end)
				end)
				settingsTable.connections["_Kick"..name] = plr.Character.AncestryChanged:Connect(function(newparent)
					if newparent == workspace then 
						repeat
							run("refresh "..name)
							run("blind "..name)
							run("kill "..name)
							run("trip "..name)
							run("setgrav "..name.." -100000000000000000000000000")
							run("punish "..name)
							task.wait()
						until not plr or game:GetService("Lighting"):FindFirstChild(plr.Name) or not plr.Character.Parent
					end
				end)
				run("refresh "..name)
				run("blind "..name)
				run("kill "..name)
				run("trip "..name)
				run("setgrav "..name.." -100000000000000000000000000")
				run("punish "..name)
			elseif settingsTable.banned[GetPlayer(who).UserId] or settingsTable.no[GetPlayer(who).UserId] then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Cannot kick a banned player."
				})
			end
		end,
		desc = "Makes the player unable to respawn until they rejoin."
	},
	["rj"] = {
		name = "rejoin",
		action = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
		end,
		desc = "Rejoins the server",
		aliases = {"rj"}
	},
	["shop"] = {
		name = "serverhop",
		action = function()
			if identifyexecutor():find("Solara") then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Bad executor",
					Text = "Can't run this command, please use a different executor."
				})
				return "Failed"
			end
			local httprequest = http and http.request or http_request or request or function()
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Bad executor",
					Text = "Can't run this command, please use a different executor."
				})
				return "Failed"
			end
			local servers = {}
			local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
			local body = game:GetService("HttpService"):JSONDecode(req.Body)

			if body and body.data then
				for i, v in next, body.data do
					if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
						table.insert(servers, 1, v.id)
					end
				end
			end

			if #servers > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
			else
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "No other server",
					Text = "This is the only server at the moment, please try again later."
				})
			end
		end,
		desc = "Joins another server",
		aliases = {"shop"}
	},
	["perm"] = {
		name = "perm",
		action = function()
			if settingsTable.perm then
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "You already have Perm",
					Text = "Can't disable Perm because you own the gamepass."
				})
			end
			settingsTable.perm = not settingsTable.perm
		end,
		desc = "Gives you permanent admin pad (Use this command to toggle Perm)",
	},
	["shutdown"] = {
		name = "shutdown",
		action = function(method : string?)
			if method and method:lower() == "vg" or not method then
				if game:GetService("Players").LocalPlayer.Character.Parent ~= workspace then
					return game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Error",
						Text = "Cannot crash while punished, please use \"-shutdown dog\" to crash."
					})
				end
				run("gear me 94794847")
				repeat task.wait() until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher")
				game:FindService("Players").LocalPlayer.Backpack:FindFirstChild("VampireVanquisher").Parent = game:GetService("Players").LocalPlayer.Character
				task.defer(function()
					while task.wait() do
						run("unsize me me me")
					end
				end)
				task.wait(1)
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("VampireVanquisher") then
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Success",
						Text = "Crashed server"
					})
				else
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Failed",
						Text = "Failed to crash server, anticrash is possibly enabled"
					})
				end
			elseif method == "dog" then
				if settingsTable.debounce then
					return
				end
				settingsTable.debounce = true
				task.delay(.5, function()
					settingsTable.debounce = false
				end)
				for i = 1, 52 do
					run("dog all all all						fuck")
				end
				for i = 1, 51 do
					run("clone all all all						fuck")
				end
				while task.wait() do
					run("clone all all all						fuck")
				end	
			elseif method == "blind" then
				if settingsTable.debounce then
					return
				end
				settingsTable.debounce = true
				task.delay(.5, function()
					settingsTable.debounce = false
				end)
				run("brightness -nan")
				run("fogend 0 fuck")
				run("blind others fuck")
				run("time -")
				task.wait(.5)
				for i = 1, 52 do
					run("dog all all all						fuck")
				end
				for i = 1, 51 do
					run("clone all all all						fuck")
				end
				while task.wait() do
					run("clone all all all						fuck")
				end
			elseif method == "respawn" then
				settingsTable.perm = not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserId, 66254)
				task.wait(.125)
				task.spawn(function()
					for i = 1, 350 do
						game.Players:Chat("respawn random random random fuck")
					end
					task.wait(5)
					for i = 1, 350 do
						game.Players:Chat("respawn random random random fuck")
					end
					task.wait(5)
					for i = 1, 30 do
						game.Players:Chat("respawn/random/random/random")
					end
					task.wait(.125)
					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Idk lol",
						Text = "Possibly crashed server"
					})
				end)
			end
		end,
		desc = "Freezes the server you are on. Methods: vg, dog, blind, respawn",
		aliases = {"crash", "stopserver"}
	},
	["nok"] = {
		name = "nok",
		action = function()
			for i, v in workspace.Terrain._Game.Workspace.Obby:GetDescendants() do
				if v:IsA("TouchTransmitter") then
					v:Destroy()
				end
			end
		end,
		desc = "Makes you immune to obby killbricks. *Stays until you rejoin*",
		aliases = {"noobbykill"}
	},
	["antifling"] = {
		name = "antifling",
		action = function()
			if settingsTable.debounce then
				return
			end
			settingsTable.debounce = true
			shared.antifling = not shared.antifling
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Antifling",
				Text = `Now {shared.antifling and "ON" or "OFF"}`
			})
			task.wait(0.5)
			settingsTable.debounce = false
		end,
		desc = "Prevents you from being flinged. (Use this command to toggle Anti-fling)"
	},
	["punish2"] = {
		name = "punish2",
		action = function(target: string)
			run("respawn "..target)
			task.wait()
			for i = 1, 20 do
				run("gear me 139578207")
			end
			repeat task.wait() until #game.Players.LocalPlayer.Backpack:GetChildren() > 6
			task.wait()
			for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
				if v.Name == "TriLaserGun" then
					v.Parent = game:GetService("Players").LocalPlayer.Character
				end
			end
			local removed = false
			local kahcon
			local kahcon2
			local TargetPlayer = GetPlayer(target)
			if not TargetPlayer or TargetPlayer == game:GetService("Players").LocalPlayer then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Please specify a valid player"
				})
				kahcon, kahcon2, TargetPlayer, removed = nil, nil, nil, true
				return
			end
			local name = TargetPlayer.Name
			kahcon = workspace.ChildAdded:Connect(function(v)
				if v.Name == "Effect" then
					task.defer(function()
						repeat 
							task.wait() 
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart, 0)
							firetouchinterestc(v, TargetPlayer.Character.HumanoidRootPart, 1)
						until v.Parent ~= workspace or removed or not kahcon
					end)
				end
			end)
			kahcon2 = TargetPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(Child)
				if Child.Name == "SelectionBox" and not removed then
					removed = true
					task.wait(.4)
					run("punish "..name)
				end
			end)
			for i, v in game:GetService("Players").LocalPlayer.Character:GetChildren() do
				if v.Name == "TriLaserGun" then
					pcall(function()
						v:WaitForChild("Click"):FireServer(TargetPlayer.Character.HumanoidRootPart.Position)
					end)	
				end
			end
			task.defer(function() repeat task.wait() until removed


				kahcon:Disconnect()
				kahcon2:Disconnect() end)
		end,
		desc = "Alternate punish. Makes the player unable to respawn. Sometimes fails"
	},
	["stop"] = {
		name = "stop",
		action = function()
			running = false
			spamming = ""
			fastspamming = ""
		end,
		desc = "Stops spamming commands"
	},
	["spam"] = {
		name = "spam",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No command provided"
				})
				return
			end
			spamming = command
		end,
		desc = "Spams the command that you want to."
	},
	["fastspam"] = {
		name = "fastspam",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No command provided"
				})
				return
			end
			fastspamming = command
		end,
		desc = "Spams the command that you want to but faster."
	},
	["prefix"] = {
		name = "prefix",
		action = function(command: string)
			if not command then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No prefix provided"
				})
				return
			end
			settingsTable.prefix = command
		end,
		desc = "Changes your command prefix."
	},
	["rkick"] = {
		name = "rkick",
		action = function(user: string)
			if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game:GetService("Players").LocalPlayer.UserId, 35748) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "P299 admin not found. This command is unavailable for you."
				})
				return
			end
			if not user or not GetPlayer(user) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "No player/invalid player specified."
				})
				return
			end
			local u = GetPlayer(user)
			run("respawn "..u.Name.." fuck																			")
			task.wait(.1)
			run("jail/"..u.Name)
			shared.antifling = true
			task.wait(.3)
			for i = 1, 128 do
				run("rocket/me "..u.Name.." me "..u.Name)
			end
			running = true
			task.spawn(function()
				while running and u ~= nil do
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (u.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(180),0)*CFrame.new(0,0,-2))
					run("rocket/ all all all")
					task.wait(0.1)
				end
			end)
		end,
		desc = "Kicks someone using rockets. P299 required"
	},
	["lagall"] = {
		name = "templagall",
		action = function()
			if #game:GetService("Players"):GetPlayers() < 4 then
				return game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Error",
					Text = "Insufficient amount of players (min. 4)"
				})
			end
			task.spawn(function()
				running = true
				while task.wait() do
					run("respawn all all all")
					if not running then break end
				end
			end)
			task.wait(10)
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
		end,
		desc = "Temporarily lags everyone using respawn."
	},
	["lagall2"] = {
		name = "lagall",
		action = function()
			local loop_dogs = {}
			local stopped = false
			task.defer(function()
				task.wait(30)
				stopped = true
				run("fix")
				run("unblind all")
			end)
			task.spawn(function()
				run("blind all")
				run("brightness -nan")
				run("fogend 0 fuck")
				run("blind others fuck")
				run("time -")
				for i = 1, 52 do
					run("dog all all all")
				end
			end)
			task.wait(.25)
			task.spawn(function()
				while task.wait() do
					if stopped then break end
					run("tp all all all")
					task.wait()
					run("stand all all all")
					if stopped then break end
				end
			end)
		end,
		desc = "Atleast 5 players is needed to crash others"
	},
	["aa"] = {
		name = "iy",
		action = function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		end,
		desc = "Loads Infinite Yield"
	},
	["breakserver"] = {
		name = "breakserver",
		action = function()
			settingsTable.antigear = false
			run("gear all 000000000000000000000000000000004842204072")
			run("blind all fuck")
			run("brightness -nan")
			run("time -")
			run("gear all 00000000000000000000000000000000253519495")
			run("ungear all all all fuck")
			run("gear all 00000000000000000000000000000000253519495")
			run("punish all fuck")
			run("trip others fuck")
			run("setgrav others -inf")
			run("speed others 000000000000000000000")
			run("unpunish me fuck")
			run("unpunish me fuck")
			run("gear all 00000000000000000000000000000000253519495")
			task.spawn(function()
				for i = 1, 99 do
					run("gear all 00000000000000000000000000000000253519495")
				end
				task.wait(.1)
				for i = 1, 99 do
					run("gear all 00000000000000000000000000000000253519495")
				end
				task.wait(.1)
				for i = 1, 99 do
					run("gear all 00000000000000000000000000000000253519495")
				end
				task.wait(.1)
			end)
			run(settingsTable.prefix.."fixcam")
		end,
		desc = "Makes the server unplayable for some time."
	},
	["breakserve"] = {
		name = "breakcam",
		action = function()
			task.spawn(function()
				for i = 1, 32 do
					run("gear all 4842204072										fuck")
				end
			end)
		end,
		desc = "Prevents everyone from moving their camera"	
	},
	["fixcam"] = {
		name = "fixcam",
		action = function()
			-- i don't know who made this but this isn't mine!
			task.spawn(function()
				local lp = game.Players.LocalPlayer
				local ui = game:GetService("UserInputService")
				local l__ContextActionService__7 = game:GetService("ContextActionService");
				local l__RunService__1 = game:GetService('RunService')
				l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
				l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
				l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
				while true do
					repeat game:GetService'RunService'.Heartbeat:Wait() until game.Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable
					l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
					l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
					l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
					local wepsys = game:GetService("ReplicatedStorage"):FindFirstChild('WeaponsSystem')
					if not wepsys then return end
					for i,v in pairs(wepsys:GetDescendants()) do
						if v:IsA("Script") then
							v.Disabled = true
						end
						v:Destroy()
					end
					local wep = lp.PlayerGui:FindFirstChild("ClientWeaponsScript")
					local gui = lp.PlayerGui:FindFirstChild("WeaponsSystemGui")
					local sc = lp.PlayerScripts:FindFirstChild("ClientWeaponsScript")
					if wep then wep.Disabled = true wep:Destroy() end
					if gui then gui:Destroy() end
					if sc then
						sc.Disabled = true
						sc:Destroy()
					end
					ui.MouseIconEnabled = true
					game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
					game.Workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
					lp.Character.Humanoid.AutoRotate = true
				end
			end)
		end,
		desc = "Undoes "..settingsTable.prefix.."breakcam *Clientsided*"
	},
	["emergency"] = {
		name = "emr",
		action = function()
			local function whatihas()
				local MarketplaceService = game:GetService("MarketplaceService")
				local Players = game:GetService("Players")
				local LocalPlayer = Players.LocalPlayer
				local gameFlr = workspace.Terrain._Game
				local adminFlr = gameFlr.Admin
				local pc1 = (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 35748) or MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 37127))
				local pc2 = (MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 66254) or MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 64354))
				if pc1 and pc2 then
					task.spawn(function()
						for i = 1, 256 do
							run("respawn random													fuck")
							run("respawn/										random")
							for i = 1,4 do
								for i = 1, 32 do
									run("shield/others/others/others")
								end
							end
							task.wait(.5)
							for i = 1, 32 do
								run("sparkles/others/others/others")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("rocket/others/others/others")
							end
							task.wait(.5)
							for i = 1, 32 do
								run("rocket/others/others/others")
							end
							task.wait(.5)
							for i = 1, 32 do
								run("rocket/others/others/others")
							end
							task.wait(.6)
							for i = 1, 32 do
								run("dog all all all										fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("ff all all all										fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("sparkles all all all										fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("clone all all all										fuck")
							end
							task.wait(.1)
							for i = 1, 9 do
								-- Incase the server somehow survived silcrash lmfao
								run("pm/others \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁😝😆😊😅😀😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁😝😆😊😅😀😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁🤪😜😁🤪🤪\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
							end
							task.wait(.22)
							for i = 1, 2 do
								run("gear all 94794847										fuck")
							end
							task.wait(.1)
							for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
								v.Parent = game:GetService("Players").LocalPlayer.Character
							end
						end
					end)
				elseif pc1 and not pc2 then
					task.spawn(function()
						for i = 1, 256 do
							run("respawn/															random")
							for i = 1, 3 do
								for i = 1, 32 do
									run("shield/others/others/others")
								end
							end
							task.wait(.1)
							for i = 1, 32 do
								run("rocket/others/others/others									fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("sparkles/others/others/others									fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("sparkles/others/others/others									fuck")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("part/10/10/10")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("h/ Lol so this server got crashed with emergency crash and you should leave it lol lol lol lol lol Lol so this server got crashed with emergency crash and you should leave it lol lol lol lol lol \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Server is crashed lol \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
							end
							task.wait(.1)
							for i = 1, 32 do
								run("part/10/10/10")
							end
							task.wait(.1)
							for i = 1, 9 do
								-- Attempting crash
								run("pm/others \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁😝😆😊😅😀😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁😝😆😊😅😀😆😊😅😀🙃😝😇😇😇🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤪😀😆🤪😆😇😅😉🤣🤪🤣🙂😅😅😁😄😉😀😊🤪😇😄😇😀😝😀😊\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁🤪😜😁🤪🤪\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
							end
							task.wait(.15)
							if adminFlr.Pads:FindFirstChild(game:GetService("Players").LocalPlayer.."'s admin") then
								run("respawn random													fuck")
								run("h pc potato chips \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n server got destroyed \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
								for i = 1, 32 do
									run("gear all 94794847")
								end
								task.wait(.4)
								for i = 1, 32 do
									run("gear all 4842204072")
								end
								task.wait(.4)
								for i = 1, 32 do
									run("gear all 00000000000000000000000000000000253519495")
								end
								task.wait()
								for i = 1, 32 do
									run("clone all all all										fuck")
								end
								task.wait(.4)
								for i = 1, 32 do
									run("gear all 94794847										fuck")
								end
								task.wait(.1)
								for i, v in game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
									v.Parent = game:GetService("Players").LocalPlayer.Character
								end
							end
						end
					end)
				elseif not pc1 and pc2 then
					task.spawn(function()
						for i = 1, 999 do
							for i = 1, 5 do
								run("gear all 00000000000000000000000000000000253519495")
							end
							task.wait(.98)
						end
					end)
				end
				print('emr lol lol lol')
			end
			print("emergency situation")
			whatihas()
			print("crashed lol lol lol")
		end,
		desc = "Alternate way to crash the server if -shutdown fails (P299 or Perm required)"
	},
	["emergency2"] = {
		name = "carlag",
		action = function()
			local function whatihas()
				task.spawn(function()
					run("gear all 4842204072										fuck")
					run("respawn random random random									fuck")
					while task.wait() do
						settingsTable.perm = true
						settingsTable.antivg = false
						run("gear all 00000000000000000000000000000000253519495										fuck")
					end
				end)
			end
			whatihas()
		end,
		desc = settingsTable.prefix.."emr without Perm or P299"
	},
	["safelogs"] = {
		name = "lgs",
		action = function()
			run("logs aaee me fuck											")
		end,
		desc = "Bypasses antilogs if someone has it"
	},
	["antilogs"] = {
		name = "antilogs",
		action = function()
			if settingsTable.debounce then
				return
			end
			settingsTable.debounce = true
			task.delay(.5, function()
				settingsTable.debounce = false
			end)
			settingsTable.antilogs = not settingsTable.antilogs
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Antilogs",
				Text = `Now {settingsTable.antilogs and "ON" or "OFF"}`
			})
			run("when the laura will hate you")
		end,
		desc = "Prevents people from seeing logs"
	},
	["gggggg"] = {
		name = "abomination",
		action = function(user: string)
			if not user or not GetPlayer(user) then
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Invalid player",
					Text = "Make sure that there are no typos in the name."
				})
				return
			end
			local name = GetPlayer(user).Name
			run("invisible "..name)
			run("size "..name.." 0.3")
			run("dog "..name)
			run("removeclones (tech loves men)")
			run("size "..name.." 10")
			run("creeper "..name)
			run("size "..name.." nan")
			run("paint "..name.." brown")
			run("visible "..name)
		end,
		desc = "turns the player into an abomination"
	},
	["antigear"] = {
		name = "antilogs",
		action = function()
			if settingsTable.debounce then
				return
			end
			settingsTable.debounce = true
			task.delay(.5, function()
				settingsTable.debounce = false
			end)
			settingsTable.antigear = not settingsTable.antigear
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Antilogs",
				Text = `Now {settingsTable.antigear and "ON" or "OFF"}`
			})
			run("h \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n what the hell \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
		end,
		desc = "Toggles anti-gear (default: off)"
	}
}


game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	local user = msg:split(" ")
	for i, v in commands do
		if msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."fastspam") then
			fastspamming = msg:sub(11)
		elseif msg:find(settingsTable.prefix..v.name) and user[2] and msg:match(settingsTable.prefix.."spam") then
			spamming = msg:sub(7)
		elseif msg:match(settingsTable.prefix..v.name) or v.aliases and v.aliases[msg] ~= nil and user[2] then
			v.action(user[2])
		elseif msg:match(settingsTable.prefix..v.name) or v.aliases and v.aliases[msg] ~= nil and not user[2] then
			v.action()
		end
	end
end)

for i, v in startupcommands do
	run(settingsTable.prefix..v)
end

local function antirkick(character)
	task.wait(.2)
	character.ChildAdded:Connect(function(rocket)
		if rocket.Name == "Rocket" then
			task.wait(.1)
			rocket:Destroy()
		end
	end)
end

for i, v in game:FindService("Players"):GetPlayers() do
	pcall(antirkick, v.Character)
	v.CharacterAdded:Connect(function() antirkick(v.Character) end)
end
game:GetService("Players").PlayerAdded:Connect(function(v)
	pcall(antirkick, v.Character)
	v.CharacterAdded:Connect(function() antirkick(v.Character) end)
end)

local assets = workspace:FindFirstChildOfClass("Terrain"):WaitForChild("_Game")
local pads = assets:WaitForChild("Admin"):WaitForChild("Pads")

game:GetService("RunService").PreSimulation:Connect(function(dt)
	for i, v in game:FindService("Players"):GetPlayers() do
		if settingsTable.antivg and (game:GetService("Players").LocalPlayer.Name ~= v.Name) and v.Character and v.Character:FindFirstChild("VampireVanquisher") or settingsTable.antivg and (game:GetService("Players").LocalPlayer.Name ~= v.Name) and v.Backpack:FindFirstChild("VampireVanquisher") then
			local name = v.Name
			run("ungear/"..name)
			run("ungear "..name)
		end
		if settingsTable.antigear and v.Backpack:FindFirstChildOfClass("Tool") or settingsTable.antigear and v.Character:FindFirstChildOfClass("Tool") then
			local name = v.Name
			run("ungear "..name)
			run("ungear/"..name)
		end
	end
	if game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND") then
		game:FindService("Players").LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND"):Destroy()
	end
	if settingsTable.antivg and workspace:FindFirstChildOfClass("Tool") or settingsTable.antigear and workspace:FindFirstChildOfClass("Tool") then
		run("clr")
	end
end)
game:GetService("Players").PlayerAdded:Connect(function(v)
	if settingsTable.banned[v.UserId] or settingsTable.no[v.Name] and v.Character.Parent and v.Character.Parent == workspace then
		local name = v.Name
		run("punish "..name)
		run("blind "..name)
	end
	v.Chatted:Connect(function(m)
		if settingsTable.antilogs and m:sub(1, 4) == "logs" or settingsTable.antilogs and m:sub(1, 5) == ":logs" then
			for i = 1, 16 do
				run("particle No logs for you lol\nNo logs for you lol\nNo logs for you lol\nNo logs for you lol\nA noob tried to access logs\nWhat is this\nHiiiiiiiiiiiiiiiiiii\nEwww you stink\nI don't know\nsize me 1000\npunish others\nlololololol\ntrolololol\ndigitality is mad\nj0ro is cool if you disagree then you stink\nimagine checking logs in\n2024\nyou are homose-\nnorth korea\nmrp\nmeow\nlogs cleared from noobs\ni don't know you\n...\nfunny more like funzy\nyou have a crush named logs\nhmmmmm\ni <3 pizza\nu fattie\nnu\nmeowww\nmeowie\nhallo\nchinese immigrant\nwhen life gives you lemons, you get shortcut v3-var\nskill issue\nez\nHave you tried using antilogs?\n🐈😺😼\n\n\n\n\n\n\n\n\n\n\n\n\nERROR 403: Forbidden\nYou can't see this...\n\n\n\n\n\n\n\n\n\nAntilogs by humanoid")
			end;task.wait(1.5)
			run("freeze "..v.Name)
			run("name "..v.Name.." "..v.DisplayName.." is addicted to logs")
			run("unname "..v.Name)
			task.wait(.2)
			run("name "..v.Name.." "..v.DisplayName.." is addicted to logs")
		end
	end)
end)
for i, v in game:GetService("Players"):GetPlayers() do
	if settingsTable.banned[v.UserId] or settingsTable.no[v.Name] and v.Character.Parent and v.Character.Parent == workspace then
		local name = v.Name
		run("punish "..name)
		run("blind "..name)
	end
	v.Chatted:Connect(function(m)
		if v.Name ~= game:GetService("Players").LocalPlayer.Name and settingsTable.antilogs and m:sub(1, 4) == "logs" or v.Name ~= game:GetService("Players").LocalPlayer.Name and settingsTable.antilogs and m:sub(1, 5) == ":logs" then
			for i = 1, 16 do
				run("particle No logs for you lol\nNo logs for you lol\nNo logs for you lol\nNo logs for you lol\nA noob tried to access logs\nWhat is this\nHiiiiiiiiiiiiiiiiiii\nEwww you stink\nI don't know\nsize me 1000\npunish others\nlololololol\ntrolololol\ndigitality is mad\nj0ro is cool if you disagree then you stink\nimagine checking logs in\n2024\nyou are homose-\nnorth korea\nmrp\nmeow\nlogs cleared from noobs\ni don't know you\n...\nfunny more like funzy\nyou have a crush named logs\nhmmmmm\ni <3 pizza\nu fattie\nnu\nmeowww\nmeowie\nhallo\nchinese immigrant\nwhen life gives you lemons, you get shortcut v3-var\nskill issue\nez\nHave you tried using antilogs?\n🐈😺😼\n\n\n\n\n\n\n\n\n\n\n\n\nERROR 403: Forbidden\n\n\n\n\n\n\n\n\n\n\nAntilogs by humanoid")
			end;task.wait(1.5)
			run("freeze "..v.Name)
			run("name "..v.Name.." "..v.DisplayName.." is addicted to logs")
			run("unname "..v.Name)
			task.wait(.2)
			run("name "..v.Name.." "..v.DisplayName.." is addicted to logs")
		end
	end)
end

task.defer(function()
	local lp = game:GetService("Players").LocalPlayer
	local store = workspace.Terrain._Game
	local pads = store.Admin.Pads
	local regen = store.Admin:FindFirstChild("Regen")
	local pad = pads:FindFirstChild("Touch to get admin")
	if pad == nil and settingsTable.perm then
		if fireclickdetector and typeof(regen) == "Instance" then
			fireclickdetector(regen.ClickDetector, 9e9)
		end	
		repeat task.wait() until pads:FindFirstChild("Touch to get admin")
		pad = pads:FindFirstChild("Touch to get admin")
	end
	pad.Archivable = true
	task.defer(function() 
		while task.wait() do
			if settingsTable.perm and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				if pad == nil or pad:FindFirstChild("Head") == nil then
					if fireclickdetector and regen then
						fireclickdetector(regen.ClickDetector, 9e9)
					end
					pad = pads:FindFirstChild("Touch to get admin")
				end
				task.spawn(function()
					if pad:FindFirstChild("Head") then
						firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1)
						firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
						firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 1)
						task.wait()
						firetouchinterest(pad.Head, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
					end
				end)
			end
		end 
	end)
end)	

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Welcome to Kohls+",
	Text = "Script loaded successfully"
})

-- Other Loops																																														e
task.defer(function()
	recursive_loop1(function()
		if fastspamming ~= "" then
			run(fastspamming)
		end
	end)
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
	if spamming ~= "" then
		run(spamming)
	end
end)
