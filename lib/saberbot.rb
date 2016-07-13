#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

require 'discordrb'
require 'thread'
require 'yaml'
require 'date'
require 'chronic_duration'

# Bot configuration and saved staff roles for sudo, also saved bans
require_relative 'saberbot/config'
Config = SaberBot::SaberConfig.read_config
Roles  = SaberBot::SaberConfig.read_staff
Bans   = SaberBot::SaberConfig.read_bans

# Define hashes for later
require_relative 'saberbot/hashes'

# Provide method for graceful shutdown
require_relative 'saberbot/botexit'

# SaberBot commands and event handlers
require_relative 'saberbot/commands'
require_relative 'saberbot/events'

# Require loops
require_relative 'saberbot/loops'

# Ban stuff
require_relative 'saberbot/bancheck'
require_relative 'saberbot/timeparse'

# Main logic
require_relative 'saberbot/main'
