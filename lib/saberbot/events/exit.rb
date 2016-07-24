# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # Log when people leave the server
    module LogExit
      extend Discordrb::EventContainer
      member_leave do |event|
        SaberConfig.server_channels[event.server][SaberConfig.settings['log_channel']].send(
          "Left: #{event.user.mention} || #{event.user.distinct}"
        )
      end
    end
  end
end
