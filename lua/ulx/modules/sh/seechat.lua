local CATEGORY_NAME = "Chat"

local statemsg = { [false] = "See private messaging has been turned off.", [true] = "See private messaging has been turned on."}

--You can change these colors if you want
local msgcolor = Color(2,194,168)
local msgoncolor = Color(232,225,14)
local msgoffcolor = Color(255,0,0)

------------------------------------------
function ulx.seechat(calling_ply)
	--Console can already see everything
	if IsValid(calling_ply) and calling_ply ~= "Console" then 

		--SetNWBool
		local togglestate = !(calling_ply:GetNWBool("SeeAdminChat",false))
		calling_ply:SetNWBool("SeeAdminChat",togglestate)
		if calling_ply:GetNWBool("SeeAdminChat",false) == false then
				ULib.tsayColor(calling_ply,true,msgoffcolor or Color(255,0,0), statemsg[false]) 
		else
				ULib.tsayColor(calling_ply,true,msgoffcolor or Color(255,0,0), statemsg[true]) 
		end
	end
end
local seechat = ulx.command(CATEGORY_NAME, "ulx seechat", ulx.seechat, "!seechat", true)
seechat:defaultAccess( ULib.ACCESS_ADMIN )
seechat:help("Lets the user see all private messaging going on")

hook.Add("ULibPostTranslatedCommand", "RelayPsay", function(ply, commandname, args)
	if not string.find(commandname, "psay") then return end
	local toggledon={}
	if args[3] ~= nil then
		
		for _,v in pairs(player.GetHumans()) do
			if IsValid(v) and v:GetNWBool("SeeAdminChat",false) then
				  table.insert(toggledon,v)
			end
		end	

		ulx.fancyLog(toggledon, "[Seechat] #P to #P: " .. args[3], args[1], args[2])	
	end
end)
