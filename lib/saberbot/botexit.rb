# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Write our yml files and exit gracefully
module SaberBot
  def self.botexit
    SaberConfig.write_yml('staff', SaberConfig.roles)
    SaberConfig.write_yml('bans', SaberConfig.bans)
    SaberConfig.write_yml('mutes', SaberConfig.mutes)
    SaberConfig.write_yml('noembeds', SaberConfig.noembeds)
    BotObject.stop
    exit
  end
end
