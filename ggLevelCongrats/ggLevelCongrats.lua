-- Whenever a unit levels, this function will be called
function LC_OnUnitLevel(event, unitTag, level)
  -- If the unit that just leveled is our player lets go ahead and print out our congratuations message!
  if unitTag == "player" then 
    d("Congrats on achieving level "..level.."!")
  end

  -- If our unit tag contains "group", then a group member just leveled
  if string.find(unitTag, "group") ~= nil then 
    local message = GetUnitName(unitTag)..": Congrats on achieving level "..level.."!"
    SendChatMessage(message, CHAT_CHANNEL_PARTY, nil)
  end
end

-- Whenever a guild member levels, this function will be called
function LC_OnGuildMemberLevel(event, guildId, displayName, characterName, level)
  local channel = nil
  if     GetGuildId(1) == guildId then channel = CHAT_CHANNEL_GUILD_1
  elseif GetGuildId(2) == guildId then channel = CHAT_CHANNEL_GUILD_2
  elseif GetGuildId(3) == guildId then channel = CHAT_CHANNEL_GUILD_3
  elseif GetGuildId(4) == guildId then channel = CHAT_CHANNEL_GUILD_4
  elseif GetGuildId(5) == guildId then channel = CHAT_CHANNEL_GUILD_5
  end

  local message = displayName..": Congrats on achieving level "..level.."!"
  SendChatMessage(message, channel, nil)
end

-- Whenever any addon finishes getting loaded this method is called
function LC_OnAddonLoad(eventCode, addOnName)
  -- Whenever our addon has finished being loaded, lets initialize our add-on by registering the level up event to our
  --   "LC_OnUnitLevel" method.  Once finished initializing, we're going to print that our addon was successfully loaded
  --   to inform the user everything is working.
  if(addOnName == "ggLevelCongrats") then
    EVENT_MANAGER:RegisterForEvent("LevelCongrats", EVENT_LEVEL_UPDATE,  LC_OnUnitLevel)
    EVENT_MANAGER:RegisterForEvent("LevelCongrats", EVENT_GUILD_MEMBER_CHARACTER_LEVEL_CHANGED,  LC_OnGuildMemberLevel)
  end
end

-- Event Handling
-- Watch for when add-ons get loaded and when this occurs, call our "LC_OnAddonLoaded" Function
EVENT_MANAGER:RegisterForEvent("LevelCongrats", EVENT_ADD_ON_LOADED, LC_OnAddonLoad)