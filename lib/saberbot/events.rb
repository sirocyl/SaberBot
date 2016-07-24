# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  # import all our event handlers
  module Event
    Dir["#{__dir__}/events/*.rb"].each do |event|
      require_relative event
    end
  end
end
