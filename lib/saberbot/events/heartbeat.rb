# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # call bancheck on each heartbeat from the server
    module BanCheckHeartbeat
      extend Discordrb::EventContainer
      heartbeat do
        SaberBot.bancheck
      end
    end
  end
end
