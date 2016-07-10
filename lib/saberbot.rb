#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

require 'discordrb'
require 'thread'
require 'yaml'

# Bot configuration and saved staff roles for sudo
require_relative 'saberbot/config'
Config = SaberBot::SaberConfig.read_config
Roles  = SaberBot::SaberConfig.read_staff

# Define hashes for later
require_relative 'saberbot/hashes'

# Provide method for graceful shutdown
require_relative 'saberbot/botexit'

# SaberBot commands and event handlers
require_relative 'saberbot/commands'
require_relative 'saberbot/events'

# Slowmode loop
require_relative 'saberbot/slowmodeloop'

# Main logic
require_relative 'saberbot/main'
