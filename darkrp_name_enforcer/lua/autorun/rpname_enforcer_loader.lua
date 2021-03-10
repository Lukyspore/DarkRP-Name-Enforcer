include("rpname_enforcer/sh_config.lua")

if SERVER then	
	include("rpname_enforcer/server/rpname_enforcer_checker.lua")
	AddCSLuaFile("rpname_enforcer/sh_config.lua")
	AddCSLuaFile("rpname_enforcer/client/rpname_enforcer_system.lua")
elseif CLIENT then
	include("rpname_enforcer/client/rpname_enforcer_system.lua")
end