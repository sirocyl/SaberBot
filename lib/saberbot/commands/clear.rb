#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Clear
      extend Discordrb::Commands::CommandContainer
      command(:clear, description: "Clear x messages. Staff only.", permission_level: 1, min_args: 1) do |event, amount|
        begin
          event.channel.prune(amount.to_i)
        rescue ArgumentError
          "Invalid amount \"#{amount}\". Expected a number between 2 and 100."
        end
      end
    end
  end
end

# !clear - Prunes specified amount of messages from channel
#          Valid range 2 - 100
