# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

# Write our yml files and exit gracefully
module SaberBot
  def self.botexit
    SaberConfig.write_yml('staff.yml', SaberConfig.roles)
    SaberConfig.write_yml('bans.yml', SaberConfig.bans)
    SaberConfig.write_yml('mutes.yml', SaberConfig.mutes)
    SaberConfig.write_yml('noembeds.yml', SaberConfig.noembeds)
    BotObject.stop
    exit
  end
end
