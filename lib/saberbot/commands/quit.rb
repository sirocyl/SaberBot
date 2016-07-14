#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Exit
      extend Discordrb::Commands::CommandContainer
      command(:quit, description: "Disconnect the bot from the server. Admins only.", permission_level: 2) do |event|
        break if event.channel.private?
        SaberBot::botexit
      end
    end
  end
end
