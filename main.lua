local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local toolbar = plugin:CreateToolbar("Part-To-Lua")

local NewButton = toolbar:CreateButton("Convert", "Convert now!", "rbxassetid://4458901886")

NewButton.Click:Connect(function()
	local tbl = Selection:Get()
	local properties = {"Name", "Position", "Orientation", "Size", "Color", "Material", "Transparency", "Reflectance", "Anchored", "CanCollide", "Locked"}
	local s = Instance.new("Script", game.Workspace)
	
	for i, part in ipairs(tbl) do
		local newContent = ""
		newContent = newContent .. ("local part"..i.. " = Instance.new('Part', game.Workspace)".."\n")
		for _, v in ipairs(properties) do
			if v == "Position" or v == "Size" or v == "Orientation" then
				local vector = part[v]
				newContent = newContent .. ("part"..i.."."..v.." = Vector3.new("..vector.X..", "..vector.Y..", "..vector.Z..")".."\n")
			elseif v == "Color" then
				local color3 = part[v]
				newContent = newContent .. ("part"..i.."."..v.." = Color3.fromRGB("..color3.R..", "..color3.G..", "..color3.B..")".."\n")
				newContent = newContent .. ("part"..i..".BrickColor".." = BrickColor.new("..color3.R..", "..color3.G..", "..color3.B..")".."\n")
			elseif v == "Material" then
				newContent = newContent .. ("part"..i.."."..v.." = Enum.Material['"..part[v].Name.."']".."\n")
			elseif v == "Anchored" or v == "CanCollide" or v == "Locked" then
				newContent = newContent .. ("part"..i.."."..v.." = "..tostring(part[v]).."\n")
			elseif v == "Name" then
				newContent = newContent .. ("part"..i.."."..v.." = '"..part[v].."'".."\n")
			else
				newContent = newContent .. ("part"..i.."."..v.." = "..part[v].."\n")
			end
		end
		s.Source = s.Source .. newContent
	end
	
	ChangeHistoryService:SetWaypoint("Converted parts into Lua!")
end)
