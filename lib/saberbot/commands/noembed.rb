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
        break if event.channel.private?
        event.server.member(event.message.mentions[0].id).add_role(Server_roles[event.server][Config["noembed_role"]])
        Server_channels[event.server][Config["modlog_channel"]].send("**No-Embed:** #{event.message.mentions[0].mention}\n**Responsible Moderator:** #{event.message.author.mention}")
        "Removed #{event.message.mentions[0].mention}'s media privileges."
      end

      command(:embed, description: "Restore a user's media privileges. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        event.server.member(event.message.mentions[0].id).remove_role(Server_roles[event.server][Config["noembed_role"]])
        Server_channels[event.server][Config["modlog_channel"]].send("**Embed:** #{event.message.mentions[0].mention}\n**Responsible Moderator:** #{event.message.author.mention}")
        "Restored #{event.message.mentions[0].mention}'s media privileges."
      end

    end
  end
end
