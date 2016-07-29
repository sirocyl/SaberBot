# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

require 'discordrb'
require 'thread'
require 'yaml'
require 'date'
require 'chronic_duration'
require 'sequel'
require 'digest'

# Bot configuration and saved staff roles for sudo, also saved bans
require_relative 'saberbot/config'

SaberConfig.settings = SaberConfig.read_yml('config')

if SaberConfig.settings == {}
  puts 'Error: Empty or missing config.'
  exit
end

SaberConfig.roles = SaberConfig.read_yml('staff')
SaberConfig.bans = SaberConfig.read_yml('bans')
SaberConfig.mutes = SaberConfig.read_yml('mutes')
SaberConfig.noembeds = SaberConfig.read_yml('noembeds')
SaberConfig.friendcodes = SaberConfig.read_database('friendcodes')[:friendcodes]

# Provide method for graceful shutdown
require_relative 'saberbot/botexit'

# SaberBot commands and event handlers
require_relative 'saberbot/commands'
require_relative 'saberbot/events'

# Require loops
require_relative 'saberbot/loops'

# Various functions utilized by commands
require_relative 'saberbot/bancheck'
require_relative 'saberbot/timeparse'
require_relative 'saberbot/valid_fc'

# Main logic
require_relative 'saberbot/main'
