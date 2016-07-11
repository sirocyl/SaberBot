#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Lockdown
      extend Discordrb::Commands::CommandContainer
      command(:lockdown, description: "Disable channel send permissions to normal users. Staff only.", permission_level: 1) do |event|
        lockdown = Discordrb::Permissions.new
        lockdown.can_send_messages = true
        event.channel.define_overwrite(Server_roles[event.server][Config["everyone_role"]], 0, lockdown)
        "This channel is now in lockdown. Only staff can send messages."
      end
      command(:unlockdown, description: "Enable channel send permissions to normal users. Staff only.", permission_level: 1) do |event|
        lockdown = Discordrb::Permissions.new
        lockdown.can_send_messages = false
        event.channel.define_overwrite(Server_roles[event.server][Config["everyone_role"]], lockdown, 0)
        "This channel is no longer in lockdown."
      end
    end
  end
end
