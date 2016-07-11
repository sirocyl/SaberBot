#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Slowmode
      extend Discordrb::Commands::CommandContainer
      command(:slowmode, description: "Set channel into slowmode. Arguments: number of messages per second. Staff only.", permission_level: 1, min_args: 1) do |event, msgs|
        if msgs.to_i < 1 then
          "Invalid amount \"#{msgs}\". Please choose a number of at least 1."
        else
          Slowmode_maxmsgs[event.channel] = msgs.to_i
          Slowmode_counters[event.channel] = 0
          "Slowmode enabled. You can only send #{msgs} messages in this channel per second."
        end
      end
      command(:slowoff, description: "Disable slowmode on a channel. Staff only.", permission_level: 1) do |event|
        Slowmode_maxmsgs.delete(event.channel)
        Slowmode_counters.delete(event.channel)
        "Slowmode disabled."
      end
    end
  end
end
