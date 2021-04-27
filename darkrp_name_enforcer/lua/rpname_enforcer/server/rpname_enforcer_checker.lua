util.AddNetworkString("ShowEnforcer")
util.AddNetworkString("NewName")
util.AddNetworkString("NewNameDone")

hook.Add( "PlayerInitialSpawn", "CheckIfShowEnforcer", function( ply )
	if ply:getDarkRPVar("rpname")== nil then
		net.Start("ShowEnforcer")
		net.Send(ply)
	end
end)

net.Receive("NewName", function(len,ply)
local newname = net.ReadString()

local allow = true
for k,v in pairs(EnforcerConfig.Blacklist) do 
	if string.find(string.lower(newname), string.lower(v)) then allow = false break end
end	

if allow == true then 
	if EnforcerConfig.AllowPrefix then 
		ply:setDarkRPVar( "rpname", EnforcerConfig.Prefix.." "..newname )
	else
		ply:setDarkRPVar( "rpname", newname )
	end
	net.Start("NewNameDone")
	net.Send(ply)
end

end)