# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  def SaberBot.botexit
    SaberBot::SaberConfig::write_staff
    SaberBot::SaberConfig::write_bans
    SaberBot::SaberConfig::write_mutes
    SaberBot::SaberConfig::write_noembeds
    BotObject.stop
    exit
  end
end
