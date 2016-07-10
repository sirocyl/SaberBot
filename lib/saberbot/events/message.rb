#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    # Increase the slowmode counter on affected channels
    module SlowmodeCounter
      extend Discordrb::EventContainer
      message do |event|                                                      # When a channel receives a message...
        if Slowmode_counters.key? event.channel                                   # If this channel is in slowmode...
          Slowmode_counters[event.channel] += 1                                   # add 1 to its counter...
          if Slowmode_counters[event.channel] > Slowmode_maxmsgs[event.channel]  # If this message is over the slowmode limit...
            event.message.delete                                                  # then delete it.
          end
        end
      end
    end
  end
end
