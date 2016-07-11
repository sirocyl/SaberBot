#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Probation
      extend Discordrb::Commands::CommandContainer
      command(:probation, description: "Add a user to probation. Staff only.", permission_level: 1) do |event|
        event.server.member(event.message.mentions[0].id).add_role(Server_roles[event.server][Config["probation_role"]])
        "Added #{event.message.mentions[0].mention} to probation."
      end
      command(:unprobation, description: "Remove a user from probation. Staff only", permission_level: 1) do |event|
        event.server.member(event.message.mentions[0].id).remove_role(Server_roles[event.server][Config["probation_role"]])
        "Removed #{event.message.mentions[0].mention} from probation."
      end
      command(:autoprobate, description: "Toggles whether new users are automatically added to probation. Admins only.", permission_level: 2) do
        Config["autoprobate"] = !Config["autoprobate"]
        "Autoprobate is now: #{Config["autoprobate"]}"
      end
    end
  end
end
