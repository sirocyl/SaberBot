# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Write our yml files and exit gracefully
module SaberBot
  def self.botexit
    SaberConfig.write_staff
    SaberConfig.write_bans
    SaberConfig.write_mutes
    SaberConfig.write_noembeds
    BotObject.stop
    exit
  end
end
