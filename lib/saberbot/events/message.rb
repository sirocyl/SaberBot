#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Event
    module SlowmodeCounter
      extend Discordrb::EventContainer
      message do |event|
        if Slowmode_counters.key? event.channel
          Slowmode_counters[event.channel] += 1
          if Slowmode_counters[event.channel] > Slowmode_maxmsgs[event.channel]
            event.message.delete
          end
        end
      end
    end
  end
end
