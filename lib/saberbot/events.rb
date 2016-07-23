# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    Dir["#{__dir__}/events/*.rb"].each {
      |event| require event
    }
  end
end
