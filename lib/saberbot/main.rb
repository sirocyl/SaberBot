#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  BotObject = Discordrb::Commands::CommandBot.new(                                     # CommandBot provides an easy way to create command triggers
                                            token:          Config["auth_token"],      # Discord API token for bot accounts
                                            application_id: Config["app_id"],          # Application ID for OAuth2
                                            prefix:         Config["command_prefix"],  # Command prefix for CommandBot's use
                                            advanced_functionality: false)             # Disable command chaining

  # Admin commands
  BotObject.include! Command::Exit
  BotObject.include! Command::Staff
  # Staff commands
  BotObject.include! Command::Clear
  BotObject.include! Command::Lockdown
  BotObject.include! Command::Logs
  BotObject.include! Command::Mute
  BotObject.include! Command::NoEmbed
  BotObject.include! Command::Probation
  BotObject.include! Command::Slowmode
  BotObject.include! Command::Sudo
  # 3dshacks commands
  BotObject.include! Command::RedditCommands
  BotObject.include! Command::Memes

  # Event handlers
  BotObject.include! Event::LogJoin
  BotObject.include! Event::LogExit
  BotObject.include! Event::AutoProbate
  BotObject.include! Event::SlowmodeCounter
  BotObject.include! Event::PopulateHashes
  BotObject.include! Event::SetGameString
  BotObject.include! Event::LogBan

  # Catch Ctrl-C and kill
  trap("SIGINT") {SaberBot::botexit}
  trap("SIGTERM") {SaberBot::botexit}

  # Run slowmode loop
  SaberBot.slowmodeloop

  BotObject.run
end
