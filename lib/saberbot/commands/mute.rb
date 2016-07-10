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
        event.server.member(event.message.mentions[0].id).add_role(Server_roles[event.server][Config["mute_role"]])
        "Muted #{event.message.mentions[0].mention}."
      end
      command(:unmute, description: "Unmute. Staff only.", permission_level: 1) do |event|
        event.server.member(event.message.mentions[0].id).remove_role(Server_roles[event.server][Config["mute_role"]])
        "Unmuted #{event.message.mentions[0].mention}."
      end
    end
  end
end

# User mute management. Muted users cannot send text messages, upload files, or speak in voice channels.
# They may read messages and message history, and may join a voice channel for listening.
# !mute - mutes the specified user
# !unmute - unmutes the specified user
