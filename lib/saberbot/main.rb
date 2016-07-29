# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Define the bot object and include all our cool stuff
module SaberBot
  BotObject = Discordrb::Commands::CommandBot.new(
    token:          SaberConfig.settings['auth_token'],
    application_id: SaberConfig.settings['app_id'],
    prefix:         SaberConfig.settings['command_prefix'],
    advanced_functionality: false
  )

  plugins = [
    Command::Exit,
    Command::Staff,
    Command::Clear,
    Command::Lockdown,
    Command::Logs,
    Command::Mute,
    Command::NoEmbed,
    Command::Probation,
    Command::Slowmode,
    Command::Sudo,
    Command::Ban,
    Command::Kick,
    Command::RedditCommands,
    Command::Memes,
    Command::Friendcodes,
    Event::LogJoin,
    Event::LogExit,
    Event::AutoProbate,
    Event::SlowmodeCounter,
    Event::PopulateHashes,
    Event::SetGameString,
    Event::BanCheckHeartbeat,
    Event::SlowmodeLoop,
    Event::AutoPunish,
    Event::LogRoleUpdate
  ]

  plugins.each { |p| BotObject.include!(p) }

  # Catch Ctrl-C and kill
  trap('SIGINT') { SaberBot.botexit }
  trap('SIGTERM') { SaberBot.botexit }

  BotObject.run
end
