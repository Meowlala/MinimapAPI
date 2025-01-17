-- copied from Music Mod Callback with some stuff removed

local cache = {}

cache.Mod = RegisterMod("MinimapAPI Cache", 1)
local mod = cache.Mod

cache.Game = Game()
cache.HUD = cache.Game:GetHUD()

local STAGE1_2 = LevelStage.STAGE1_2
local STAGETYPE_REPENTANCE = StageType.STAGETYPE_REPENTANCE
local STAGETYPE_REPENTANCE_B = StageType.STAGETYPE_REPENTANCE_B

function cache.ReloadRoomCache()
	cache.Level = cache.Game:GetLevel()
	cache.Room = cache.Game:GetRoom()
	cache.RoomDescriptor = cache.Level:GetCurrentRoomDesc()
	cache.Stage = cache.Level:GetStage()
	cache.AbsoluteStage = cache.Level:GetAbsoluteStage()
	cache.StageType = cache.Level:GetStageType()
	cache.CurrentRoomIndex = cache.Level:GetCurrentRoomIndex()
	cache.RoomType = cache.Room:GetType()
	cache.Seeds = cache.Game:GetSeeds()
	
	--Dimension
	if REPENTANCE then
		if GetPtrHash(cache.RoomDescriptor) == GetPtrHash(cache.Level:GetRoomByIdx(cache.CurrentRoomIndex, 0)) then
			cache.Dimension = 0
		elseif GetPtrHash(cache.RoomDescriptor) == GetPtrHash(cache.Level:GetRoomByIdx(cache.CurrentRoomIndex, 2)) then
			cache.Dimension = 2
		else
			cache.Dimension = 1
		end
		
		cache.MirrorDimension = cache.Dimension == 1 and cache.Stage == STAGE1_2 and (cache.StageType == STAGETYPE_REPENTANCE or cache.StageType == STAGETYPE_REPENTANCE_B)
	end
end
cache.ReloadRoomCache()

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, cache.ReloadRoomCache)

return cache