#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module NoEmbed
      extend Discordrb::Commands::CommandContainer
      command(:noembed, description: "Remove a user's media privileges. Staff only.", permission_level: 1, min_args: 1) do |event|
        event.server.member(event.message.mentions[0].id).add_role(Server_roles[event.server][Config["noembed_role"]])
        "Removed #{event.message.mentions[0].mention}'s media privileges."
      end
      command(:embed, description: "Restore a user's media privileges. Staff only.", permission_level: 1) do |event|
        event.server.member(event.message.mentions[0].id).remove_role(Server_roles[event.server][Config["noembed_role"]])
        "Restored #{event.message.mentions[0].mention}'s media privileges."
      end
    end
  end
end
