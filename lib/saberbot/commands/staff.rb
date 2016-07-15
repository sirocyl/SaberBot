#!/usr/bin/env ruby
# encoding: utf-8

# SaberBot by Alex Taber and Megumi Sonoda
# Copyright 2016 Alex Taber, Megumi Sonoda
# This file is licensed under the MIT License

module SaberBot
  module Command
    module Staff
      extend Discordrb::Commands::CommandContainer

      command(:addstaff, description: "Add a new staff member or modify a staff member's role. Admins only.", permission_level: 2, min_args: 2) do |event, user, role_name|
        break if event.channel.private?
        if event.message.mentions[0]
          if Server_roles[event.server][role_name]
            member = event.server.member(event.message.mentions[0])
            role = Server_roles[event.server][role_name]
            member.add_role(Server_roles[event.server][Config["staff_role"]])
            Roles[member.id] = role.id
            "Member #{member.mention} has been added as a #{role.name}. Welcome aboard!"
          else
            "Invalid argument. Please specify a valid role."
          end
        else
          "Invalid argument. Please mention a valid user."
        end
      end

      command(:delstaff, description: "Remove a staff member. Admins only.", permission_level: 2, min_args: 1) do |event|
        break if event.channel.private?
        if event.message.mentions[0]
          member = event.server.member(event.message.mentions[0])
          if Roles[member.id]
            member.remove_role(event.server.role(Roles[member.id]))
            member.remove_role(Server_roles[event.server][Config["staff_role"]])
            Roles.delete(member.id)
            "Member #{member.mention} has been removed from staff. See you!"
          else
            "Error: #{member.mention}'s UID isn't saved in the sudo list! You should report this to an admin."
          end
        end
      end

    end
  end
end
