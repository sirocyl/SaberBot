# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  BotObject = Discordrb::Commands::CommandBot.new(
                                            token:          Config["auth_token"],
                                            application_id: Config["app_id"],
                                            prefix:         Config["command_prefix"],
                                            advanced_functionality: false)

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
  BotObject.include! Command::Ban
  BotObject.include! Command::Kick
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
  BotObject.include! Event::BanCheckHeartbeat
  BotObject.include! Event::SlowmodeLoop
  BotObject.include! Event::AutoPunish

  # Catch Ctrl-C and kill
  trap("SIGINT") {SaberBot::botexit}
  trap("SIGTERM") {SaberBot::botexit}

  BotObject.run
end
