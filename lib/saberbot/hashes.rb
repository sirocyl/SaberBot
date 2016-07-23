# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  Logchannels       = Hash.new  # Stores server-specific log channel objects
  Ignorechannels    = Hash.new  # Stores server-specific objects for channels not meant to be logged
  Slowmode_counters = Hash.new  # Stores the current number of messages per second for a slowmode-enabled channel
  Slowmode_maxmsgs  = Hash.new  # Stores the maximum amount of messages per second for a slowmode-enabled channel
  Server_roles      = Hash.new  # Create hash with format {server, {role_name, role}}
  Server_channels   = Hash.new  # Create hash with format {server, {channel_name, channel}}
end
