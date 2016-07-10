#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Staff
      extend Discordrb::Commands::CommandContainer
      command(:addstaff, description: "Add a new staff member or modify a staff member's role. Admins only.", permission_level: 2) do |event, user, role_name|
        member = event.server.member(event.message.mentions[0])
        role = Server_roles[event.server][role_name]
        member.add_role(Server_roles[event.server][Config["staff_role"]])
        Roles[member.id] = role.id
        "Member #{member.mention} has been added as a #{role.name}. Welcome aboard!"
      end
      command(:delstaff, description: "Remove a staff member. Admins only.", permission_level: 2) do |event|
        member = event.server.member(event.message.mentions[0])
        member.remove_role(Server_roles[event.server][Config["staff_role"]])
        Roles.delete(member.id)
        "Member #{member.mention} has been removed from staff. See you!"
      end
    end
  end
end

## Staff management commands. These define sudo levels.
# !addstaff @user Role
# !delstaff @user Role
