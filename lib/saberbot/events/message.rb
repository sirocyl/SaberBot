# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # increment the slowmode counter if it's active
    module SlowmodeCounter
      extend Discordrb::EventContainer
      message do |event|
        if SaberConfig.slowmode_counters.key? event.channel
          SaberConfig.slowmode_counters[event.channel] += 1
          if SaberConfig.slowmode_counters[event.channel] > SaberConfig.slowmode_maxmsgs[event.channel]
            event.message.delete
          end
        end
      end
    end
  end
end
