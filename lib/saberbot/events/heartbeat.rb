# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event

    module BanCheckHeartbeat
      extend Discordrb::EventContainer
      heartbeat do
        SaberBot.bancheck
      end
    end

  end
end
