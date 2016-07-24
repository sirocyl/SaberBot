# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  # import all our commands!
  module Command
    Dir["#{__dir__}/commands/*.rb"].each do |command|
      require_relative command
    end
  end
end
