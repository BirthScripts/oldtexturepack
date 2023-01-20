local function getcustomassetfunc(path)
	if not isfile(path) then
		spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = game.CoreGui.RobloxGui
			repeat wait() until isfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/BirthScripts/oldtexturepack/main/bedwars/"..path,
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	if not isfile(path) then
		local textlabel = Instance.new("TextLabel")
		textlabel.Size = UDim2.new(1, 0, 0, 36)
		textlabel.Text = "Downloading "..path
		textlabel.BackgroundTransparency = 1
		textlabel.TextStrokeTransparency = 0
		textlabel.TextSize = 30
        textlabel.Font = Enum.Font.SourceSans
		textlabel.TextColor3 = Color3.new(1, 1, 1)
		textlabel.Position = UDim2.new(0, 0, 0, -36)
		textlabel.Parent = game.CoreGui.RobloxGui
		repeat wait() until isfile(path)
		textlabel:Remove()
	end
	return getasset(path) 
end

local function downloadassets(path2)
    local json = requestfunc({
        Url = "https://api.github.com/repos/BirthScripts/oldtexturepack/contents/bedwars/"..path2,
        Method = "GET"
    })
    local decodedjson = game:GetService("HttpService"):JSONDecode(json.Body)
    for i2,v2 in pairs(decodedjson) do
        if v2["type"] == "file" then
			getcustomassetfunc(path2.."/"..v2["name"])
		end
    end
end

if isfolder("bedwars") == false then
	makefolder("bedwars")
end
downloadassets("bedwars")
if isfolder("bedwars/models") == false then
	makefolder("bedwars/models")
end
downloadassets("bedwars/models")
if isfolder("bedwars/sounds") == false then
	makefolder("bedwars/sounds")
end
downloadassets("bedwars/sounds")
if isfolder("bedwars/sounds/footstep") == false then
	makefolder("bedwars/sounds/footstep")
end
downloadassets("bedwars/sounds/footstep")

local sounds = require(game.ReplicatedStorage.TS.sound["sound-manager"]).SoundManager.soundConfigs
local footstepsounds = require(game.ReplicatedStorage.TS.sound["footstep-sounds"])
local items = require(game.ReplicatedStorage.TS.item["item-meta"])
local itemtab = debug.getupvalue(items.getItemMeta, 1)
local hotbartile = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-tile"])
local hotbaropeninventory = require(game.Players.LocalPlayer.PlayerScripts.TS.controllers.global.hotbar.ui["hotbar-open-inventory"])
local roact = debug.getupvalue(hotbartile["HotbarTile"].render, 1)
local colorutil = debug.getupvalue(hotbartile["HotbarTile"].render, 2)
local soundmanager = debug.getupvalue(hotbartile["HotbarTile"].render, 3)
local itemviewport = debug.getupvalue(hotbartile["HotbarTile"].render, 5)
local empty = debug.getupvalue(hotbartile["HotbarTile"].render, 6)
local tween = debug.getupvalue(hotbartile["HotbarTile"].tweenPosition, 1)
hotbaropeninventory["HotbarOpenInventory"].render = function() end
hotbartile["HotbarTile"].tweenPosition = function(slottile)
	slottile.positionMaid:DoCleaning()
	local tempTween
	if slottile.props.Selected then
		tempTween = tween:Create(slottile.frameRef:getValue(), TweenInfo.new(0.12), {
			Position = UDim2.fromScale(0, 0)
		})
	else
        for i2,v2 in pairs(v:GetDescendants()) do
            if v2:IsA("Texture") then
                v2.Texture = getcustomassetfunc("bedwars/"..v.Name..".png")
            end
        end
        v.DescendantAdded:connect(function(v3)
            if v3:IsA("Texture") then
                v3.Texture = getcustomassetfunc("bedwars/"..v.Name..".png")
            end
        end)
    end
    if v:IsA("Accessory") and isfile("bedwars/models/"..v.Name..".mesh") then
        spawn(function()
            local handle = v:WaitForChild("Handle")
            handle.MeshId = getcustomassetfunc("bedwars/models/"..v.Name..".mesh")
            handle.TextureID = getcustomassetfunc("bedwars/models/"..v.Name..".png")
            for i2,v2 in pairs(handle:GetDescendants()) do
                if v2:IsA("MeshPart") then
                    v2.Transparency = 1
                end
            end
        end)
    end
end
