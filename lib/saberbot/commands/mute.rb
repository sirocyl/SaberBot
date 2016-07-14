#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Mute
      extend Discordrb::Commands::CommandContainer

      command(:mute, description: "Mute a user. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        event.server.member(event.message.mentions[0].id).add_role(Server_roles[event.server][Config["mute_role"]])
        Server_channels[event.server][Config["modlog_channel"]].send("**Muted:** #{event.message.mentions[0].mention}\n**Responsible Moderator:** #{event.message.author.mention}")
        "Muted #{event.message.mentions[0].mention}."
      end

      command(:unmute, description: "Unmute. Staff only.", permission_level: 1) do |event|
        break if event.channel.private?
        event.server.member(event.message.mentions[0].id).remove_role(Server_roles[event.server][Config["mute_role"]])
        Server_channels[event.server][Config["modlog_channel"]].send("**Unmuted:** #{event.message.mentions[0].mention}\n**Responsible Moderator:** #{event.message.author.mention}")
        "Unmuted #{event.message.mentions[0].mention}."
      end
      
    end
  end
end
